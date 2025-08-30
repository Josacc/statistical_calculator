header <- dashboardHeader(

  title = tags$div(
    style = 'display: flex; align-items: center; justify-content: center; height: 50px; width: 100%;',
    tags$image(src = 'logo_dashboardheader.png', height = '35px', style  = 'margin-right: 15px;'),
    tags$span('Statistical calculator', style = 'font-size: 16px; font-weight: bold;')
  ),

  titleWidth = 250,

  tags$li(
    class = "dropdown",
    style = "display: flex; align-items: center; height: 50px;",
    actionButton("page_toggle", label = NULL, icon = icon("maximize"))
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
)
