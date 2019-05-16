server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot3 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  
  output$progressBox2 <- renderInfoBox({
    infoBox(
      "Progress", paste0(25 + input$count, "%"), icon = icon("list"),
      color = "purple", fill = TRUE
    )
  })
  output$approvalBox2 <- renderInfoBox({
    infoBox(
      "Approval", "80%", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "yellow", fill = TRUE
    )
  })
  output$rules = DT:: renderDataTable({
    rules_table
  })
  output$itemFreq = DT:: renderDataTable({
    AllItemsFreq
  })
  output$productRevenue = DT:: renderDataTable({
    ProductRevenue
  })
  
  output$ItemFreqGraph <- renderPlot({
    itemFrequencyPlot(allitemstransactions, topN= input$itemfreq_inp, type="absolute", popCol="coral",
                      xlab="Items", ylab="Frequency")
  })
  
  output$customerOffer = DT:: renderDataTable({
    CustomerOffer
  })
  output$rules_graph <- renderPlot({
    plot(apriori(transactions, parameter = list(support = input$minsupp, confidence = input$minconf , minlen=2, maxlen=5, ext=TRUE ), 
                 control = list(verbose=TRUE))[1:input$rules_count], 
         method = "graph", engine = "interactive", shading = "lift")
  })
  
  output$rules_scatterplot <- renderPlotly({
    plotly_arules(apriori(transactions, parameter = list(support = input$minsuppsctrplt, confidence = input$minconfsctrplt , minlen=2, maxlen=5, ext=TRUE ),
                          control = list(verbose=TRUE))[1:input$rules_countsctrplt],
                  jitter = 10,marker = list(opacity = .7, size = 10, symbol = 1),
                  colors = c("blue", "green"))
  })
  
  output$revenueForecast <- renderPlot({
    plot(forecast(auto.arima(myts[,2], D=1,stationary = FALSE,seasonal = TRUE),
                  h=input$ahead),
         xlab="Years",ylab="Revenue ( Rupees )", include = input$behind, showgap = F)
  })
  
  output$rev_forecast_info <- renderText({
    
    paste0("Day = ", input$plot_click$x, " Rupees = ", input$plot_click$y, "\n")
    
  })
  # Subset data
  selected_trends <- reactive({
    ProductSales %>%
      filter(
        Name==input$producttype)
  })
  
  output$arimaForecastPlot <- renderPlot({
    plot(forecast(auto.arima(ts(selected_trends()$Quantity,frequency = 7),D=1),h=input$productahead),
         xlab="Weeks",ylab="Sales Unit ( kg / number )", include = input$productbehind, showgap = F)
  })
  output$demand_forecast_info <- renderText({
    
    paste0("Day = ", input$demandplot_click$x, " Unit ( kg/number ) = ", input$demandplot_click$y, "\n")
    
  })
  output$comboOffersPlot<-({
    ds <- reshape2::melt(data, id = "SaleDate")
    
    # Set some colors
    plotcolor <- "#F5F1DA"
    papercolor <- "#E3DFC8"
    
    # Plot time series chart 
    output$timeseries <- renderPlotly({
      p <- plot_ly(source = "source") %>% 
        add_lines(data =ds, x = ~SaleDate, y = ~value, color = ~variable, mode = "lines", line = list(width = 3))%>%
        layout(title = "SaleDate Vs. Quantity",
               xaxis = list(title = "Dates", gridcolor = "#bfbfbf", domain = c(0, 0.98)),
               yaxis = list(title = "Quantity", gridcolor = "#bfbfbf"), 
               plot_bgcolor = plotcolor,
               paper_bgcolor = papercolor) 
      
    })
    
    # Coupled hover event
    output$correlation <- renderPlotly({
      
      # Read in hover data
      eventdata <- event_data("plotly_hover", source = "source")
      validate(need(!is.null(eventdata), "Hover over the time series chart to populate this heatmap"))
      
      # Get point number
      datapoint <- as.numeric(eventdata$pointNumber)[1]
      window <- 10
      # Show correlation heatmap
      rng <- (datapoint - window):(datapoint + window)
      cormat <- round(cor(data[rng, 1:3]),2)
      
      plot_ly(x = rownames(cormat), y = colnames(cormat), z = cormat, type = "heatmap", 
              colors = colorRamp(c('#e3dfc8', '#808c6c')))%>% 
        layout(title = "Correlation heatmap",
               xaxis = list(title = ""),
               yaxis = list(title = ""))
      
    })
  })
  output$comboOffers = DT:: renderDataTable({
    comboOffer_table
  })
}