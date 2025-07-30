# 'upload file' module ----------------------------------------------------

anova_upload_file_UI <- function(id) {
  ns <- NS(id)
  tabPanel(
    'Load data',
    icon = icon('upload'),
    br(),
    fluidRow(
      column(
        width = 4,
        useShinyFeedback(),
        fileInput(
          ns('id_file_upload'),
          'Upload file',
          accept      = c('.xlsx', '.csv'),
          width       = '450px'
        )
      ),
      column(
        width = 1,
        actionBttn(
          inputId = ns('id_info_button_file_upload'),
          label   = '',
          icon    = icon('info-circle'),
          style   = 'jelly'
        )
      )
    ),
    br(),
    dataTableOutput(ns('table'))
  )
}

anova_upload_file_Server <- function(id) {
  moduleServer(id, function(input, output, session) {

    source_data <- reactive({
      req(input$id_file_upload)
      ext <-  tools::file_ext(input$id_file_upload$datapath)
      validate(need(ext == "csv" | ext == "xlsx" , "Please upload a csv or xlsx file"))
      if(ext == "csv"){
        d <- input$id_file_upload$datapath %>% read_csv()
      }else(d <- input$id_file_upload$datapath %>% read_excel()
      )
      return(d)
    })

    output$table <- renderDataTable(source_data())

    return(source_data)

  })
}
