# **TidyDataSetAssignment**
***

### **File 1:  *run_analysis.R* ** 

**tidyDataSet() Function**

* Obtains tidy data for the assignment  
* Consists of 9 steps (see table below for description---steps correspond in *run_analysis.R*)  

Step  |   Output Description/Data Source
------|----------------------------------
1     |   Create 2 x 561 dataframe with descriptions of derived features and their identifier (ascending integers 1-561)<br>**Data Source:**  *features.txt*
2     |   Limit to only features with mean() or std() calculations<br>**Data Source:**  *step 1 output*
3     |   Obtain friendly descriptions for the 6 different activities<br>**Data Source:**  *activity_labels.txt*
4     |   Create foundational data set by applying subject and activity labels to each observation from files containing derived time-frequency features (*X_test.txt* and *X_train.txt*)<br>**Data Source:**  *X_test.txt*, *X_train.txt*, *subject_test.txt*,<br>*subject_train.txt*, *y_test.txt*, *y_train.txt*
5     |   Link activity labels from foundational data set (*step 4 output*) with friendly activity descriptions from *step 3 output*<br>**Data Source:**  *step 3 output*, *step 4 output*
6     |   Melt dataframe (*step 5 output*) to reduce the 561 time-frequency features to a single 561-level factor variable<br>**Data Source:**  *step 5 output*
7     |   Include only those observation from melted dataframe (*step 6 output*) that contain time-frequency features with mean() or std() calculations<br>**Data Source:** *step 2 output*, *step 6 output*
8     |   Apply group_by to step 7 output, using activity and subject as grouping variables<br>**Data Source:**  *step 7 output*
9     |   Establish final dataframe by summarizing average time-frequency feature variables for the grouped dateframe from step 8 output and arranging for readability<br>**Data Source:** *step 8 output*



### **File 2:  *CodeBook.md* ** 

**Data dictionary for *tidyDataSet* **

* Provides detailed description of columns and values in *tidyDataSet* and data lineage
* Complements File 1 description above  


