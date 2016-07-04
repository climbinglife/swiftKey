library(shiny)

# Load prediction model function
source("D:/Coursera/capstone project/swiftKey/simpleModel.R")

# Load word frequency matrix
load("D:/Coursera/capstone project/swiftKey/temp/frequency_matrix.RData")

shinyServer(
  function(input, output) {
    observeEvent(input$predict, {
      # First use a fixed substitution matrix
        inText=input$text
        nextWord <- predictNext(inText, freq1_df, freq2_df, freq3_df, freq4_df, freq5_df)
        output$result <- renderText(nextWord)
    })
  }
)
