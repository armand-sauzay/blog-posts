import hydra
from omegaconf import DictConfig, OmegaConf


@hydra.main(config_path=".", config_name="config")
def my_app(cfg: DictConfig) -> None:
    print(OmegaConf.to_yaml(cfg))
    print(f"reading data with username {cfg.db.user}")


if __name__ == "__main__":
    my_app()
