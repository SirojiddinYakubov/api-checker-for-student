#!/usr/bin/make

PYTHON := $(shell which python3 || which python)
PIP := $(shell which pip3 || which pip)
VENV_EXISTS := $(shell [ -d venv ] && echo 1 || echo 0)

env:
    ifeq ($(VENV_EXISTS),0)
		$(PIP) install virtualenv && $(PYTHON) -m venv venv && . venv/bin/activate && pip install -r requirements.txt && pre-commit install
    else
		@echo "Virtual environment (venv) already exists."
		. venv/bin/activate && pip install -r requirements.txt && pre-commit install
    endif
run:
	make env && $(PYTHON) manage.py migrate && $(PYTHON) manage.py runserver
