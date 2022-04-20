library(shiny)
library(tidyverse)
library(leaflet)
library(plotly)
library(ggrepel)
library(here)

measuresloc_df <- read.csv(here("data/measuresloc.csv"))
measuresloc_df <- measuresloc_df %>% mutate(id = row_number())
measuresloc_maxyear <- measuresloc_df %>% group_by(Hospital.Name) %>% 
    summarise(Year = max(Year))

hospitalsgeocode_df <- read.csv(here("data/hospitalsgeocode.csv"))

awesome3 <- makeIcon(
    "https://gizmobrewworks.com/wp-content/uploads/leaflet-maps-marker-icons/hospital-2.png", 
    iconWidth = 18, 
    iconHeight = 18
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
        measuresloc_var() %>% filter(Year == input$xyear1)
    })
    
    yvar <- reactive({
        measuresloc_var() %>% filter(Year == input$yyear1)
    })
    
    both_df <- reactive({
        full_join(xvar(), yvar(), by = c("Hospital.Name" = "Hospital.Name"))
    })
    
    measuresloc_year2 <- reactive({
        measuresloc_df %>% filter(Year == input$year2)
    })
    
    output$leaflet <- renderLeaflet(
        leaflet(measuresloc_leafletyear()) %>% 
            addTiles() %>% 
            addProviderTiles(providers$Wikimedia) %>% 
            addMarkers(lng = measuresloc_leafletyear()[[4]], 
                              lat = measuresloc_leafletyear()[[3]], 
                       popup = paste(measuresloc_leafletyear()[[5]], "<br/>", 
                                      input$leafletvar, ": ", measuresloc_leafletyear()[[1]]), 
                       icon = awesome3)
    )
    
    output$table <- renderDataTable(
        measuresloc_leafletyear()
    )
    
    output$line <- renderPlot(
        ggplot(data = measuresloc_linecounty(), aes(x = Year, y = .data[[input$linevar]], 
                                                    group = Hospital.Name)) + 
            geom_line() + 
            geom_label_repel(aes(label = Hospital.Name))
    )
    
    output$lineleaflet <- renderLeaflet(
        leaflet(measuresloc_df) %>% 
            addTiles() %>% 
            addProviderTiles(providers$Wikimedia) %>% 
            addMarkers(lng = measuresloc_df$lon, lat = measuresloc_df$lat, 
                              popup = paste0(measuresloc_df$Hospital.Name), 
                              icon = awesome3)
    )
    
    temp <- reactive({
        measuresloc_df %>% filter(lon == input$lineleaflet_marker_click$lng)
    })
    
    output$tim <- renderPlot(
        ggplot(data = measuresloc_df, aes(x = Year, y = .data[[input$linevar]], 
                                          group = Hospital.Name)) + 
                  geom_line(alpha = 0.3) + 
                  geom_line(data = temp(), aes(x = Year, y = .data[[input$linevar]]), colour = "red")
    )
    
    output$tim2 <- renderPlot(
        g <- ggplot(data = measuresloc_df, aes(x = Year, y = .data[[input$linevar]], 
                                          group = Hospital.Name)) + geom_line(alpha = 0.3)
        if(input$lineleaflet_marker_click){
            g <- g + geom_line(data = temp(), aes(x = Year, y = .data[[input$linevar]]), colour = "red")
        }
        return(g)
    )
    
    output$scatter1 <- renderPlotly({
        g1 <- ggplot(data = both_df(), aes(x = both_df()[[3]], y = both_df()[[5]])) + 
            geom_point(aes(text = Hospital.Name), alpha = 0.4) + 
            geom_smooth(se = F) + 
            labs(x = input$xyear1, y = input$yyear1)
        
        ggplotly(g1, tooltip = "text")
    })
    
    output$scatter2 <- renderPlotly({
        plot1 <- ggplot(data = measuresloc_year2(), aes(x = .data[[input$xvar2]], 
                                                        y = .data[[input$yvar2]])) + 
            geom_point(aes(text = Hospital.Name), alpha = 0.4) + geom_smooth(se = F)
        
        ggplotly(plot1, tooltip = "text")
    })
})