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
        license = f.read()
        return license.strip()


def process_scriptcontent(content):
    """Removes unwanted fileIn()'s and whitespace
    that should not be part of the final build."""
    content = content.strip()
    lines = content.split("\n")

    def _filter_lines(lines):
        struct_def_found = False
        for line in lines:
            if line.strip().startswith("struct "):
                struct_def_found = True
            if struct_def_found:
                yield line

    lines = list(_filter_lines(lines))
    fixed_content = "\n".join(lines)
    return fixed_content


def build():
    if os.path.isfile(TARGET_FILE):
        os.remove(TARGET_FILE)
    with open(TARGET_FILE, "w") as f:
        license = get_license()
        f.write(license + SEPARATION)
        for scriptfile in SOURCE_FILES:
            scriptpath = os.path.join(ROOT_DIR, scriptfile)
            content = open(scriptpath).read()
            fixed_content = process_scriptcontent(content)
            f.write(fixed_content + SEPARATION)

    print ("Build created at:", TARGET_FILE)


if __name__ == "__main__":
    build()
