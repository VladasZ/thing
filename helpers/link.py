
import os


def _get_home():
    if "HOME" in os.environ:
        return os.environ["HOME"]
    return os.path.expanduser("~")
    

home = _get_home()

print(home)

os.symlink(home + "/thing/.shell/config", home + "/.ssh/config")
