library(shiny)

ui <- fluidPage(
  sliderInput("number",
              "Choose a number:",
              min = 1,
              max = 50,
              value = 30),
  textOutput("outputText")
)

server <- function(input, output) {
  output$outputText <- renderText({
    paste("The number you chose is ", input$number)
  })
}

shinyApp(ui = ui, server = server)
