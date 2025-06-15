# ANOVA module ------------------------------------------------------------
library(shiny)
library(shinydashboard)

anova_UI <- function(id) {
  ns <- NS(id)
  tabItem(
    'anova',
    navbarPage(
      title       = 'ANOVA',
      id          = ns('id_navbar_anova'),
      # selected    = 'Cargar archivo',
      collapsible = TRUE
    )
  )
}

anova_Server <- function(id) {
  moduleServer(id, function(input, output, session) {

  })
}
