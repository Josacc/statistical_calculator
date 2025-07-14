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
          accept      = c('.xlsx'),
          width       = '450px',
          buttonLabel =  'Buscar',
          placeholder = 'Sin archivo'
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
    )
  )


}

anova_upload_file_Server <- function(id) {
  moduleServer(id, function(input, output, session) {

    raw_data <- reactive({
      req(input$upload_file)
      ext <-  tools::file_ext(input$upload_file$datapath)
      validate(need(ext == "csv" | ext == "xlsx" , "Please upload a csv or xlsx file"))
      if(ext == "csv"){
        d <- input$upload_file$datapath %>%
          read_csv()
      }else(d <- input$upload_file$datapath %>%
              read_excel()
      )
      return(d)
    })

    return(raw_data)

  })
}
