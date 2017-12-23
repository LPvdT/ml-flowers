![header](https://github.com/LPvdT/ml-flowers/blob/master/img/header.png)

# Machine Learning with Iris Flower Data

Prediction of flower species using simple machine learning algorithms in R. The data set used is [_Fisher's_ iris flower dataset](https://en.wikipedia.org/wiki/Iris_flower_data_set).

## Description

All project steps, requirements and details can be found in the [`R Markdown`](https://github.com/LPvdT/ml-flowers/blob/master/markdown.Rmd) file.

The [pdf](https://github.com/LPvdT/ml-flowers/blob/master/markdown.pdf) version contains a _LaTeX_ version of the project with output and visualisations included.

### Note

In this project, the Linear Discriminant Analysis and k-Nearest Neighbours algorithm have performed equally well. I suspect this may be due to a certain _seed_ setting in _R_, as well as the relatively small scale of the data set. Predictions have been made using the _LDA_ algorithm. 

However, one can also easily include predictions using the _kNN_ algorithm by calling the `predict()` function on the `fit.knn` variable and parsing the test data located in the `validation` variable. Assign the returned output to a new variable and pipe (`%>%`) it into the `confustionMatrix()` function along with the test data subset by _Species_ (`validation$Species`).  
