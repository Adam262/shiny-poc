## Overview

This is a demo of the Shiny web developmemt framework. In particular, I wanted to learn how to make a robust bookmarkable page using query params

## Local Development

* git clone repo
* Open an R terminal in the app directory

### In the R terminal

```bash
install.packages("shiny")
# You may also need to run library(shiny)
runApp()
```
* The last step will run the project in a browse. The app has hot loading, so any development changes will cause a browser refresh

### Local View-only

If you just want to run the project locally without cloning, do the following in an R terminal

```bash
install.packages("shiny")
library(shiny)
runGitHub("shiny-poc", "Adam262")
```

## Deployment

I deployed this app via [shinyapps.io](https://shinyapps.io). See https://adambarcan.shinyapps.io/shiny-poc