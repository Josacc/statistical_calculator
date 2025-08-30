
function(input, output, session) {

  fullscreen_mode <- reactiveVal(FALSE)

  observeEvent(input$page_toggle, {
    if (!fullscreen_mode()) {

      runjs("document.documentElement.requestFullscreen();")
      updateActionButton(session, "page_toggle", icon = icon("minimize"))
      fullscreen_mode(TRUE)
    } else {

      session$sendCustomMessage("exitFullScreen", list())
      updateActionButton(session, "page_toggle", icon = icon("maximize"))
      fullscreen_mode(FALSE)
    }
  })

  home_Server('id_home')
  anova_Server('id_anova')


}
