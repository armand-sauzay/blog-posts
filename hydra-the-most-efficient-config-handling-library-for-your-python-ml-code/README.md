# Hydra, the most efficient config handling library for your Python/ML code
Improve your python code by using hydra for configuration.

![](https://miro.medium.com/max/1400/1*PoU6CMaYh6uNWgYn0AX7bg.webp)
<center>
Photo by Ferenc Almasi on Unsplash
</center>

In this tutorial, we’ll go through some available options that you might encounter for config handling, then explain why hydra is my favorite pick, and finally go through some code examples to highlight the key functionalities of Hydra.

## Context and available options
As one works on a Python project, especially for machine learning, the number of parameters rapidly increases. Soon comes the question: what is the ideal way to store my parameters?

Let’s go through a few options you might have encountered.

- __hardcoding__: Should I hardcode them in some random places in my code? Probably not.
- __yaml/json__: Should I create a simple YAML file? Or json file? And import with json.load? Doesn’t seem very pythonic, does it?
- __config.py__: Should I create a config.py file where I put all my parameters? That’s nice, but lets say I want to run 10 experiments, would I want to go back to my config.py file and change the values 1 by 1 before re-running. Once again, probably not.
- __dotenv__: Should I use something like dotenv? Same as config.py, it does not seem ideal if we play with a lot of parameters.
- __other tools__: I also tried other tools like dynaconf, or docopt or configparser (the python native configuration parser). But nothing comes close to hydra, which is an amazing tool for configuring python code.

Hydra notably allows for a clear yaml-format configuration, the ability to instantiate objects, running multiple tasks and many other features that you’ll probably love or found missing in other libraries. As described in the hydra official documentation:

The key feature is the ability to dynamically create a hierarchical configuration by composition and override it through config files and the command line. The name Hydra comes from its ability to run multiple similar jobs — much like a Hydra with multiple heads.

--- 

Without further due, let’s get right into the code and understand why hydra is the clear winner for configuration file a handling.

--- 

All of the code for this tutorial can be found [here](https://github.com/armand-sauzay/blog-posts/). You can clone the repo to easily navigate through the different sections in this tutorial.


## Requirements:
- having Conda (miniconda) installed and a basic understanding of Conda environment. If you’re not familiar with this, check out the article I wrote on that subject [here](https://medium.com/dev-genius/using-conda-environments-for-python-all-you-need-to-know-2eb36e224d1c)
- having a basic understanding of the command line / terminal. If you’re not familiar with this, check out the article I wrote on that subject [here](https://medium.com/@armand-sauzay/a-simple-guide-to-using-the-command-line-aka-terminal-e030dbf18afe)

## Code

### 1. Basic example (folder 1_basic_example on the GitHub repo)
In this example, we’re going to go though the basic of hydra. There are two files
```yaml
#config.yaml
db:
  driver: mysql
  table: bar
  user: bar
  password: foo
```

```python
# my_app.py 
import hydra
from omegaconf import DictConfig, OmegaConf
@hydra.main(config_path=".", config_name="config")
def my_app(cfg: DictConfig) -> None:
    print(OmegaConf.to_yaml(cfg))
    print(f"reading data with username {cfg.db.user}")
if __name__ == "__main__":
    my_app()
```

From the terminal, navigate to `1_basic` and run `python my_app.py`.

You see that in the file `my_app.py`, the function my_app has been decorated with `@hydra.main()` with 2 parameters `config_path` and `config_name`:

- `config_path=”.”` → looking for a config file in the same folder as the script
- `config_name=”config’` → looking for a config file named config(.yaml is implicit) in the config_path, which means the current folder.
This decoration will load the config file in cfg. And you can then access it in your code. If we want to access the value of user from the db section of the config file, we just have to write cfg.db.user. As easy as this.

Now, let’s try a nice added functionality of hydra, the multirun. Lets say we want to run this job with 2 different parameters (for example db.table). For this you can simply run the following:

```
python my_app.py -m db.table=bar,foo
```
→ this will launch 2 jobs (-m stands for multirun): one with db.table=bar and one with db.table=foo

### 2. Config groups (folder 2_config_groups on the GitHub repo)

```python
#my_app.py
import logging
import hydra
from omegaconf import DictConfig
log = logging.getLogger(__name__)
@hydra.main(config_path="configs", config_name="config")
def my_app(cfg: DictConfig) -> None:
    log.info("Info level message")
    log.debug("Debug level message")
    print(f"driver={cfg.dataloader.type}, timeout={cfg.dataloader.timeout}")
if __name__ == "__main__":
    my_app()
```
```yaml
#config.yaml
defaults:
  - dataloader: local
  - _self_
dataloader:
  type: foo
```

The idea is to simplify the main config file and be able to create groups in the yaml to make it even more configurable. Here, the decorator indicates that we are in a folder called configs and that the main config file is named config (.yaml is implicit).

Then, in `configs/config.yaml`, the defaults: argument indicates that there exists a subfolder called dataloader, in which there are multiple configurations for dataloader.

Finally, in `configs/config.yaml`, the argument `_self_` is required and indicates the precedence. In this case, `_self_` is the last line, so it indicates that the defaults will be overwritten by values hardcoded outside of the default yaml. If `_self_` is at the beginning, the value from the defaults is used.

Now if you want to try the multi-run approach of hydra you can run the following:

```
python my_app.py -m dataloader=local,redshift
```
→ this will launch 2 jobs (`-m` stands for multirun): one with `dataloader=local` and one with `dataloader=redshift`. Of course, this is very useful for hyper parameter tuning.

### 3. Instantiation (folder 3_instantiation on the GitHub repo)

What happens when you want to pass python objects as part of your config. For instance, let’s say you want to test different ML algorithms in a simple Sklearn project and you want to try a XGBoost model and a Logistic Regression. Hydra allows you to do that!!

Let’s go through this example which has 2 files

```python
#my_app.py
import hydra
import pandas
import sklearn.ensemble
from hydra.utils import instantiate
from omegaconf import DictConfig, OmegaConf
@hydra.main(config_path=".", config_name="config")
def my_app(cfg):
    print(OmegaConf.to_yaml(instantiate(cfg)))
    model = instantiate(cfg.model.feature_extractor)
    print(model)
if __name__ == "__main__":
    my_app()
```
```yaml
#config.yaml
model:
  feature_extractor:
    _target_: sklearn.ensemble.GradientBoostingClassifier
    random_state: 0
    n_estimators: 500
    learning_rate: 0.01
    max_depth: 2
bar:
  a: 1
  b: 2
foo:
  a: ${bar.a}
```

In the yaml, you need to pass a `_target_` (note that this name is a convention so dont modify it or you wont be able to instantiate your object) as the first line of the object we want to instantiate. Following lines are parameters for the object we wish to instantiate. For instance, here, `instantiate(cfg.model.feature_extractor)` will lead to ```sklearn.ensemble.GradientBoostingClassifier(random_state=0, n_estimators-500, learning_rate: 0.0, max_depth: 2)```. Pretty cool right?

--- 

Woohoo! You now know how to use hydra for config, creating config groups, instantiating objects. Feel free to checkout on the repo the 4th section on the popular plugin Optuna for bayesian optimization.

Hope you liked this article! Don’t hesitate if you have any question, or suggestions, in comments, or feel free to contact me on LinkedIn, GitHub or Twitter, or checkout some other tutorials I wrote on DS/ML best practices.

## About me
Hey! 👋 I'm Armand Sauzay ([armandsauzay](https://twitter.com/armandsauzay)). You can find, follow or contact me on: 

- [Github](https://github.com/armand-sauzay) 
- [Twitter](https://twitter.com/armandsauzay)
- [LinkedIn](https://www.linkedin.com/in/armand-sauzay-80a70b160/)
- [Medium](https://medium.com/@armand-sauzay)
- [Dev.to](https://dev.to/armandsauzay)