## Test environments

* local: x86_64-apple-darwin17.0, R 4.2.1
* win-builder (release): x86_64-w64-mingw32, R 4.3.0
* win-builder (devel): x86_64-w64-mingw32, R 2023-05-24 r84463 ucrt
* rhub: Ubuntu Linux 20.04.1 LTS, R-release, GCC
* rhub: Fedora Linux, R-devel, clang, gfortran
* rhub: Windows Server 2022, R-devel, 64 bit

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## Response to Beni Altmann's comments

> Please add \value to .Rd files regarding exported methods and explain the functions results in the documentation. 

Done. All functions that return non-NULL values have a \value entry and documentation is more detailed.

> Please replace \dontrun with \donttest...In your examples/vignettes/tests you can write to tempdir().

I wanted to make sure I wasn't accidentally changing user options if they run the examples. I've changed them to use files in the tempdir and reset options to original.
