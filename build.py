"""Merge the individual scripts into a single file for easy distribution.

Call from the root directory like:

    python build.py

"""
import os


ROOT_DIR = os.path.dirname(os.path.dirname(__file__))
LICENSE_FILE = os.path.join(ROOT_DIR, "LICENSE.txt")
SOURCE_DIR = os.path.join(ROOT_DIR, "mxs_types")
SOURCE_FILES =  [os.path.join(SOURCE_DIR, "mxs_dict.ms"),
                 os.path.join(SOURCE_DIR, "mxs_defaultdict.ms"),
                 os.path.join(SOURCE_DIR, "mxs_set.ms")]
TARGET_FILE = os.path.join(ROOT_DIR, "mxs_types.ms")

SEPARATION = "\n" * 3


def get_license():
    with open(LICENSE_FILE) as f:
        return f.read()


def remove_fileins(lines):
    for line in lines:
        stripped = line.strip()
        if not stripped.startswith("fileIn"):
            yield line


def build():
    if os.path.isfile(TARGET_FILE):
        os.remove(TARGET_FILE)
    with open(TARGET_FILE, "w") as f:
        license = get_license()
        f.write(license + SEPARATION)
        for scriptfile in SOURCE_FILES:
            scriptpath = os.path.join(ROOT_DIR, scriptfile)
            raw_lines = open(scriptpath).readlines()
            lines = list(remove_fileins(raw_lines))
            content = "".join(lines)
            f.write(content + SEPARATION)

    print ("Build created at:", TARGET_FILE)


if __name__ == "__main__":
    build()
