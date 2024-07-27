install:
	pip install --upgrade pip
	pip install -r requirements.txt

lint:
	pylint hello.py

test:
	pytest

format:
	autopep8 --in-place --agressive --agressive hello.py
