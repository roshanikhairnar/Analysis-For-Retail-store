dashboardTab <- tabItem(tabName = "dashboard",
                        fluidRow(
                          infoBox("New Orders", 10 * 2, icon = icon("credit-card"), fill = TRUE),
                          infoBoxOutput("progressBox2"),
                          infoBoxOutput("approvalBox2")
                        ),
                        
                        fluidRow(
                          # Clicking this will increment the progress amount
                          box(width = 4, actionButton("count", "Increment progress"))
                        ),
                        fluidRow(
                          box(
                            title = "Histogram", status = "primary", solidHeader = TRUE,
                            collapsible = TRUE,
                            plotOutput("plot3", height = 250)
                          ),
                          
                          box(
                            title = "Inputs", status = "warning", solidHeader = TRUE,
                            "Box content here", br(), "More box content",
                            sliderInput("slider", "Slider input:", 1, 100, 50),
                            submitButton("Submit")
                          )
                        )
)

rulesTab <- tabItem(tabName = "rules",
                    tabBox(
                      title = "Rules",
                      width = "600px",
                      tabPanel("Table",
                               DT::dataTableOutput("rules")  
                      ),
                      tabPanel("Graph", 
                               box(
                                 title = "Inputs", status = "info",
                                 sliderInput("minsupp", "Minimum Support:", 0.0001, 0.01, 0.001),
                                 sliderInput("minconf", "Minimum Confidence:", 0.01, 1.0, 0.2),
                                 numericInput("rules_count", "Number of rules:", 15),
                                 submitButton("Submit")
                               ),
                               plotOutput("rules_graph")
                      ),
                      tabPanel("Scatter Plot",
                               title = "Scatter Plot", status = "info",
                               fluidRow(
                                 sliderInput("minsuppsctrplt", "Minimum Support:", 0.0001, 0.01, 0.001),
                                 sliderInput("minconfsctrplt", "Minimum Confidence:", 0.01, 1.0, 0.2)
                               ),
                               numericInput("rules_countsctrplt", "Number of rules:", 15),
                               submitButton("Submit"),
                               plotlyOutput("rules_scatterplot",height = "400px", width = "600px" )
                      )
                    )
)

itemFreqTab <- tabItem(tabName = "itemFreq",
        tabBox(
          title = "Item Frequency",
          width = "600px",
          tabPanel("Table",
                   DT::dataTableOutput("itemFreq")
          ),
          tabPanel("Bar Graph",
                   numericInput("itemfreq_inp", "Number of Items:", 15),
                   submitButton("Submit"),
                   plotOutput("ItemFreqGraph")
          )
        )
)

customerOfferTab <- tabItem(tabName = "customerOffer",
                            DT::dataTableOutput("customerOffer")
)

productRevenueTab <- tabItem(tabName = "productRevenue",
                            DT::dataTableOutput("productRevenue")
)

forecastsTab <- tabItem(tabName = "forecasts",
                        tabBox(
                          title = "Forecasts",
                          width = "600px",
                          tabPanel("Product Demand",
                                   fluidRow(
                                     box(
                                       title = "Product Demand Forecast", status = "primary", solidHeader = TRUE,
                                       collapsible = TRUE, width = 600,
                                       plotOutput("arimaForecastPlot", height = 300, 
                                                  click = clickOpts(id="demandplot_click", clip = TRUE) ),
                                       submitButton("Show Values"),
                                       verbatimTextOutput("demand_forecast_info")
                                     )
                                   ),
                                   fluidRow(
                                     box(
                                       title = "Inputs", status = "warning", solidHeader = TRUE,
                                       selectInput(inputId = "producttype", label = strong("Product Name"),
                                                   choices = unique(ProductSales$Name),
                                                   selected = "All"),
                                       numericInput("productahead", "Days to Forecast Ahead:", 14),
                                       numericInput("productbehind", "Include Past Days Graph:", 21),
                                       submitButton("Update View")
                                     )
                                   )
                          ),
                          tabPanel("Revenue",
                                   fluidRow(
                                     box(
                                       title = "Revenue Forecast", status = "primary", solidHeader = TRUE,
                                       collapsible = TRUE, width = 600,
                                       plotOutput("revenueForecast",click = clickOpts(id="plot_click", clip = TRUE)),
                                       submitButton("Show Values"),
                                       verbatimTextOutput("rev_forecast_info")
                                     )
                                   ),
                                   fluidRow(
                                     box(
                                       title = "Inputs", status = "warning", solidHeader = TRUE,
                                       numericInput("ahead", "Days to Forecast Ahead:", 60),
                                       numericInput("behind", "Include Past Days Graph:", 30),
                                       submitButton("Update View")
                                     )
                                   )
                          )
                        )
)

comboOffersTab<- tabItem(tabName = "comboOffers",
                         tabBox(
                           title = "Combo Offers",
                           width = "600px",
                           tabPanel("Corelation Heatmap",
                                    #theme = shinytheme("spacelab"),
                                    
                                    # Vertical space
                                    tags$hr(),
                                    
                                    fluidRow(
                                      box(
                                        title = "Combo Offers Plot", status = "primary", solidHeader = TRUE,
                                        collapsible = TRUE, width = 600,
                                        column(6, plotlyOutput(outputId = "timeseries", height = "600px")),
                                        column(6, plotlyOutput(outputId = "correlation", height = "600px"))),
                                      
                                      tags$hr(),
                                      tags$blockquote("Hover over time series chart to fix a specific date. Correlation chart will update with historical 
                                                      correlations.")
                                      )
                                    ),
                           tabPanel("Combo Offers",
                                    DT::dataTableOutput("comboOffers")
                           )
                           
                           )
                         )