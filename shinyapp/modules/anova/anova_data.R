# 'data' module ----------------------------------------------------

anova_data_UI <- function(id) {
  ns <- NS(id)
  tagList(
    br(),
    dataTableOutput(ns('table'))
  )
}

anova_data_Server <- function(id, source_data) {
  moduleServer(id, function(input, output, session) {

    output$table <- renderDataTable({
      source_data()
    })

  })
}


