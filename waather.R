library(shiny)
library(ggplot2)
library(plotly)

# Baca data
data <- read.csv("LOKASI PENEMPATAN DATA CSV", header = TRUE, sep = ",")

if (!"Rainfall" %in% colnames(data)) {
  stop("Kolom 'Rainfall' tidak ditemukan dalam dataset.")
}

# UI
ui <- fluidPage(
  titlePanel("Visualisasi Data Rainfall"),
  mainPanel(
    tabsetPanel(
      tabPanel("Scatter Plot", plotlyOutput("scatterPlot")),
      tabPanel("Line Plot", plotlyOutput("linePlot"))
    )
  )
)

# Server
server <- function(input, output) {
  # Scatter Plot
  output$scatterPlot <- renderPlotly({
    gg <- ggplot(data, aes(x = seq_along(Rainfall), y = Rainfall)) +
      geom_point(color = "blue", size = 2) +
      labs(title = "Scatter Plot - Rainfall", x = "Index", y = "Rainfall") +
      theme_minimal()
    ggplotly(gg)
  })
  
  # Line Plot
  output$linePlot <- renderPlotly({
    gg <- ggplot(data, aes(x = seq_along(Rainfall), y = Rainfall)) +
      geom_line(color = "red", size = 1) +
      labs(title = "Line Plot - Rainfall", x = "Index", y = "Rainfall") +
      theme_minimal()
    ggplotly(gg)
  })
}

# Menampilkan Aplikasi
shinyApp(ui = ui, server = server)
