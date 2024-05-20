#################################
##        Group 3 Project      ##
##        Box Office Mojo      ##
##        Sentiment Scores     ##
#################################

#############################
## Clear Working Directory ##
#############################

rm(list = ls())

library(tidyverse)
library(tm)
library(stringr)
library(R.utils)
library(dplyr) 

###########################
## Set working directory ##
###########################

workingdir <- "C:/Users/jaych/OneDrive/MS FINANCE/Semester 2/Textual Analysis/Final Project"
if (!dir.exists(workingdir)){
  dir.create(workingdir)
} 
setwd(workingdir)

##########################
## Read in all the Data ##
##########################

All_Budgets <- read.csv("All_Budgets.csv", stringsAsFactors=FALSE)
head(All_Budgets)

All_MovieInfo <- read.csv("All_MovieInfo.csv", stringsAsFactors=FALSE)
head(All_MovieInfo)

All_Reviews <- read.csv("All_Reviews.csv", stringsAsFactors=FALSE)
head(All_Reviews)

BoxOfficeSummary2015_2019 <- read.csv("BoxOfficeSummary2015_2019.csv", stringsAsFactors=FALSE)
head(BoxOfficeSummary2015_2019)

DroppedMovies_byName <- read.csv("DroppedMovies_byName.csv", stringsAsFactors=FALSE)
head(DroppedMovies_byName)

FinalMovieIndex_DerivativeURLS_wSuccess <- read.csv("FinalMovieIndex_DerivativeURLS_wSuccess.csv", stringsAsFactors=FALSE)
head(FinalMovieIndex_DerivativeURLS_wSuccess)

abnormal_scores <- read.csv("abnormal_scores.csv", stringsAsFactors=FALSE)
head(abnormal_scores)

#################################
## Clean Data from All_Reviews ##
#################################

summary(All_Reviews$OriginalScore)
All_Reviews %>% as_tibble() %>% count(OriginalScore)

All_Reviews <- All_Reviews %>% as_tibble()

# All_Reviews %>% 
#   mutate(new = str_trim(OriginalScore)) %>% 
#   select(new) %>% 
#   mutate(new_new = str_split(new, '/', n = 2, simplify = T))

All_Reviews

######################################
## Sentiment Score Analysis attempt ##
######################################

##Use case 1 FIPS is.na

dictionary_neg <- read.csv("LoughranMcDonald_Negative.csv", header=FALSE)
dictionary_pos <- read.csv("LoughranMcDonald_Positive.csv", header=FALSE)
len_pos <- dim(dictionary_pos)[1]
len_neg <- dim(dictionary_neg)[1]
len_pos
len_neg

regex_pos <- rep("", len_pos)
regex_neg <- rep("", len_neg)

for(j in 1:len_pos){
  regex_pos[j] <- tolower(dictionary_pos[j,1])
}
for(j in 1:len_neg){
  regex_neg[j] <- tolower(dictionary_neg[j,1])
}


## Sentiment Score continued

All_Reviews %>% select(X, ReviewQuote)

# N: row number of reviews
N <- nrow(All_Reviews)
# review_sent: For saving output
review_sent <- matrix(0, N, 3)
terms_used <- matrix(0,0,3)

for(i in 1:N){
  cat("Iteration", i, "out of", N, "\n")
  lines <- All_Reviews[i, ]$ReviewQuote
  
  # Collapse all lines into one.
  filing <- paste(lines, collapse = " ")
  
  # Some cleaning
  filing <- gsub("\\d", "", filing)
  filing <- gsub("[[:punct:]]", "", filing)
  filing <- gsub("[^\x20-\x7E]", "", filing)
  filing <- gsub("\\s+", " ", filing)
  
  pos_hits <- rep(0, len_pos)
  neg_hits <- rep(0, len_neg)
  
  # Let's use the tm package
  vs <- VectorSource(filing)
  corpora <- VCorpus(vs)
  corpora <- tm_map(corpora, content_transformer(tolower))
  tdm = TermDocumentMatrix(corpora, control=list(weighting=weightTfIdf))
  
  # Count words
  for(j in 1:len_pos){
    pos_hits[j] <- tm_term_score(tdm, regex_pos[j])
  }
  n_pos <- sum(pos_hits)
  
  for(j in 1:len_neg){
    neg_hits[j] <- tm_term_score(tdm, regex_neg[j])
  }
  n_neg <- sum(neg_hits)
  
  n_words <- length(unlist(str_split(filing, "\\s")))
  
  ## save n_words (total words), n_pos, and n_neg into review_sent
  review_sent[i,1] <- n_words
  review_sent[i,2] <- n_pos
  review_sent[i,3] <- n_neg
  
  test_matrix$count <- as.data.frame(as.matrix(tdm), row.names=F)
  test_matrix$word <- rownames(tdm)
  test_matrix$doc <- N
  terms_used <- rbind(terms_used, test_matrix)
}


## Covert the matrix to dataframe
df_review_sent <- as_tibble(review_sent)
colnames(df_review_sent) <- c("ntotal", "npos", "nneg")

df_review_sent$pos_score <- df_review_sent$npos/df_review_sent$ntotal
df_review_sent$neg_score <- df_review_sent$nneg/df_review_sent$ntotal
df_review_sent$sentiment <- df_review_sent$pos_score - df_review_sent$neg_score

view(df_review_sent)
write.csv(df_review_sent, file='sentiment_score.csv',row.names=T )

write.csv(terms_used, file='terms_in_reviews.csv', row.names=F)



