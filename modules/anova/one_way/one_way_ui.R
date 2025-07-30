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
