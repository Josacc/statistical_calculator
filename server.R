library(shiny)
library(tidyverse)
library(readxl)
library(plotly)
library(scales)
library(shinyWidgets)
library(shinycssloaders)
library(DT)

function(input, output, session) {

  observeEvent(input$info_button_one_way_anova, {
    show_alert(
      session = session,
      title   = "",
      text    = tags$div(
        tags$h3("Information",
                style = "color: #0076C8; font-weight: bold; text-align: center"),
        tags$br(),
        tags$br(),
        style = "text-align: justify;
        margin-left:  auto;
        margin-right: auto;",
        tags$b('One-way ANOVA', style = "font-weight: bold"),
        ' is the statistical analysis to compare the variation of means of two
          or more populations. The application has the ability to analyze structured
          databases according to the download example, providing a box plot and
          hypothesis tests to apply the ANOVA. The information can be loaded in
          xlsx or csv format, specifying the reference sheet and selecting the
          column containing the response variable.',
        tags$br(), tags$br(),
        'Note: You can download the sample database to test the app.',
        tags$br(),
      ),
      html  = TRUE,
      width = "55%"
    )
  })

  raw_data <- reactive({
    req(input$upload_file)
    ext <-  tools::file_ext(input$upload_file$datapath)
    validate(need(ext == "csv" | ext == "xlsx" , "Please upload a csv or xlsx file"))
    if(ext == "csv"){
      d <- input$upload_file$datapath %>%
        read_csv()
    }else(d <- input$upload_file$datapath %>%
            read_excel(sheet = input$n_hoja)
    )
    return(d)
  })

  graph_type <- eventReactive(input$go, {
    switch(
      input$id_fun_order,
      Default = grafica(raw_data(), input$n_col, input$nombre, input$eje_y),
      Mean    = switch(
        input$id_order,
        Ascending  = g_as_mean(raw_data(), input$n_col, input$nombre, input$eje_y),
        Descending = g_des_mean(raw_data(), input$n_col, input$nombre, input$eje_y)
      ) ,
      Median = switch(
        input$id_order,
        Ascending  = g_as_median(raw_data(), input$n_col, input$nombre, input$eje_y),
        Descending = g_des_median(raw_data(), input$n_col, input$nombre, input$eje_y)
      ) ,
      `Standard deviation` = switch(
        input$id_order ,
        Ascending  = g_as_sd(raw_data(), input$n_col, input$nombre, input$eje_y),
        Descending = g_des_sd(raw_data(), input$n_col, input$nombre, input$eje_y)
      )
    )
  })

  analysis_type <- eventReactive(input$go , {
    switch(
      input$selection ,
      Normality        = shapiro(raw_data(), input$n_col) ,
      Homoscedasticity = bar(raw_data(), input$n_col) ,
      ANOVA            = an(raw_data(), input$n_col) ,
      all              = analisis(raw_data(), input$n_col)
    )
  })

  output$plot <- renderPlotly({
    if(input$tabset == "Box plot")
      graph_type()

  })

  output$t_anova <- renderPrint({
    if(input$tabset == "Statistical analysis")
      analysis_type()
  })
}
