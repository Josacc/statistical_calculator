
sidebar <- dashboardSidebar(

  width = 130,

  HTML(str_c('<br><br><br><br><br><br>')),

  sidebarMenu(

    menuItem(
      tags$span('ANOVA', style = "margin-left: 5px;"),
      tabName = 'anova',
      icon    = icon('chart-simple')
    ),

    menuItem(
      tags$span("Home", style = "margin-left: 5px;"),
      tabName = 'home',
      icon    = icon('house')
    )
    # menuItem(
    #   tags$span('ANOVA', style = "margin-left: 5px;"),
    #   tabName = 'anova',
    #   icon    = icon('chart-simple')
    # )
  )
)
