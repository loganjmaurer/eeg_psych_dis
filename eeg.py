import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.impute import SimpleImputer
from sklearn.decomposition import PCA
from sklearn.svm import SVC
from sklearn.model_selection import GridSearchCV, cross_val_score

#read data
eeg = pd.read_csv("EEG.machinelearing_data_BRMH.csv")
eeg.info()
eeg.head()

#create matrix of eeg scan variables 
eeg_vars = eeg.columns[8:]
eeg_data = eeg[eeg_vars].values
target_var = 'main.disorder'


# Impute missing values
imputer = SimpleImputer(strategy='mean')
eeg_data_imputed = imputer.fit_transform(eeg_data)


#perform PCA on eeg scan
pca = PCA()
pca.fit(eeg_data_imputed)
pc_scores = pca.transform(eeg_data_imputed)
pc_loadings = pca.components_

#plot variance explained by PCA
fig, ax = plt.subplots(figsize=(8, 6))
ax.plot(range(1, len(pca.explained_variance_ratio_) + 1), 
        pca.explained_variance_ratio_)
ax.set_xlabel("Number of Principal Components")
ax.set_ylabel("Explained Variance Ratio")
ax.set_title("Scree Plot")
plt.savefig("scree_plot.png")

# Define the hyperparameter grid for the SVM
param_grid = {
    'C': [0.1, 1, 10],
    'gamma': ['scale', 'auto'],
    'kernel': ['rbf', 'linear']
}

# Create the SVM classifier
svm = SVC()

# Perform grid search with cross-validation
grid_search = GridSearchCV(svm, param_grid, cv=5)
grid_search.fit(pc_scores, eeg[target_var].values)

# Print the best parameters and the best score
print("Best Parameters:", grid_search.best_params_)
print("Best Score:", grid_search.best_score_)
