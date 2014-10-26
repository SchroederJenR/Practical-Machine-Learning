
Practical Machine Learning Course Project
========================================================
Predict Activity Quality from Activity Monitors
--------------------------------------------------------

The original dataset consisted of 159 variables and 19622 observations.  100 of the variables consisted largely of missing values so these were deleted because they were uninformative.  The function nearZeroVar() was used to determine whether any more variables were candidates for removal because of low variability (percentage of unique values <20% and ration of most frequent to second most frequent value >20), none of these variables were found.  The function anyNA() was used to determine if there were any missing values in the remaining variables and none were found.

Cross-Validation
---------------------
The dataset was split into balanced training and test sets using the createDataPartition() function.  To ensure reproducibilty of results, first the seed was set.  Random subsamples were constructed, assigning 60% of observations to the training set and 40% to the test set, having equivalent distributions of the outcome variable "classe."  The 60/40 proportions were chosen to avoid over-fitting the model to the training set (thus the training set is not overly large.)  Evaluating model performance on two independent datasets (training and test) is the method of cross-validation I employed.

Pre-processing of the Training Set
----------------------------------------
The Training Set consisted of 11776 observations, 52 predictor variables and 1 outcome variable.  Distributions of predictors were examined, and an overall correlation matrix was generated to determine if whether predictors were highly correlated (r>0.80).  Most predictors did not follow gaussian-shaped distributions, and there were less than 20 pairs of highly correlated variables, which is relatively few considering there were over 50 predictors (1250 correlations).  Nevertheless, pre-processing with Principal Components Analysis (PCA) can be beneficial since it reduces the amount of noise in the data and reduces the likelihood of overfitting the model.  The function preProcess() was used to generate components that captured 90% of the predictor variance; these 18 components were applied to the data using the predict() function to produce a reduced number of predictors (18 instead of 52).

Building the Models
---------------------------------------
Random Forests was chosen as the modeling method, because it is highly accurate and appropriate for predicting an outcome that is a categorical variable consisting of several categories.  Two competing models were built: one with the original 52 predictors, and another with 18 predictors derived using PCA.  I would expect the PCA model to perform better because components tend to have less noise than the variables from which they are derived.  The PCA model had an optimal accuracy of 95% (for mtry=2), and an out-of-bag (OOB) estimated error rate of 3.6 percent.

Surprisingly, the model using the original 52 predictors performed better, perhaps because the data distributions were not ideally suited to PCA. Below are results from the second model.  Its optimal accuracy was 98.5% (for mtry=27) and OOB estimated error rate was 0.83 percent.

Testing the Model
---------------------------------------
The Testing Set consisted of 7846 observations and 52 predictor variables.  Since the second models performance was clearly better, this model was the only one applied to the Testing Set.  Typically, accuracy in the Training Set is higher than that in the Testing Set.  Since the Training Set had an accuracy of 98.5 percent and an out-of-bag (OOB) error of 0.83 percent, I expected the out-of-sample error to be approximately 1 to 2 percent.  The accuracy observed in the Testing Set was actually higher than this: 99.2 percent, indicating the out-of-sample error was less than 1 percent.  Statistics indicating model performance on the Testing Set is shown below.  This is a highly accurate model.

Overall Statistics
                                          
               Accuracy : 0.9912          
                 95% CI : (0.9889, 0.9932)
    No Information Rate : 0.2845          
    P-Value [Acc > NIR] : < 2.2e-16       
                                          
                  Kappa : 0.9889          
 
