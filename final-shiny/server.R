library(shiny)
library(tidyverse)
library(leaflet)
library(plotly)

measuresloc_df <- read.csv(here("data/measuresloc.csv"))

awesome <- makeAwesomeIcon(
    icon = "ios-clos",
    iconColor = "black",
    markerColor = "blue",
    library = "ion"
)

shinyServer(function(input, output) {
    
    measuresloc_leafletyear <- reactive({
        measuresloc_df %>% filter(Year == input$leafletyear) %>% 
            select(input$leafletvar, Year, lat, lon, Hospital.Name)
    })
    
    output$leaflet <- renderLeaflet(
        leaflet(measuresloc_leafletyear()) %>% 
            addTiles() %>% 
            addProviderTiles(providers$Wikimedia) %>% 
            addAwesomeMarkers(lng = measuresloc_leafletyear()[[lon]], lat = measuresloc_leafletyear()[[lat]], 
                              popup = paste0(measuresloc_leafletyear()[[Hospital.Name]], ", ", measuresloc_year[2]), 
                              icon = awesome)
    )
    
    output$line <- renderPlotly(
        g <- ggplot(data = measuresloc_vdf, aes(x = Year, y = input$linevar, group = Hospital.Name)) + 
            geom_line(aes(label = Hospital.Name)), 
        return(ggplotly(g, tooltip = "label"))
    )

})
