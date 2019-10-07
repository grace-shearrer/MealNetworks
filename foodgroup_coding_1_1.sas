********************************************************************************
* Project: 		Meal patterns and BMI/weight - PEAS.
* Program: 		foodgroup_coding_1_1
* Author: 		Carolina Schwedhelm
* Created: 		07/26/2019
* Last Changes: 09/10/2019, by Carolina Schwedhelm
* Origin: 		self made
* Category: 	creation of dataset
* Program before: 	none
* Short descr.: Merging ingredient information for mixed dishes and creating the 
				dataset to start from for recoding of food groups
*******************************************************************************;

*********************************************************************************
********************************************************************************;

********************************************************************************;
data new; 
	set 'N:\DIPHRHBB\PEAS\Data - Updated\Analytic\Main\PEAS-pregnancy\Diet recall\Data\infitems_unc.sas7bdat';
run;
/*
proc contents data=new;
run;
*/
********************************************************************************;

*keep only relevant variables (no macronutrients for now);
data infitems; set new;
	keep 	patID RecallNo Occ_No Occ_Name Occ_Time_New
			KCAL FoodAmt FoodCode FoodNum 
		  	Food_Description Pregpost Visit;
	format 	food_description $200. Occ_Time_New TIME.;
	informat food_description $200.;
run;
/*
proc univariate data=infitems;				* 165 missing times corresponding to 48 meals without time;
	var occ_time_new;
run;
*/
*condense by meal;
proc means data=infitems noprint;
	class patid pregpost visit recallno occ_no occ_name Occ_Time_New;
	ways 7;
	var foodamt kcal;
	output out=bymeal sum=;
run;
/*
*check times at midnight;
proc print data =  bymeal;
	where OCC_TIME_NEW = 0;
run;

proc sort data = bymeal; by occ_name;
proc means data=bymeal noprint;
	var occ_time_new;
	by occ_name;
	output out=time_by_meal;
run;
proc print data = time_by_meal;
run;
*check where midnight;
proc print data=bymeal;
	where occ_time_new = 0;
run;
*/
*condense by day to obtain total daily intake;
proc means data=bymeal noprint;
	class patid pregpost visit recallno;
	ways 4;
	var kcal;
	output out=byday sum=;
run;
*merge bymeal and byday for keeping total daily kcal intake;
data bymeal; set bymeal;
	drop _TYPE_ _FREQ_;
run;
proc sort data=bymeal; by patid pregpost visit recallno;
data byday; set byday;
	drop _TYPE_;
	rename kcal = total_kcal_day;
run;
proc sort data=byday; by patid pregpost visit recallno;
data bymeal_1;
	merge bymeal (in=a) byday;
	if a;
	by patid pregpost visit recallno;
run;
*check eating occasions with 0 kcal (excluding just a drink and supplement);
data bymeal_0kcal; set bymeal;
	where kcal = 0  and occ_name in (1,2,3,4,5,6);
run;
*connect with data on items to check contents of meal;
proc sort data=bymeal_0kcal; by patid pregpost visit recallno occ_no occ_name;
proc sort data=infitems; by patid pregpost visit recallno occ_no occ_name;
data check1; 
	merge bymeal_0kcal (in=a) infitems;
	if a;
	by patid pregpost visit recallno occ_no occ_name;						*everything is water!;
run;
*number of meals of just water categorized as a meal... (by type of meal);
proc means data=check1 noprint;
	class patid pregpost visit recallno occ_no occ_name;
	ways 6;
	var kcal;
	output out=check2 sum=;
run;
proc sort data=check2; by pregpost;
*proc freq data=check2;
*	table occ_name;
*	by pregpost;
*run;

*RENAME occasion names 1-6 that were JUST WATER --> into OCC_NAME = 7;
data bymeal_0kcal; set bymeal_0kcal;
	occ_name_new = 7;
	keep patid pregpost visit recallno occ_no occ_name occ_name_new;
run;
proc sort data=bymeal_0kcal; by patid pregpost visit recallno occ_no occ_name;
proc sort data=infitems; by patid pregpost visit recallno occ_no occ_name;
data infitems1;
	merge infitems (in=a) bymeal_0kcal;
	if a;
	by patid pregpost visit recallno occ_no occ_name;
run;
data infitems; set infitems1;
	if occ_name_new = 7 then occ_name = 7;
	drop occ_name_new;
run;



/*
proc contents data= new;
run;

*somehow different food descriptions share foodcode. 
Example:;
proc print data = infitems;
	where foodcode = 27250040;
run;
*check how many are missing food description and how frequent these are;			* 613 without food description;
proc freq data = infitems;
	where food_description = "";
	table foodcode;
run;

/*
proc means data = infitems noprint;													* 235 different food codes without description;
	where food_description = "";													* most frequent repeats 90 times;	
	class foodcode;
	ways 1;
	var foodamt;
	output out= miss_fd mean=;
run;
proc print data = miss_fd;
	var foodcode _FREQ_;
run;
*/
*fill in food description where missing (from INFITEMS_UNC);
proc sort data = infitems; by foodcode;
data infitems_fill
(drop=	lag_food_description lag2_food_description lag3_food_description lag4_food_description lag5_food_description lag6_food_description 
		lag_foodcode lag2_foodcode lag3_foodcode lag4_foodcode lag5_foodcode lag6_foodcode);
	set infitems;
		lag_food_description = lag(food_description);
		lag2_food_description = lag2(food_description);
		lag3_food_description = lag3(food_description);
		lag4_food_description = lag4(food_description);
		lag5_food_description = lag5(food_description);
		lag6_food_description = lag6(food_description);

		lag_foodcode = lag(foodcode);
		lag2_foodcode = lag2(foodcode);
		lag3_foodcode = lag3(foodcode);
		lag4_foodcode = lag4(foodcode);
		lag5_foodcode = lag5(foodcode);
		lag6_foodcode = lag6(foodcode);

	if food_description  = "" and foodcode=lag_foodcode
		then food_description = lag_food_description; 
	if food_description = "" and lag_food_description = "" and foodcode = lag2_foodcode and lag2_food_description ne "" 
		then food_description = lag2_food_description;
	if food_description = "" and lag_food_description = "" and lag2_food_description = "" and foodcode = lag3_foodcode and lag3_food_description ne "" 
		then food_description = lag3_food_description;
	if food_description = "" and lag_food_description = "" and lag2_food_description = "" and lag3_food_description = "" and foodcode = lag4_foodcode and lag4_food_description ne "" 
		then food_description = lag4_food_description;
	if food_description = "" and lag_food_description = "" and lag2_food_description = "" and lag3_food_description = "" and lag4_food_description = "" and foodcode = lag5_foodcode 
			and lag5_food_description ne "" then food_description = lag5_food_description;
	if food_description = "" and lag_food_description = "" and lag2_food_description = "" and lag3_food_description = "" and lag4_food_description = "" and lag5_food_description = "" 
			and foodcode = lag6_foodcode and lag6_food_description ne "" then food_description = lag6_food_description;
run;
/*
*check how many are missing food description;						* 34 observations still without description;
proc print data = infitems_fill;									* corresponding to 25 different food codes;
	where food_description = "";
run;
* check if these food codes are named somewhere in INFITEMS;
proc print data = infitems_fill;
	where foodcode in 	(11641020,14204010,14303010,14420100,24201110,
						24403100,27343470,27540110,27540150,53452400,
						54401080,55301000,57132000,57207000,58100110,
						58148110,58160220,58175110,58400000,64205010,
						71101120,75340000,83114000,91300010,91715100)
		and food_description ne "";
run;
*/
* label;
data  infitems; set infitems_fill;
	if foodcode = 11641020 and food_description = "" then food_description = "Meal replacement or supplement, milk based, ready-to-drink";
	if foodcode = 14204010 and food_description = "" then food_description = "Cheese, cottage, lowfat (1-2% fat)";
	if foodcode = 14303010 and food_description = "" then food_description = "Cheese, cream, light or lite (formerly called Cream Cheese Lowfat)";
	if foodcode = 14420100 and food_description = "" then food_description = "Cheese spread, American or Cheddar cheese base";
	if foodcode = 24201110 and food_description = "" then food_description = "Turkey, light meat, roasted, NS as to skin eaten";

	if foodcode = 24403100 and food_description = "" then food_description = "Quail, cooked";
	if foodcode = 27343470 and food_description = "" then food_description = "Chicken or turkey, noodles, and vegetables (including carrots, broccoli, 
																			and/or dark-green leafy), cream sauce, white sauce, or mushroom soup-based sauce (mixture)";
	if foodcode = 27540110 and food_description = "" then food_description = "Chicken sandwich, with spread";
	if foodcode = 27540150 and food_description = "" then food_description = "Chicken fillet (breaded, fried) sandwich with lettuce, tomato and spread";
	if foodcode = 53452400 and food_description = "" then food_description = "Pastry, puff";

	if foodcode = 54401080 and food_description = "" then food_description = "Salty snacks, corn or cornmeal base, tortilla chips";
	if foodcode = 55301000 and food_description = "" then food_description = "French toast, plain";
	if foodcode = 57132000 and food_description = "" then food_description = "Corn Chex";
	if foodcode = 57207000 and food_description = "" then food_description = "Bran Flakes, NFS (formerly 40% Bran Flakes, NFS)";
	if foodcode = 58100110 and food_description = "" then food_description = "Burrito with beef and beans";

	if foodcode = 58148110 and food_description = "" then food_description = "Macaroni or pasta salad";
	if foodcode = 58160220 and food_description = "" then food_description = "Rice with vegetables, tomato-based sauce (mixture)";
	if foodcode = 58175110 and food_description = "" then food_description = "Tabbouleh (bulgar with tomatoes and parsley)";
	if foodcode = 58400000 and food_description = "" then food_description = "Soup, NFS";
	if foodcode = 64205010 and food_description = "" then food_description = "Peach nectar";

	if foodcode = 71101120 and food_description = "" then food_description = "White potato, baked, peel eaten, fat added in cooking";
	if foodcode = 75340000 and food_description = "" then food_description = "Vegetable combinations, Oriental style, (broccoli, green pepper, water chestnut, etc) 
																			cooked, NS as to fat added in cooking";
	if foodcode = 83114000 and food_description = "" then food_description = "Thousand Island dressing";
	if foodcode = 91300010 and food_description = "" then food_description = "Syrup, NFS";
	if foodcode = 91715100 and food_description = "" then food_description = "SNICKERS Bar";
run;
/*
*check how many are missing food description;						* now all have descriptions;
proc print data = infitems;									
	where food_description = "";
run;
*/


********************************************************************************
call FNDDS (main food descriptions);
********************************************************************************;
/*
*prepare fndds1 dataset;
proc import datafile = 'P:\Carolina\NIH\PEAS\SAS\FNDDS\FNDDS1\MainFoodDesc.txt'
	out = mainfooddesc_fndds
	dbms = dlm
	replace;
	getnames = no;
	delimiter = '^';
run;
data mainfooddesc_fndds; 
	set mainfooddesc_fndds;
	rename 	var1 = foodcode	
			var4 = fndds_desc;
	keep 	var1 var4 foodcode_fndds;
	foodcode_fndds = var1;
run;

*prepare fndds2 dataset;
proc import datafile = 'P:\Carolina\NIH\PEAS\SAS\FNDDS\FNDDS2\MainFoodDesc.txt'
	out = mainfooddesc_fndds
	dbms = dlm
	replace;
	getnames = no;
	delimiter = '^';
run;
data mainfooddesc_fndds; 
	set mainfooddesc_fndds;
	rename 	var1 = foodcode	
			var4 = fndds_desc;
	keep 	var1 var4 foodcode_fndds;
	foodcode_fndds = var1;
run;

*prepare fndds3 dataset;
proc import datafile = 'P:\Carolina\NIH\PEAS\SAS\FNDDS\FNDDS3\MainFoodDesc.txt'
	out = mainfooddesc_fndds
	dbms = dlm
	replace;
	getnames = no;
	delimiter = '^';
run;
data mainfooddesc_fndds; 
	set mainfooddesc_fndds;
	rename 	var1 = foodcode	
			var4 = fndds_desc;
	keep 	var1 var4 foodcode_fndds;
	foodcode_fndds = var1;
run;
*/
*prepare fndds4 dataset;
proc import datafile = 'N:\DIPHRHBB\Staff Subdirectories\Carolina Schwedhelm\fndds4\MainFoodDesc_1.txt'
	out = mainfooddesc_fndds
	dbms = dlm
	replace;
	getnames = no;
	delimiter = '^';
run;
data mainfooddesc_fndds; 
	set mainfooddesc_fndds;
	rename 	var1 = foodcode	
			var4 = fndds_desc;
	keep 	var1 var4 foodcode_fndds;
	foodcode_fndds = var1;
	format var4 $200.;
	informat var4 $200.;
run;
/*
*prepare fndds5 dataset;
data mainfooddesc_fndds; 
	set 'N:\DIPHRHBB\Staff Subdirectories\Carolina Schwedhelm\FNDDS 5, NHANES 2009-10\SAS\mainfooddesc.sas7bdat';
	rename 	food_code = foodcode
			main_food_description = fndds_desc;
	keep 	food_code foodcode_fndds main_food_description;
	foodcode_fndds = food_code;
run;

*prepare fndds1112 dataset;
data mainfooddesc_fndds; 
	set 'P:\Carolina\NIH\PEAS\SAS\FNDDS\fndds1112\mainfooddesc.sas7bdat';
	rename 	food_code = foodcode
			main_food_description = fndds_desc;
	keep 	food_code foodcode_fndds main_food_description;
	foodcode_fndds = food_code;
run;

*prepare fndds1314 dataset;
data mainfooddesc_fndds; 
	set 'P:\Carolina\NIH\PEAS\SAS\FNDDS\fndds1314\mainfooddesc.sas7bdat';
	rename 	food_code = foodcode
			main_food_description = fndds_desc;
	keep 	food_code foodcode_fndds main_food_description;
	foodcode_fndds = food_code;
run;

*prepare fndds1516 dataset;
data mainfooddesc_fndds; 
	set 'P:\Carolina\NIH\PEAS\SAS\FNDDS\fndds1516\mainfooddesc.sas7bdat';
	rename 	food_code = foodcode
			main_food_description = fndds_desc;
	keep 	food_code foodcode_fndds main_food_description;
	foodcode_fndds = food_code;
run;
*/
proc sort data = mainfooddesc_fndds; by foodcode;
proc sort data = infitems; by foodcode;
*merge;
data infitems1;
	merge infitems (in=a) mainfooddesc_fndds;
	by foodcode;
	if a;
run;


********************************************************************************
*check missings (observations in PEAS not in FNDDS) 
********************************************************************************;
*check observations that we have in infitems but not in fndds;
data infitems1_miss; set infitems1;
	where foodcode_fndds = .;
	if foodcode_fndds = . then miss = 1;
run;
proc means data =infitems1_miss noprint;
	class foodcode;
	ways 1;
	var miss;
	output out= miss1 mean=;
run;

********************************************************************************
identify mixed dishes and create dataset with these observations
********************************************************************************;
/*
*check for egg mixtures;
proc print data = infitems1;
	where foodcode >= 32100000 and foodcode < 33000000;
run;
*/
data infitems_mixed_dishes;						*1972 probable mixed dishes (they may repeat themselves);
	set infitems1;
	where foodcode >= 27000000 and foodcode < 27500000
	or foodcode >= 28000000 and foodcode < 28300000
	or foodcode >= 32000000 and foodcode < 33000000
	or foodcode >= 58000000 and foodcode < 58400000
	or foodcode >= 74500000 and foodcode < 74600000;
run;

* FIXING PROBLEMS WITH CODING OF MIXED DISHES OR INGREDIENTS;
*code (58148110) Macaroni salad W/ ITALIAN DRESSING with FNDDS15-16 as 58148114
	and Macaroni or pasta salad W/ MAYONNAISE-TYPE SALAD DRESSING (INCLUDE MIRACLE WHIP) as 58148112;
data infitems_mixed_dishes; set infitems_mixed_dishes;
	if foodcode = 58148110 and food_description = "Macaroni salad W/ ITALIAN DRESSING" then foodcode = 58148114;
	if foodcode = 58148114 and food_description = "Macaroni salad W/ ITALIAN DRESSING" then food_description = "Macaroni or pasta salad, made with Italian dressing";

	if foodcode = 58148110 and food_description = "Macaroni or pasta salad W/ MAYONNAISE-TYPE SALAD DRESSING (INCLUDE MIRACLE WHIP)" then foodcode = 58148112;
	if foodcode = 58148112 and food_description = "Macaroni or pasta salad W/ MAYONNAISE-TYPE SALAD DRESSING (INCLUDE MIRACLE WHIP)" 
				then food_description = "Macaroni or pasta salad, made with mayonnaise-type salad dressing";
	*if foodcode = 27347100 then foodcode = 27317010;		* code chicken pot pie as beef pot pie for info on all ingredients.;
	*if foodcode = 58100013 then foodcode = 58100015;		*58100013 - code as 58100015 and remove potato;
	*if foodcode = 58100145 then foodcode = 58100120;		*58100145 - code as 58100120 and add sour cream from 58100135;
	*if foodcode = 58106310 then foodcode = 58106325;		
	*if foodcode = 58106320 then foodcode = 58106325;
	*if foodcode = 58106330 then foodcode = 58106325;		*code all crust variations for pizza with cheese and vegetables as regular crust (there's no difference);
	*if foodcode = 58106540 then foodcode = 58106550;
	*if foodcode = 58106555 then foodcode = 58106550;
	*if foodcode = 58106560 then foodcode = 58106550;		*code all crust variations for pizza with pepperoni as thin crust (there's no difference);
	*if foodcode = 58106610 then foodcode = 58106625;
	*if foodcode = 58106620 then foodcode = 58106625;
	*if foodcode = 58106630 then foodcode = 58106625;		*code all crust variations for pizza with meat other than pepperoni as thin crust (there's no difference);
	*if foodcode = 58106700 then foodcode = 58106720;		
	*if foodcode = 58106705 then foodcode = 58106720;		
	*if foodcode = 58106725 then foodcode = 58106720;		
	*if foodcode = 58106730 then foodcode = 58106720;		*code all crust variations for pizza with meat and vegetables as thin crust (there's no difference);
	*if foodcode = 58110130 then foodcode = 58110120;		*58110130 - code as 58110120 and rename shrimp -> beef/pork;
	*if foodcode = 58110170 then foodcode = 58110120;		*58110170 - code as 58110120 and rename shrimp -> chicken/turkey;
	*if foodcode = 58112110 then foodcode = 58110120;		*58112110 - code as 58110120, rename shrimp -> beef/pork AND leave food description as is (dim sum);
	if foodcode = 58132113 then foodcode = 58132110;		*58132113 - code as 58132110 and add cheese from 58131523;
	if foodcode = 58132313 then foodcode = 58132310;		*58132313 - code as 58132310 and recode after to retain description and avoid duplicate codes;
	*if foodcode = 58134620 then foodcode = 58134660;		*58134620 - code as 58134660 and replace sauce with tomato sauce;
	*if foodcode = 58134680 then foodcode = 58134660;		*58134680 - code as 58134660 and remove sauce;
	*if foodcode = 58145112 then foodcode = 58145110;		
	*if foodcode = 58145114 then foodcode = 58145110;		*code packaged mixes of macaroni and cheese as the non-packaged counterpart for ingredient disaggregation;
	*if foodcode = 58145117 then foodcode = 58145110;		*58145117 - code as 58145110 to get ingredient break-down and return to original code later;
run;
/*
proc print data = infitems_mixed_dishes;
where foodcode in (58148110,58148112,58148114);
run;
*/
/*
proc print data= infitems_mixed_dishes;								* all observations in probable PEAS mixes have foodcode;
	where foodcode = .;
run;
proc print data= infitems_mixed_dishes;								* all mixed dishes have food descriptions;
	where food_description = "";
run;
*/

*check groups with ingredient info missing (FNDDS info missing);
data infitems1_miss2; set infitems_mixed_dishes;					* 85 observations are not linked to FNDDS4.0;
	where foodcode_fndds = .;
	if foodcode_fndds = . then miss = 1;
run;
proc means data =infitems1_miss2 noprint;							* 44 different mixed dish food codes (different recipes) not linked to FNDDS4.0;
	class foodcode food_description;
	ways 2;
	var miss;
	output out= miss1 mean=;
run;
/*
*print missing mixed dishes;
proc print data = miss1;
	var foodcode food_description _FREQ_;
run;
*/
*check how many different food codes/mixed there are;			*371 potential (different) mixed recipes;
proc means data =infitems_mixed_dishes noprint;
	class foodcode;
	ways 1;
	var foodamt;
	output out= test mean=;
run;
data test; set test; 
	drop foodamt;
run;

********************************************************************************
REMOVE MIXED DISHES THAT WILL STAY AS MIXED DISH (1 INGREDIENT ONLY)
********************************************************************************;

data infitems_mixed_dishes; set infitems_mixed_dishes;
	if foodcode in (27160100,27214100,27214110,27246300,27246500,27311510,27350410,27450070,27450130) then delete;
	if foodcode in (27260010:27260090) then delete;
	if foodcode in (32104950,32105180,32130070,32102000,32202010,32202085,32202200,32400080) then delete;
*	if foodcode in (58100013:58103310) then delete;
*	if foodcode in (58104280:58127350) then delete;
*	if foodcode in (58130011:58131310) then delete;
*	if foodcode in (58145110:58145117) then delete;
*	if foodcode in (58147310:58148112) then delete;
*	if foodcode in (58161110,58161510,58200250,58302000,58306100) then delete;
/*	if foodcode in (272500401:272500701) then delete;
*	if foodcode in (581003201) then delete;
*	if foodcode in (581451101:581451142) then delete;
*	if foodcode in (581473101:581473303) then delete;
*/run;

********************************************************************************
get proportions for ingredients part of mixture dishes in FNDDS 4.0
********************************************************************************;

*import FNDDS 4.0 info on ingredients;
proc import datafile = 'N:\DIPHRHBB\Staff Subdirectories\Carolina Schwedhelm\fndds4\fnddssrlinks_1.txt'
	out = fndds
	dbms = dlm
	replace;
	getnames = no;
	delimiter = '^';
run;
data fndds; 
	set fndds;
	rename 	var1 = foodcode	
			var4 = seq_num
			var5 = SR_code
			var6 = SR_description
			var12 = weight;
	keep 	var1 var4 var5 var6 var12;
	format 	var6 $200.;
	informat var6 $200.;
run;


*condensing by food_code and summing weights;
proc means data = fndds noprint;
	class foodcode;
	ways 1;
	var weight;
	output out=by_food_code sum=;
run;
/*
proc freq data = by_food_code; 				 *max number of food groups in food mixes -->this is 25;
	table _FREQ_;
run;

proc contents data= by_food_code;
run;
*/
*renaming weight = sum_weight;
data by_food_code_sum;
	set by_food_code;
	drop _TYPE_;
	label 
		weight = 'total mixture weight'
		_FREQ_ = 'nr of ingredients in mixture';
	rename weight = sum_weight _FREQ_= num_ingr;
run;
/*
proc contents data= by_food_code_sum;
run;

*check there are no empty sum_weight;
proc print data= by_food_code_sum;
	where sum_weight = .;
run;
*/

*put ingredient name and weight back in dataset;
data fndds_1;
	set fndds;
		keep foodcode SR_code SR_description seq_num weight;
run;
proc sort data= fndds_1; by foodcode;
proc sort data= by_food_code_sum; by foodcode; 
data fndds_2;
	merge fndds_1 (in=a) by_food_code_sum;
	by foodcode;
	if a;
run;


********************************************************************************
Make wide (fndds_ingr with foodcode, num ingr, dummies for seq_nums (3 ingr)
********************************************************************************;
*make wide vars for num_ingr;
data fndds_ingr_wide;
	set fndds_2;
		if seq_num = 1 then seq_num1 = weight;
		if seq_num = 2 then seq_num2 = weight;
		if seq_num = 3 then seq_num3 = weight;
		if seq_num = 4 then seq_num4 = weight;
		if seq_num = 5 then seq_num5 = weight;

		if seq_num = 6 then seq_num6 = weight;
		if seq_num = 7 then seq_num7 = weight;
		if seq_num = 8 then seq_num8 = weight;
		if seq_num = 9 then seq_num9 = weight;
		if seq_num = 10 then seq_num10 = weight;

		if seq_num = 11 then seq_num11 = weight;
		if seq_num = 12 then seq_num12 = weight;
		if seq_num = 13 then seq_num13 = weight;
		if seq_num = 14 then seq_num14 = weight;
		if seq_num = 15 then seq_num15 = weight;

		if seq_num = 16 then seq_num16 = weight;
		if seq_num = 17 then seq_num17 = weight;
		if seq_num = 18 then seq_num18 = weight;
		if seq_num = 19 then seq_num19 = weight;
		if seq_num = 20 then seq_num20 = weight;

		if seq_num = 21 then seq_num21 = weight;
		if seq_num = 22 then seq_num22 = weight;
		if seq_num = 23 then seq_num23 = weight;
		if seq_num = 24 then seq_num24 = weight;
		if seq_num = 25 then seq_num25 = weight;
run;
*collapse by food code;
proc means data = fndds_ingr_wide noprint;
	class foodcode num_ingr sum_weight;
	ways 3;
	var seq_num1--seq_num25;
	output out=fndds_ingr_wide1 sum=;
run;


********************************************************************************
Fill in the gaps (44 unlinked mixed dishes) with FNDDS 2015-2016
********************************************************************************;
*import fndds1516 dataset;
data fndds1516; 
	set 'N:\DIPHRHBB\Staff Subdirectories\Carolina Schwedhelm\FNDDS_2015_2016\fnddsingred.sas7bdat';
	rename 	food_code = foodcode
			ingredient_code = SR_code
			ingredient_description = SR_description
			ingredient_weight = weight;
	keep 	food_code seq_num ingredient_code ingredient_description ingredient_weight;
	format 	ingredient_description $200.;
	informat ingredient_description $200.;
run;

*keep needed foodcodes only;
data fndds1516; set fndds1516;
	where foodcode in 	(27146360,27446332,32130000,32130010,32130020,
						32130040,32130060,32130070,32130120,32130160,
						32130170,32130310,32130460,32130630,32130670,
						32130860,32131090,32131110,32400070,32400075,
						32400080,58100013,58100015,58100120,58100125,
						58100135,58100145,58100165,58101323,58101345,
						58104190,58104750,58121620,58145110,58145112,
						58145117,58148112,58148114,58160000,58160450,
						58160520,58160530,58160650,58161460,58161502,
						58163420,58164520,58165070,58165480);
run;

*condensing by food_code and summing weights;
proc means data = fndds1516 noprint;
	class foodcode;
	ways 1;
	var weight;
	output out=by_food_code1516 sum=;
run;
/*
proc freq data = by_food_code1516; 				 *max number of food groups in food mixes -->this is 13;
	table _FREQ_;
run;
*/
/*
proc print data= by_food_code_sum1516;
run;
*/
*renaming weight = sum_weight;
data by_food_code_sum1516;
	set by_food_code1516;
	drop _TYPE_;
	label 
		weight = 'total mixture weight'
		_FREQ_ = 'nr of ingredients in mixture';
	rename weight = sum_weight _FREQ_= num_ingr;
run;
/*
*check there are no empty sum_weight;
proc print data= by_food_code_sum1516;
	where sum_weight = .;
run;
*/
*put ingredient name and weight back in dataset;
data fndds1516_1;
	set fndds1516;
		keep foodcode SR_code SR_description seq_num weight;
run;
proc sort data= fndds1516_1; by foodcode;
proc sort data= by_food_code_sum1516; by foodcode; 
data fndds1516_2;
	merge fndds1516_1 (in=a) by_food_code_sum1516;
	by foodcode;
	if a;
run;

***MAKE WIDE***;
*make wide vars for seq_num;
data fndds1516_ingr_wide;
	set fndds1516_2;
		if seq_num = 1 then seq_num1 = weight;
		if seq_num = 2 then seq_num2 = weight;
		if seq_num = 3 then seq_num3 = weight;
		if seq_num = 4 then seq_num4 = weight;
		if seq_num = 5 then seq_num5 = weight;

		if seq_num = 6 then seq_num6 = weight;
		if seq_num = 7 then seq_num7 = weight;
		if seq_num = 8 then seq_num8 = weight;
		if seq_num = 9 then seq_num9 = weight;
		if seq_num = 10 then seq_num10 = weight;

		if seq_num = 11 then seq_num11 = weight;
		if seq_num = 12 then seq_num12 = weight;
		if seq_num = 13 then seq_num13 = weight;
run;
*collapse by food code;
proc means data = fndds1516_ingr_wide noprint;
	class foodcode num_ingr sum_weight;
	ways 3;
	var seq_num1--seq_num13;
	output out=fndds1516_ingr_wide1 sum=;
run;


********************************************************************************
MERGE fndds_ingr_wide1 AND fndds1516_ingr_wide1 AND INFITEMS mixed dishes
********************************************************************************;
/*
proc print data = long1;
where foodcode in (58148110,58148112,58148114);
run;
*/
proc sort data=fndds_ingr_wide1; by FoodCode;
proc sort data=fndds1516_ingr_wide1; by FoodCode;
proc sort data=infitems_mixed_dishes; by FoodCode;

data merge1;
	merge infitems_mixed_dishes (in=a) fndds_ingr_wide1 fndds1516_ingr_wide1;
	by foodcode;
	if a;
run;

*make long to include new observation for ingredients;
proc sort data = merge1; by patid visit recallno occ_no occ_name foodcode foodnum foodamt food_description pregpost num_ingr sum_weight; 

proc transpose data= merge1 out = long1;
	by patid visit recallno occ_no occ_name foodcode foodnum foodamt food_description pregpost num_ingr sum_weight;
	var seq_num1-seq_num25;
run;
*delete where seq_num = 0;
data long2;
	set long1;
	rename COL1 = weight;
	if COL1 = 0 or COL1 = . then delete;
	drop _NAME_;
	if _NAME_ = "seq_num1" then seq_num = 1;
	if _NAME_ = "seq_num2" then seq_num = 2;
	if _NAME_ = "seq_num3" then seq_num = 3;
	if _NAME_ = "seq_num4" then seq_num = 4;
	if _NAME_ = "seq_num5" then seq_num = 5;

	if _NAME_ = "seq_num6" then seq_num = 6;
	if _NAME_ = "seq_num7" then seq_num = 7;
	if _NAME_ = "seq_num8" then seq_num = 8;
	if _NAME_ = "seq_num9" then seq_num = 9;
	if _NAME_ = "seq_num10" then seq_num = 10;

	if _NAME_ = "seq_num11" then seq_num = 11;
	if _NAME_ = "seq_num12" then seq_num = 12;
	if _NAME_ = "seq_num13" then seq_num = 13;
	if _NAME_ = "seq_num14" then seq_num = 14;
	if _NAME_ = "seq_num15" then seq_num = 15;

	if _NAME_ = "seq_num16" then seq_num = 16;
	if _NAME_ = "seq_num17" then seq_num = 17;
	if _NAME_ = "seq_num18" then seq_num = 18;
	if _NAME_ = "seq_num19" then seq_num = 19;
	if _NAME_ = "seq_num20" then seq_num = 20;

	if _NAME_ = "seq_num21" then seq_num = 21;
	if _NAME_ = "seq_num22" then seq_num = 22;
	if _NAME_ = "seq_num23" then seq_num = 23;
	if _NAME_ = "seq_num24" then seq_num = 24;
	if _NAME_ = "seq_num25" then seq_num = 25;
run;	
											* done! there are 12401 observations (ingredients/food components from probable mixed dishes);
													* including the 44 missing mixed dishes from FNDDS4.0 filled in with FNDDS 2015-2016;


********************************************************************************
Put back ingredient details
********************************************************************************;
proc sort data=long2; by foodcode seq_num;
proc sort data=fndds; by foodcode seq_num;
proc sort data=fndds1516; by foodcode seq_num;

data infitems_mixed_ingr;
	merge long2 (in=a) fndds fndds1516;
	by foodcode seq_num;
	if a;
run;
proc sort data=infitems_mixed_ingr; by patid visit recallno occ_no occ_name foodnum foodcode seq_num;
run; 						


********************************************************************************
NEW CODES FOR MIXED FOODS WITH SAME FOOD CODE FOR MORE THAN 1 MIXTURE
WITH IMPLICIT DIFFERENCES IN THE DESCRIPTION
********************************************************************************;
proc means data = infitems_mixed_ingr noprint;
	class foodcode food_description num_ingr sum_weight weight seq_num sr_code sr_description;
	ways 8;
	var foodamt;
	output out= infitems_mixed_ingr_corr mean=;
run;
data infitems_mixed_ingr_corr; set infitems_mixed_ingr_corr;
	drop foodamt _TYPE_ _FREQ_;
run;
proc sort data = infitems_mixed_ingr_corr; by foodcode food_description seq_num; run;

/*
*check;
proc print data = infitems_mixed_ingr_corr;
	where foodcode = ;
run;
*/


*********************************************************************************
*CUSTUM MACROS ALSO TO KEEP RIGHT PROPORTION OF ADDED INGREDIENT 
*	corr_rep_plus_chillifix(foodcode_want,food_description_want,new_num_ingr,foodcode_similar);
*	corr_rep_plus_fixburrito(foodcode_start,food_description_end,foodcode_end,new_num_ingr,foodcode_similar,sr_description,weight);
*	corr_rep_multiply(foodcode_rep,food_description_new,foodcode_new,seq_num_want,multiplier);
********************************************************************************;
%corr_rep_plus_chillifix(27111440,"Chili con carne with beans and cheese",9,27111410);
*%corr_rep_plus_fixburrito(58100120,"Burrito with meat, beans, and sour cream, from fast food",58100145,6,58100135,"Cream, sour, cultured",26.5);

/*
*foods that just need to have the amount of an ingredient adjusted;
*double the bread for "Double cheeseburger (2 patties), with mayonnaise or salad dressing, on double-decker bun";
%corr_rep_multiply(27510230,"Double cheeseburger (2 patties), with mayonnaise or salad dressing, on double-decker bun",27510300,2,2);
%corr_rep_multiply(27510230,"Cheeseburger, 1/4 lb meat, with tomato and/or catsup, on bun",27510320,1,3);
%corr_rep_multiply(27510230,"Cheeseburger, 1/4 lb meat, with mayonnaise or salad dressing, and tomato and/or catsup, on bun",27510350,1,3);
%corr_rep_multiply(27510230,"Hamburger, 1/4 lb meat, with mayonnaise or salad dressing, and tomato and/or catsup, on bun",27510560,1,3);
*/

*********************************************************************************
* macro to assign new foodcode to a repeated code without disturbing the recipe (these will remain as mixed-dishes);
*	%corr_rep_newcode(foodcode_rep,food_description_rep,foodcode_new)
********************************************************************************;
%corr_rep_newcode(27250040,"Crab cake W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",272500401);
%corr_rep_newcode(27250040,"Crab cake W/O FAT",272500402);
%corr_rep_newcode(27250070,"Salmon cake or patty W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",272500701);
%corr_rep_newcode(58100320,"Burrito with beans, meatless",581003201);
%corr_rep_newcode(58145110,"Macaroni or noodles with cheese W/ BUTTER, NFS",581451101);
%corr_rep_newcode(58145110,"Macaroni or noodles with cheese W/O FAT",581451102);
%corr_rep_newcode(58145114,"Macaroni or noodles with cheese, made from dry mix W/ BUTTER, NFS",581451141);
%corr_rep_newcode(58145114,"Macaroni or noodles with cheese, made from dry mix W/O FAT",581451142);
%corr_rep_newcode(58145170,"Macaroni and cheese with egg W/O FAT",581451701);
%corr_rep_newcode(58147310,"Macaroni, creamed W/O FAT",581473101);
%corr_rep_newcode(58147330,"Macaroni, creamed, with cheese W/ BUTTER, NFS",581473301);
%corr_rep_newcode(58147330,"Macaroni, creamed, with cheese W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",581473302);
%corr_rep_newcode(58147330,"Macaroni, creamed, with cheese W/O FAT",581473303);
%corr_rep_newcode(58163380,"Flavored rice and pasta mixture W/ BUTTER, NFS", 581633801);
%corr_rep_newcode(58163380,"Flavored rice and pasta mixture W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",581633802);
%corr_rep_newcode(32103000,"Egg salad W/ LOW CALORIE OR DIET MAYONNAISE (INCLUDE HELLMAN'S LIGHT... )",321030001);
%corr_rep_newcode(32105130,"Egg omelet or scrambled egg, Spanish omelet, made with onions, peppers, tomatoes, and mushrooms",321051302);


*********************************************************************************
* macro to assign new foodcode to a repeated code where only 1 ingredient is the difference (deleting one ingredient);
*	corr_rep_minus1(foodcode_rep,food_description_rep,foodcode_new,seq_num_delete,new_num_ingr);
********************************************************************************;
%corr_rep_minus1(27146050,"Chicken wing with hot pepper sauce W/O FAT",271460501,2,4);
%corr_rep_minus1(27246100,"Chicken or turkey with dumplings (mixture) W/O FAT",272461001,7,7);
*%corr_rep_minus1(27250040,"Crab cake W/O FAT",272500402,2,5);
%corr_rep_minus1(27450060,"Tuna salad W/O SALAD DRESSING",274500601,3,4);
*%corr_rep_minus1(27550750,"Tuna salad submarine sandwich, with lettuce and tomato",27550750,1,3);
%corr_rep_minus1(32105030,"Egg omelet or scrambled egg, with ham or bacon W/O FAT OR W/ NONSTICK SPRAY (INCLUDE PAM...)",32105030,4,4);
%corr_rep_minus1(32105050,"Egg omelet or scrambled egg, with vegetables other than dark-green vegetables W/O FAT OR W/ NONSTICK SPRAY (INCLUDE PAM...)",321050501,6,6);
%corr_rep_minus1(32105121,"Egg omelet or scrambled egg, with sausage and cheese W/O FAT OR W/ NONSTICK SPRAY (INCLUDE PAM...)",32105121,6,5);
%corr_rep_minus1(32105130,"Egg omelet or scrambled egg, with onions, peppers, tomatoes, and mushrooms W/O FAT OR NONSTICK SPRAY (INCLUDE PAM...)",32105130,8,7);
%corr_rep_minus1(32105010,"Egg omelet or scrambled egg, with cheese W/O FAT OR W/ NONSTICK SPRAY (INCLUDE PAM...)",321050101,4,4);
%corr_rep_minus1(32105080,"Egg omelet or scrambled egg, with cheese and ham or bacon W/O FAT OR W/ NONSTICK SPRAY (INCLUDE PAM...)",321050801,5,5);
%corr_rep_minus1(32105122,"Egg omelet or scrambled egg, with sausage W/O FAT OR W/ NONSTICK SPRAY (INCLUDE PAM...)",321051221,5,4);
*%corr_rep_minus1(58100320,"Burrito with beans, meatless",581003201,3,2);
%corr_rep_minus1(58132110,"Spaghetti with tomato sauce, meatless W/O FAT",581321101,3,3);
%corr_rep_minus1(58132310,"Spaghetti with tomato sauce and meatballs or spaghetti with meat sauce or spaghetti with meat sauce  and meatballs W/O FAT",581323101,11,16);
%corr_rep_minus1(58132360,
"Spaghetti with tomato sauce and meatballs, whole wheat noodles or spaghetti with meat sauce, whole wheat noodles or spaghetti with meat sauce and meatballs, whole wheat noodles W/O FAT",
	581323601,11,16);
%corr_rep_minus1(58132910,"Spaghetti with tomato sauce and poultry, W/O FAT",581329101,5,5);
*%corr_rep_minus1(58145110,"Macaroni or noodles with cheese W/O FAT",581451102,2,7);
*%corr_rep_minus1(581451102,"Macaroni or noodles with cheese W/O FAT",581451102,8,6);
*%corr_rep_minus1(58145110,"Macaroni or noodles with cheese, made from dry mix W/O FAT",581451102,2,7);
*%corr_rep_minus1(581451102,"Macaroni or noodles with cheese, made from dry mix W/O FAT",581451102,8,6);
*%corr_rep_minus1(58145170,"Macaroni and cheese with egg W/O FAT",581451701,2,8);
*%corr_rep_minus1(581451701,"Macaroni and cheese with egg W/O FAT",581451701,8,7);
*%corr_rep_minus1(58147310,"Macaroni, creamed W/O FAT",581473101,2,4);
*%corr_rep_minus1(58147330,"Macaroni, creamed, with cheese W/O FAT",581473303,4,4);
%corr_rep_minus1(58148180,"Macaroni or pasta salad with cheese W/ ITALIAN DRESSING",581481801,6,5);
%corr_rep_minus1(58160110,"Rice with beans W/O FAT",581601102,4,3);
%corr_rep_minus1(58160120,"Rice with beans and tomatoes W/O FAT",581601201,5,4);
%corr_rep_minus1(58160130,"Rice with beans and chicken W/O FAT",581601302,6,5);
%corr_rep_minus1(58160150,"Red beans and rice W/O FAT",58160150,7,6);
%corr_rep_minus1(58160300,"Rice with peas W/O FAT",58160300,4,3);
%corr_rep_minus1(58162310,"Rice pilaf W/O FAT",581623101,3,5);
%corr_rep_minus1(58163410,"Spanish rice W/O FAT",581634102,6,8);
*%corr_rep_minus1(27510230,"Cheeseburger with tomato and/or catsup, on bun",27510310,4,9);
*%corr_rep_minus1(27510320,"Cheeseburger, 1/4 lb meat, with tomato and/or catsup, on bun",27510320,4,9);
*%corr_rep_minus1(27510230,"Hamburger, with tomato and/or catsup, on bun",27510510,4,9);
*%corr_rep_minus1(27510510,"Hamburger, with tomato and/or catsup, on bun",27510510,5,8);
*%corr_rep_minus1(27510560,"Hamburger, 1/4 lb meat, with mayonnaise or salad dressing, and tomato and/or catsup, on bun",27510560,5,9);
*%corr_rep_minus1(35003000,"Sausage griddle cake sandwich",27560660,1,2);
*%corr_rep_minus1(32202010,"Sausage and cheese on English muffin",27560670,3,3);
*%corr_rep_minus1(58100015,"Burrito, taco, or quesadilla with egg and breakfast meat, from fast food",58100013,5,5);
*%corr_rep_minus1(58134660,"Tortellini, cheese-filled, no sauce",58134680,9,8);
%corr_rep_minus1(74506000,
"Tomato and cucumber salad made with tomato, cucumber, oil, and vinegar W/ ITALIAN DRESSING, LOW CALORIE (INCLUDE WISHBONE LITE DIJON VINAIGRETTE, MCDONALD'S LITE VINAIGRETTE)",
745060001,4,6);
%corr_rep_minus1(745060001,
"Tomato and cucumber salad made with tomato, cucumber, oil, and vinegar W/ ITALIAN DRESSING, LOW CALORIE (INCLUDE WISHBONE LITE DIJON VINAIGRETTE, MCDONALD'S LITE VINAIGRETTE)",
745060001,5,5);
%corr_rep_minus1(745060001,
"Tomato and cucumber salad made with tomato, cucumber, oil, and vinegar W/ ITALIAN DRESSING, LOW CALORIE (INCLUDE WISHBONE LITE DIJON VINAIGRETTE, MCDONALD'S LITE VINAIGRETTE)",
745060001,6,4);
%corr_rep_minus1(745060001,
"Tomato and cucumber salad made with tomato, cucumber, oil, and vinegar W/ ITALIAN DRESSING, LOW CALORIE (INCLUDE WISHBONE LITE DIJON VINAIGRETTE, MCDONALD'S LITE VINAIGRETTE)",
745060001,7,3);


*********************************************************************************
* macro to assign new foodcode to a repeated code where 1 ingredient is substituted (= num_ingr);
*	corr_rep_substitute1(foodcode_rep,food_description_rep,foodcode_new,seq_num_substitute,subst_ingr_description);
*********************************************************************************;
%corr_rep_substitute1(27143000,"Chicken or turkey with cream sauce (mixture) W/ BUTTER, NFS",27143000,1,"butter, NFS");
%corr_rep_substitute1(27243000,"Chicken or turkey and rice, no sauce (mixture) W/ BUTTER, NFS",272430001,3,"butter, NFS");
%corr_rep_substitute1(27243000,"Chicken or turkey and rice, no sauce (mixture) W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",272430002,3,"vegetable oil, NFS");
%corr_rep_substitute1(27243500,"Chicken or turkey and rice with tomato-based sauce (mixture) W/ VEGETABLE OIL, NFS (OIL, NFS)",272435001,6,"vegetable oil, NFS");
*%corr_rep_substitute1(27250040,"Crab cake W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",272500401,2,"vegetable oil, NFS");
%corr_rep_substitute1(32105000,"Egg omelet or scrambled egg, fat added in cooking W/ ANIMAL FAT OR MEAT DRIPPINGS",321050001,3,"animal fat/meat dripping");
%corr_rep_substitute1(32105000,"Egg omelet or scrambled egg, fat added in cooking W/ BUTTER, NFS",321050002,3,"butter, NFS");
%corr_rep_substitute1(32105000,"Egg omelet or scrambled egg, fat added in cooking W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",321050003,3,"vegetable oil, NFS");
%corr_rep_substitute1(32105010,"Egg omelet or scrambled egg, with cheese W/ BUTTER, NFS",321050102,4,"butter, NFS");
%corr_rep_substitute1(32105010,"Egg omelet or scrambled egg, with cheese W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",321050103,4,"vegetable oil, NFS");
%corr_rep_substitute1(32105080,"Egg omelet or scrambled egg, with cheese and ham or bacon W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",32105080,5,"vegetable oil, NFS");
%corr_rep_substitute1(32105050,"Egg omelet or scrambled egg, with vegetables other than dark-green vegetables W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",32105050,6,"vegetable oil, NFS");
%corr_rep_substitute1(32105130,"Egg omelet or scrambled egg, with onions, peppers, tomatoes, and mushrooms W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",321051301,8,"vegetable oil, NFS");
*%corr_rep_substitute1(58145110,"Macaroni or noodles with cheese W/ BUTTER, NFS",581451101,2,"butter, NFS");
*%corr_rep_substitute1(581451101,"Macaroni or noodles with cheese W/ BUTTER, NFS",581451101,8,"butter, NFS");
*%corr_rep_substitute1(58145110,"Macaroni or noodles with cheese, made from dry mix W/ BUTTER, NFS",581451101,2,"butter, NFS");
*%corr_rep_substitute1(581451101,"Macaroni or noodles with cheese, made from dry mix W/ BUTTER, NFS",581451101,8,"butter, NFS");
*%corr_rep_substitute1(58147330,"Macaroni, creamed, with cheese W/ BUTTER, NFS",581473301,4,"butter, NFS");
*%corr_rep_substitute1(58147330,"Macaroni, creamed, with cheese W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",581473302,4,"vegetable oil, NFS");
%corr_rep_substitute1(58160110,"Rice with beans W/ BUTTER, NFS",581601101,4,"butter, NFS");
%corr_rep_substitute1(58160130,"Rice with beans and chicken W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",581601301,6,"vegetable oil, NFS");
%corr_rep_substitute1(58163130,"Dirty rice W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",581631301,1,"vegetable oil, NFS");
*%corr_rep_substitute1(58163380,"Flavored rice and pasta mixture W/ BUTTER, NFS", 581633801,2,"butter, NFS");
*%corr_rep_substitute1(58163380,"Flavored rice and pasta mixture W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",581633802,2,"vegetable oil, NFS");
%corr_rep_substitute1(58163410,"Spanish rice W/ BUTTER, NFS",581634101,6,"butter, NFS");
*%corr_rep_substitute1(27317010,"Chicken or turkey pot pie",27347100,5,"chicken or turkey");
*%corr_rep_substitute1(27515080,"Sausage on biscuit",27560650,2,"sausage");
*%corr_rep_substitute1(58110120,"Egg roll, with beef and/or pork",58110130,2,"beef/pork");
*%corr_rep_substitute1(58110120,"Egg roll, with chicken or turkey",58110170,2,"chicken/turkey");
*%corr_rep_substitute1(58110120,"Dim sum, meat filled (egg roll-type)",58112110,2,"beef/pork");
*%corr_rep_substitute1(58134660,"Tortellini, cheese-filled, meatless, with tomato sauce",58134620,9,"Tomato sauce");

*********************************************************************************
* macro to assign new foodcode to a repeated code where only 1 ingredient is the difference (adding one ingredient);
*	%corr_rep_plus1(foodcode_rep,food_description_new,foodcode_new,new_num_ingr,foodcode_similar,seq_num_similar);
*	%corr_rep_plus_everything(foodcode_rep,food_description_rep,seq_num_retain,foodcode_similar,new_num_ingr);
* 	%corr_rep_multiply_tunasalad(foodcode_rep,food_description_rep,seq_num_retain,foodcode_similar,new_num_ingr,multiplier);
********************************************************************************;
*%corr_rep_plus1(27250070,"Salmon cake or patty W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)",272500701,6,272500401,2);
%corr_rep_plus1(581481801,"Macaroni or pasta salad with cheese W/ ITALIAN DRESSING",581481801,6,58148500,2);
%corr_rep_plus1(745060001,
	"Tomato and cucumber salad made with tomato, cucumber, oil, and vinegar W/ ITALIAN DRESSING, LOW CALORIE (INCLUDE WISHBONE LITE DIJON VINAIGRETTE, MCDONALD'S LITE VINAIGRETTE)",
	745060001,4,58148500,2);
%corr_rep_plus1(58132110,"Pasta with tomato sauce and cheese, canned",58132113,5,58131323,9);
*%corr_rep_plus1(58100120,"Burrito with meat, beans, and sour cream, from fast food",58100145,6,58100135,5);

*adding all ingredients of 27510320 to 2751040;
*%corr_rep_plus_everything(27510440,"Bacon cheeseburger, 1/4 lb meat, with mayonnaise or salad dressing, and tomato and/or catsup, on bun",2,27510350,11);

*add all ingredients from tuna salad but multiply portion by 0.25 to keep proportion of tuna salad in submarine sandwich;
*%corr_rep_multiply_tunasalad(27550750,"Tuna salad submarine sandwich, with lettuce and tomato",27450060,8,0.25);

*********************************************************************************
* macro to *delete water used for cooking rice,...;
*corr_rep_minus_water(foodcode,sr_description_water,seq_num_delete,new_num_ingr);
********************************************************************************;
%corr_rep_minus_water(27120060,"Water, tap, drinking",8,16);
%corr_rep_minus_water(27146100,"Water, tap, drinking",8,15);
%corr_rep_minus_water(27345410,"Water, tap, drinking",5,9);
%corr_rep_minus_water(27345510,"Water, tap, drinking",5,9);
%corr_rep_minus_water(27345520,"Water, tap, drinking",5,9);
%corr_rep_minus_water(27363100,"Water, tap, drinking",2,10);
%corr_rep_minus_water(58137220,"Water, tap, municipal",2,10);
%corr_rep_minus_water(58137230,"Water, tap, municipal",13,13);
%corr_rep_minus_water(58137240,"Water, tap, municipal",17,16);
%corr_rep_minus_water(58151130,"Water, tap, municipal",3,10);
%corr_rep_minus_water(58160000,"Water, tap, drinking",3,12);
%corr_rep_minus_water(58161510,"Water, tap, municipal",12,11);
%corr_rep_minus_water(58162310,"Water, tap, municipal",2,5);
%corr_rep_minus_water(58163380,"Water, tap, drinking",1,11);
%corr_rep_minus_water(58175110,"Water, tap, municipal",10,9);
%corr_rep_minus_water(581623101,"Water, tap, municipal",2,4);
%corr_rep_minus_water(581633801,"Water, tap, drinking",1,11);
%corr_rep_minus_water(581633802,"Water, tap, drinking",1,11);

/*
proc print data = infitems_mixed_ingr_corr;
	where foodcode in (27510350,27510440);
run;
*/

********************************************************************************
MAKE CORRECTIONS TO INGREDIENTS FOR MIXED FOODS WITH SAME
FOOD CODE FOR MORE THAN 1 MIXTURE
********************************************************************************;
*description of one of these is wrong -- correct this;
data infitems_mixed_ingr_corr; set infitems_mixed_ingr_corr;
	if foodcode = 27146350 then food_description = "Lemon chicken, Chinese style";
	if foodcode = 27343470 then food_description = "Chicken or turkey, noodles, and vegetables (including carrots, broccoli, 
								and/or dark-green leafy), cream sauce, white sauce, or mushroom soup-based sauce (mixture)";
	if foodcode = 27420500 then food_description = "Pork and vegetables (including carrots, broccoli, and/or dark-green leafy), 
								soy-based sauce (mixture)";
	if foodcode = 27446200 then food_description = "Chicken or turkey salad, made with mayonnaise";
	if foodcode = 27450060 then food_description = "Tuna salad, made with mayonnaise";
	if foodcode = 27450090 then food_description = "Tuna salad with cheese, made with mayonnaise";
	*if foodcode = 27510230 and food_description = "Double cheeseburger (2 patties), with mayonnaise or salad dressing, on double-decker bun"
			then foodcode = 27510300;
	*if foodcode = 27510230 and food_description = "Cheeseburger, 1/4 lb meat, with tomato and/or catsup, on bun"
			then foodcode = 27510320;
	*if foodcode = 27510230 and food_description = "Cheeseburger, 1/4 lb meat, with mayonnaise or salad dressing, and tomato and/or catsup, on bun"
			then foodcode = 27510350;
	*if foodcode = 27510230 and food_description = "Hamburger, 1/4 lb meat, with mayonnaise or salad dressing, and tomato and/or catsup, on bun"
			then foodcode = 27510560;
	if foodcode = 58100110 then food_description = "Burrito with beef and beans";
	if foodcode = 58100220 then food_description = "Burrito with chicken, beans, and cheese";
	if foodcode = 58106225 then food_description = "Pizza, cheese, regular crust";
	if foodcode = 58106550 then food_description = "Pizza with pepperoni, thin crust";
	if foodcode = 58106555 then food_description = "Pizza with pepperoni, regular crust";
	if foodcode = 58106610 then food_description = "Pizza with meat other than pepperoni, NS as to type of crust";
	if foodcode = 58106625 then food_description = "Pizza with meat other than pepperoni, regular crust";
	*if foodcode = 58106720 then food_description = "Pizza with meat and vegetables";
	*if foodcode = 58145110 and food_description = "Macaroni or noodles with cheese, Easy Mac type" then foodcode = 58145117;
	*if foodcode = 58145110 then food_description = "Macaroni or noodles with cheese";
	*if foodcode = 581451101 then food_description = "Macaroni or noodles with cheese W/ BUTTER, NFS";
	*if foodcode = 581451102 then food_description = "Macaroni or noodles with cheese W/O FAT";
	if foodcode = 58147330 and food_description = "Macaroni or noodles, creamed, with cheese" then food_description = "Macaroni, creamed, with cheese";
	if foodcode = 58163410 then food_description = "Spanish rice";
	*if foodcode = 58106325 then food_description = "Pizza, cheese, with vegetables";		
	if foodcode = 58132310 and food_description = "Pasta with tomato sauce and meat or meatballs, canned" then foodcode = 58132313;
	if foodcode = 32103000 then food_description = "Egg salad, made with mayonnaise";
	if foodcode = 32105010 then food_description = "Egg omelet or scrambled egg, with cheese";
run;


/*
proc print data = by_ingredient;
	where foodcode in (32105000,321050001,321050002,321050003,32105010,321050101,321050102,321050103);
run;
*/

********************************************************************************
Put seq_num back in
********************************************************************************;
*make sure no recipe repeats;
proc means data = infitems_mixed_ingr_corr noprint;
	class foodcode food_description num_ingr sum_weight weight sr_description;
	ways 6;
	var sr_code;
	output out= infitems_mixed_ingr_corr1 mean=;
run;
data infitems_mixed_ingr_corr1; set infitems_mixed_ingr_corr1;
	drop sr_code _TYPE_ _FREQ_;
run;

*make a new seq_num in sequence;
data count1; set infitems_mixed_ingr_corr1;
	by foodcode;
	if first.foodcode THEN
		DO;
			cnt = 0;
		END;
			cnt + 1;
run;
proc sort data = count1;
	by foodcode sr_description;
run;
*proc print data=count1;
*run;

data count1; set count1;
	rename cnt = seq_num_temp;
run;

*create seq_num assigning order from highest amount to least amount;
proc sort data = count1; by foodcode descending seq_num_temp;
data by_ingredient; set count1;
	by foodcode descending seq_num_temp;
	if first.foodcode and first.seq_num_temp THEN
		DO;
			seq_num = 0;
		END;
			seq_num + 1;
	drop seq_num_temp;
run;



********************************************************************************
*FINAL MIXED FOODS (WITHOUT UNLINKED FOODS) IS by_ingredient;
********************************************************************************;

proc sort data = by_ingredient;
	by foodcode seq_num sr_description;
run;



*view mixes in PEAS;
proc means data = by_ingredient noprint;					* 401 different types of mixes;
	class foodcode food_description num_ingr;					
	ways 3;
	var sum_weight;
	output out= test5 mean=;
run;
data test5; set test5; drop sum_weight _TYPE_ _FREQ_;
run;

/* print changes (water for cooking) in Grace's part;
proc print data = by_ingredient;
	where foodcode in (27120060,27146100,27345410,27345510,27345520,27363100);
run;
*/
/* print changes (water for cooking) in my part;
proc print data = by_ingredient;
	where foodcode in (58137220,58137230,58137240,58151130,58160000,58161510,58162310,58163380,
						58175110,581623101,581633801,581633802,745060001);
run;
*/


