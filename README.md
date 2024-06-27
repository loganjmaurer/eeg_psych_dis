THe data is on Kaggle at: https://www.kaggle.com/datasets/shashwatwork/eeg-psychiatric-disorders-dataset

I attempted to use brain scan data to predict mental health conditions. The python file imputes missing data, computes principal components for the EEG data and trains a support vector machine 
to classify main disorder using the principal components as predictors. This is optimized using grid search and tested by cross validation. It doesn't perform supper well, but I don't think
brain scans can be used to diagnose mental illness quite yet.

I also wanted to play with Julia mostly to learn it, but truth be told, I have no objective reason to use it at this point. All it does now is plot some demographic data.
