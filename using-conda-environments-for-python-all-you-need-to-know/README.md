# Conda environment 101

You can find a the detailed article of the following on: 
- [medium](https://medium.com/dev-genius/using-conda-environments-for-python-all-you-need-to-know-2eb36e224d1c)
- [dev.to](https://dev.to/armandsauzay/using-conda-environments-for-python-all-you-need-to-know-2n5p)

Pre-requisite: First you need to install [miniconda](https://docs.conda.io/en/latest/miniconda.html). You can install it under /Users/<your_username>

In this tutorial, we'll cover the following:

1. [create, list, activate and deactivate](#1-create-list-activate-and-deactivate)
2. [environment.yaml and its use](#2-environmentyaml-and-its-use)
3. [environment variables](#3-environment-variables)


## 1. create, list, activate and deactivate
If you hadn't installed miniconda, you can verfy that your installation by opening a terminal and typing the following
```bash
conda list
```

**The following commands are bash commands

- create your environment
    ```bash
    conda create --name conda-tutorial python=3.8
    ```
    → here we create an environment called `conda-tutorial` with python 3.8 installed.
    →  _NOTE: if it asks whether to proceed, type y and enter_


-  list existing environments
    ```bash
    conda env list
    ```

    → you should be able to see the newly created environment

-  activate your environment
    ```bash
    conda activate conda-tutorial
    ```
    → you're now in your conda virtual environment.

    →  to check this, you can type in terminal:  `which python`.

    → also you can install package by typing `conda install <package>`

    → we'll see later how we can use an environment.yaml to not have manual installs

-  deactivate your environment
    ```bash
    conda deactivate
    ```

- If you want, remove your environment
    ```bash
    conda env remove --name <your_environment_name>
    ```

    → note that you need to first deactivate your current environment if you wish to remove it

Nice! You can now create an environment in which to run your code which can greatly help for reproducibility!

But running a lot of `conda install <package>` is not that great for reproducibility. So let's see hwo we can use environment.yaml files.


## 2. environment.yaml and its use
Lets create an environment file with pandas installed.

Create a file called `environment_pandas.yaml` and paste the following in it:

```yaml
name: conda-tutorial

channels:
  - conda-forge
  - defaults

dependencies:
    - python=3.8
    - pandas=1.4.2
```

→ This file will create an environment named `conda-tutorial` with python 3.8 and pandas 1.4.2.

If you don't have an environment named conda-tutorial
```bash
conda env create --file environment_pandas.yaml
```

If you do have an environment named conda-tutorial
```bash
conda env update --file environment_pandas.yaml
```

Now, take a look at conda_tutorial_pandas.py file, activate the environment `conda-tutorial` and from terminal, run `python conda_tutorial_pandas.py`. It should print out: `1.4.2.`

Let's now go a step further and let's create environment variable so you don't have to worry about credentials being leaked for instance.

## 3. Environment variables

- Create the shell scripts that will activate and deactivate your environment variables.

    ```bash
    cd $CONDA_PREFIX
    mkdir -p ./etc/conda/activate.d
    mkdir -p ./etc/conda/deactivate.d
    touch ./etc/conda/activate.d/env_vars.sh
    touch ./etc/conda/deactivate.d/env_vars.sh
    ```

- add your variables to your conda environment
    - add the following to export your environment variables when you activate your environment
        ```bash
        nano $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
        ```

        then paste the following:
        ```
        export MY_KEY='secret-key-value'
        export MY_FILE=/path/to/my/file/
        ```
        - then click ctrl+o and then ctrl+x

    - add the following to unset your environment variables when you deactivate your environment
        ```
        nano $CONDA_PREFIX/etc/conda/deactivate.d/env_vars.sh
        ```

        Then paste the following
        ```
        unset MY_KEY
        unset MY_FILE
        ```
        - then click ctrl+o and then ctrl+x


Now, activate your conda environment, and run
```
python conda_tutorial_environment_variables.py
```

Woohoo! You now know how to create and manage a conda environment and create environment variables in your environment so you don't have to worry about hardcoding credentials in your code!!
