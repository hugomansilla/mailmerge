# library(shiny)
# library(miniUI)

#' Preview mailmerge as shiny gadget in RStudio preview pane.
#' 
#' @param x mailmer_preview object
#' 
#' @export
#' @importFrom miniUI miniPage gadgetTitleBar miniContentPanel
#' @importFrom shiny numericInput htmlOutput reactive observeEvent runGadget stopApp
preview_mailmerge <- function(x) {
  
  ui <- miniPage(
    gadgetTitleBar("Preview mail merge"),
    miniContentPanel(
      numericInput("item", label = "number", value = 1, min = 1, max = length(x), step = 1),
      htmlOutput("rendered")
    )
  )
  
  server <- function(input, output, session) {
    # Define reactive expressions, outputs, etc.
    # browser()
    output$rendered <- reactive(as_html(x[[input$item]], standalone = FALSE))
    
    # When the Done button is clicked, return a value
    observeEvent(input$done, { stopApp(NULL) })
  }
  
  runGadget(ui, server)
}