library(shiny)

shinyUI(fluidPage(

    selectInput("choice", "Selecciona la variable que deseas en el eje X",
                choices = c("weight", "acceleration", 
                            "horsepower", "cylinders")),
    downloadButton("report", "Generar informe")
    
))
