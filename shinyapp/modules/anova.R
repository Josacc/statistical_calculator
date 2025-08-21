# ANOVA module ------------------------------------------------------------

source('modules/anova/anova_upload_file.R')
source('modules/anova/one_way/one_way_ui.R')
source('modules/anova/one_way/one_way_server.R')

anova_UI <- function(id) {
  ns <- NS(id)
  tabItem(
    'anova',
    # useShinyjs(),
    tagList(
      navbarPage(
        title = 'Analysis of Variance',
        id = ns('id_navbar_anova'),
        selected = 'Upload',
        collapsible = TRUE,
        tabPanel(
          'Upload',
          icon = icon('database'),
          anova_upload_file_UI(ns('id_anova_upload_file'))
        ),
        tabPanel(
          'One way',
          icon = icon('square-poll-vertical'),
          value = "one_way_tab",
          anova_one_way_UI(ns('id_anova_one_way')
          )
        )
      )
    )
  )
}

anova_Server <- function(id) {
  moduleServer(id, function(input, output, session) {

    # runjs('$("li a[data-value=\'one_way_tab\']").parent().hide();')

    # observe({
    #   req(source_data())
    #   runjs('$("li a[data-value=\'one_way_tab\']").parent().show();')
    #   # updateNavbarPage(session, "id_navbar_anova", selected = "one_way_tab")
    # })

    hideTab(inputId = "id_navbar_anova", target = "one_way_tab")

    observe({
      req(source_data())
      showTab(inputId = "id_navbar_anova", target = "one_way_tab")
    })

    source_data <- anova_upload_file_Server('id_anova_upload_file')
    anova_one_way_Server('id_anova_one_way', source_data)
  })
}
