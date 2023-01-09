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

# run the following: python my_app.py -m dataloader=local,redshift
