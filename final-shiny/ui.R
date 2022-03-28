library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Maternity Data for New York"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type = "tabs", 
                        tabPanel("Leaflet", leafletOutput("leaflet")), 
                        tabPanel("Line", plotlyOutput("line")), 
                        tabPanel("Scatter1", plotlyOutput("scatter1")), 
                        tabPanel("Scatter2", plotlyOutput("scatter2")))
        )
    )
))


# shinyUI(navbarPage("App Title",
#                    tabPanel("Tab Name",
#                             sidebarPanel([inputs for the first tab]),
#                             mainPanel([outputs for the first tab])
#                    ),
#                    tabPanel("Second tab name",
#                             sidebarPanel([inputs for the second tab]),
#                             mailPanel([outputs for the second tab])
#                   )
#))