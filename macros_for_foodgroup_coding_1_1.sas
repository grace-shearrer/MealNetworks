********************************************************************************
* Project: 		Meal patterns and BMI/weight - PEAS.
* Program: 		MACROS_for_foodgroup_coding_1_1
* Author: 		Carolina Schwedhelm
* Created: 		08/2/2019
* Last Changes: 08/20/2019, by Carolina Schwedhelm
* Origin: 		self made
* Category: 	creation of macros
* Program before: 	none
* Short descr.: Macros for obtaining new codes for MIXED FOODS WITH SAME FOOD CODE FOR 
					MORE THAN 1 MIXTURE WITH IMPLICIT DIFFERENCES IN THE DESCRIPTION
				and
					to MAKE CORRECTIONS TO INGREDIENTS FOR MIXED FOODS WITH SAME
					FOOD CODE FOR MORE THAN 1 MIXTURE

*********************************************************************************
********************************************************************************;


*********************************************************************************
* macro to assign new foodcode to a repeated code (but not making any change in ingredients);
********************************************************************************;

%macro corr_rep_newcode(foodcode_rep,food_description_rep,foodcode_new);
data infitems_mixed_ingr_corr; set infitems_mixed_ingr_corr;
	if foodcode = &foodcode_rep and food_description = &food_description_rep then foodcode = &foodcode_new;
run;
%mend corr_rep_newcode;



*********************************************************************************
* macro to assign new foodcode to a repeated code where only 1 ingredient is the difference (deleting one ingredient);
********************************************************************************;

%macro corr_rep_minus1(foodcode_rep,food_description_rep,foodcode_new,seq_num_delete,new_num_ingr);
data infitems_mixed_ingr_corr; set infitems_mixed_ingr_corr;
	if foodcode = &foodcode_rep and food_description = &food_description_rep then foodcode = &foodcode_new;
	if foodcode = &foodcode_new and food_description = &food_description_rep and seq_num = &seq_num_delete then delete;
	if foodcode = &foodcode_new and food_description = &food_description_rep then num_ingr = &new_num_ingr;
run;

*condensing by food_code and summing weights;
proc means data = infitems_mixed_ingr_corr noprint;
	where foodcode = &foodcode_new and food_description = &food_description_rep;
	class foodcode;
	ways 1;
	var weight;
	output out=by_food_code_corr sum=weight;
run;
*renaming weight = sum_weight;
data by_food_code_sum_corr;
	set by_food_code_corr;
	drop _TYPE_ _FREQ_;
	rename weight = sum_weight_new;
run;
*put ingredient name and weight back in dataset;
proc sort data= infitems_mixed_ingr_corr; by foodcode;
proc sort data= by_food_code_sum_corr; by foodcode; 
data infitems_mixed_ingr_corr_1;
	merge infitems_mixed_ingr_corr (in=a) by_food_code_sum_corr;
	by foodcode;
	if a;
run;
*replace sum_weight with sum_weight_new;
data infitems_mixed_ingr_corr; set infitems_mixed_ingr_corr_1;
	if sum_weight_new ne . then sum_weight = sum_weight_new;
	drop sum_weight_new;
run;
%mend corr_rep_minus1;



*********************************************************************************
* macro to assign new foodcode to a repeated code where only 1 ingredient is the difference (adding one ingredient);
********************************************************************************;

%macro corr_rep_plus1(foodcode_rep,food_description_new,foodcode_new,new_num_ingr,foodcode_similar,seq_num_similar);
data test; set infitems_mixed_ingr_corr;
	if foodcode = &foodcode_rep and food_description = &food_description_new then foodcode = &foodcode_new;
run;

data test1; set infitems_mixed_ingr_corr;
	where foodcode = &foodcode_similar and seq_num = &seq_num_similar;
run;

data test1; set test1;
	foodcode = &foodcode_new;
	food_description = &food_description_new;
	num_ingr = 99;
run;

proc sort data = test; by foodcode food_description sr_description;
proc sort data = test1; by foodcode food_description sr_description;
data test2;
	merge test test1;
	by foodcode food_description sr_description;	
run;
* putting back with all food groups;
proc sort data = test2; by foodcode food_description;
proc sort data = test; by foodcode food_description;
data infitems_mixed_ingr_corr;
	merge test (in=a) test2;
	by foodcode food_description;
	if a;
run;

*condensing by food_code and summing weights;
proc means data = infitems_mixed_ingr_corr noprint;
	where foodcode = &foodcode_new;
	class foodcode;
	ways 1;
	var weight;
	output out=by_food_code_add sum=weight;
run;
*renaming weight = sum_weight;
data by_food_code_add1;
	set by_food_code_add;
	drop _TYPE_ _FREQ_;
	rename weight = sum_weight_new;
run;
*put ingredient name and weight back in dataset;
proc sort data= infitems_mixed_ingr_corr; by foodcode;
proc sort data= by_food_code_add1; by foodcode; 
data infitems_mixed_ingr_corr_1;
	merge infitems_mixed_ingr_corr (in=a) by_food_code_add1;
	by foodcode;
	if a;
run;
*replace sum_weight with sum_weight_new;
data infitems_mixed_ingr_corr; set infitems_mixed_ingr_corr_1;
	if sum_weight_new ne . then sum_weight = sum_weight_new;
	drop sum_weight_new;
	if foodcode = &foodcode_new then num_ingr = &new_num_ingr;
run;
%mend corr_rep_plus1;



*********************************************************************************
* macro to assign new foodcode to a repeated code where 1 ingredient is substituted;
*********************************************************************************;

%macro corr_rep_substitute1(foodcode_rep,food_description_rep,foodcode_new,seq_num_substitute,subst_ingr_description);
data infitems_mixed_ingr_corr; set infitems_mixed_ingr_corr;
	if foodcode = &foodcode_rep and food_description = &food_description_rep then foodcode = &foodcode_new;
	if foodcode = &foodcode_new and seq_num = &seq_num_substitute then sr_description = &subst_ingr_description;
run;
%mend corr_rep_substitute1;



*********************************************************************************
* macro to ADD ALREADY PRESENT ingredients in same food code
* (multiply weight of an ingredient);
*%corr_rep_multiply(foodcode_rep,food_description_new,foodcode_new,seq_num_want,multiplier);
********************************************************************************;


%macro corr_rep_multiply(foodcode_rep,food_description_new,foodcode_new,seq_num_want,multiplier);
data test; set infitems_mixed_ingr_corr;
	if foodcode = &foodcode_rep and food_description = &food_description_new then foodcode = &foodcode_new;
	if foodcode = &foodcode_new and seq_num = &seq_num_want then do;
		weight = weight*&multiplier;
	end;
run;

*condensing by food_code and summing weights;
proc means data = test noprint;
	where foodcode = &foodcode_new;
	class foodcode;
	ways 1;
	var weight;
	output out=by_food_code_add sum=weight;
run;
*renaming weight = sum_weight;
data by_food_code_add1;
	set by_food_code_add;
	drop _TYPE_ _FREQ_;
	rename weight = sum_weight_new;
run;
*put ingredient name and weight back in dataset;
proc sort data= test; by foodcode;
proc sort data= by_food_code_add1; by foodcode; 
data infitems_mixed_ingr_corr_1;
	merge test (in=a) by_food_code_add1;
	by foodcode;
	if a;
run;
*replace sum_weight with sum_weight_new;
data infitems_mixed_ingr_corr; set infitems_mixed_ingr_corr_1;
	if sum_weight_new ne . then sum_weight = sum_weight_new;
	drop sum_weight_new;
run;
%mend corr_rep_multiply;


*********************************************************************************
* macro to add all ingredients of one foodcode to another (where only 1 ingredient is retained);
********************************************************************************;

%macro corr_rep_plus_everything(foodcode_rep,food_description_rep,seq_num_retain,foodcode_similar,new_num_ingr);
data test; set infitems_mixed_ingr_corr;
	where foodcode = &foodcode_rep and seq_num = &seq_num_retain;
run;

data test1; set infitems_mixed_ingr_corr;
	where foodcode = &foodcode_similar;
run;

data test1; set test1;
	foodcode = &foodcode_rep;
	food_description = &food_description_rep;
run;

proc sort data = test; by foodcode food_description sr_description;
proc sort data = test1; by foodcode food_description sr_description;
data test2;
	merge test test1;
	by foodcode food_description sr_description;
run;
* putting back with all food groups;
proc sort data = test2; by foodcode food_description;
proc sort data = infitems_mixed_ingr_corr; by foodcode food_description;
data infitems_mixed_ingr_corr;
	merge infitems_mixed_ingr_corr (in=a) test2;
	by foodcode food_description;
	if a;
run;

*condensing by food_code and summing weights;
proc means data = infitems_mixed_ingr_corr noprint;
	where foodcode = &foodcode_rep;
	class foodcode;
	ways 1;
	var weight;
	output out=by_food_code_add sum=weight;
run;
*renaming weight = sum_weight;
data by_food_code_add1;
	set by_food_code_add;
	drop _TYPE_ _FREQ_;
	rename weight = sum_weight_new;
run;
*put ingredient name and weight back in dataset;
proc sort data= infitems_mixed_ingr_corr; by foodcode;
proc sort data= by_food_code_add1; by foodcode; 
data infitems_mixed_ingr_corr_1;
	merge infitems_mixed_ingr_corr (in=a) by_food_code_add1;
	by foodcode;
	if a;
run;
*replace sum_weight with sum_weight_new;
data infitems_mixed_ingr_corr; set infitems_mixed_ingr_corr_1;
	if sum_weight_new ne . then sum_weight = sum_weight_new;
	drop sum_weight_new;
	if foodcode = &foodcode_rep then num_ingr = &new_num_ingr;
run;
%mend corr_rep_plus_everything;


*********************************************************************************
* macro to add all ingredients of one foodcode to another and multiply portion by wanted weight to keep proportion;
********************************************************************************;

%macro corr_rep_multiply_tunasalad(foodcode_rep,food_description_rep,foodcode_similar,new_num_ingr,multiplier);
data test; set infitems_mixed_ingr_corr;
	where foodcode = &foodcode_rep;
run;

data test1; set infitems_mixed_ingr_corr;
	where foodcode = &foodcode_similar;
	weight = weight*&multiplier;
run;

proc means data = test1 noprint;
	class foodcode sr_description seq_num;
	ways 3;
	var weight;
output out = test1 mean=;

data test1; set test1;
	foodcode = &foodcode_rep;
	food_description = &food_description_rep;
	drop _TYPE_ _FREQ_;
run;

proc sort data = test; by foodcode food_description sr_description;
proc sort data = test1; by foodcode food_description sr_description;
data test2;
	merge test test1;
	by foodcode food_description sr_description;
run;
* putting back with all food groups;
proc sort data = test2; by foodcode food_description;
proc sort data = infitems_mixed_ingr_corr; by foodcode food_description;
data infitems_mixed_ingr_corr;
	merge infitems_mixed_ingr_corr (in=a) test2;
	by foodcode food_description;
	if a;
run;

*condensing by food_code and summing weights;
proc means data = infitems_mixed_ingr_corr noprint;
	where foodcode = &foodcode_rep;
	class foodcode;
	ways 1;
	var weight;
	output out=by_food_code_add sum=weight;
run;
*renaming weight = sum_weight;
data by_food_code_add1;
	set by_food_code_add;
	drop _TYPE_ _FREQ_;
	rename weight = sum_weight_new;
run;
*put ingredient name and weight back in dataset;
proc sort data= infitems_mixed_ingr_corr; by foodcode;
proc sort data= by_food_code_add1; by foodcode; 
data infitems_mixed_ingr_corr_1;
	merge infitems_mixed_ingr_corr (in=a) by_food_code_add1;
	by foodcode;
	if a;
run;
*replace sum_weight with sum_weight_new;
data infitems_mixed_ingr_corr; set infitems_mixed_ingr_corr_1;
	if sum_weight_new ne . then sum_weight = sum_weight_new;
	drop sum_weight_new;
	if foodcode = &foodcode_rep then num_ingr = &new_num_ingr;
run;
%mend corr_rep_multiply_tunasalad;


*********************************************************************************
* chilli fix macro for adding all chilli ingredients to 2711140 and just retaining cheese from self;
*corr_rep_plus_chillifix(foodcode_want,food_description_want,new_num_ingr,foodcode_similar);
********************************************************************************;


%macro corr_rep_plus_chillifix(foodcode_want,food_description_want,new_num_ingr,foodcode_similar);
data test; set infitems_mixed_ingr_corr;
	if foodcode = &foodcode_want and seq_num = 2 then weight = weight*17.7;
	if foodcode = &foodcode_want and seq_num = 1 then delete;
run;

data test1; set infitems_mixed_ingr_corr;
	where foodcode = &foodcode_similar;
run;

data test2; set test1;
	foodcode = &foodcode_want;
	food_description = &food_description_want;
run;

proc sort data = test; by foodcode food_description sr_description;
proc sort data = test2; by foodcode food_description sr_description;
data test3;
	merge test test2;
	by foodcode food_description sr_description;	
run;

*condensing by food_code and summing weights;
proc means data = test3 noprint;
	where foodcode = &foodcode_want;
	class foodcode;
	ways 1;
	var weight;
	output out=by_food_code_add sum=weight;
run;
*renaming weight = sum_weight;
data by_food_code_add1;
	set by_food_code_add;
	drop _TYPE_ _FREQ_;
	rename weight = sum_weight_new;
run;
*put ingredient name and weight back in dataset;
proc sort data= test3; by foodcode;
proc sort data= by_food_code_add1; by foodcode; 
data infitems_mixed_ingr_corr_1;
	merge test3 (in=a) by_food_code_add1;
	by foodcode;
	if a;
run;
*replace sum_weight with sum_weight_new;
data infitems_mixed_ingr_corr; set infitems_mixed_ingr_corr_1;
	if sum_weight_new ne . then sum_weight = sum_weight_new;
	drop sum_weight_new;
	if foodcode = &foodcode_want then num_ingr = &new_num_ingr;
run;
%mend corr_rep_plus_chillifix;



*********************************************************************************
* macro to assign new foodcode to a repeated code where only 1 ingredient is the difference (adding one ingredient)
AND KEEP RIGHT PROPORTION OF ADDED INGREDIENT ;
*	corr_rep_plus_fixburrito(foodcode_start,food_description_end,foodcode_end,new_num_ingr,foodcode_similar,sr_description,weight);
********************************************************************************;

%macro corr_rep_plus_fixburrito(foodcode_start,food_description_end,foodcode_end,new_num_ingr,foodcode_similar,sr_description,weight);
data test; set infitems_mixed_ingr_corr;
	if foodcode = &foodcode_start and food_description = &food_description_end then foodcode = &foodcode_end;
run;

data test1; set infitems_mixed_ingr_corr;
	where foodcode = &foodcode_similar and sr_description = &sr_description;
run;

data test1; set test1;
	foodcode = &foodcode_end;
	food_description = &food_description_end;
	weight = &weight;
run;

proc sort data = test; by foodcode food_description sr_description;
proc sort data = test1; by foodcode food_description sr_description;
data test2;
	merge test test1;
	by foodcode food_description sr_description;	
run;

*condensing by food_code and summing weights;
proc means data = test2 noprint;
	where foodcode = &foodcode_end;
	class foodcode;
	ways 1;
	var weight;
	output out=by_food_code_add sum=weight;
run;
*renaming weight = sum_weight;
data by_food_code_add1;
	set by_food_code_add;
	drop _TYPE_ _FREQ_;
	rename weight = sum_weight_new;
run;
*put ingredient name and weight back in dataset;
proc sort data= test2; by foodcode;
proc sort data= by_food_code_add1; by foodcode; 
data infitems_mixed_ingr_corr_1;
	merge test2 (in=a) by_food_code_add1;
	by foodcode;
	if a;
run;
*replace sum_weight with sum_weight_new;
data infitems_mixed_ingr_corr; set infitems_mixed_ingr_corr_1;
	if sum_weight_new ne . then sum_weight = sum_weight_new;
	drop sum_weight_new;
	if foodcode = &foodcode_end then num_ingr = &new_num_ingr;
run;
%mend corr_rep_plus_fixburrito;



*********************************************************************************
* macro to delete cooking water
********************************************************************************;

%macro corr_rep_minus_water(foodcode,sr_description_water,seq_num_delete,new_num_ingr);
data infitems_mixed_ingr_corr; set infitems_mixed_ingr_corr;
	if foodcode = &foodcode and sr_description = &sr_description_water and seq_num = &seq_num_delete then delete;
	if foodcode = &foodcode then num_ingr = &new_num_ingr;
run;

*condensing by food_code and summing weights;
proc means data = infitems_mixed_ingr_corr noprint;
	where foodcode = &foodcode;
	class foodcode;
	ways 1;
	var weight;
	output out=by_food_code_corr sum=weight;
run;
*renaming weight = sum_weight;
data by_food_code_sum_corr;
	set by_food_code_corr;
	drop _TYPE_ _FREQ_;
	rename weight = sum_weight_new;
run;
*put ingredient name and weight back in dataset;
proc sort data= infitems_mixed_ingr_corr; by foodcode;
proc sort data= by_food_code_sum_corr; by foodcode; 
data infitems_mixed_ingr_corr_1;
	merge infitems_mixed_ingr_corr (in=a) by_food_code_sum_corr;
	by foodcode;
	if a;
run;
*replace sum_weight with sum_weight_new;
data infitems_mixed_ingr_corr; set infitems_mixed_ingr_corr_1;
	if sum_weight_new ne . then sum_weight = sum_weight_new;
	drop sum_weight_new;
run;
%mend corr_rep_minus_water;
