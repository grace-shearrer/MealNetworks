# MealNetworks

Aims, hypotheses, methods, and an example network are provided in the document AIMS_METHODS.docx

Step-by-step food grouping.docx contains the detailed procedure of how foods were grouped.

To group, SAS programs should be run in the following order:
1. macros_for_foodgroup_coding_1_1.sas
2. foodgroup_coding_1_1.sas
3. foodgroup_coding_1_2.sas
4. foodgroup_coding_1_3.sas
5. foodgroup_coding_1_4.sas
6. foodgroup_coding_1_5.sas
7. foodgroup_coding_2_1.sas

### For now, the dataset and codes for the generation of a network as an example is provided here: BMI categories 2&3, among pregnant women for breakfast
Dataset is preg_bmi2_3_occ1.sas7bdat (obtained by running sas code meal_PEAS_preg.sas)
Frequencies of consumption of food groups (for node weights) are in BMI2_3_FREQ.csv (obtained by running sas code meal_PEAS_preg.sas)

### 10-fold cross validated glasso R code for regularized network (skeptic transformed)
- R code PREG_BMI_breakfast.R
- in Python, code is networkX.ipynb (used on the same cross-validated, regularized sparse correlation matrix obtained in R above): corrm_PREG_BMI2_3_OCC1.csv
