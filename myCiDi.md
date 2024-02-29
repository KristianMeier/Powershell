# Chat-GPT
* https://chat.openai.com/c/7717f89e-395a-4bae-aa05-aa602ae569fd

# Azure Pipelines
- Det samme som Github
- Skriv noget CI yml (test/lintin når pr lavet)
- Skriv noget CD yml (deploy, når pr merged*)
*evt. branch-protection: status-check

# Github Actions:
- (express backend, react frontend, express listener, terraform)
- `dockercompose.yml`
- `ci.yml` (kører unit tests)

# Overall
- Github Action does the CI (integrates and tests the codes smoothly).
- Github Webhook og min Express Listener stor for Continous Delivery.
- Note: Githb Action kan også lave CD

# Flow (Github Action ci.yml, Webhooks Listener CD)
- App is running
- (M) I push new code
- (M) I create a PR.
## CI
- (A) Ci.yml is triggered by PR
- (A) Testing/listinig starts
- (M) PR is merged*
## CD (with webhook and listener)
- (A) Webhook is trigged, sends event
- (A) Listener (running on the VM) receives event
- (A) Listener (running on the VM) pulls new code and runs docker-compose

* waited for test to be done due to branch-protection

# Flow (Github Action cd.yml and cd.yml)
- App is running
- (M) I push new code
- (M) I create a PR.
## CI
- (A) Ci.yml is triggered by PR
- (A) Testing/listinig starts
- (M) PR is merged*
## CD (cd.yml)
- (A) Github Actions SSHs into the VM
- (A) Github Action pulls code and run's docker-compose

* waited for test to be done due to branch-protection

## Branch protection*
- I "Prptect matching branches" vælg: "Require status checks to pass before merging".
- Vælg navnet du har kaldt dit CI,
- This means I can create the PR, while the test are running
- Test are being run

# docker-compose-yml
```
version: '3.8'
services:
  backend:
    build: ./backend
    container_name: backend
    ports:
      - '4000:4000'
  deployment:
    build: ./deployment
    container_name: deployment
    ports:
      - '4001:4001'
  frontend:
    build: ./frontend
    container_name: frontend
    ports:
      - '80:3000'
```

# cd.yml
```
name: Deploy on PR Merge to Main
on:
  pull_request:
    branches:
      - main
    types: [closed]
jobs:
  deploy:
    runs-on: ubuntu-latest
    if: github.event.pull_request.merged == true
    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Setup SSH
      uses: webfactory/ssh-agent@v0.5.3
      with:
        ssh-private-key: ${{ secrets.SSH_PRIVATE_KEY }}

    - name: Deploy to AWS EC2
      run: |
        # Ensure SSH does not prompt for verification of host
        echo "$HOST ecdsa-sha2-nistp256 
        # Denne laves med ssh-keygen
        AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBB..." >> ~/.ssh/known_hosts
        # SSH to EC2 instance and run Docker Compose commands
        ssh -o StrictHostKeyChecking=no -l ec2-user ${{ secrets.HOST }} << EOF
          cd /path/to/your/docker-compose/project
          git pull
          docker-compose up -d --build
        EOF
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        HOST: ${{ secrets.HOST }}
```

# ci.yml
```
name: mit-github-actionos-ci
on:
  pull_request:
    branches: [ main ]
    types: [opened, synchronize, reopened, ready_for_review]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Set up Node.js
      uses: actions/setup-node@v1
      with:
        node-version: '14'

    - name: Install Backend Dependencies
      run: npm install
      working-directory: ./backend

    - name: Run Backend Tests
      run: npm test
      working-directory: ./backend

    - name: Install Frontend Dependencies
      run: npm install
      working-directory: ./frontend

    - name: Run Frontend Tests
      run: npm test
      working-directory: ./frontend
```

# Backend Test
```
describe('GET /api/hello', () => {
  it('responds with a json message', async () => {
    const response = await request(app).get('/api/hello');
    expect(response.statusCode).toBe(200);
    expect(response.body).toEqual({ message: 'Hello, World!' });
  });
});
```

# Backend package.json
```
  "scripts": {
    "start": "node app.js",
    "test": "jest"
  },
  "dependencies": {
    "express": "^4.17.1"
  },
  "devDependencies": {
    "jest": "^27.0.0",
    "supertest": "^6.1.3"
  },
```

# Frontend Test
```
describe('HelloWorld Component', () => {
  it('renders the correct message', () => {
    render(<HelloWorld />);
    const messageElement = screen.getByText(/hello, world!/i);
    expect(messageElement).toBeInTheDocument();
  });
});
```

# Frontend package.json`

```
  "dependencies": {
    "react": "^17.0.2",
    "react-dom": "^17.0.2",
    "react-scripts": "4.0.3"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
```

### Note
Jest and @testing-library/react are included implicitly by react-scripts, so you don't need to install them separately for basic testing needs.

# Github Webhook
Go to the Repo ini question -> Go to setting -> Go to Webhooks.

# Listener
```
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

```
