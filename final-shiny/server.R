library(shiny)
library(tidyverse)
library(leaflet)
library(plotly)
library(ggrepel)
library(here)

measuresloc_df <- read.csv(here("data/measuresloc.csv"))
measuresloc_df <- measuresloc_df %>% mutate(id = row_number())
hospitalsgeocode_df <- read.csv(here("data/hospitalsgeocode.csv"))

hospital <- makeIcon(
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
        measuresloc_df %>% select(Year, Hospital.Name, input$var1, Hospital.County)
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
                       popup = paste("<strong>", measuresloc_leafletyear()[[5]], "<br/>", 
                                     "</strong>", input$leafletvar, ":", 
                                     measuresloc_leafletyear()[[1]]), 
                       icon = hospital)
    )
    
    output$table <- renderDataTable(
        measuresloc_leafletyear()
    )
    
    output$lineleaflet <- renderLeaflet(
        leaflet(measuresloc_df) %>% 
            addTiles() %>% 
            addProviderTiles(providers$Wikimedia) %>% 
            addMarkers(lng = measuresloc_df$lon, lat = measuresloc_df$lat, 
                              popup = paste0("<strong>", measuresloc_df$Hospital.Name, "</strong>"), 
                              icon = hospital)
    )
    
    temp <- reactive({
        measuresloc_df %>% filter(lon == input$lineleaflet_marker_click$lng)
    })

    output$lineplot <- renderPlot({
        g <- ggplot(data = measuresloc_df, aes(x = Year, y = .data[[input$linevar]], 
                                               group = Hospital.Name)) + 
            geom_line(aes(text = Hospital.Name), alpha = 0.2) + 
            theme(axis.title = element_text(size = 20))
        if(is.null(input$lineleaflet_marker_click)){
            g <- ggplot(data = measuresloc_df, aes(x = Year, y = .data[[input$linevar]], 
                                                   group = Hospital.Name)) + 
                geom_line(aes(text = Hospital.Name), alpha = 0.2) + 
                theme(axis.title = element_text(size = 20))
        }
        else{
            g <- g + 
                geom_line(data = temp(), aes(x = Year, y = .data[[input$linevar]], 
                                             text = Hospital.Name), 
                          colour = "red", size = 1)
        }
        ggplotly(g, tooltip = "text")
    })
    
    output$scatter1 <- renderPlotly({
        g1 <- ggplot(data = both_df(), aes(x = both_df()[[3]], y = both_df()[[6]])) + 
            geom_point(aes(colour = both_df()[[4]], 
                           text = (paste("<br>", Hospital.Name, "<br> County: ", both_df()[[4]]))), 
                       alpha = 0.4) + 
            geom_smooth(se = F) + 
            labs(x = input$xyear1, y = input$yyear1, title = "Compare a variable over time") + 
            theme(legend.position = "none")
        
        ggplotly(g1, tooltip = "text")
    })
    
    output$scatter2 <- renderPlotly({
        plot1 <- ggplot(data = measuresloc_year2(), aes(x = .data[[input$xvar2]], 
                                                        y = .data[[input$yvar2]])) + 
            geom_point(aes(colour = Hospital.County, text = 
                               paste("<br>", Hospital.Name, "<br> County: ", Hospital.County)), 
                       alpha = 0.4) + 
            geom_smooth(se = F) + 
            labs(title = "Compare two variables within a year") + 
            theme(legend.position = "none")
        
        ggplotly(plot1, tooltip = "text")
    })
})