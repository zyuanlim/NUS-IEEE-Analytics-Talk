# This R code generates the partial dependency plot (PDP) using the 'pdp' library
# Here we plot the PDPs for the top 2 features of wine dataset
# For reproducibility:
# xgboost version: 0.6-4
# pdp version: 0.5.2
# dplyr version: 0.7.1

library(xgboost)
library(pdp)
library(dplyr)

# Function to plot the pdp
plot_pdp <- function(xgb_mdl, train, feature){
  lstat <- partial(xgb_mdl, train = train, pred.var = feature, plot = TRUE, 
                   prob = TRUE, rug = TRUE, type = "classification")
  lstat
}

# First load the xgboost model
xgb_mdl <- xgb.load("./data/xgb_clf.model")
# Assign the objective to be part of the model's attribute
xgb_mdl$params$objective <- "binary:logistic"
# Load the training data
df <- readr::read_csv("./data/wine_data.csv")

# PDP for Color Intensity
color_int <- plot_pdp(xgb_mdl, df, "color_intensity")
color_int
# Write the data out for plotting in jupyter notebook
write.csv(attr(color_int, "partial.data"), "./data/pdp/color_int.csv", row.names = F)

# PDP for flavanoids
flava <- plot_pdp(xgb_mdl, df, "flavanoids")
flava
# Write the data out for plotting in jupyter notebook
write.csv(attr(flava, "partial.data"), "./data/pdp/flavanoids.csv", row.names = F)
