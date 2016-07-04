library(shiny)

shinyUI(fluidPage(
  headerPanel("Prediction of next word based on n-grams model"),
  fluidRow(
      column(width=8, 
          h3('Input text for next word prediction'),
          textInput("text", "Enter the text", "What is the weather"),
          actionButton("predict", "Predict the next word")
      )
  ),
  fluidRow(
        column(width=8,
        h3('Prediction results'),
        h4('Next word is:'),
        h4(textOutput('result'))
    )
  ),
  fluidRow(
      column(width=8,
             HTML('<hr height="30">'),
             h5(a("About this app", href="https://github.com/climbinglife/swiftKey"))
      )
  )
))