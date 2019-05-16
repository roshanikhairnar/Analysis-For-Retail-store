source("tabs.R", local = TRUE)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css")
    )
  )
)
header <- dashboardHeader(title = "Chitale Analytics")

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Association Rules", tabName = "rules", icon = icon("th")),
    menuItem("Item Selling Frequency", tabName = "itemFreq", icon = icon("chart-bar")),
    menuItem("Customer Offer", tabName = "customerOffer", icon = icon("gift")),
    menuItem("Product Combinations",tabName = "comboOffers", icon =icon("dolly")),
    menuItem("Item Space Optimisation", tabName = "productRevenue", icon = icon("boxes")),
    menuItem("Forecasts", tabName = "forecasts", icon = icon("chart-line"))
  )
)

body <- dashboardBody(
  tabItems(
    dashboardTab,
    rulesTab,
    itemFreqTab,
    customerOfferTab,
    comboOffersTab,
    productRevenueTab,
    forecastsTab
  )
)

ui <- dashboardPage(title = 'Chitale Analytics', header, sidebar, body)
