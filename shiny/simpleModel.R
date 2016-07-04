library(plyr)
library(tm)
library(data.table)
options(java.parameters = "-Xmx4g" )
library(RWeka)
library(stringr)
library(slam)

predictNext <- function(input, unigrams, bigrams, trigrams, quadgrams, quintgrams=NULL) {
    usableText=str_replace_all(input,"[^[:graph:]]", " ")
    text <- tolower(usableText)
    text <- stripWhitespace(text)
    text <- removeWords(text, stopwords("english"))
    text <- removePunctuation(text)
    text <- removeNumbers(text)
    #print(text)
    tokens <- strsplit(text, " ")[[1]]
    tokens <- tokens[tokens!=""]
    n <- length(tokens)
    if(n == 0) {
        # No input
        best <- unigrams[which(unigrams$count == max(unigrams$count)), ][1,]
        return(best$word)
    }
    else if(n == 1) {
        hits = bigrams[bigrams$w1 == tokens[1], ]
        if(nrow(hits) > 0) {
            best <- hits[which(hits$count == max(hits$count)), ][1,]
            return(best$w2)
        }
        else {
            best <- unigrams[which(unigrams$count == max(unigrams$count)), ][1,]
            return(best$word)
        }
    }
    else if (n ==2) {
        hits = trigrams[trigrams$w1 == tokens[n-1] & trigrams$w2 == tokens[n], ]
        if(nrow(hits) > 0) {
            best <- hits[which(hits$count == max(hits$count)), ][1,]
            return(best$w3)
        }
        else {
            input = tokens[n]
            result = predictNext(input, unigrams, bigrams, trigrams, quadgrams)
            return(result)
        }
    }
    else if(n == 3 | (n>3 & missing(quintgrams)) ) {
        hits = subset(quadgrams, w1== tokens[n-2] & w2== tokens[n-1] & w3== tokens[n])
        if(nrow(hits) > 0) {
            best <- hits[which(hits$count == max(hits$count)), ][1,]
            return(best$w4)
        }
        else {
            input = paste(tokens[n-1], tokens[n], sep=" ")
            result = predictNext(input, unigrams, bigrams, trigrams, quadgrams)
            return(result)
        }
    }
    else if(n > 3 & !missing(quintgrams)) {
        hits = subset(quintgrams, w1==tokens[n-3] & w2== tokens[n-2] & w3== tokens[n-1] & w4== tokens[n])
        if(nrow(hits) > 0) {
            best <- hits[which(hits$count == max(hits$count)), ][1,]
            return(best$w5)
        }
        else {
            input = paste(tokens[n-2], tokens[n-1], tokens[n], sep=" ")
            result = predictNext(input, unigrams, bigrams, trigrams, quadgrams)
            return(result)
        }
    }
}
