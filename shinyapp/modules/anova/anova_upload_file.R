# 'upload file' module ----------------------------------------------------

anova_upload_file_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        width = 11,
        sidebarLayout(
          sidebarPanel(
            width = 5,
            useShinyFeedback(),
            fileInput(
              ns('id_file_upload'),
              'Upload file',
              accept = c('.xlsx', '.csv')
            ),
            actionBttn(
              ns('default_example'),
              label = 'Show default example',
              style = 'float',
              color = 'primary',
              size  = 'xs'
            ),
          ),
          mainPanel()
        )
      ),
      column(
        width = 1,
        div(
          style = 'display: flex; justify-content: flex-end;',
          actionBttn(
            inputId = ns('id_info_button_file_upload'),
            label   = '',
            icon    = icon('info-circle'),
            style   = 'jelly'
          )
        )
      )
    ),
    br(),
    dataTableOutput(ns('table'))
  )
}

anova_upload_file_Server <- function(id) {
  moduleServer(id, function(input, output, session) {

    data_store <- reactiveVal(NULL)

    observeEvent(input$id_file_upload, {
      file <- input$id_file_upload
      req(file)
      ext <- tools::file_ext(file$datapath)
      validate(need(ext %in% c("csv", "xlsx"), "Please upload a CSV or XLSX file."))

      df <- tryCatch({
        if (ext == "csv") {
          readr::read_csv(file$datapath)
        } else {
          readxl::read_excel(file$datapath)
        }
      }, error = function(e) {
        showNotification("Error reading file", type = "error")
        return(NULL)
      })

      if (!is.null(df)) {
        data_store(df)
      }
    })

    observeEvent(input$default_example, {
      df <- tryCatch({
        readxl::read_xlsx("www/database_example/experimentacion.xlsx")
      }, error = function(e) {
        showNotification("Failed to load default data.", type = "error")
        return(NULL)
      })
      if (!is.null(df)) {
        data_store(df)
      }
    })

    output$table <- renderDataTable({
      req(data_store())
      data_store()
    })

    return(data_store)
  })
}
