# glossary (development version)

# glossary 1.0.9003

* Fixed a bug where terms could have multiple matches (e.g., "alpha" would match both "alpha" and "alpha (graphics)")

# glossary 1.0.9002

* Added `add_to_quarto()` to set up a quarto book with a persistent glossary
* `glossary_style()` now has an `inline` argument (default TRUE) for easier use in creating inline css versus writing to a linked CSS file

# glossary 1.0.9001

* Added `glossary_load_all()` to load all definitions in a glossary file 
* Added `glossry_persistent()` to create a persistent list of used definitions that loads between chapters when creating quarto books or other projects where definitions are added across multiple environments

# glossary 1.0.0

# glossary 0.0.0.9002

* Cleaned up popup display of definitions with lists or line breaks
* Fixed bug when setting `glossary_path(NULL)`
* Added `create` argument to `glossary_path()` to control whether a new file should be created if it doesn't exist
* Fixed bug in link to psyteachr glossary

# glossary 0.0.0.9001

* Added a `NEWS.md` file to track changes to the package.
* Added popup styles and default to "click"
