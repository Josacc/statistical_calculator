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
      fileInput(
        "upload_file",
        HTML(
          paste0(
            "Import (.csv or .xlsx) file",
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
            "n_hoja", "sheet", width = '80px', value = 1,
            min = 1, max = 2
          )
        ),
        column(
          width = 5,
          numericInput(
            "n_col", "col", width = '80px', value = 2,
            min = 2, max = 7
          )
        )
      ),
      tabsetPanel(
        id = "tabset",
        tabPanel("Plot",
                 br(),
                 radioButtons(
                   "id_fun_order", "ordered by",
                   choices = c("NULL", "mean", "median", "sd"), inline = TRUE
                 ),
                 radioButtons(
                   "id_order", "order",
                   choices = c("ascending", "descending"), inline = TRUE
                 ),
                 br(),
                 textInput(
                   "nombre", label = "graphic title"
                 ),
                 textInput(
                   "eje_y", label = "Y axis title"
                 )
        ),
        tabPanel("Inference",
                 br(),
                 radioButtons(
                   "selection", "select",
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
