library(shiny)

ui <- fluidPage(
   titlePanel("Old Faithful Geyser Data"),
   
   sliderInput("bins",
               "Number of bins:",
               min = 1,
               max = 50,
               value = 30),
   
   plotOutput("distPlot")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
}

shinyApp(ui = ui, server = server)
