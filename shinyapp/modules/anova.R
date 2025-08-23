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
      fluidRow(
        box(
          solidHeader = TRUE,
          width       = 12,
          tabBox(
            id    = ns('id_navbar_anova'),
            width = 12,
            title = tags$b('Analysis of Variance', style = 'color: #3c8dbc;'),
            tabPanel(
              'Upload',
              icon = icon('database'),
              anova_upload_file_UI(ns('id_anova_upload_file'))
            ),
            tabPanel(
              'Data',
              icon = icon('table'),
              value = 'data_tab',
              anova_data_UI(ns('id_anova_data'))
            ),
            tabPanel(
              'One way',
              icon  = icon('square-poll-vertical'),
              value = 'one_way_tab',
              anova_one_way_UI(ns('id_anova_one_way')
              )
            )
          )
        )
      )
    )
  )
}

anova_Server <- function(id) {
  moduleServer(id, function(input, output, session) {

    hideTab(inputId = 'id_navbar_anova', target = 'one_way_tab')
    hideTab(inputId = 'id_navbar_anova', target = 'data_tab')

    observe({
      req(source_data())
      showTab(inputId = 'id_navbar_anova', target = 'one_way_tab')
      showTab(inputId = 'id_navbar_anova', target = 'data_tab')
    })

    source_data <- anova_upload_file_Server('id_anova_upload_file')
    anova_data_Server('id_anova_data', source_data)
    anova_one_way_Server('id_anova_one_way', source_data)
  })
}
