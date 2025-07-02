# ANOVA module ------------------------------------------------------------

source('modules/anova/anova_upload_file.R')

anova_UI <- function(id) {
  ns <- NS(id)
  tabItem(
    'anova',
    navbarPage(
      title       = 'ANOVA',
      id          = ns('id_navbar_anova'),
      # selected    = 'Cargar archivo',
      collapsible = TRUE,
      anova_upload_file_UI(ns('id_anova_upload_file'))
    )
  )
}

anova_Server <- function(id) {
  moduleServer(id, function(input, output, session) {

    anova_upload_file_Server('id_anova_upload_file')

  })
}
