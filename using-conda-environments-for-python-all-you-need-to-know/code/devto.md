
**Conda environments and environment variables made simple for your python projects.**



![Photo by Kristijan Arsov on Unsplash](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ebjp5mlvub55g6pr3st7.png)

---

All of the code for this tutorial can be found [here](https://github.com/armand-sauzay/best-practices/tree/main/tutorials/conda_environment).

---

> Python code is great, but being able to reproduce the code is even better! This is why all python projects should come with something that defines the packages and versions to be able to run that exact same code: an environment.

> Then comes the question: how can I create my code environment?

There are many possibilities. 

First, I am sure all of you have used the following: `pip install <package>`

But how do we then keep track of the packages we installed and their version? 

This is where virtualenv (native Python environment manager) could come handy. But what happens when you have projects in different python versions? You'd need to use pyenv (native Python version manager) to make sure you use the right version of python. And then virtualenv to make sure you use the right package version…

It would be great if a tool could do all of this, wouldn't it? **This is why conda exists**. 

In short, in most cases (except for work that will end in production), conda covers all of what you would need, does some magic behind the scene so you don't have to worry about environments, and has some great added benefits, like allowing you to define environment variables.

Without further due, let's learn more about conda!

In this tutorial, we'll cover the following:
1. Basic conda commands: create, list, activate and deactivate
2. environment.yaml and its use
3. Defining environment variables through conda


---

### 1. Basic conda commands: create, list, activate and deactivate

If you haven't installed conda, you can start by installing [miniconda](https://docs.conda.io/en/latest/miniconda.html). If you are not sure, open a terminal and run `conda list` 

Once the installation is complete, run `conda list` to make sure you have conda installed.

_The following commands are bash commands_

#### a. create your environment: 
`conda create --name conda-tutorial python=3.8`
→ here we create an environment called conda-tutorial with python 3.8 installed. → NOTE: if it asks whether to proceed, type y and enter

#### b. list existing environments
`conda env list`
→ you should be able to see the newly created environment

#### c. activate your environment
`conda activate conda-tutorial`
→ you're now in your conda virtual environment. So the python code you execute should find its python version and the packages currently installed through this environment.
→ to check this, you can type in terminal: which python.
→ also you can install package by typing conda install <package>
→ we'll see later how we can use an environment.yaml to not have manual installs

#### d. deactivate your environment
`conda deactivate`

#### e. Lastly, if you want, remove your environment
`conda env remove --name <your_environment_name>`
→ note that you need to first deactivate your current environment if you wish to remove it

---

Nice! You can now create an environment in which to run your code which can greatly help for reproducibility! You can also bookmark the conda cheat sheet for your future use cases
But, let's be honest, running a lot of conda install <package> is not that great for reproducibility. So let's see hwo we can use environment.yaml files.

---

### 2. environment.yaml and its use

Let's create an environment file with pandas installed and test it. For this we need two files
#### 1. A simple python file named `conda_tutorial_pandas.py` which imports pandas and prints its version.

```
### conda_tutorial_pandas.py file
import pandas as pd
if __name__ == "__main__":    
    print(pd.__version__)
```

#### 2. A file called environment_pandas.yaml and paste the following in it:

```
### environment_pandas.yaml file
name: conda-tutorial
channels:
  - conda-forge
  - defaults
dependencies:
    - python=3.8
    - pandas=1.4.2
```

→ This file will create an environment named conda-tutorial with python 3.8 and pandas 1.4.2.
If you don't have an environment named conda-tutorial, you can run
`conda env create --file environment_pandas.yaml`
If you do have an environment named conda-tutorial, you can run
`conda env update --file environment_pandas.yaml`

Now, you can activate the environment conda-tutorial and from terminal, run `python conda_tutorial_pandas.py`. It should print out: 1.4.2.

---

Let's now go a step further and let's create environment variable so you don't have to worry about credentials being leaked for instance.

---

### 3. Environment variables
#### a. Create the shell scripts that will activate and deactivate your environment variables.

```
cd $CONDA_PREFIX 
mkdir -p ./etc/conda/activate.d 
mkdir -p ./etc/conda/deactivate.d 
touch ./etc/conda/activate.d/env_vars.sh 
touch ./etc/conda/deactivate.d/env_vars.sh
```

#### b. add the following to export your environment variables when you activate your environment
`nano $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh`
then paste the following:

```
export MY_KEY='secret-key-value' 
export MY_FILE=/path/to/my/file/
```
then click ctrl+o and then ctrl+x. If you don't want to use nano, you can also manually create this file with its content.

#### c. to unset your environment variables when you deactivate your environment
`nano $CONDA_PREFIX/etc/conda/deactivate.d/env_vars.sh`
Then paste the following

```
unset MY_KEY 
unset MY_FILE
```

then click ctrl+o and then ctrl+x. If you don't want to use nano, you can manually create this file with its content.

Now let's create a python file named `conda_tutorial_environment_variables.py` which will print out these environment variables


```
### conda_tutorial_environment_variables.py file
import os
if __name__ == "__main__": 
    print(os.getenv("MY_KEY")) 
    print(os.getenv("MY_FILE"))
```

Now, activate your conda environment by running `conda activate <my_env>` first and then:
`python conda_tutorial_environment_variables.py`

---

Woohoo! You now know how to create and manage a conda environment and create environment variables in your environment so you don't have to worry about hardcoding credentials in your code!!

---

Hope you liked this article! Don't hesitate if you have any question, or suggestions, in comments, or feel free to contact me on LinkedIn, GitHub or Twitter, or checkout some other tutorials I wrote on DS/ML best practices.

### About me
You can follow me, contact me, or see what I do on the following platforms:

- [GitHub: armand-sauzay](https://github.com/armand-sauzay)
- [Twitter: @armandsauzay](https://twitter.com/armandsauzay)
- [LinkedIn](https://www.linkedin.com/in/armand-sauzay-80a70b160/)
- [Medium: armand-sauzay](https://medium.com/@armand-sauzay)
