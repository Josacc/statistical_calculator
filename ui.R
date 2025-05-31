library(shiny)
library(tidyverse)
library(readxl)
library(plotly)
library(scales)
library(shinyWidgets)
library(shinycssloaders)
library(DT)


fluidPage(
  titlePanel("ANOVA"),
  fluidRow(
    column(
      width = 2,
      h4(
        p(strong("One-way")),
        style = "color: #3c8dbc"
      )
    ),
    column(
      width = 1,
      actionBttn(
        inputId = "info_button_one_way_anova",
        label   = "",
        icon    = icon("info-circle"),
        style   = "jelly"
      )
    )
  ),
  sidebarLayout(
    sidebarPanel(
      width = 3,
      actionBttn(
        'test_data',
        label = 'Show default example',
        style = 'float',
        block = TRUE,
        color = 'primary',
        size  = 'xs'
      ),
      br(), br(),
      fileInput(
        "upload_file",
        HTML(
          paste0(
            "Import (csv or xlsx) file",
            "<br>",
            "<a href='database_example.zip'
                    download
                    style='font-size:12px'
                    target='_blank'>
                    Download database example <i class='fa-solid fa-download'></i>
                </a>"
          )
        ),
        accept = c(".xlsx", ".csv")
      ),
      fluidRow(
        column(
          width = 5,
          numericInput(
            "n_hoja",
            "Choose the sheet",
            width = '80px', value = 1,
            min = 1, max = 2
          )
        ),
        column(
          width = 5,
          numericInput(
            "n_col",
            "Choose the col",
            width = '80px', value = 2,
            min = 2, max = 7
          )
        )
      ),
      tabsetPanel(
        id = "tabset",
        tabPanel("Box plot",
                 br(),
                 prettyRadioButtons(
                   "id_fun_order",
                   "Ordered by",
                   choices    = c("Default", "Mean", "Median", "Standard deviation"),
                   status     = 'primary',
                   icon       = icon('check'),
                   animation  = 'smooth'
                 ),
                 radioGroupButtons(
                   "id_order",
                   "Order",
                   selected = character(0),
                   choices = c(
                     `<i class='fa fa-sort-up'></i> Ascending ` = 'Ascending',
                     `<i class='fa fa-sort-down'></i> Descending ` = 'Descending'
                   ),
                   justified = TRUE,
                 ),
                 br(),
                 textInput(
                   "nombre", label = "Graphic title"
                 ),
                 textInput(
                   "eje_y", label = "Y axis title"
                 )
        ),
        tabPanel("Statistical analysis",
                 br(),
                 radioButtons(
                   "selection", "Select test",
                   choices = c("Normality", "Homoscedasticity", "ANOVA", "all"),
                   inline = T
                 )
        )
      )
    ),
    mainPanel(
      actionButton("go", "Go"),
      verbatimTextOutput("t_anova"),
      plotlyOutput("plot")
    )
  )
)
