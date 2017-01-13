library(shiny)
library(quantmod)
library(googleCharts)

shinyServer(function(input, output) {
   
  
  ### Gold Prices from FRED ###
  
  # Download Data
  getSymbols.FRED('GOLDAMGBD228NLBM', env = globalenv(), return.class = "data.frame")
  GOLDAMGBD228NLBM$Date <- as.Date(row.names(GOLDAMGBD228NLBM))
  
  # Render Chart
  output$plot <- renderGvis({
    
    gold_plot_data <- GOLDAMGBD228NLBM[GOLDAMGBD228NLBM$Date >= input$dateRange[1] & GOLDAMGBD228NLBM$Date <= input$dateRange[2], ]
    
    gvisLineChart(gold_plot_data,
                  xvar = "Date",
                  yvar = "GOLDAMGBD228NLBM",
                  options = list(
                    title = "Gold Fixing Price 10:30 A.M. (London time) in London Bullion Market, based in U.S. Dollars",
                    titleTextStyle = "{color: '#a3c8f7',
                                       fontName: 'Helvetica',
                                       fontSize: 16,
                                       bold: 'true'}",
                    backgroundColor = "{stroke: 'black',
                                        strokeWidth: 10,
                                        fill: '#49515b'}",
                    colors = "['gold']",
                    backgroundColor.stroke = "white",
                    backgroundColor.strokeWidth = 10,
                    width = 800,
                    height = 400,
                    minorTicks = 5,
                    legend = "none", 
                    vAxis = "{gridlines: {color: '#96b0d1'},
                              textStyle: {color: '#96b0d1'}}", 
                    hAxis = "{slantedText: 'true',
                              slantedTextAngle: 45,
                              gridlines: {color: '#96b0d1'},
                              textStyle: {color: '#96b0d1'}}"
                                )
                  )
  })
  
  output$gold_change <- renderText({
    
    gold_change_data <- GOLDAMGBD228NLBM[GOLDAMGBD228NLBM$Date >= input$dateRange[1] & GOLDAMGBD228NLBM$Date <= input$dateRange[2], ]
    gold_change <- tail(gold_change_data$GOLDAMGBD228NLBM, 1) / head(gold_change_data$GOLDAMGBD228NLBM, 1) - 1
    
    paste0("<br><p style='color:white;font-size:18px'>From ",
           "<span style='font-style:italic;'>",
           input$dateRange[1],
           "</span>",
           " to ",
           "<span style='font-style:italic;'>",
           input$dateRange[2],
           "</span>",
           " gold has changed by ",
           "<span style='font-weight:bold'>",
           round(gold_change * 100, digits = 3),
           "%</span>.")
    })
  
  
})
