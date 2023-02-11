This article lives on: 
- [Meduim](https://medium.com/@armand-sauzay/shap-values-machine-learning-interpretability-and-feature-selection-made-easy-feb8765f815b)
- [Dev.to](https://dev.to/armandsauzay/shap-values-machine-learning-interpretability-and-feature-selection-made-easy-396k)

# SHAP values: Machine Learning interpretability and feature selection made easy.
Machine learning interpretability with hands on code with SHAP.

![Photo by Edu Grande on Unsplash](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*9q9Wr6rz5Li6IZcgLD7_Ig.jpeg)
<p align="center">Photo by Edu Grande on Unsplash</p>

Machine Learning interpretability is becoming increasingly important, especially as ML algorithms are getting more complex.

How good is your Machine Learning algorithm if it cant be explained? Less performant but explainable models (like linear regression) are sometimes preferred over more performant but black box models (like XGBoost or Neural Networks). This is why research around machine learning explainability (aka eXplainable AI or XAI) has recently been a growing field with amazing projects like SHAP emerging.

> Would you feel confident using a machine learning model if you can't explain what it does?

This is where SHAP can be of great help: it can explain **any ML model** by giving the influence of each of the features on the target. But this is not all that SHAP can do. 

Build a simple model (sklearn/xgboost/keras) and use SHAP: you now have a feature selection process by looking at features which have the biggest impact on the prediction.
But how does SHAP work under the hood? And how can you start using it?

In this article we'll first get our hands on some python code to see how you can start using SHAP and how it can help you both for explainability and feature selection. 

Then, for those of you who want to get into the details of SHAP, we'll go through the theory behind popular XAI tools like SHAP and LIME.

---

All the code for this tutorial can be found on Kaggle [here](https://www.kaggle.com/code/armandsauzay/shap-interpret-any-ml-model-feature-selection?scriptVersionId=99746743). Feel free to run the notebook yourself or create a copy!

---

## 1. How can you start using SHAP?

Here, we'll go through a simple example with Shap values using the competition Kaggle competition "House Prices - Advanced Regression Techniques" to illustrate SHAP. If you are interested or you have never been on Kaggle before, feel free to read more about the data and the competition itself here.

The process to use shap is quite straightforward: we need to build a model and then use the shap library to explain it.
![Explanation of how to use SHAP in your Machine Learning Project](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*BG6W1B8OW6gUVHPbBXIvIA.png)

understand the output of your modelHere, our machine learning model tries to predict the house prices from the data that is given (number of square feet, quality, number of floors etc).

The usual workflow in terms of code looks like this:
1. Create an estimator. For instance GradientBoostingRegressor from sklearn.ensemble:
    ```python
    estimator = GradientBoostingRegressor(random_state = random_state)
    ```
2. Train your estimator:
    ```python
    estimator.fit(X_train, y_train)
    ```
3. use shap library to calculate the SHAP values. For instance, using the following code:
    ```python
    explainer = shap.Explainer(estimator.predict, X100)
    shap_values = explainer(X100)
    ```
4. See what is the impact of each feature using shap.summary_plot:
    ```python 
    shap.summary_plot(shap_values, max_display=15, show=False)
    shap.summary_plot(shap_values, max_display=15, show=False)
    ```
![Summary plot of feature importance](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*9M6mMjsGH_nj0BG_7uJpCg.png)

For instance, you can see here that OverallQual is the feature that has the most impact on the model output. High values (colored in red on the graph above) of OverallQual can increase a property's price by ~60,000 and low values can decrease a price by ~20,000. Interesting to know if you're in real estate, isn't it?

But this is not all of what SHAP can do! SHAP can also explain a single prediction.

For example, using shap.plots.waterfall for a single element in the dataset, you can have the following:
```python
shap.plots.waterfall(shap_values[sample_index], max_display=14)
```
![Waterfall plot of feature importance for a single example](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*AGEnQK781FHnjEwexOklbg.png)

For this specific example, the predicted price was 166k (vs 174k on average). And we can understand why the algorithm predicted such: for instance OverallQual which is high (7) drives the value up but YearBuilt (1925) drives the value down.

You can now understand the dynamics behind your model, both overall and on specific datapoints. With SHAP, you can more easily see if something is wrong (or does not make sense for your sharpened data science mind) so you can correct it! This is what observability is about.

And since SHAP allows you to understand the feature importance of your model, you can also use this for feature selection. For instance
```python 
shap.summary_plot(shap_values, max_display=15, show=False, plot_type='bar')
```
![Barplot of feature importance](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*LPp8lnK6n2peGk1wbBb8Og.png)

Then you can see which features do not have a lot of impact on the output of the model. The features usually are noise for your machine learning model and do not bring a lot of predictive value. So removing them from your training set will generally improve the performance, and allow you to tune correctly the hyper parameters without overfitting on noisy data.
![Worfklow for feature selection in your machine learning project](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*zI3DWLj7E71y4jyVHHJx9g.png)
<p align="center"> How SHAP can be used for feature selection </p>


## 2. Quick overview: How does SHAP work under the hood?

If you have a bit of time, feel free to read the original paper that describes the different approaches for model explainability and goes through the advantages of SHAP.

But let's try to explain in short what SHAP is doing and the concepts behind without getting too deep into the mathematical equations.

Explainable Machine Learning (aka eXplainable AI or XAI) aims at understanding why the output of a machine learning model is such. To do so, you could theoretically take the definition of your model, for example a tree based model like Random Forest, and then see why your output is such. But this is not so straightforward, and of course, it gets even more complex for Deep Learning models…

Instead of going through the winding path of understanding what happens inside your model (forward and backward propagation for deep learning models, which splits are the most used in your RF algo etc). But once you have your trained model, could you not instead use it to see how it reacts when you change a feature?

This is the core concept behind popular XAI algorithm (SHAP, LIME etc): use your existing model, approximate it using an explainable model and you now have an explainable model. The complexity is now on how to approximate a ML model around a given prediction, and then around most predictions.

If you are interested in this and want to learn more, let me know and I'll write a follow up article on the mathematical concepts behind SHAP, how it is related to the classic Shapley values, how you can compute SHAP values and how we are able to approximate it for specific use cases, which makes the computation easier.

---

Woohoo! You now know the basics on how SHAP works and how you can start using it right away in your machine learning projects!

---

I hope you liked this article! Let me know if you have any questions or suggestions. Also feel free to contact me on LinkedIn, GitHub or Twitter, or checkout some other tutorials I wrote on DS/ML best practices. Happy learning!

Sources:
- [official documentation](https://shap.readthedocs.io/en/latest/index.html)
- [original paper](https://proceedings.neurips.cc/paper/2017/file/8a20a8621978632d76c43dfd28b67767-Paper.pdf)

## About me
Hey! 👋 I'm Armand Sauzay ([armandsauzay](https://twitter.com/armandsauzay)). You can find, follow or contact me on: 

- [Github](https://github.com/armand-sauzay) 
- [Twitter](https://twitter.com/armandsauzay)
- [LinkedIn](https://www.linkedin.com/in/armand-sauzay-80a70b160/)
- [Medium](https://medium.com/@armand-sauzay)
- [Dev.to](https://dev.to/armandsauzay)