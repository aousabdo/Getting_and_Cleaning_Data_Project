
### Overview
The script in this repo, run_Analysis.R, performs data cleaning and data merging on the files from the "Human Activity Recognition Using Smartphones Dataset" [experiment](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) . The script reads several files from the training and testing data sets and merges them together for one final dataset. The data can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

### Steps to run the Analysis
- Clone this repo to your computer
- Download the data set [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
- Extract the data you downloaded to the `data` folder which is now in your cloned repo.
- Notice that the code assumes the data is available in under the directory `data` so you must extract the data to this directory
- Your `data` directory should now have the following directory which contains all the files we need: `data/UCI HAR Dataset`
- In your terminal rename the directory to have no spaces; something like `mv UCI\ HAR\ Dataset/ UCI_HAR_Dataset/`
- Change your working directory to where the `run_Analysis.R` file is
- Run the script from your R or RStudio councel
- The final tidy dataset will be saved to the same directory as `Tidy_Data.txt`
