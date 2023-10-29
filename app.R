library(shiny)

# hot load changes in development
options(shiny.autoreload = TRUE)

sideSliderInput <- function(name) {
  sliderInput(name, name, value = 10, min = 0, max = 100, step = 1)
}

ui <- function(request) {
  fluidPage(
    mainPanel(
      sideSliderInput("length"),
      sideSliderInput("width"),
      checkboxInput("check1", "Not in query state"),
    )
  )
}
server <- function(input, output, session) {
  # Exclude vector of input IDs from query params
  setBookmarkExclude(c("check1"))
  
  observe({
    session$doBookmark()
  })

  # after bookmarkmarking event, render query params in browser 
  onBookmarked(updateQueryString)
}

# set bookmarking option, it can be one of:

#   * `url` -- write to query params, eg localhost:5551/?_inputs_&width=50&length=100
#   * `server` -- write to file. The file name is appended to url, eg localhost?_state_id_=020928f10faae863
#   * `none` -- valid, but you would never do this, just omit `enableBookmarking`
shinyApp(ui, server, enableBookmarking = "url")