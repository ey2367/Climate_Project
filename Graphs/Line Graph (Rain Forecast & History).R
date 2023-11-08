library(shiny)
library(plotly)

ui <- fluidPage(
  titlePanel("Combination of Line and Bar Graphs"),
  sidebarLayout(
    sidebarPanel(
      # You can add input elements here if needed
    ),
    mainPanel(
      plotlyOutput("combo_plot")
    )
  )
)

server <- function(input, output) {
  # Define your dataset here (replace 'your_data' with your actual data)
  rain_data <- data.frame(
    Year = c(2023, 2022, 2021, 2020, 2019, 2018, 2017, 2016, 2015, 2014, 2013, 2023, 2022, 2021, 2020, 2019, 2018, 2017, 2016, 2015, 2014, 2013, 2023, 2022, 2021, 2020, 2019, 2018, 2017, 2016, 2015, 2014, 2013, 2023, 2022, 2021, 2020, 2019, 2018, 2017, 2016, 2015, 2014, 2013),
    Month = c(2023.7, 2022.7, 2021.7, 2020.7, 2019.7, 2018.7, 2017.7, 2016.7, 2015.7, 2014.7, 2013.7, 2023.6, 2022.6, 2021.6, 2020.6, 2019.6, 2018.6, 2017.6, 2016.6, 2015.6, 2014.6, 2013.6, 2023.8, 2022.8, 2021.8, 2020.8, 2019.8, 2018.8, 2017.8, 2016.8, 2015.8, 2014.8, 2013.8, 2023.9, 2022.9, 2021.9, 2020.9, 2019.9, 2018.9, 2017.9, 2016.9, 2015.9, 2014.9, 2013.9),
    RainHistory = c(0, 0, 0, 312.9, 182.1, 98.4, 225.2, 216.8, 74.6, 346.5, 310.2, 0, 0, 0, 312.9, 182.1, 98.4, 225.2, 216.8, 74.6, 346.5, 310.2, 0, 0, 0, 312.9, 182.1, 98.4, 225.2, 216.8, 74.6, 346.5, 310.2, 0, 0, 0, 312.9, 182.1, 98.4, 225.2, 216.8, 74.6, 346.5, 310.2),
    RainForecast = c(60.3, 15.6, 20.4, 27.2, 41.9, 48, 26.9, 16.5, 51.8, 35.9, 15.9, 48.2, 18, 32.6, 21.1, 34.5, 34.3, 22.4, 17.1, 41.5, 33.2, 24.8, 43.7, 23.3, 24.2, 20.7, 36.5, 42, 26.2, 17.4, 38, 27, 20.5, 0, 17.8, 22.1, 24.2, 52.9, 35.8, 14.9, 17.6, 35.7, 19.3, 22)
  )
  
  rain_data<-rain_data[order(rain_data$Year, rain_data$Month),]
  
  output$combo_plot <- renderPlotly({
    plot_ly(data = rain_data, type = 'scatter', mode = 'lines', x = ~Year, y = ~RainHistory, name = 'Rain History') %>%
      add_trace(type = 'bar', x = ~Month, y = ~RainForecast, name = 'Rain Forecast', yaxis = 'y2') %>%
      layout(title = "Rain History and Forecast",
             yaxis2 = list(overlaying = "y", side = "right", title = "Bar Data"),
             xaxis = list(title = "Time"),
             yaxis = list(title = "Line Data")
      )
  })
}

shinyApp(ui, server)