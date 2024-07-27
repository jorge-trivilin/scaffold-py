# Scaffold-Py - Continuous integration (CI) simultaneously across multiple cloud platforms

This document provides a comprehensive guide for setting up, configuring, and using the Scaffold-Py repository. It includes all the steps, code, and configuration changes made during the project. This guide is designed for future reference and to ensure you can easily replicate the setup or troubleshoot any issues.

![Version](https://img.shields.io/badge/version-1.0.0-blue)

*Jorge Trivilin.* 

---

## Project Overview
The Scaffold-Py repository provides a structured starting point for Python projects, with a focus on continuous integration (CI) across multiple cloud platforms: GitHub Actions, GCP Cloud Build, and Azure Pipelines. The scaffold includes configurations and tools for linting, testing, and formatting Python code.

## Project Structure
```
scaffold-py/
├── .github/
│   └── workflows/
│       └── python-app.yml
├── .git/
├── logs_26487738085/
├── azure-pipelines.yml
├── azure-pipelines-log.txt
├── buildspec.yml
├── cloudbuild.yaml
├── Dockerfile
├── gcp-cloud-build-log.txt
├── hello.py
├── Makefile
├── README.md
├── requirements.txt
├── test_hello.py
└── test.txt
```
- `.github/workflows/python-app.yml`: Configuration for GitHub Actions to automate testing, linting, and formatting.
- `.git/`: Git repository metadata.
- `logs_26487738085/`: Log files for debugging.
- `azure-pipelines.yml`: Configuration for Azure Pipelines.
- `azure-pipelines-log.txt`: Logs from Azure Pipelines builds.
- `buildspec.yml`: Configuration for AWS CodeBuild.
- `cloudbuild.yaml`: Configuration for GCP Cloud Build.
- `Dockerfile`: Docker image configuration.
- `gcp-cloud-build-log.txt`: Logs from GCP Cloud Build.
- `hello.py`: Example Python script.
- `Makefile`: Makefile to simplify common development tasks.
- `README.md`: This documentation.
- `requirements.txt`: Python dependencies.
- `test_hello.py`: Example test script for `hello.py`.
- `test.txt`: Temporary test file.

## Setup and Configuration

### Prerequisites
Ensure you have Python 3.8 or higher installed. You also need to have `make` installed on your system.

### Initial Setup
1. Clone the repository:
    ```sh
    git clone https://github.com/jorge-trivilin/scaffold-py.git
    cd scaffold-py
    ```

2. Create and activate a virtual environment:
    ```sh
    python3 -m venv venv
    source venv/bin/activate
    ```

3. Install dependencies:
    ```sh
    make install
    ```

### Makefile
The Makefile simplifies common development tasks. Here is the complete Makefile used in the project:
```Makefile
install:
    pip install --upgrade pip
    pip install -r requirements.txt

lint:
    pylint hello.py

test:
    pytest

format:
    autopep8 --in-place --aggressive --aggressive hello.py
```

### requirements.txt
The requirements.txt file lists the dependencies needed for the project:
```
pytest==6.2.5
pylint==2.10.2
autopep8==1.5.7
```

### Example Scripts
#### hello.py
A simple script to demonstrate basic functionality.
```python
"""
This module provides a simple addition function.
"""

def add(num1, num2):
    """This is an add function"""
    return num1 + num2

if __name__ == "__main__":
    print(add(1, 1))
```

#### test_hello.py
Basic tests for the `add` function using pytest.
```python
from hello import add

def test_add():
    assert add(1, 1) == 2
```

## Continuous Integration Across Multiple Clouds

### GitHub Actions

#### Configuration
The `.github/workflows/python-app.yml` file configures GitHub Actions to automate testing, linting, and formatting.
```yaml
name: Python application

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Check out the repository
      uses: actions/checkout@v2
      with:
        token: ${{ secrets.GITHUB_TOKEN }}
    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: 3.8
    - name: Install dependencies
      run: |
        make install
    - name: Lint code
      run: |
        make lint
    - name: Test code
      run: |
        make test
    - name: Format code
      run: |
        make format
    - name: Commit changes
      run: |
        git config --global user.email "jorge.trivilin@gmail.com"
        git config --global user.name "Jorge Trivilin"
        git add hello.py
        git commit -m "Auto-format code" || echo "No changes to commit"
    - name: Push changes
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      run: |
        git push origin main
```

#### Activating GitHub Actions
To activate GitHub Actions for this repository:
1. Ensure that the repository has GitHub Actions enabled.
2. Push any changes to the repository, and the GitHub Actions workflow will automatically run.

#### Configuring GITHUB_TOKEN Permissions
1. Navigate to Repository Settings:
   - Go to the repository on GitHub.
   - Click on Settings.
2. Configure Actions Settings:
   - In the left sidebar, click on Actions.
   - Then click on General.
3. Set Workflow Permissions:
   - Under Workflow permissions, select Read and write permissions.
   - Click Save to save the changes.

### GCP Cloud Build

#### cloudbuild.yaml
The `cloudbuild.yaml` file defines the steps to build and test the application.
```yaml
steps:
  - name: 'python:3.8'
    entrypoint: 'bash'
    args: ['-c', 'pip install --upgrade pip && pip install -r requirements.txt']
  - name: 'python:3.8'
    entrypoint: 'bash'
    args: ['-c', 'make lint']
  - name: 'python:3.8'
    entrypoint: 'bash'
    args: ['-c', 'make test']
  - name: 'python:3.8'
    entrypoint: 'bash'
    args: ['-c', 'make format']
options:
  logging: CLOUD_LOGGING_ONLY
  machineType: 'N1_HIGHCPU_8'
timeout: '1200s'
logsBucket: 'gs://YOUR-BUCKET-NAME'
```

#### Setting Up Cloud Build
1. Create a GCP project and enable the Cloud Build API.
2. Create a bucket for logs.
3. Connect your GitHub repository to Cloud Build.
4. Push changes to trigger the build.

### Azure Pipelines

#### azure-pipelines.yml
The `azure-pipelines.yml` file defines the steps to build, lint, test, and format the application.
```yaml
trigger:
  branches:
    include:
      - main

pool:
  name: 'scaffold-py'

steps:
- task: UsePythonVersion@0
  inputs:
    versionSpec: '3.11'
    addToPath: true

- script: |
    python -m venv myenv
    source myenv/bin/activate
    pip install --upgrade pip
    pip install -r requirements.txt
  displayName: 'Setup Python environment and install dependencies'

- script: |
    source myenv/bin/activate
    pylint hello.py
  displayName: 'Run lint'

- script: |
    source myenv/bin/activate
    pytest
  displayName: 'Run tests'
```

#### Setting Up Azure Pipelines
1. Navigate to Azure DevOps and create a new project.
2. Create a new pipeline and select your repository.
3. Configure the pipeline using `azure-pipelines.yml`.
4. Save and run the pipeline.

#### Setting Up Self-Hosted Agent
1. Download the agent package and extract it.
2. Configure the agent:
   ```sh
   ./config.sh
   ```
3. Run the agent:
   ```sh
   ./run.sh
   ```

#### Configuring Docker Hub Integration
1. Create an access token on Docker Hub.
2. Store the token in Azure DevOps as a pipeline secret.
3. Update your pipeline to use the token for Docker operations.

### Running Tasks Locally
- **Lint the code:**
  ```sh
  make lint
  ```
- **Run tests:**
  ```sh
  make test
  ```
- **Format the code:**
  ```sh
  make format
  ```

## Troubleshooting

### Common Issues
- **Permission Denied for GitHub Actions Push:**
  - Ensure that the `GITHUB_TOKEN` has read and write permissions.
  - Verify that the `GITHUB_TOKEN` is correctly referenced in the workflow file.
  
- **Dependency Installation Issues:**
  - Ensure that the virtual environment is activated.
  - Make sure `requirements.txt` lists all necessary dependencies.

### Logs and Debugging
Check the logs of the GitHub Actions, GCP Cloud Build, and Azure Pipelines run for detailed information about failures. The logs can be accessed from the respective cloud platform's interface.

## Demo
- Video 01: https://youtu.be/AIJ2z2FWF0A
- Video 02: https://youtu.be/HIB8HM3gj68

---

This updated

 documentation should now cover all the steps we took, including the configurations for GCP Cloud Build and Azure Pipelines, the Docker setup, and the necessary troubleshooting steps.
