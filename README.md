### A simple scaffold-py project

![Version](https://img.shields.io/badge/version-1.0.0-blue)

*This project was created by Jorge Trivilin.* 

*Connect with Jorge here:*

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Jorge_Trivilin-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/jorgetrivilin/)

```markdown
# Scaffold-Py

This repository provides a scaffold for Python projects with a focus on continuous integration and code quality. The scaffold includes setup for linting, testing, and formatting using tools like `pylint`, `pytest`, and `autopep8`.

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

## Getting Started

### Prerequisites

Ensure you have Python 3.8 or higher installed. You also need to have `make` installed on your system.

### Setup

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

### Running Tasks

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

### Continuous Integration

This project is set up with GitHub Actions for continuous integration. The workflow is defined in `.github/workflows/python-app.yml` and includes steps for installing dependencies, linting, testing, and formatting the code.

To trigger the CI pipeline, simply push changes to the repository:

```sh
git add .
git commit -m "Your commit message"
git push origin main
```

## Example Scripts

### `hello.py`

A simple script to demonstrate basic functionality:

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

### `test_hello.py`

Basic tests for the `add` function using `pytest`:

```python
from hello import add

def test_add():
    assert add(1, 1) == 2
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

```

This README file provides an overview of the project, instructions for setting up the environment, and details on how to run various tasks. It also includes information on the project's structure and continuous integration setup. Feel free to modify it to better suit your project's needs.
