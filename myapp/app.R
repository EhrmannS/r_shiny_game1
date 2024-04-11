library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      textInput("msg", "Message", placeholder = "type a message in the chat"),
      actionButton("submit", "submit")
    ),
    mainPanel(
      verbatimTextOutput("text")
    )
  )
)

createChat <- function(initVal) {
  chat_text <- reactiveVal(initVal)
  list(
    get = function(){ chat_text() },
    append = function(val) {
      chat_text(paste0(isolate(chat_text()), "\n", val))
    }
  )
}

myChat <- createChat("## This is a chat ##\n")

server <- function(input, output) {
  observeEvent(input$submit, {
    myChat$append(input$msg)
  })
  output$text <- renderText(myChat$get())
}

shinyApp(ui = ui, server = server)
