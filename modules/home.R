# Home module -------------------------------------------------------------

home_UI <- function(id) {
  ns <- NS(id)
  tabItem(
    'home'
  )

}

home_Server <- function(id) {
  moduleServer(id, function(input, output, session) {

  })
}
