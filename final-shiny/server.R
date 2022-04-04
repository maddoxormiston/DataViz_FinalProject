library(shiny)
library(tidyverse)
library(leaflet)
library(plotly)
library(ggrepel)

measuresloc_df <- read.csv(here("data/measuresloc.csv"))
measuresloc_df <- measuresloc_df %>% mutate(id = row_number())
measuresloc_maxyear <- measuresloc_df %>% group_by(Hospital.Name) %>% 
    summarise(Year = max(Year))

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
    
    measuresloc_linecounty <- reactive({
        measuresloc_df %>% filter(Hospital.County == input$linecounty)
    })
    
    measuresloc_var <- reactive({
        measuresloc_df %>% select(Year, Hospital.Name, input$var1)
    })
    
    xvar <- reactive({
        measuresloc_var %>% filter(Year == input$xyear1) %>% rename(xvar = measuresloc_var()[[3]])
    })
    
    yvar <- reactive({
        measuresloc_var %>% filter(Year == input$yyear1) %>% rename(yvar = measuresloc_var()[[3]])
    })
    
    both_df <- full_join(xvar(), yvar(), by = "Hospital.Name")
    
    measuresloc_year2 <- reactive({
        measuresloc_df %>% filter(Year == input$year2)
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
    
    output$line <- renderPlot(
        ggplot(data = measuresloc_linecounty(), aes(x = Year, y = .data[[input$linevar]], group = Hospital.Name)) + 
            geom_line() + 
            geom_label_repel(aes(label = Hospital.Name))
    )
    
#    output$scatter1 <- renderPlotly(
#        g1 <- ggplot(data = both_df(), aes(x = xvar, y = yvar)) + 
#            geom_point(aes(label = Hospital.Name)) + 
#            xlim(0, 2000) + 
#            ylim(0, 2000) + 
#            geom_smooth(),
        
#        ggplotly(g1, tooltip = "label")
#    )
    
    output$scatter2 <- renderPlotly(
        g2 <- ggplot(data = measuresloc_year2(), aes(x = .data[[input$xvar2]], y = .data[[input$yvar2]])) + 
            geom_point(aes(label = Hospital.Name)) + xlim(0, 1500) + ylim(0, 1500) + geom_smooth(se = F),
        
        return(ggplotly(g2, tooltip = "label"))
    )
})