# 5 tools I wish I knew when I started writing Machine Learning code

This article lives on: 
- [Meduim](https://medium.com/@armand-sauzay/5-tools-i-wish-i-knew-when-i-started-writing-machine-learning-code-55b429d06f32)
- [Dev.to](https://dev.to/armandsauzay/5-tools-i-wish-i-knew-when-i-started-writing-machine-learning-code-575f)
--- 
A few tools that will get you on the right track for your Machine Learning projects using python.


![Image description](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*dbOgJi1lNK72h_NjKh7OdQ.jpeg)
Photo by ray rui on Unsplash

A few years back, I first learnt how to write machine learning code as I took my first ML class while pursuing my graduate studies in Applied Mathematics. 

I learnt about the Math behind classic ML algorithms, got my hands on popular python libraries for like scikit-learn, PyTorch and Tensorflow, and participated in my first Kaggle competition on the Titanic dataset.

Fast forward a few years, after a pursuing my graduate studies in Machine Learning at UC Berkeley, I now work on developing machine learning models that end up being used in production and at scale.

And, of course, the code I now write is very different from the Python Notebooks I used to write when I originally started. 

Even though I still use notebooks for the exploration part, my final code is structured using only python files, often containerized, and integrated using CI/CD and triggered by workflow management tools.

## Environment management tool like conda or poetry

The first thing to consider when you write code is to create an environment for you code to live in.

For Data Science / Machine learning, the best tool around for environments is probably Conda at first. Then for production it's probably more poetry. But let's keep this discussion for another article and talk a bit about conda.

Conda has the benefits of being a version manager and a package manager, it allows you to easily define environments, make sure the package versions are compatible with each other and has some cool perks like being able to define environment variables. If you want to learn more about this tool or if you want a quick refresher, you can go through the article I wrote on that subject:

[Using Conda environments for Python, all you need to know](https://blog.devgenius.io/using-conda-environments-for-python-all-you-need-to-know-2eb36e224d1c)

## Configuration tools like hydra

Another thing is that Data Science / Machine Learning code often comes with a lot of parameters (hyper parameters, where to log artifacts, preprocessing steps etc..).

For configuration, one of the nicest tool around is Hydra. From the hydra documentation itself:

> The key feature is the ability to dynamically create a hierarchical configuration by composition and override it through config files and the command line. The name Hydra comes from its ability to run multiple similar jobs - much like a Hydra with multiple heads.

Hydra makes it easy to set up your config parameters, create config groups, and even instantiate objects from your config. If you want to learn more about this tool, and want to have a code tutorial to get up to speed on it, feel free to check out the article I wrote about it: [Hydra, the most efficient config handling library for your Python/ML code](https://medium.com/@armand-sauzay/hydra-the-most-efficient-config-handling-library-for-your-python-ml-code-9178d491523c)

## Using the terminal (best way to navigate through files)

Something that can be a bit of a pain when starting to write code but that will make your life 10x easier once you get used to it is to use the terminal / command line interface to navigate through files and perform actions.

If you want a quick overview of the basic actions you can perform with the terminal, feel free to check out the article I wrote: [Command Line 101: a Basic Guide to Using the Terminal](https://medium.com/@armand-sauzay/a-simple-guide-to-using-the-command-line-aka-terminal-e030dbf18afe)

## MLFlow (ML artifact handling tool)

A lot of tools exist to help with the machine learning lifecycle: for ML experiments, for Model Registry, for packaging your ML code or putting your models in production. MLFlow has all of these capabilities.

But you might agree with me, production machine learning is kind of a niche use case and unless you work for a big marketplace company or FAANG you might not need to deploy your models in production…

However, in general, you might want to have a place to store all your ML experiments results and know which validation score was obtained with which hyper parameters etc. This is exactly what MLFlow Tracking has to offer.
In short, in seconds, you can simply log your artifacts and, by typing mlflow ui in your terminal, you will instantly start a mlflow server on `http://127.0.0.1:5000/` that will read from your `mlruns` folder. You can then easily navigate through your experiments and see all the metrics, parameters and artifacts you logged.

## Github Actions (or another CI/CD tool)

Once you work in a context where your ML models need to be retrained or integrated to some architecture or even write daily ETLs you will quickly realize that a lot of actions can be automated with a CI/CD tool like Jenkins or GitHub actions (for ETLs Airlfow is considered a better pick but that's another subject). From the GitHub documentation: 
> GitHub Actions makes it easy to automate all your software workflows, now with world-class CI/CD

Examples of CI/CD include build/push-ing docker images, pre-commit checks, automated testing and much more. If you want more details, let me know and I'll write a quick tutorial on how GitHub Actions can be used for ML code.

---

Of course there are many more tools that are absolutely amazing and that I use on a daily basis such as cloud platforms like AWS or GCP, Docker or Visual Studio Code to mention but a few. If you'd like more details about how industry standards for these tools, feel free to reach out!

---

Hope you liked this article! Don't hesitate if you have any question, or suggestions, in comments, or feel free to connect on LinkedIn, GitHub or Twitter.

## About me
Hey! 👋 I'm Armand Sauzay ([armandsauzay](https://twitter.com/armandsauzay)). You can find, follow or contact me on: 

- [Github](https://github.com/armand-sauzay) 
- [Twitter](https://twitter.com/armandsauzay)
- [LinkedIn](https://www.linkedin.com/in/armand-sauzay-80a70b160/)
- [Medium](https://medium.com/@armand-sauzay)
- [Dev.to](https://dev.to/armandsauzay)