library(shiny)
library(shinythemes)
library(shiny)
library(quantmod)
suppressPackageStartupMessages(library(googleVis))

shinyUI(navbarPage(title = "Economic Indicators",
                   theme = shinytheme("slate"),
                   fluid = TRUE,
                   tabPanel("Controls",
                            mainPanel(dateRangeInput('dateRange',
                                                     label = 'Date range',
                                                     start = Sys.Date() - 7, end = Sys.Date()
                                                    )
                                      )
                            ),
                   tabPanel("FRED",
                            htmlOutput("plot"),
                            htmlOutput("gold_change")
                           )
                  )
        )