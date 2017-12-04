# red

Following the naming scheme of `ed`, `qed`, and `sed`, `red` is a **r**ange **ed**itor for large files.

```
NAME
     red -- range editor

SYNOPSIS
     red start end input [output]

DESCRIPTION
     Loads a range of a given file into vim, and either writes in place, or
     writes to a new file.

     Useful for making precise edits to predetermined ranges in large
     (~100mb) files without having to load the entire file into memory.

EXAMPLES
     red 1 20 largefile.txt
```

## Installation

Place `red.sh` somewhere accessible in your `$PATH`.

Example:

```bash
git clone https://github.com/timhwang21/red.git
ln -s $( pwd )/red/red.sh /usr/local/bin/red
```
