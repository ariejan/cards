# Cards

Easily create PDF story cards from Agilefant Excel exports.

## Installation

    bundle install

## Usage

Download an export of the current Agilefant sprint. XLS format is okay. Put
that file in the root of this project and rename it to `data.xls`.

Then run:

    bundle exec go.rb

Depending on the size of the sprint, this will generate a `stories.pdf` file
with one user story per page.

Print this file with 9-on-a-page and you're done.
