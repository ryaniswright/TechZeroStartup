# Taskbook 

## Setup instructions
### *These instructions are a general set of steps that you will need to take to successfully install Taskbook on your local machine and run it. The commands may vary slightly depending on environment. If you do not know exactly what a command does, look it up so you can troubleshoot in the case of an error.*
## Setup
1. Make sure that you have python 3.8 installed and in your PATH
2. Make sure that you have pipenv installed. To install, run `pip install pipenv`
3. Clone this git repository using `git clone https://github.com/ryaniswright/TechZeroStartup.git`
4. Create a python 3.8 environment with `python3 -m pipenv --python 3.8`
5. Download the requirements with `python3 -m pipenv install` (you must do this every time you pull)
6. Activate the virtual environment with `python3 -m pipenv shell`
7. Run `python setup.py` to generate the prepopulated tasks
8. Run `python swift.py` and navigate to `localhost:8080` in your web browser
