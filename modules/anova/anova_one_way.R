# One way module ----------------------------------------------------------

anova_one_way_UI <- function(id) {
  ns <- NS(id)
  tabPanel(
    'One way',
    icon = icon('upload'),

    fluidRow(
      column(
        width = 2,
        h3(
          p(strong('One way ANOVA')),
          style = 'color: #3c8dbc'
        )
      ),
      column(
        width = 1,
        actionBttn(
          inputId = ns('info_button_one_way_anova'),
          label   = '',
          icon    = icon('info-circle'),
          style   = 'jelly'
        )
      )
    ),
    br(),
    sidebarLayout(
      sidebarPanel(
        width = 3,
        actionBttn(
          ns('test_data'),
          label = 'Show default example',
          style = 'float',
          block = TRUE,
          color = 'primary',
          size  = 'xs'
        ),
        br(), br(),
        fluidRow(
          column(
            width = 5,
            numericInput(
              ns('n_hoja'),
              'Choose the sheet',
              width = '80px', value = 1,
              min = 1, max = 2
            )
          ),
          column(
            width = 5,
            numericInput(
              ns('n_col'),
              'Choose the col',
              width = '80px', value = 2,
              min = 2, max = 7
            )
          )
        ),
        tabsetPanel(
          id = ns('tabset'),
          tabPanel(
            'Box plot',
            br(),
            prettyRadioButtons(
              ns('id_fun_order'),
              'Ordered by',
              choices    = c('Default', 'Mean', 'Median', 'Standard deviation'),
              status     = 'primary',
              icon       = icon('check'),
              animation  = 'smooth'
            ),
            radioGroupButtons(
              ns('id_order'),
              'Order',
              selected = character(0),
              choices = c(
                `<i class='fa fa-sort-up'></i> Ascending ` = 'Ascending',
                `<i class='fa fa-sort-down'></i> Descending ` = 'Descending'
              ),
              justified = TRUE,
            ),
            br(),
            textInput(
              ns('nombre'), label = 'Graphic title'
            ),
            textInput(
              ns('eje_y'), label = 'Y axis title'
            )
          ),
          tabPanel('Statistical analysis',
                   br(),
                   radioButtons(
                     ns('selection'), 'Select test',
                     choices = c('Normality', 'Homoscedasticity', 'ANOVA', 'all'),
                     inline = T
                   )
          )
        )
      ),
      mainPanel(
        actionButton(ns('go'), 'Go'),
        verbatimTextOutput(ns('t_anova')),
        plotlyOutput(ns('plot'))
      )
    )
  )
}

anova_one_way_Server <- function(id) {
  moduleServer(id, function(input, output, session) {

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

  })
}
