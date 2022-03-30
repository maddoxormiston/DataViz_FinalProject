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
            addAwesomeMarkers(lng = measuresloc_leafletyear()[[4]], lat = measuresloc_leafletyear()[[3]], 
                       popup = paste0(measuresloc_leafletyear()[[5]], ", ", measuresloc_leafletyear()[[1]]), 
                       icon = awesome
    ))
    
    output$table <- renderDataTable(
        measuresloc_leafletyear()
    )
    
    output$lineleaflet <- renderLeaflet(
        leaflet(measuresloc_df) %>% 
            addTiles() %>% 
            addProviderTiles(providers$Wikimedia) %>% 
            addAwesomeMarkers(lng = measuresloc_df$lon, lat = measuresloc_df$lat, 
                              popup = paste0(measuresloc_df$Hospital.Name), 
                              icon = awesome
            ))
    
    output$line <- renderPlot(
        ggplot(data = measuresloc_df, aes(x = Year, y = .data[[input$linevar]], group = Hospital.Name)) + 
            geom_line()
    )

})
