"""Merge the individual scripts into a single file for easy distribution.

Call from the root directory like:
    python misc/merge.py

"""
import os


ROOT_DIR = os.path.dirname(os.path.dirname(__file__))
TARGET_FILE = os.path.join(ROOT_DIR, "mxs_types.ms")


def remove_license_header(lines):
    struct_found = False
    for line in lines:
        if line.strip().startswith("struct "):
            struct_found = True
        if struct_found:
            yield line


def main():
    scriptfiles = ["mxs_dict.ms",
                   "mxs_set.ms"]

    with open(TARGET_FILE, "w") as f:
        for scriptfile in scriptfiles:
            scriptpath = os.path.join(ROOT_DIR, scriptfile)
            lines = open(scriptpath).readlines()
            lines = list(remove_license_header(lines))
            content = "".join(lines)
            f.write(content + "\n" * 3)


if __name__ == "__main__":
    main()
