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
