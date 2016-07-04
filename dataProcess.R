library(plyr)
library(tm)
library(data.table)
options(java.parameters = "-Xmx4g" )
library(RWeka)
library(stringr)
library(slam)
rm(list=ls())

setwd("D:/Coursera/capstone project")

twitter <- readLines("D:/Coursera/capstone project/final/en_US/en_US.twitter.txt", encoding="UTF-8")
news <- readLines("D:/Coursera/capstone project/final/en_US/en_US.news.txt", encoding="UTF-8")
blogs <- readLines("D:/Coursera/capstone project/final/en_US/en_US.blogs.txt", encoding="UTF-8")

# Get the size and sample 6% of the data for model construction
frac = 0.06
n_twitter <- length(twitter)
n_news <- length(news)
n_blogs <- length(blogs)
set.seed(27)
twitter_sample <- twitter[sample(n_twitter, frac * n_twitter)]
news_sample <- news[sample(n_news, frac * n_news)]
blogs_sample <- blogs[sample(n_blogs, frac * n_blogs)]
# Clear the memory
rm(twitter)
rm(news)
rm(blogs)

## Function to generate corpus given a text input
getCorpus <- function(v) {
    usableText=str_replace_all(v,"[^[:graph:]]", " ") 
    corpus <- VCorpus(VectorSource(usableText))
    corpus <- tm_map(corpus, content_transformer(function(x) iconv(enc2utf8(x), sub = "byte")))
    corpus <- tm_map(corpus, stripWhitespace)  # remove whitespace
    corpus <- tm_map(corpus, content_transformer(tolower))  # lowercase all
    # Does not work very well if removing stop words
    corpus <- tm_map(corpus, removeWords, stopwords("english"))  # rm stopwords
    corpus <- tm_map(corpus, removePunctuation)
    corpus <- tm_map(corpus, removeNumbers)
    corpus 
}

tCorpus <- getCorpus(twitter_sample)
nCorpus <- getCorpus(news_sample) 
bCorpus <- getCorpus(blogs_sample)

sample_corpus <- c(tCorpus, nCorpus, bCorpus)
# Save the data to temp files
corpusfile = "temp/sample_corpus.RData"
save(sample_corpus, file=corpusfile)

# Geneate n-grams
# Load data directly from saved file
load(corpusfile)
UnigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
QuadgramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
QuintgramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 5, max = 5))

# 1-gram frequency matrix
tdm_1 <- TermDocumentMatrix(sample_corpus, control = list(tokenize = UnigramTokenizer)) 
freq1_df <- data.frame(sort(row_sums(tdm_1), decreasing=TRUE))
freq1_df <- cbind(rownames(freq1_df), freq1_df)
rownames(freq1_df) <- NULL
colnames(freq1_df) <- c("word", "count")

# 2-gram frequency matrix
tdm_2 <- TermDocumentMatrix(sample_corpus, control = list(tokenize = BigramTokenizer)) 
freq2_df <- data.frame(sort(row_sums(tdm_2), decreasing=TRUE))
freq2_df <- cbind(rownames(freq2_df), freq2_df)
rownames(freq2_df) <- NULL
colnames(freq2_df) <- c("word", "count")

# 3-gram frequency matrix
tdm_3 <- TermDocumentMatrix(sample_corpus, control = list(tokenize = TrigramTokenizer)) 
freq3_df <- data.frame(sort(row_sums(tdm_3), decreasing=TRUE))
freq3_df <- cbind(rownames(freq3_df), freq3_df)
rownames(freq3_df) <- NULL
colnames(freq3_df) <- c("word", "count")

# 4-gram frequency matrix
tdm_4 <- TermDocumentMatrix(sample_corpus, control = list(tokenize = QuadgramTokenizer)) 
freq4_df <- data.frame(sort(row_sums(tdm_4), decreasing=TRUE))
freq4_df <- cbind(rownames(freq4_df), freq4_df)
rownames(freq4_df) <- NULL
colnames(freq4_df) <- c("word", "count")

# 5-gram frequency matrix
tdm_5 <- TermDocumentMatrix(sample_corpus, control = list(tokenize = QuintgramTokenizer)) 
freq5_df <- data.frame(sort(row_sums(tdm_5), decreasing=TRUE))
freq5_df <- cbind(rownames(freq5_df), freq5_df)
rownames(freq5_df) <- NULL
colnames(freq5_df) <- c("word", "count")

freq1_df$word <- as.character(freq1_df$word)
freq2_df$word <- as.character(freq2_df$word)
freq3_df$word <- as.character(freq3_df$word)
freq4_df$word <- as.character(freq4_df$word)
freq5_df$word <- as.character(freq5_df$word)

# Remove singleton token as noise
freq1_df <- subset(freq1_df, count > 1)
freq1_df$word <- as.character(freq1_df$word)
# Add the first word as a column
#freq2_df <- subset(freq2_df, count > 1)
word.df <- data.frame(t(sapply(freq2_df$word, function(x) strsplit(x, " ")[[1]])))
freq2_df$w1 <- as.character(word.df[,1])
freq2_df$w2 <- as.character(word.df[,2])
# Add the first and second word as a column
#freq3_df <- subset(freq3_df, count > 1)
word.df <- data.frame(t(sapply(freq3_df$word, function(x) strsplit(x, " ")[[1]])))
freq3_df$w1 <- as.character(word.df[,1])
freq3_df$w2 <- as.character(word.df[,2])
freq3_df$w3 <- as.character(word.df[,3])
# Add the first, second and thrid word as a column
# freq4_df <- subset(freq4_df, count > 1)
word.df <- data.frame(t(sapply(freq4_df$word, function(x) strsplit(x, " ")[[1]])))
freq4_df$w1 <- as.character(word.df[,1])
freq4_df$w2 <- as.character(word.df[,2])
freq4_df$w3 <- as.character(word.df[,3])
freq4_df$w4 <- as.character(word.df[,4])

# freq5_df <- subset(freq5_df, count > 1)
word.df <- data.frame(t(sapply(freq5_df$word, function(x) strsplit(x, " ")[[1]])))
freq5_df$w1 <- as.character(word.df[,1])
freq5_df$w2 <- as.character(word.df[,2])
freq5_df$w3 <- as.character(word.df[,3])
freq5_df$w4 <- as.character(word.df[,4])
freq5_df$w5 <- as.character(word.df[,5])

# Remove the word column
freq2_df <- freq2_df[,-1]
freq3_df <- freq3_df[,-1]
freq4_df <- freq4_df[,-1]
freq5_df <- freq5_df[,-1]

save(freq1_df, freq2_df, freq3_df, freq4_df, freq5_df, file = "temp/frequency_matrix.RData")
