library(shiny)
library(here)

measuresloc_df <- read.csv(here("data/measuresloc.csv"))
var_choices <- names(measuresloc_df)[c(5:35)]
year_choices <- c(2008:2017)

shinyUI(navbarPage("Maternity Data for New York", 
                   tabPanel("Leaflet", 
                            sidebarPanel(
                              selectInput("var",
                                          label = "Select a variable",
                                          choices = var_choices)), 
                            mainPanel()
                            ), 
                   tabPanel("Line", 
                            sidebarPanel(
                              selectInput("var",
                                          label = "Select a variable",
                                          choices = var_choices), 
                              selectInput("county", 
                                          label = "Select a county", 
                                          choices = measuresloc_df$Hospital.County)), 
                            mainPanel()
                            ), 
                   tabPanel("Scatter1", 
                            sidebarPanel(selectInput("var",
                                                     label = "Select a variable",
                                                     choices = var_choices), 
                                         selectInput("xyear", 
                                                     label = "Select a year for the x-axis", 
                                                     choices = year_choices), 
                                         selectInput("yyear", 
                                                     label = "Select a year for the y-axis", 
                                                     choices = year_choices)), 
                            mainPanel()
                            ), 
                   tabPanel("Scatter2", 
                            sidebarPanel(selectInput("var",
                                                     label = "Select a year",
                                                     choices = year_choices), 
                                         selectInput("xvar", 
                                                     label = "Select a variable for the x-axis", 
                                                     choices = var_choices), 
                                         selectInput("yvar", 
                                                     label = "Select a variable for the y-axis", 
                                                     choices = var_choices)), 
                            mainPanel()
                   )
))

# leafletOutput("leaflet")
# plotlyOutput("line")
# plotlyOutput("scatter1")
# plotlyOutput("scatter2")