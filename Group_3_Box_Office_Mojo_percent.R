#################################
##        Group 3 Project      ##
##        Box Office Mojo      ##
#################################

#############################
## Clear Working Directory ##
#############################

rm(list = ls())

library(tidyverse)
library(data.table)

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

## In this part, we transfer the original score into percentage score(out of 100%)
All_Reviews <- All_Reviews %>% as_tibble()

All_Reviews %>% as_tibble() %>% count(OriginalScore)

## Rule one: Find the NAs. If the movie is "fresh", assign the NAs 60%; if "rotten", 40%.
X<- All_Reviews

X$OriginalScore[which(X$ScoreState == 'fresh' & is.na(X$OriginalScore) == TRUE)] <- "60%"
X$OriginalScore[which(X$ScoreState == 'rotten' & is.na(X$OriginalScore) == TRUE)] <- "40%"



## Rule two: Deal with the abnormal scores
# 0	0%
X$OriginalScore[which(X$OriginalScore == '0')] <- "0%"

# 2:04	50%
X$OriginalScore[which(X$OriginalScore == '2:04')] <- "50%"

# 0.5	10%
X$OriginalScore[which(X$OriginalScore == '0.5')] <- "10%"

# 1	20%
X$OriginalScore[which(X$OriginalScore == '1')] <- "20%"

# 1.5	30%
X$OriginalScore[which(X$OriginalScore == '1.5')] <- "30%"

# 2	40%
X$OriginalScore[which(X$OriginalScore == '2')] <- "40%"

# 2.25	45%
X$OriginalScore[which(X$OriginalScore == '2.25')] <- "45%"

# 2.4	48%
X$OriginalScore[which(X$OriginalScore == '2.4')] <- "48%"

# 2.5	50%
X$OriginalScore[which(X$OriginalScore == '2.5')] <- "50%"

# 2.54	51%
X$OriginalScore[which(X$OriginalScore == '2.54')] <- "51%"

# 3	60%
X$OriginalScore[which(X$OriginalScore == '3')] <- "60%"

# 3.5	70%
X$OriginalScore[which(X$OriginalScore == '3.5')] <- "70%"

# 4	80%
X$OriginalScore[which(X$OriginalScore == '4')] <- "80%"

# 4.5	90%
X$OriginalScore[which(X$OriginalScore == '4.5')] <- "90%"

# 4.7	94%
X$OriginalScore[which(X$OriginalScore == '4.7')] <- "94%"

# 5	100%
X$OriginalScore[which(X$OriginalScore == '5')] <- "100%"

# 5.42042	54%
X$OriginalScore[which(X$OriginalScore == '5.42042')] <- "54%"

# 5.5	55%
X$OriginalScore[which(X$OriginalScore == '5.5')] <- "55%"

# 6	60%
X$OriginalScore[which(X$OriginalScore == '6')] <- "60%"

# 7	70%
X$OriginalScore[which(X$OriginalScore == '7')] <- "70%"

# 8	80%
X$OriginalScore[which(X$OriginalScore == '8')] <- "80%"

# 10	100%
X$OriginalScore[which(X$OriginalScore == '10')] <- "100%"

# 1-5 stars	20%
X$OriginalScore[which(X$OriginalScore == '1-5 stars')] <- "20%"

# 1-5 Stars	20%
X$OriginalScore[which(X$OriginalScore == '1-5 Stars')] <- "20%"

# 2 of 5	40%
X$OriginalScore[which(X$OriginalScore == '2 of 5')] <- "40%"

# A	90%
X$OriginalScore[which(X$OriginalScore == 'A')] <- "90%"

# A-	85%
X$OriginalScore[which(X$OriginalScore == 'A-')] <- "85%"

# A+	95%
X$OriginalScore[which(X$OriginalScore == 'A+')] <- "95%"

# B	75%
X$OriginalScore[which(X$OriginalScore == 'B')] <- "75%"

# B +	80%
X$OriginalScore[which(X$OriginalScore == 'B +')] <- "80%"

# B plus	80%
X$OriginalScore[which(X$OriginalScore == 'B plus')] <- "80%"

# B-	70%
X$OriginalScore[which(X$OriginalScore == 'B-')] <- "70%"

# B+	80%
X$OriginalScore[which(X$OriginalScore == 'B+')] <- "80%"

# Big Screen Watch	60%
X$OriginalScore[which(X$OriginalScore == 'Big Screen Watch')] <- "60%"

# C	60%
X$OriginalScore[which(X$OriginalScore == 'C')] <- "60%"

# C +	65%
X$OriginalScore[which(X$OriginalScore == 'C +')] <- "65%"

# C minus	55%
X$OriginalScore[which(X$OriginalScore == 'C minus')] <- "55%"

# C plus	65%
X$OriginalScore[which(X$OriginalScore == 'C plus')] <- "65%"

# C-	55%
X$OriginalScore[which(X$OriginalScore == 'C-')] <- "55%"

# C--	50%
X$OriginalScore[which(X$OriginalScore == 'C--')] <- "50%"

# C-plus	65%
X$OriginalScore[which(X$OriginalScore == 'C-plus')] <- "65%"

# C+	65%
X$OriginalScore[which(X$OriginalScore == 'C+')] <- "65%"

# Catch It On Cable	70%
X$OriginalScore[which(X$OriginalScore == 'Catch It On Cable')] <- "70%"

# D	45%
X$OriginalScore[which(X$OriginalScore == 'D')] <- "45%"

# D-	40%
X$OriginalScore[which(X$OriginalScore == 'D-')] <- "40%"

# D+	50%
X$OriginalScore[which(X$OriginalScore == 'D+')] <- "50%"

# F	35%
X$OriginalScore[which(X$OriginalScore == 'F')] <- "35%"

# F-	30%
X$OriginalScore[which(X$OriginalScore == 'F-')] <- "30%"

# F---	25%
X$OriginalScore[which(X$OriginalScore == 'F---')] <- "25%"

# Half Price	50%
X$OriginalScore[which(X$OriginalScore == 'Half Price')] <- "50%"

# Not Recommended	25%
X$OriginalScore[which(X$OriginalScore == 'Not Recommended')] <- "25%"

# Read A Book	25%
X$OriginalScore[which(X$OriginalScore == 'Read A Book')] <- "25%"

# Recommended	85%
X$OriginalScore[which(X$OriginalScore == 'Recommended')] <- "85%"

# x	60%
X$OriginalScore[which(X$OriginalScore == 'x')] <- "60%"





## Rule three: for ***/*** format, do the division, keep the integer
X %>% 
  mutate(new = str_trim(OriginalScore)) %>% 
  select(new) %>% 
  mutate(new_new = str_split(new, '/', n = 2, simplify = T))

X %>% 
  mutate(new = str_trim(OriginalScore)) %>% 
  select(X, new) %>% 
  filter(!grepl('\\/', new)) %>% 
  count(new) %>% view()

## 
# Use Y temporarily
Y <- X %>% 
  mutate(new = str_trim(OriginalScore)) %>% 
  select(X, new)
setDT(Y)

# check other modes
Y %>% 
  filter(!grepl('\\/', new)) %>% 
  count(new) 

Y[new == '', new := NA_character_][]
Y[new == '0%', new := "0"][]
Y[new == '1-5', new := "20"][]
Y[new == '10%', new := "10"][]
Y[new == '100%', new := "100"][]
Y[new == '1.0', new := "100"][]
Y[new == '2:4', new := "50"][]
Y[new == '2.0', new := "40"][]
Y[new == '2.00', new := "40"][]
Y[new == '2.00', new := "40"][]
Y[new == '4.0', new := "80"][]
Y[new == '5.420420', new := "54"][]
Y[grepl("\\%$", new), new := str_sub(new, 1, 2)][]


# Deal with "/"
Y %>% 
  filter(grepl('\\/', new)) %>% 
  count(new) 

two_cols <- Y[grepl('\\/', new)] %>% .$new %>% str_split('/', n = 2, simplify = T) %>% as.data.table()
Y[grepl('\\/', new), num := as.numeric(two_cols$V1)]
Y[grepl('\\/', new), dem := as.numeric(two_cols$V2)]
Y[, num := as.numeric(num)][]
Y[, dem := as.numeric(dem)][]
Y[grepl('\\/', new), ratio := num / dem * 100][]
Y[grepl('\\/', new), new := as.character(ratio)][]
Y[, `:=`(num = NULL, dem = NULL, ratio = NULL)][]

Y[, `:=`(percent_num = as.numeric(new), 
         percent_char = str_c(round(as.numeric(new), digits = 0), '%'))]


# Merge back
Y

X <- X %>% 
  left_join(Y, by = c('X'))

view(X)

write.csv(X, file="percent_score.csv")
