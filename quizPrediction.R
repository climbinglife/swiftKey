# Load prediction model function
source("D:/Coursera/capstone project/swiftKey/simpleModel.R")

# Load word frequency matrix
load("D:/Coursera/capstone project/swiftKey/temp/frequency_matrix.RData")

# Quiz 1
test <- c()
temp <- "The guy in front of me just bought a pound of bacon, a bouquet, and a case of"
test <- c(test, temp)
temp <- "You're the reason why I smile everyday. Can you follow me please? It would mean the"
test <- c(test, temp)
temp <- "Hey sunshine, can you follow me and make me the"
test <- c(test, temp)
temp <- "Very early observations on the Bills game: Offense still struggling but the"
test <- c(test, temp)
temp <- "Go on a romantic date at the"
test <- c(test, temp)
temp <- "Well I'm pretty sure my granny has some old bagpipes in her garage I'll dust them off and be on my"
test <- c(test, temp)
temp <- "Ohhhhh #PointBreak is on tomorrow. Love that film and haven't seen it in quite some"
test <- c(test, temp)
temp <- "After the ice bucket challenge Louis will push his long wet hair out of his eyes with his little"
test <- c(test, temp)
temp <- "Be grateful for the good times and keep the faith during the"
test <- c(test, temp)
temp <- "If this isn't the cutest thing you've ever seen, then you must be"
test <- c(test, temp)

for(input in test) {
    result <- predictNext(input, freq1_df, freq2_df, freq3_df, freq4_df, freq5_df)
    print(paste("Input: ", input))
    print(paste("Prediction:", result))
}

# Quiz 2
test2 <- c()
temp <- "When you breathe, I want to be the air for you. I'll be there for you, I'd live and I'd"
test2 <- c(test2, temp)
temp <- "Guy at my table's wife got up to go to the bathroom and I asked about dessert and he started telling me about his"
test2 <- c(test2, temp)
temp <- "I'd give anything to see arctic monkeys this"
test2 <- c(test2, temp)
temp <- "Talking to your mom has the same effect as a hug and helps reduce your"
test2 <- c(test2, temp)
temp <- "When you were in Holland you were like 1 inch away from me but you hadn't time to take a"
test2 <- c(test2, temp)
temp <- "I'd just like all of these questions answered, a presentation of evidence, and a jury to settle the"
test2 <- c(test2, temp)
temp <- "I can't deal with unsymetrical things. I can't even hold an uneven number of bags of groceries in each"
test2 <- c(test2, temp)
temp <- "Every inch of you is perfect from the bottom to the"
test2 <- c(test2, temp)
temp <- "I'm thankful my childhood was filled with imagination and bruises from playing"
test2 <- c(test2, temp)
temp <- "I like how the same people are in almost all of Adam Sandler's"
test2 <- c(test2, temp)

for(input in test2) {
    result <- predictNext(input, freq1_df, freq2_df, freq3_df, freq4_df, freq5_df)
    print(paste("Input: ", input))
    print(paste("Prediction:", result))
}
