source('modules/home.R')
source('modules/anova.R')


body <- dashboardBody(

  tags$head(tags$link(rel = 'stylesheet', type = 'text/css', href = 'style.css')),

  useShinyjs(),

  tags$script(HTML("
      Shiny.addCustomMessageHandler('exitFullScreen', function(message) {
        if (document.fullscreenElement) {
          document.exitFullscreen();
        }
      });
    ")),

  tabItems(
    home_UI('id_home'),
    anova_UI('id_anova')
  )
)
