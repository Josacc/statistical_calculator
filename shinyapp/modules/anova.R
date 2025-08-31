# ANOVA module ------------------------------------------------------------

source('modules/anova/anova_upload_file.R')
source('modules/anova/anova_data.R')
source('modules/anova/one_way/one_way_ui.R')
source('modules/anova/one_way/one_way_server.R')

anova_UI <- function(id) {

  ns <- NS(id)

  tabItem(
    'anova',
    tagList(
      tabsetPanel(
        id   = ns('id_navbar_anova'),
        selected = 'tab_upload',

        tabPanel(
          tags$b('Analysis of Variance', style = 'color: #3c8dbc;'),
          value = 'tab_anova',
          br()
        ),

        tabPanel(
          'Upload',
          icon  = icon('database'),
          value = 'tab_upload',
          br(),
          anova_upload_file_UI(ns('id_anova_upload_file'))
        ),

        tabPanel(
          'Data Viewer',
          icon  = icon('square-poll-vertical'),
          value = 'tab_data',
          br(),
          anova_data_UI(ns('id_anova_data'))
        ),

        tabPanel(
          'One way',
          icon  = icon('square-poll-vertical'),
          value = 'tab_one_way',
          br(),
          anova_one_way_UI(ns('id_anova_one_way'))
        )
      )
    )
  )
}

anova_Server <- function(id) {
  moduleServer(id, function(input, output, session) {

    hideTab(inputId = 'id_navbar_anova', target = 'tab_one_way')
    hideTab(inputId = 'id_navbar_anova', target = 'tab_data')

    observe({
      req(source_data())
      showTab(inputId = 'id_navbar_anova', target = 'tab_one_way')
      showTab(inputId = 'id_navbar_anova', target = 'tab_data')
    })

    source_data <- anova_upload_file_Server('id_anova_upload_file')
    anova_data_Server('id_anova_data', source_data)
    anova_one_way_Server('id_anova_one_way', source_data)
  })
}
