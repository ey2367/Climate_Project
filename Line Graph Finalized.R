install.packages("zoo")
install.packages(c("tidyr", "lubridate"))
library(shiny)
library(readr)
library(plotly)
library(tidyr)     # 新添加的tidyr库
library(lubridate) # 新添加的lubridate库

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
    df <- read_csv(input$data_file$datapath)
    
    # 如果选择的x变量是月份数据，则进行处理
    if('month' %in% colnames(df)) {
      df$month <- as.Date(as.yearmon(df$month, format = "%Y-%m"))
      # 补全数据中的所有月份
      df <- df %>%
        complete(month = seq.Date(min(month), max(month), by="month"))
    }
    df
  })
  
  observe({
    var_choices <- colnames(data())
    updateSelectInput(session, "x_var", choices = var_choices)
    updateSelectInput(session, "y_var", choices = var_choices)
  })
  
  output$line_plot <- renderPlotly({
    if (is.null(input$x_var) || is.null(input$y_var)) return()
    
    # 计算刻度值
    date_range <- range(data()[[input$x_var]])
    tickvals <- seq(date_range[1], date_range[2], by="6 months")
    
    p <- plot_ly(data(), x = ~.data[[input$x_var]], y = ~.data[[input$y_var]], type = "scatter", mode = "lines+markers") %>%
      layout(
        title = paste("Line Graph of", input$y_var, "over", input$x_var),
        xaxis = list(title = input$x_var, tickvals = tickvals, tickformat = "%Y-%m"),  # 调整X轴格式为每6个月一个刻度
        yaxis = list(title = input$y_var),
        hovermode = "closest"
      )
    p
  })
}

shinyApp(ui, server)
