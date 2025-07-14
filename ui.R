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
library(mosaic)
library(mosaicCalc)

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
    width = 180,
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
