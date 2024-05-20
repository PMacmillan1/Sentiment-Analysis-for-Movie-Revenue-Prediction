#################################
##        Group 3 Project      ##
##        Box Office Mojo      ##
##      Regression Analysis    ##
#################################

#############################
## Clear Working Directory ##
#############################

rm(list = ls())

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

sentiment_score <- read.csv("sentiment_score.csv", stringsAsFactors=FALSE)
head(sentiment_score)

percent_score <- read.csv("percent_score.csv", stringsAsFactors=FALSE)
head(percent_score)

################
## Merge Data ##
################

merged_dat <- merge(sentiment_score, percent_score, by = "X")
head(merged_dat)

write.csv(merged_dat, file="merged_per_sent.csv")

####################################################################
## Regression Analysis 1: Y: Percent Score vs. X: Sentiment Score ##
####################################################################

mylm <- lm(merged_dat$percent_num~merged_dat$sentiment, na.action = na.omit)

plot(merged_dat$percent_num~merged_dat$sentiment, main = "Plot of Sentiment Scores vs. Percentage Scores", xlab="Sentiment Score", ylab="Percent Score")
abline(mylm, col="darkgreen", lty="dashed", lwd=2)
text(x=0.8, y=10, "Correlation = 0.1669")

cor(merged_dat$sentiment, merged_dat$percent_num,use="complete.obs") ##Weak Positive Correlation: 0.1669

summary(mylm)

##########################################
## Regression Analysis: Summarized Data ##
##########################################

regression_analysis <- read.csv("regression_analysis.csv", stringsAsFactors=FALSE)

####################
## Clean the Data ##
####################

regression_analysis[,2] <- as.numeric(regression_analysis[,2])
regression_analysis[,4] <- as.numeric(regression_analysis[,4])
regression_analysis[,5] <- as.numeric(regression_analysis[,5])
regression_analysis[,6] <- as.numeric(regression_analysis[,6])

####################################################################################
## Regression Analysis 2: Y: Average Percent Score vs. X: Average Sentiment Score ##
####################################################################################

mylm1 <- lm(regression_analysis$AveragePercent~regression_analysis$AverageSentiment, na.action = na.omit)

plot(regression_analysis$AveragePercent~regression_analysis$AverageSentiment, main = "Plot of Average Sentiment Score vs. Average Percentage Scores", xlab="Average Sentiment Score", ylab="Average Percent Score")
abline(mylm1, col="darkgreen", lty="dashed", lwd=2)
text(x=0.07, y=30, "Correlation = 0.3129")

cor(regression_analysis$AverageSentiment, regression_analysis$AveragePercent,use="complete.obs") ##Positive Correlation: 0.3129

summary(mylm1)

#########################################################################
## Regression Analysis 3: Y: Average Percent Score vs. X: Tomato Score ##
#########################################################################

mylm2 <- lm(regression_analysis$AveragePercent~regression_analysis$TomatoScore, na.action = na.omit)

plot(regression_analysis$AveragePercent~regression_analysis$TomatoScore, main = "Plot of Tomato Scores vs. Average Percentage Scores", xlab="Tomato Score", ylab="Average Percent Score")
abline(mylm2, col="darkgreen", lty="dashed", lwd=2)
text(x=80, y=30, "Correlation = 0.8746")

cor(regression_analysis$AveragePercent, regression_analysis$TomatoScore,use="complete.obs") ##Strong Positive Correlation: 0.8746

summary(mylm2)

#####################################################################################
## The following Regressions will focus on Gross Revenue as the Dependent Variable ##
#####################################################################################

############################################################################
## Regression Analysis 4: Y: Gross Revenue vs. X: Average Sentiment Score ##
############################################################################

options(scipen = 100000000) ##This makes the plot more readible and removes scientific notation
mylm3 <- lm(regression_analysis$GrossRevenue~regression_analysis$AverageSentiment, na.action = na.omit)

plot(regression_analysis$GrossRevenue~regression_analysis$AverageSentiment, main = "Plot of Gross Revenue vs. Average Sentiment Score", xlab="Average Sentiment Score", ylab="Gross Revenue")
abline(mylm3, col="darkgreen", lty="dashed", lwd=2)
text(x=0.08, y=800000000, "Correlation = 0.0906")

cor(regression_analysis$GrossRevenue, regression_analysis$AverageSentiment,use="complete.obs") ##Weak Positive Correlation: 0.0906

summary(mylm3)

######################################################################
## Regression Analysis 5: Y: Gross Revenue vs. X: Production Budget ##
######################################################################

mylm4 <- lm(regression_analysis$GrossRevenue~regression_analysis$ProductionBudget, na.action = na.omit)

plot(regression_analysis$GrossRevenue~regression_analysis$ProductionBudget, main = "Plot of Gross Revenue vs. Production Budget", xlab="Production Budget", ylab="Gross Revenue")
abline(mylm4, col="darkgreen", lty="dashed", lwd=2)
text(x=350000000, y=200000000, "Correlation = 0.7309")

cor(regression_analysis$GrossRevenue, regression_analysis$ProductionBudget,use="complete.obs") ##Strong Positive Correlation: 0.7309

summary(mylm4)

##################################
## Multiple Regression Analysis ##
##################################

#######################################################################################################
## Regression Analysis 6: Y: Gross Revenue vs. X: Production Budget Holding Constant the Distributor ##
#######################################################################################################

mylm5 <- lm(GrossRevenue~ProductionBudget+Distributor, data=regression_analysis, na.action = na.omit)
summary(mylm5)
sqrt(0.5837) ##The square root of the multiple R-Squared indicates a strong positive correlation of 0.7640
anova(mylm5)

#############################################################################################################
## Regression Analysis 7: Y: Gross Revenue vs. X: Average Sentiment Score Holding Constant the Distributor ##
#############################################################################################################

mylm6 <- lm(GrossRevenue~scale(AverageSentiment)+Distributor, data=regression_analysis, na.action = na.omit)
summary(mylm6)
sqrt(0.3811) ##The square root of the multiple R-Squared indicates a strong positive correlation of 0.6173
anova(mylm6)



