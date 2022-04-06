library(shiny)
library(here)
library(leaflet)
library(plotly)

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
                                         choices = year_choices), 
                              submitButton("Update Selections")), 
                            mainPanel(leafletOutput("leaflet"), dataTableOutput("table"))
                            ), 
                   tabPanel("Line", 
                            sidebarPanel(
                              selectInput("linevar",
                                          label = "Select a variable",
                                          choices = var_choices)), 
                            mainPanel(plotOutput("tim"), leafletOutput("lineleaflet"))
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
                                                     choices = year_choices), 
                                         submitButton("Update Selections")), 
                            mainPanel(plotlyOutput("scatter1"))
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
                                                     choices = var_choices), 
                                         submitButton("Update Selections")), 
                            mainPanel(plotlyOutput("scatter2"))
                   )
))

# leafletOutput("leaflet")
# plotOutput("line")
# plotlyOutput("scatter1")
# plotlyOutput("scatter2")