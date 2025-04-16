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

  graph_type <- eventReactive(input$go, {
    ext <- tools::file_ext(input$upload_file$datapath)
    req(input$upload_file)
    validate(need(ext == "csv" | ext == "xlsx" , "Please upload a csv or xlsx file"))

    if(ext == "csv"){
      d <- input$upload_file$datapath %>%
        read_csv()
    }else(d <- input$upload_file$datapath %>%
            read_excel(sheet = input$n_hoja)
    )

    switch(
      input$id_fun_order,
      `NULL` = grafica(d, input$n_col, input$nombre, input$eje_y),
      mean = switch(
        input$id_order,
        ascending = g_as_mean(d, input$n_col, input$nombre, input$eje_y),
        descending = g_des_mean(d, input$n_col, input$nombre, input$eje_y)
      ) ,
      median = switch(
        input$id_order,
        ascending = g_as_median(d, input$n_col, input$nombre, input$eje_y),
        descending = g_des_median(d, input$n_col, input$nombre, input$eje_y)
      ) ,
      sd = switch(
        input$id_order ,
        ascending = g_as_sd(d, input$n_col, input$nombre, input$eje_y),
        descending = g_des_sd(d, input$n_col, input$nombre, input$eje_y)
      )
    )
  })

  analysis_type <- eventReactive(input$go , {
    ext <-  tools::file_ext(input$upload_file$datapath)
    req(input$upload_file)
    validate(need(ext == "csv" | ext == "xlsx" , "Please upload a csv or xlsx file"))
    if(ext == "csv"){
      d <- input$upload_file$datapath %>%
        read_csv()
    }else(d <- input$upload_file$datapath %>%
            read_excel(sheet = input$n_hoja)
    )
    switch(
      input$selection ,
      Normality        = shapiro(d, input$n_col) ,
      Homoscedasticity = bar(d, input$n_col) ,
      ANOVA            = an(d, input$n_col) ,
      all              = analisis(d, input$n_col)
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
