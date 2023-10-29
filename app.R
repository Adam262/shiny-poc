library(shiny)

# hot load changes in development
options(shiny.autoreload = TRUE)

rectSideInput <- function(name) {
  sliderInput(name, paste("Rectangle", " ", name), value = 100, min = 0, max = 500, step = 1)
}

ui <- function(request) {
  
  fluidPage(
    titlePanel("Query Params in Shiny"),
    checkboxInput("check1", "Disable query params", value = FALSE),
    rectSideInput("width"),
    rectSideInput("height"),
    textOutput("rectangle_area"),
    uiOutput("rectangle_plot"),
  )
}
server <- function(input, output, session) {

  observe({
  # Exclude vector of input IDs from query params
  if (input$check1) {
    setBookmarkExclude(c("check1", "width", "height"))
  } else {
    setBookmarkExclude(c("check1"))
  }
    session$doBookmark()
  })

  # after bookmarkmarking event, render query params in browser 
  onBookmarked(updateQueryString)

  output$rectangle_area <- renderText({
    paste("The area of the rectangle is", sep = " ", input$height * input$width)
  }) 

  output$rectangle_plot <- renderUI({
    rect_style <- paste0(
      "width: ", input$width, "px; ",
      "height: ", input$height, "px; ",
      "background-color: ", "lightblue"
    )
    
    div(style = rect_style)
  })
}

# set bookmarking option, it can be one of:

#   * `url` -- write to query params, eg localhost:5551/?_inputs_&width=50&height=100
#   * `server` -- write to file. The file name is appended to url, eg localhost?_state_id_=020928f10faae863
#   * `none` -- valid, but you would never do this, just omit `enableBookmarking`
shinyApp(ui, server, enableBookmarking = "url")