import os 
import sys

def act():
    """
    find and activate a python virtual environment
    """
    envs = []
    for root, _, files in os.walk(os.getcwd()):
        if 'activate' in files:
            envs.append(os.path.join(root, 'activate'))
    if not envs:
        print(f"No virtual environment 'activate' script found in {os.getcwd()} ")
        print(" ")
        return None
    if len(envs) == 1:
        selected_env = envs[0]
        print(f"activating {selected_env}")
        return None 
    print("multiple environments found, select from:", file=sys.stderr)
    for i, env in enumerate(envs):
        print(f"{i +1}: {env}", file = sys.stderr)
    print("-"*50, file = sys.stderr)
    try:
        print("Select environment number: ", file = sys.stderr)
        choice = int(input())
        if 1 <= choice <= len(envs):
            selected_env = envs[int(choice) - 1]
            print(f"activating {selected_env}")
            return None
        else:
            print("Invalid choice.", file=sys.stderr)
    except ValueError:
        print("Invalid input.", file=sys.stderr)
    return None 

if __name__ == "__main__":
    act()
