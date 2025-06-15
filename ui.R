library(shiny)
library(tidyverse)
library(readxl)
library(plotly)
library(scales)
library(shinyWidgets)
library(shinycssloaders)
library(DT)
library(shinydashboard)
library(shinyWidgets)
library(shinycssloaders)
library(shinyFeedback)
library(shinyfullscreen)
library(xfun)

source('modules/home.R')
source('modules/anova.R')

dashboardPage(
  dashboardHeader(
    title = tags$div(
      style = '
      display: flex;
      align-items: center;
      justify-content: center;
      height: 50px;
      width: 100%;

      ',
      tags$image(
        src    = 'logo_dashboardheader.png',
        height = '35px',
        style  = 'margin-right: 15px;'
      ),
      tags$span(
        'Statistical calculator',
        style = '
        font-size: 16px;
        font-weight: bold;
        '
      ),
      tags$head(
        tags$title('Statistical calculator')
      )
    ),
    titleWidth = 250,
    tags$li(
      class = "dropdown",
      style = "display: flex; align-items: center; height: 50px;",
      actionBttn("page_full", style = "stretch", icon("maximize"))
    ),
    dropdownMenu(
      type        = "messages",
      badgeStatus = NULL,
      headerText  = "Administrador",
      messageItem(
        from    = 'hello',
        message = 'hello',
        icon    = icon("user-gear"),
        href    = str_c("mailto:", 'hello', "?Subject=DIIE%20app")
      )
    )
  ),
  dashboardSidebar(
    width = 200,
    HTML(str_c('<br><br><br><br><br><br>')),
    sidebarMenu(
      menuItem(
        tags$span("Home", style = "margin-left: 5px;"),
        tabName = 'home',
        icon    = icon('house')
      ),
      menuItem(
        tags$span('ANOVA', style = "margin-left: 5px;"),
        tabName = 'anova',
        icon    = icon('chart-simple')
      )
    )


  ),
  dashboardBody(
    tags$head(tags$style(HTML("
      .content-wrapper {
        background-color: #FFFFFF;
      }
      .skin-blue .main-header .logo {
          background-color: #3c8dbc !important;
          color: white !important;
        }
    "
    ))),
    fullscreen_all(click_id = 'page_full'),
    tabItems(
      home_UI('id_home'),
      anova_UI('id_anova')
    )
  )
)

# page_sidebar(
#   title = 'One way ANOVA',
#   sidebar = sidebar(
#     width = 380,
#     fg = 'blue',

  # titlePanel("ANOVA"),
  # fluidRow(
  #   column(
  #     width = 2,
  #     h4(
  #       p(strong("One-way")),
  #       style = "color: #3c8dbc"
  #     )
  #   ),
  #   column(
  #     width = 1,
  #     actionBttn(
  #       inputId = "info_button_one_way_anova",
  #       label   = "",
  #       icon    = icon("info-circle"),
  #       style   = "jelly"
  #     )
  #   )
  # ),
  # page_sidebar(
    #  sidebar = sidebar(
    #   width = 3,
#       accordion(
#         accordion_panel(title = 'Primary controls', value = 'primary',
#           actionBttn(
#             'test_data',
#             label = 'Show default example',
#             style = 'float',
#             block = TRUE,
#             color = 'primary',
#             size  = 'xs'
#           ),
#           br(), br(),
#           fileInput(
#             "upload_file",
#             HTML(
#               paste0(
#                 "Import (csv or xlsx) file",
#                 "<br>",
#                 "<a href='database_example.zip'
#                     download
#                     style='font-size:12px'
#                     target='_blank'>
#                     Download database example <i class='fa-solid fa-download'></i>
#                 </a>"
#               )
#             ),
#             accept = c(".xlsx", ".csv")
#           ),
#           numericInput(
#             "n_col",
#             "Choose the data column",
#             value = 2,
#             min = 2, max = 100
#           ),
#           br()
#         ),
#         accordion_panel(title = 'Secundary controls', value = 'sec',
#           navset_card_pill(
#             id = "tabset",
#             nav_panel("Box plot",
#                       br(),
#                       prettyRadioButtons(
#                         "id_fun_order",
#                         "Ordered by",
#                         choices    = c("Default", "Mean", "Median", "Standard deviation"),
#                         status     = 'primary',
#                         icon       = icon('check'),
#                         animation  = 'smooth'
#                       ),
#                       radioGroupButtons(
#                         "id_order",
#                         "Order",
#                         selected = character(0),
#                         choices = c(
#                           `<i class='fa fa-sort-up'></i> Ascending ` = 'Ascending',
#                           `<i class='fa fa-sort-down'></i> Descending ` = 'Descending'
#                         ),
#                         justified = TRUE,
#                       ),
#                       br(),
#                       textInput(
#                         "nombre", label = "Graphic title"
#                       ),
#                       textInput(
#                         "eje_y", label = "Y axis title"
#                       )
#             ),
#             nav_spacer(),
#             nav_panel("Statistical analysis",
#                       br(),
#                       radioButtons(
#                         "selection", "Select test",
#                         choices = c("Normality", "Homoscedasticity", "ANOVA", "all"),
#                         inline = T
#                       )
#             )
#           )
#         )
#
#         )
#
#     ),
#     card(
#       actionButton("go", "Go"),
#       verbatimTextOutput("t_anova"),
#       plotlyOutput("plot")
#     )
#   # )
# )
