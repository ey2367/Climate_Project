install.packages("shiny")
install.packages("readr")
install.packages("plotly")
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

server <- function(input, output,session) {
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
