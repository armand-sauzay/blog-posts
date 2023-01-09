import sklearn.ensemble
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline


def create_pipeline(
    numerical_imputer,
    numerical_scaler,
    categorical_imputer,
    categorical_encoder,
    categorical_features,
    numerical_features,
    estimator,
):
    numerical_transformer = Pipeline(
        steps=[
            ("numerical_imputer", numerical_imputer),
            ("numerical_scaler", numerical_scaler),
        ]
    )
    categorical_transformer = Pipeline(
        steps=[
            ("categorical_imputer", categorical_imputer),
            # ("categorical_encoder",  LabelBinarizer())]
            ("categorical_encoder", categorical_encoder),
        ]
    )
    preprocessor = ColumnTransformer(
        transformers=[
            ("num", numerical_transformer, numerical_features),
            ("cat", categorical_transformer, categorical_features),
        ]
    )
    clf = Pipeline(  # or just Pipeline if we don't care about PMML format
        steps=[("preprocessor", preprocessor), ("classifier", estimator)]
    )
    return clf
