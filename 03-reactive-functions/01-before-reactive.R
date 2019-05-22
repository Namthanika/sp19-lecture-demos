library(ggplot2)
library(dplyr)
library(shiny)


# Let's make an interactive Shiny application about air passengers!
# The dataset is built into R, but it is impossible to use without some data wrangling:
data <- data.frame(
  year = rep(1949:1960, each = 12),
  month = month.abb,
  passengers = AirPassengers # in thousands
)


ui <- fluidPage(
  titlePanel("Air Passengers"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("years",
                  "Year range",
                  min = min(data$year),
                  max = max(data$year),
                  value = c(min(data$year), max(data$year)),
                  sep = "",
                  step = 1)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Plot by Year", plotOutput("yearPlot")),
        
        tabPanel("Table by Year", tableOutput("yearTable"))
      )
    )
  )
)


server <- function(input, output) {
  # Plot: passengers over time by year
  output$yearPlot <- renderPlot({
    # First, filter to the specified date range:
    data %>% 
      filter(year >= input$years[1], year <= input$years[2]) %>% 
    
    # Summarize data by year:
      group_by(year) %>% 
      summarize(passengers = sum(passengers)) %>% 
      
    # Finally, plot the data!
      ggplot(aes(x = year, y = passengers, group = 1)) +
      labs(
        title = 'Passengers over time by year',
        x = 'Year',
        y = 'Passengers (thousands)'
      ) +
      geom_line(size = 2, color = 'red')
  })
  
  # Table: passengers over time by year
  output$yearTable <- renderTable({
    # First, filter to the specified date range:
    data %>% 
      filter(year >= input$years[1], year <= input$years[2]) %>% 
      
      # Summarize data by year:
      group_by(year) %>% 
      summarize(passengers = sum(passengers))
  })
}


# Run the application 
shinyApp(ui = ui, server = server)






