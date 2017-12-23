## Call packages
library(caret)
library(lattice)
library(ggplot2)
source("QuickCairoExport.R")

## Load data
hardsource = FALSE

if (hardsource == TRUE) {
  source <- "iris.csv"
  dataset <- read.csv(source, header = FALSE)
  colnames(dataset) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")
}

dataset <- iris

## Partitioning
# Create validation set
validation_index <- createDataPartition(dataset$Species, p = 0.8, list = FALSE)
validation <- dataset[-validation_index, ]

# Create testing set
dataset <- dataset[validation_index, ]

## Basic data exploration
dim(dataset)
sapply(dataset, class)
head(dataset, n = 8)

levels(dataset$Species)

# Class distribution
percentage <- prop.table(table(dataset$Species)) * 100
frequency <- table(dataset$Species)
cbind(frequency, percentage)

# Summary
summary(dataset)


## Visualisation

# Split by class; numeric and factors
x <- dataset[, 1:4]
y <- dataset[, 5]

# Boxplots
par(mfrow = c(1, 4))
  for(i in 1:4) {
    boxplot(x[, i], main = names(dataset)[i])
}

# Barplot
par(mfrow = c(1, 1))
plot(y)

# Multivariate scattering
pairs(dataset[ ,-5], col = dataset$Species)    
featurePlot(x = x, y = y, plot = "pairs")

# Multivariate box
featurePlot(x = x, y = y, plot = "box")

# Probability density
scaleconfig <- list(x = list(relation = "free"), y = list(relation = "free"))
featurePlot(x = x, y = y, plot = "density", scales = scaleconfig)

## Algorithm evaluation

# Test harness
control <- trainControl(method = "cv", number = 10)
metric <- "Accuracy"

# Linear Discriminant Analysis (LDA)
set.seed(813675)
fit.lda <- train(Species~., data = dataset, method = "lda", metric = metric, trControl = control)

# Classification and Regression Trees (CART)
set.seed(813675)
fit.cart <- train(Species~., data = dataset, method = "rpart", metric = metric, trControl = control)

# k-Nearest Neighbours (kNN)
set.seed(813675)
fit.knn <- train(Species~., data = dataset, method = "knn", metric = metric, trControl = control)

# Support Vector Machine (SVM) with linear kernel
set.seed(813675)
fit.svm <- train(Species~., data = dataset, method = "svmRadial", metric = metric, trControl = control)

# Random Forest (RF)
set.seed(813675)
fit.rf <- train(Species~., data = dataset, method = "rf", metric = metric, trControl = control)

## Summarise accuracy measures
results <- resamples(list(lda = fit.lda, cart = fit.cart, knn = fit.knn, svm = fit.svm, rf = fit.rf))

# Tabulate
summary(results)

# Visualise
dotplot(results)

# Print best algorithm's results
print(fit.lda)

## Predictions
predictions <- predict(fit.lda, validation)
confusionMatrix(predictions, validation$Species)
