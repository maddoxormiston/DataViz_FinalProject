library(shiny)
library(here)

measuresloc_df <- read.csv(here("data/measuresloc.csv"))
var_choices <- names(measuresloc_df)[c(5:35)]
year_choices <- c(2008:2017)

shinyUI(navbarPage("Maternity Data for New York", 
                   tabPanel("Leaflet", 
                            sidebarPanel(
                              selectInput("leafletvar",
                                          label = "Select a variable",
                                          choices = var_choices), 
                              selectInput("leafletyear",
                                         label = "Select a year",
                                         choices = year_choices)), 
                            mainPanel(leafletOutput("leaflet"))
                            ), 
                   tabPanel("Line", 
                            sidebarPanel(
                              selectInput("linevar",
                                          label = "Select a variable",
                                          choices = var_choices), 
                              selectInput("linecounty", 
                                          label = "Select a county", 
                                          choices = measuresloc_df$Hospital.County)), 
                            mainPanel(plotlyOutput("line"))
                            ), 
                   tabPanel("Scatter1", 
                            sidebarPanel(selectInput("var1",
                                                     label = "Select a variable",
                                                     choices = var_choices), 
                                         selectInput("xyear1", 
                                                     label = "Select a year for the x-axis", 
                                                     choices = year_choices), 
                                         selectInput("yyear1", 
                                                     label = "Select a year for the y-axis", 
                                                     choices = year_choices)), 
                            mainPanel()
                            ), 
                   tabPanel("Scatter2", 
                            sidebarPanel(selectInput("year2",
                                                     label = "Select a year",
                                                     choices = year_choices), 
                                         selectInput("xvar2", 
                                                     label = "Select a variable for the x-axis", 
                                                     choices = var_choices), 
                                         selectInput("yvar2", 
                                                     label = "Select a variable for the y-axis", 
                                                     choices = var_choices)), 
                            mainPanel()
                   )
))

# leafletOutput("leaflet")
# plotlyOutput("line")
# plotlyOutput("scatter1")
# plotlyOutput("scatter2")