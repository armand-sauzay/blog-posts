
# Pre-commit checks to format your files and commit messages
Stop committing wrongly formatted code and start using pre-commit checks.

![](https://miro.medium.com/max/1400/1*-zO5GC_wdGUDuOb6R-IelA.webp)
<center>Photo by Roman Synkevych 🇺🇦 on Unsplash </center>

## Introduction

How many times have you seen a commit message like 'test' or 'modif' or 'reran notebook'?

Commit messages can be very useful and their format can help get the relevant information in a simple look. This is what conventional commits is trying to achieve: standardize the commit format to be able to navigate through commits easily and understand what code update they were associated to. But how could we make sure all commits followed this format?

File formatting can also be quite challenging when more than one person works on a GitHub repository. How could we make sure that all the files committed to a repository have the same format? Or that you do have the extra empty line at the end of your file that some system require to successfully run?

This is where standardization makes our life easier, especially when enforced before the commits: black formatting for python, getting rid of trailing whitespaces, etc.

Long story short, all the formatting issues that you might had to deal with or that created useless commits could be avoided by using pre-commit checks.

Without further due, let's see how we can implement these concepts to an actual GitHub repository (if you need more context on conventional commits feel free to skip to the appendix and come back here after).

---
<center>

All of the code for this tutorial can be found [here](https://github.com/armand-sauzay/blog-posts/pre-commit-checks-to-format-your-files-and-commit-messages)
</center>

---

## Get started with pre-commit checks
### Step 1: Install pre-commit
To install pre-commit, simply run
``` bash
brew install pre-commit
```
This will install pre-commit on your machine.

### Step 2: Add pre-commit checks to your repo

To be able to add pre-commit checks that make sure your files and commit messages are correctly formatted, you simply need to add __2 files__ at the root of your repo:
- __.pre-commit-config.yaml__: defines the checks you want to run
- __.commitlintrc.yaml__: defines the npm package you use for pre commits.

``` yaml
# .commitlintrc.yaml
extends:
  - "@open-turo/commitlint-config-conventional"
```


``` yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v2.3.0
    hooks:
    -   id: check-yaml
    -   id: end-of-file-fixer
    -   id: trailing-whitespace
  - repo: https://github.com/alessandrojcm/commitlint-pre-commit-hook
    rev: v8.0.0
    hooks:
      - id: commitlint
        stages: [commit-msg]
        additional_dependencies: ["@open-turo/commitlint-config-conventional"]
```

Once you added those files, you can try adding a commit, the pre commit checks defined will make sure that:
- yaml files are correctly formatted
- files have an extra empty line at the end (this is considered best practice as some systems fail when this condition is not met)
- get rid of trailing whitespaces
- make sure that the commits follow the [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) format.

To see if this worked, try to commit those files to your repo with some commit message like
git commit -m 'feat: enabled pre-commit checks'

---

Woohoo! You now know how to add pre commit checks to your own repository to make sure your file format are consistent and your commit messages too!

---

## Apendix

__Appendix 1__: A word on Conventional Commits
With conventional commits, the commit message should be structured as follows:
```
<type>[optional scope]: <description>
[optional body]
[optional footer(s)]
```
For example (from commit conventional docs):
```
feat: allow provided config object to extend other configs
BREAKING CHANGE: `extends` key in config file is now used for extending other config files
```

__Appendix 2__: adding a python code formatter to pre-commit checks
Additional content: if you want to add a python code formatter, like black, you can append to the end of .pre-commit-config.yaml
``` yaml
- repo: https://github.com/psf/black
    rev: 21.12b0
    hooks:
    - id: black
```

## About me
Hey! 👋 I'm Armand Sauzay ([armandsauzay](https://twitter.com/armandsauzay)). You can find, follow or contact me on: 

- [Github](https://github.com/armand-sauzay) 
- [Twitter](https://twitter.com/armandsauzay)
- [LinkedIn](https://www.linkedin.com/in/armand-sauzay-80a70b160/)
- [Medium](https://medium.com/@armand-sauzay)
- [Dev.to](https://dev.to/armandsauzay)