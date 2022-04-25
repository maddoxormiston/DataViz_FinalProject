library(shiny)
library(here)
library(leaflet)
library(plotly)
library(shinythemes)

measuresloc_df <- read.csv(here("data/measuresloc.csv"))
var_choices <- names(measuresloc_df)[c(5:35)]
year_choices <- c(2008:2017)

shinyUI(navbarPage(theme = shinytheme("superhero"), "Maternity Data for New York", 
                   tabPanel("Leaflet", 
                            sidebarPanel(
                              selectInput("leafletvar",
                                          label = "Select a variable",
                                          choices = var_choices), 
                              selectInput("leafletyear",
                                         label = "Select a year",
                                         choices = year_choices)), 
                            mainPanel(leafletOutput("leaflet"), dataTableOutput("table"))
                            ), 
                   tabPanel("Line", 
                            sidebarPanel(
                              selectInput("linevar",
                                          label = "Select a variable",
                                          choices = var_choices), 
                              p("Select a hospital on the map to view on the line plot.")), 
                            mainPanel(plotOutput("lineplot"), leafletOutput("lineleaflet"))
                            ), 
                   tabPanel("Year vs Year Scatterplot", 
                            sidebarPanel(selectInput("var1",
                                                     label = "Select a variable",
                                                     choices = var_choices), 
                                         selectInput("xyear1", 
                                                     label = "Select a year for the x-axis", 
                                                     choices = year_choices), 
                                         selectInput("yyear1", 
                                                     label = "Select a year for the y-axis", 
                                                     choices = year_choices, 
                                                     selected = "2017")), 
                            mainPanel(plotlyOutput("scatter1"))
                            ), 
                   tabPanel("Var vs Var Scatterplot", 
                            sidebarPanel(selectInput("year2",
                                                     label = "Select a year",
                                                     choices = year_choices), 
                                         selectInput("xvar2", 
                                                     label = "Select a variable for the x-axis", 
                                                     choices = var_choices), 
                                         selectInput("yvar2", 
                                                     label = "Select a variable for the y-axis", 
                                                     choices = var_choices, 
                                                     selected = "Repeat.Cesarean")), 
                            mainPanel(plotlyOutput("scatter2"))
                   )
))