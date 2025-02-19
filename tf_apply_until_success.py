import subprocess
import time

def run_terraform_apply():
    while True:
        try:
            result = subprocess.run(["terraform", "apply", "-auto-approve"], check=True)
            print("Terraform apply succeeded!")
            break
        except subprocess.CalledProcessError as e:
            print(f"Terraform apply failed with exit code {e.returncode}. Retrying in 60 seconds...")
            time.sleep(60)

if __name__ == "__main__":
    run_terraform_apply()
