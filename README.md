# Sentiment-Analysis-for-Movie-Revenue-Prediction
This project aims to explore the relationship between movie review sentiments and box office revenue using Natural Language Processing (NLP) techniques. The analysis focuses on determining if review sentiments from Rotten Tomatoes can predict a movie's financial success and if review sentiments correlate with review scores.

**Objectives**
- Primary Objective: Assess if sentiment scores from movie reviews can predict box office revenue.
- Secondary Objective: Evaluate the correlation between review sentiment and review ratings.
- Additional Objective: Hold constant variables such as production budget and movie studio to ensure accurate correlation outputs.

**Methodology**

A. **Data Collection:**
Scraped data for 1,000 movies (2015-2019) from Box Office Mojo and Rotten Tomatoes.
Gathered 44,158 reviews and movie details, including production budgets from The Numbers website.

B. **Data Cleaning and Preparation:**
- Standardized review scores to a percentage format.
- Processed review texts by removing non-ASCII characters, punctuation, and stopwords.

C. **Sentiment Analysis:**
- Used Loughran McDonald dictionaries to calculate sentiment scores.
- Identified common positive and negative words specific to movie reviews.

D. **Regression Analysis:**
- Conducted multiple single and multiple regressions to analyze relationships between sentiment scores, review scores, and gross revenue.
- Held constant variables like production budget and distributor to refine the analysis.

**Results**

A. **Sentiment and Review Scores:**
- Found a weak positive correlation (0.1669) between sentiment scores and review percentages.
- Identified a stronger correlation (0.8746) between average percent scores and Rotten Tomatoes scores.

B. **Sentiment and Revenue:**
- Discovered a weak positive correlation (0.0906) between sentiment scores and gross revenue.
- Found that holding the movie studio constant increased the positive correlation to 0.6173.

C. **Budget and Revenue:**
- Identified a strong positive correlation (0.7640) between production budget and gross revenue, suggesting higher budgets generally lead to higher revenues.

**Skills and Tools Used**
- Programming Languages: Python, R
- Libraries: BeautifulSoup for web scraping, NLTK for NLP, pandas for data manipulation, scikit-learn for regression analysis
- Techniques: Sentiment analysis, data cleaning and standardization, regression analysis
- Tools: Excel for data cleaning, R Studio for statistical analysis

**Outcomes**
- Key Insight: While sentiment scores from reviews are weak predictors of box office revenue, the production budget has a strong positive impact on revenue.
- Future Work: Create a custom movie review sentiment dictionary to improve sentiment analysis accuracy. Expand research to include worst-performing films and analyze additional variables like genre, director, and cast members.
