# digital-archive
Create and maintain digital archive for paper scanned documents with metadata

This is set of simple shell scripts with hardcoded paths with zenity GUI to
scan paper document, attach some metadata in YAML format and store in filesystem.

# Prerequisities

- zenity
- sane-backends
- bash

# Installation

Clone the repo into `/home/archive` and create `/home/archive/documents` directory
where the scanned documents and metatada will be stored.

Update `tags` file with list of prefered tags to be used on documents.

Put the `archivedoc.desktop` to `/usr/share/applications`

# Use

Run `archivedoc.sh` script it will prompt for details of the scanned document
such as data, tags, comments. Then it will prompt to insert document into scanner.
You can scan multiple documents.

If you wish to add one more scan into existing archived document then lauch
`archivedoc-add-scan.sh` 
