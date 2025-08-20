# ANOVA module ------------------------------------------------------------

source('modules/anova/anova_upload_file.R')
source('modules/anova/one_way/one_way_ui.R')
source('modules/anova/one_way/one_way_server.R')

anova_UI <- function(id) {
  ns <- NS(id)
  tabItem(
    'anova',
    navbarPage(
      title       = 'Analysis of Variance',
      id          = ns('id_navbar_anova'),
      selected    = 'Upload',
      collapsible = TRUE,
      anova_upload_file_UI(ns('id_anova_upload_file')),
      anova_one_way_UI(ns('id_anova_one_way'))
    )
  )
}

anova_Server <- function(id) {
  moduleServer(id, function(input, output, session) {

    source_data <- anova_upload_file_Server('id_anova_upload_file')
    anova_one_way_Server('id_anova_one_way', source_data)
  })
}
