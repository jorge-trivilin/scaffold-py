# Scaffold-Py

This document provides a comprehensive guide for setting up, configuring, and using the Scaffold-Py repository. It includes all the steps, code, and configuration changes made during the project. This guide is designed for future reference and to ensure you can easily replicate the setup or troubleshoot any issues.

![Version](https://img.shields.io/badge/version-1.0.0-blue)

*Jorge Trivilin.* 

---

## Project Overview

The Scaffold-Py repository provides a structured starting point for Python projects, focusing on continuous integration and code quality. The scaffold includes configurations and tools for linting, testing, and formatting Python code.

## Project Structure

```
scaffold-py/
├── .github/
│   └── workflows/
│       └── python-app.yml
├── hello.py
├── Makefile
├── requirements.txt
└── test_hello.py
```

- **`.github/workflows/python-app.yml`**: Configuration for GitHub Actions to automate testing, linting, and formatting.
- **`hello.py`**: Example Python script.
- **`Makefile`**: Makefile to simplify common development tasks.
- **`requirements.txt`**: Python dependencies.
- **`test_hello.py`**: Example test script for `hello.py`.

---

## Setup and Configuration

### Prerequisites

Ensure you have Python 3.8 or higher installed. You also need to have `make` installed on your system.

### Initial Setup

1. **Clone the repository**:

   ```sh
   git clone https://github.com/jorge-trivilin/scaffold-py.git
   cd scaffold-py
   ```

2. **Create and activate a virtual environment**:

   ```sh
   python3 -m venv venv
   source venv/bin/activate
   ```

3. **Install dependencies**:

   ```sh
   make install
   ```

### Makefile

The `Makefile` simplifies common development tasks. Here is the complete `Makefile` used in the project:

```makefile
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

The `requirements.txt` file lists the dependencies needed for the project:

```text
pytest==6.2.5
pylint==2.10.2
autopep8==1.5.7
```

### Example Scripts

**`hello.py`**: A simple script to demonstrate basic functionality.

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

**`test_hello.py`**: Basic tests for the `add` function using `pytest`.

```python
from hello import add

def test_add():
    assert add(1, 1) == 2
```

---

## Continuous Integration with GitHub Actions

### GitHub Actions Configuration

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

### Activating GitHub Actions

To activate GitHub Actions for this repository:

1. Ensure that the repository has GitHub Actions enabled.
2. Push any changes to the repository, and the GitHub Actions workflow will automatically run.

### Configuring GITHUB_TOKEN Permissions

1. **Navigate to Repository Settings**:
   - Go to the repository on GitHub.
   - Click on `Settings`.

2. **Configure Actions Settings**:
   - In the left sidebar, click on `Actions`.
   - Then click on `General`.

3. **Set Workflow Permissions**:
   - Under `Workflow permissions`, select `Read and write permissions`.
   - Click `Save` to save the changes.

---

## Running Tasks Locally

- **Lint the code**:

  ```sh
  make lint
  ```

- **Run tests**:

  ```sh
  make test
  ```

- **Format the code**:

  ```sh
  make format
  ```

---

## Troubleshooting

### Common Issues

1. **Permission Denied for GitHub Actions Push**:
   - Ensure that the `GITHUB_TOKEN` has `read and write` permissions.
   - Verify that the `GITHUB_TOKEN` is correctly referenced in the workflow file.

2. **Dependency Installation Issues**:
   - Ensure that the virtual environment is activated.
   - Make sure `requirements.txt` lists all necessary dependencies.

### Logs and Debugging

Check the logs of the GitHub Actions run for detailed information about failures. The logs can be accessed from the `Actions` tab in the repository.

---

## Demo

- Video 01:
   - [https://youtu.be/AIJ2z2FWF0A](https://youtu.be/HIB8HM3gj68)
- Video 02:
   - [https://youtu.be/HIB8HM3gj68](https://youtu.be/AIJ2z2FWF0A)
