"""Merge the individual scripts into a single file for easy distribution.

Call from the root directory like:

    python build.py

"""
import os


ROOT_DIR = os.path.dirname(os.path.dirname(__file__))
SOURCE_DIR = os.path.join(ROOT_DIR, "mxs_types")
LICENSE_FILE = os.path.join(ROOT_DIR, "LICENSE.txt")
TARGET_FILE = os.path.join(ROOT_DIR, "mxs_types.ms")

SEPARATION = "\n" * 3


def get_license():
    with open(LICENSE_FILE) as f:
        return f.read()


def build():
    scriptfiles = [os.path.join(SOURCE_DIR, "mxs_dict.ms"),
                   os.path.join(SOURCE_DIR, "mxs_set.ms")]

    os.remove(TARGET_FILE)
    with open(TARGET_FILE, "w") as f:
        license = get_license()
        f.write(license + SEPARATION)
        for scriptfile in scriptfiles:
            scriptpath = os.path.join(ROOT_DIR, scriptfile)
            content = open(scriptpath).read()
            content = content.strip()
            f.write(content + SEPARATION)

    print ("Build created at:", TARGET_FILE)


if __name__ == "__main__":
    build()
