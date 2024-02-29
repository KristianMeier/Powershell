const express = require('express')
const bodyParser = require('body-parser')
const crypto = require('crypto')
const { exec } = require('child_process')
require('dotenv').config()

const app = express()
const port = process.env.PORT || 3000
const webhookSecret = "the-webhookk-secret-i-set-when-creating-webhook-in-github"
const repoPath = '/home/ec2-user/repo' // Path to your repository
const gitRepoUrl = 'https://github.com/KristianMeier/cvr-dk-clone.git' // Your Git repository URL
const awsParameterName = 'github_token' // AWS SSM parameter name for GitHub token

app.use(bodyParser.json())

// When creating the Webhook, the Payload URL i gave was https://kkm-terraform.com/min-webhook
app.post('/min-webhook', (req, res) => {
  const signature =
    req.headers['x-hub-signature-256'] || req.headers['x-hub-signature']
  const githubEvent = req.headers['x-github-event']
  const deliveryId = req.headers['x-github-delivery']

  if (!signature || !githubEvent || !deliveryId) {
    return res.status(401).send('Missing headers')
  }

  const payload = JSON.stringify(req.body)
  const hmac = crypto.createHmac('sha256', webhookSecret)
  const digest = `sha256=${hmac.update(payload).digest('hex')}`

  if (signature !== digest) {
    return res.status(401).send('Invalid signature')
  }

  console.log(`Received ${githubEvent} event from GitHub.`)

  // PR, closed and merged
  if (
    githubEvent === 'pull_request' &&
    req.body.action === 'closed' &&
    req.body.pull_request.merged
  ) {
    console.log('Handling push event...')
    const updateScript = `
      cd ${repoPath} &&
      export GIT_TOKEN=$(aws ssm get-parameter --name "${awsParameterName}" --query "Parameter.Value" --output text) &&
      git pull https://${GIT_TOKEN}@${gitRepoUrl} &&
      docker-compose up --build -d
    `

    exec(updateScript, (err, stdout, stderr) => {
      if (err) {
        console.error('Error executing update script:', err)
        return res.status(500).send('Internal Server Error')
      }
      console.log('Update script executed successfully:', stdout)
      res.status(200).send('OK')
    })
  } else {
    console.log(`Received non-push event: ${githubEvent}`)
    res.status(200).send('OK')
  }
})

app.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`)
})
