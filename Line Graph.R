#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
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

# Run the application 
shinyApp(ui = ui, server = server)

library(shiny)
library(readr)
library(plotly)

ui <- fluidPage(
    titlePanel("Past Data Visualization"),
    sidebarLayout(
        sidebarPanel(
            fileInput("data_file", "Choose a CSV file:"),  # Input for uploading CSV file
            selectInput("x_var", "Select X-axis variable:", choices = NULL),  # Input for X-axis variable selection
            selectInput("y_var", "Select Y-axis variable:", choices = NULL)  # Input for Y-axis variable selection
        ),
        mainPanel(
            plotlyOutput("line_plot")
        )
    )
)

    

    


server <- function(input, output, session) {
    data <- reactive({
        req(input$data_file)
        read_csv(input$data_file$datapath)
    })
    
    observe({
        var_choices <- colnames(data())
        updateSelectInput(session, "x_var", choices = var_choices)
        updateSelectInput(session, "y_var", choices = var_choices)
    })
    
    output$line_plot <- renderPlotly({
        if (is.null(input$x_var) || is.null(input$y_var)) return()
        
        p <- plot_ly(data(), x = ~.data[[input$x_var]], y = ~.data[[input$y_var]], type = "scatter", mode = "lines+markers") %>%
            layout(
                title = paste("Line Graph of", input$y_var, "over", input$x_var),
                xaxis = list(title = input$x_var),
                yaxis = list(title = input$y_var),
                hovermode = "closest"
            )
        
        p
    })
}

shinyApp(ui, server)
