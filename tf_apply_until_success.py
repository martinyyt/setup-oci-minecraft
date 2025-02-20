import subprocess
import time
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)
handler = logging.StreamHandler()
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)

def run_terraform_apply():
    while True:
        try:
            result = subprocess.run(
                ["terraform", "apply", "-auto-approve"],
                check=True,
                stderr=subprocess.PIPE,
                text=True
            )
            logger.info("Terraform apply succeeded!")
            break
        except subprocess.CalledProcessError as e:
            if "out of host capacity" in e.stderr.lower():
                logger.info(f"Terraform apply failed with 'Out of host capacity' error.\n{e.stderr}\nRetrying in 60 seconds...")
                time.sleep(60)
                continue
            raise e

if __name__ == "__main__":
    logger.info("Starting Terraform apply...")
    run_terraform_apply()
