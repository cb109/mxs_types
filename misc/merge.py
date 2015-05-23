"""Merge the individual scripts into a single file for easy distribution.

Call from the root directory like:
    python misc/merge.py

"""
import os


ROOT_DIR = os.path.dirname(os.path.dirname(__file__))
LICENSE_FILE = os.path.join(ROOT_DIR, "LICENSE.txt")
TARGET_FILE = os.path.join(ROOT_DIR, "mxs_types.ms")


def get_license():
    with open(LICENSE_FILE) as f:
        return f.read()


def main():
    scriptfiles = ["mxs_dict.ms",
                   "mxs_set.ms"]

    separation = "\n" * 3
    with open(TARGET_FILE, "w") as f:
        license = get_license()
        f.write(license + separation)
        for scriptfile in scriptfiles:
            scriptpath = os.path.join(ROOT_DIR, scriptfile)
            content = open(scriptpath).read()
            content = content.strip()
            f.write(content + separation)

    print ("Scripts merged to:", TARGET_FILE)

if __name__ == "__main__":
    main()
