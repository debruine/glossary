
<!-- README.md is generated from README.Rmd. Please edit that file -->

# glossary

<!-- badges: start -->
<!-- badges: end -->

The goal of glossary is to provide a lightweight solution for making
glossaries in educational materials written in quarto or R Markdown.

## Installation

You can install the development version of glossary from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("debruine/glossary")
```

## Quick Start

### Setup

``` r
library(glossary)
```

### Definition File

Set the default path to the definition file.

``` r
glossary_path("inst/glossary.yml")
```

You can store definitions in a YAML file like this:

    alpha: |
      The threshold chosen in Neyman-Pearson hypothesis testing to distinguish test results that lead to the decision to reject the null hypothesis, or not, based on the desired upper bound of the Type 1 error rate. An alpha level of 5% it most commonly used, but other alpha levels can be used as long as they are determined and preregistered by the researcher before the data is analyzed.
    p-value: |
      The probability of the observed data, or more extreme data, if the null hypothesis is true. The lower the p-value, the higher the test statistic, and less likely it is to observe the data if the null hypothesis is true.

### Style

Set a glossary entry style like this at the top of your document (set
the code chunk to `results='asis'`).

``` r
glossary_style(color = "green", text_decoration = "purple underline")
```

<style>
a.glossary {
  color: green;
  text-decoration: purple underline;
}
</style>

### In-Text Terms

Hover over the highlighted terms to see the definition.

Look up a term from the glossary file with `glossary("alpha")`:
<a class='glossary' title='The threshold chosen in Neyman-Pearson hypothesis testing to distinguish test results that lead to the decision to reject the null hypothesis, or not, based on the desired upper bound of the Type 1 error rate. An alpha level of 5% it most commonly used, but other alpha levels can be used as long as they are determined and preregistered by the researcher before the data is analyzed.'>alpha</a>

Display a different value for the term with
`glossary("alpha", "$\\alpha$")`:
<a class='glossary' title='The threshold chosen in Neyman-Pearson hypothesis testing to distinguish test results that lead to the decision to reject the null hypothesis, or not, based on the desired upper bound of the Type 1 error rate. An alpha level of 5% it most commonly used, but other alpha levels can be used as long as they are determined and preregistered by the researcher before the data is analyzed.'>$\alpha$</a>

Use an inline definition instead of the glossary file with
`glossary("beta", def = "The second letter of the Greek alphabet")`:
<a class='glossary' title='The second letter of the Greek alphabet'>beta</a>

Just show the definition with `glossary("p-value", show_def = TRUE)`:
The probability of the observed data, or more extreme data, if the null
hypothesis is true. The lower the p-value, the higher the test
statistic, and less likely it is to observe the data if the null
hypothesis is true.

### Glossary Table

Show the table of terms defined on this page with `glossary_table()`:

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
term
</th>
<th style="text-align:left;">
definition
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
alpha
</td>
<td style="text-align:left;">
The threshold chosen in Neyman-Pearson hypothesis testing to distinguish
test results that lead to the decision to reject the null hypothesis, or
not, based on the desired upper bound of the Type 1 error rate. An alpha
level of 5% it most commonly used, but other alpha levels can be used as
long as they are determined and preregistered by the researcher before
the data is analyzed.
</td>
</tr>
<tr>
<td style="text-align:left;">
beta
</td>
<td style="text-align:left;">
The second letter of the Greek alphabet
</td>
</tr>
<tr>
<td style="text-align:left;">
p-value
</td>
<td style="text-align:left;">
The probability of the observed data, or more extreme data, if the null
hypothesis is true. The lower the p-value, the higher the test
statistic, and less likely it is to observe the data if the null
hypothesis is true.
</td>
</tr>
</tbody>
</table>

Reset the glossary table between sections with `glossary_reset()`.
