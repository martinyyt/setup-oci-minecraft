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
            result = subprocess.run(["terraform", "apply", "-auto-approve"], check=True)
            logger.info("Terraform apply succeeded!")
            break
        except subprocess.CalledProcessError as e:
            logger.info(f"Terraform apply failed with exit code {e.returncode}. Retrying in 60 seconds...")
            time.sleep(60)

if __name__ == "__main__":
    logger.info("Starting Terraform apply...")
    run_terraform_apply()
