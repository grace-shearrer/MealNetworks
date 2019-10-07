********************************************************************************
* Project: 		Meal patterns and BMI/weight - PEAS.
* Program: 		foodgroup_coding_2_1
* Author: 		Carolina Schwedhelm
* Created: 		08/26/2019
* Last Changes: 09/26/2019, by Carolina Schwedhelm
* Origin: 		self made
* Category: 	creation of dataset
* Program before: 	macros_for_foodgroup_coding_1_1
					foodgroup_coding_1_1
					foodgroup_coding_1_2
					foodgroup_coding_1_3
					foodgroup_coding_1_4
					foodgroup_coding_1_5
* Short descr.:	2.1	Prepare rest of foods dataset (all but disaggregated mixed dishes) 
				2.2 Code food groups from rest of foods dataset
				2.3 Merge mixed dish dataset with remaining foods
				2.4 Check dataset and put in needed format for analysis

*******************************************************************************;

*********************************************************************************
run programs	macros_for_foodgroup_coding_1_1.sas
				foodgroup_coding_1_1.sas
				foodgroup_coding_1_2.sas
				foodgroup_coding_1_3.sas
				foodgroup_coding_1_4.sas
				foodgroup_coding_1_5.sas
before			(directory: 'N:\DIPHRHBB\Staff Subdirectories\Carolina Schwedhelm\SAS programs\foodgroup_coding_1_1.sas')
********************************************************************************;

********************************************************************************
start with		data = infitems1							(37168 ingredients*foodcodes) - repeating.
				variables in dataset = 						PATID, pregpost, visit, recallno, occ_no, occ_name,
															foodcode, foodnum, food_description
															foodamt
				data = mixed_dish_final
				variables in dataset = 						(5136 observations from disaggregated and reaggregated ingredients in mixed dishes, repeating)
															PATID, pregpost, visit, recallno, occ_no, occ_name,
															foodcode, foodnum, food_category, num_ingr seq_num, food_description_new
															foodamt (food amount broken down by ingredients - using proportions)
********************************************************************************;


********************************************************************************
2.1 Prepare rest of foods dataset (all but disaggregated mixed dishes)
********************************************************************************;
*delete observations from mixed dishes dataset to avoid duplicates;
data infitems_complement; set infitems1;												* dataset with 35196 observations;
	if foodcode >= 27000000 and foodcode < 27500000 then delete;
	if foodcode >= 28000000 and foodcode < 28300000 then delete;
	if foodcode >= 32000000 and foodcode < 33000000 then delete;
	if foodcode >= 58000000 and foodcode < 58400000 then delete;
	if foodcode >= 74500000 and foodcode < 74600000 then delete;
run;

*retain mixed dishes that will be treated as 1 food and are absent from infitems_mixed_dishes;
data infitems_complement1; set infitems1;												* dataset with 106 observations;
	where foodcode in (27160100,27214100,27214110,27246300,27246500,27311510,27350410,27450070,27450130)
	or foodcode in (27260010:27260090)
	or foodcode in (32104950,32105180,32130070,32102000,32202010,32202085,32202200,32400080);
run;

*merge these two;
proc sort data = infitems_complement; by foodcode;
proc sort data = infitems_complement1; by foodcode;
data infitems_nomix;															* dataset with 35302 observations;
	drop fndds_desc foodcode_fndds;
	merge infitems_complement infitems_complement1;
	by foodcode;
run;


********************************************************************************
2.2 Code food groups from rest of foods dataset
********************************************************************************;
data infitems_nomix_fgroups; set infitems_nomix;
	if foodcode in (11000000:11999999) then food_category = 1;				*1: Milk and milk drinks;
	if foodcode in (12000000:12299999) then food_category = 1;				*33: sauces, salad dressings;
	if foodcode in (13000000:13299999) then food_category = 2;				*2: Milk desserts;
	if foodcode in (14000000:14999999) then food_category = 3;				*3: cheeses;
	if foodcode in (24000000:24999999) then food_category = 4;				*4: poultry;
	if foodcode in (26000000:26999999) then food_category = 5;				*5: fish and shellfish;

	if foodcode in (20000000:23999999) then food_category = 6;				*6: meat;
	if foodcode in (25200000:25999999) then food_category = 7;				*7: cured and organ meat;
	if foodcode in (25100000:25199999) then food_category = 7;				
	if foodcode in (31000000:33999999) then food_category = 8;				*8: eggs;
	if foodcode in (41000000:49999999) then food_category = 9;				*9: legumes, nuts and seeds;
	if foodcode in (51000000:51199999) then food_category = 10;				*10: breads from refined grains;
	if foodcode in (52100000:52999999) then food_category = 10;	

	if foodcode in (51200000:51699999) then food_category = 11;				*11: breads from whole grains;
	if foodcode in (53100000:53999999) then food_category = 12;				*12: cakes, cookies, pies, pastries, bars;
	if foodcode in (55100000:55999999) then food_category = 13;				*13: pancakes, waffles, French toast, other grain products;

	if foodcode in (56100000:56999999) then food_category = 20;				*20: pastas, cooked cereals, rice;
	if foodcode in (54000000:54999999) then food_category = 21;				*21: crackers and salty snacks from grain products;
	if foodcode in (61000000:61999999) then food_category = 24;				*24: fruit juices;
	if foodcode in (64000000:67999999) then food_category = 24;

	if foodcode in (62100000:63999999) then food_category = 25;				*25: whole fruits;
	if foodcode in (71000000:71199999) then food_category = 26;				*26: white potatoes and starchy vegetables;
	if foodcode in (71300000:71399999) then food_category = 26;	
	if foodcode in (71500000:71999999) then food_category = 26;	
	if foodcode in (71200000:71299999) then food_category = 27;				*27: white potatoes, fried, chips and sticks;
	if foodcode in (71400000:71499999) then food_category = 27;	
	if foodcode in (72100000:72999999) then food_category = 28;				*28: dark green vegetables;
	if foodcode in (73100000:74499999) then food_category = 29;				*29: red and orange vegetables;
	if foodcode in (63105010,75100000:75999999) then food_category = 30;	*30: other vegetables (+ avocado);

	if foodcode in (81000000:81299999) then food_category = 31;				*31: solid fats;
	if foodcode in (82000000:82999999) then food_category = 32;				*32: oils;
	if foodcode in (83100000:89999999) then food_category = 33;				*33: sauces, salad dressings;
	if foodcode in (12300000:12999999) then food_category = 33;				*33: sauces, salad dressings;
	if foodcode in (13400000:13999999) then food_category = 33;	
	if foodcode in (28500000:29999999) then food_category = 33;
	if foodcode in (74400000:74500000) then food_category = 33;
	if foodcode in (81300000:81999999) then food_category = 33;
	if foodcode in (14700000:14999999) then food_category = 34;				*34: soups;
	if foodcode in (28300000:28399999) then food_category = 34;
	if foodcode in (58400000:58499999) then food_category = 34;
	if foodcode in (71800000:71899999) then food_category = 34;
	if foodcode in (72300000:72999999) then food_category = 34;
	if foodcode in (73500000:73999999) then food_category = 34;
	if foodcode in (74600000:74999999) then food_category = 34;
	if foodcode in (75600000:75999999) then food_category = 34;
	if foodcode in (91000000:91999999) then food_category = 35;				*35: sugars and sweets;

	if foodcode in (92100000:92399999) then food_category = 36;				*36: coffee and tea;
	if foodcode in (92400000:92999999) then food_category = 37;				*37: soft drinks and sugar-sweetened drinks;
	if foodcode in (95100000:95299999) then food_category = 37;				
	if foodcode in (93000000:93999999) then food_category = 38;				*38: alcoholic drinks;
	if foodcode in (94000000:94999999) then food_category = 39;				*39: water, noncarbonated;
	if foodcode in (95300000:95999999) then food_category = 40;				*40: nutritional drinks;
run;


*separate codes 57000000 to < 58000000 into high sugar (>21.2g/100g) and low sugar (=<21.2g/100g) - breakfast cereals;
data new1; set new;
	keep patid visit recallno occ_no occ_name foodcode food_description foodamt sugr;
	where foodcode in (57000000:57999999);
run;
*get sugar content per 100g;
data new1; set new1;
	sugar_p100g = (sugr*100)/foodamt;
	if sugar_p100g > 21.2 then sugar_cont = "high";
	if sugar_p100g =< 21.2 then sugar_cont = "low";
run;
*add sugar variable to infitems_nomix_fgroups;
data new2; set new1;
	keep foodcode food_description sugar_cont;
run;
proc sort data = new2; by foodcode food_description;
proc sort data = infitems_nomix_fgroups; by foodcode food_description;
data infitems_nomix_fgroups;
	merge infitems_nomix_fgroups (in=a) new2;
	by foodcode food_description;
	if a;
run;


*separate codes 51800000 to < 52000000 into refined and whole grain and add breakfast cereals (categories 24 & 25);
/*
proc print data = infitems_nomix_fgroups;
	where foodcode in (51800000:51999999);
run;
*/
*code rest of foods;
data infitems_nomix_fgroups; set infitems_nomix_fgroups;
	if foodcode in (51800000:51999999) then food_category = 11;							*11: whole grain breads;
	if sugar_cont = "high" then food_category = 22;										*22: breakfast cereals, higher sugar;
	if sugar_cont = "low" then food_category = 23;										*23: breakfast cereals, lower sugar;
	if foodcode in (27500050:27560910,58127330,58127350) then food_category = 15;		*15: sandwiches;
	if foodcode in (58100013:58105050,58306100) then food_category = 18;				*18: tortilla-based mixed dishes;
	if foodcode in (58106200:58121620,58124250:58126300,58161510) then food_category = 14;	*14: savory pies and pastries;
	if foodcode in (58122220) then food_category = 20;									*20: pastas, cooked cereals, rice;
	if foodcode in (58130011:58161110,58302000) then food_category = 17;				*17: pasta-based mixed dishes;
	if foodcode in (58200250) then food_category = 15;									*15: sandwiches;
run;
data infitems_nomix_fgroups; set infitems_nomix_fgroups;
	drop sugar_cont;
run;

*check all foods have a category;
proc print data = infitems_nomix_fgroups;
	where food_category = .;
run;

*code rest of foods;
data infitems_nomix_fgroups; set infitems_nomix_fgroups;
	if food_description =: 'Meatballs' then food_category = 16;			*16: protein-based patties and loaves;
	if food_description =: 'Meat loaf' then food_category = 16;			*16: protein-based patties and loaves;
	if find(food_description,'turkey cake') then food_category = 16;	*16: protein-based patties and loaves;
	if food_description =: 'Shepherd' then food_category = 16;			*16: protein-based patties and loaves;
	if find(food_description,'noodle casserole') then food_category = 17;	*17: pasta-based mixed dishes;
	if food_description =: 'Shrimp salad' then food_category = 19;		*19: mayonnaise-based salads;
	if food_description =: 'Crab salad' then food_category = 19;		*19: mayonnaise-based salads;
run;

*check all foods have a category;
proc print data = infitems_nomix_fgroups;
	where food_category = .;
run;
/*
*check nutrition beverages and energy drinks;
proc print data= infitems_nomix_fgroups;
	where foodcode in (95000000:95999999);
run;
*/

********************************************************************************
2.3 Merge mixed dish and no-mixed dish datasets
********************************************************************************;
proc sort data = infitems_nomix_fgroups; by patid pregpost visit recallno occ_no occ_name foodnum foodcode food_description;
proc sort data = mixed_dish_final; by patid pregpost visit recallno occ_no occ_name foodnum foodcode food_description;
data infitems_finalfoods_long;
	merge infitems_nomix_fgroups mixed_dish_final;
	by patid pregpost visit recallno occ_no occ_name foodnum foodcode food_description;
run;
data infitems_finalfoods_long; set infitems_finalfoods_long;				*final foods dataset long format;
	drop num_ingr seq_num foodcode;
run;



********************************************************************************
2.4 Check dataset and put in needed format for analysis						*make foods wide for each occ_name;
********************************************************************************;

data infitems_foods_wide; set infitems_finalfoods_long;
	if food_category = 1 then food_1 = foodamt;
	if food_category = 2 then food_2 = foodamt;
	if food_category = 3 then food_3 = foodamt;
	if food_category = 4 then food_4 = foodamt;
	if food_category = 5 then food_5 = foodamt;
	if food_category = 6 then food_6 = foodamt;
	if food_category = 7 then food_7 = foodamt;
	if food_category = 8 then food_8 = foodamt;
	if food_category = 9 then food_9 = foodamt;
	if food_category = 10 then food_10 = foodamt;

	if food_category = 11 then food_11 = foodamt;
	if food_category = 12 then food_12 = foodamt;
	if food_category = 13 then food_13 = foodamt;
	if food_category = 14 then food_14 = foodamt;
	if food_category = 15 then food_15 = foodamt;
	if food_category = 16 then food_16 = foodamt;
	if food_category = 17 then food_17 = foodamt;
	if food_category = 18 then food_18 = foodamt;
	if food_category = 19 then food_19 = foodamt;
	if food_category = 20 then food_20 = foodamt;

	if food_category = 21 then food_21 = foodamt;
	if food_category = 22 then food_22 = foodamt;
	if food_category = 23 then food_23 = foodamt;
	if food_category = 24 then food_24 = foodamt;
	if food_category = 25 then food_25 = foodamt;
	if food_category = 26 then food_26 = foodamt;
	if food_category = 27 then food_27 = foodamt;
	if food_category = 28 then food_28 = foodamt;
	if food_category = 29 then food_29 = foodamt;
	if food_category = 30 then food_30 = foodamt;

	if food_category = 31 then food_31 = foodamt;
	if food_category = 32 then food_32 = foodamt;
	if food_category = 33 then food_33 = foodamt;
	if food_category = 34 then food_34 = foodamt;
	if food_category = 35 then food_35 = foodamt;
	if food_category = 36 then food_36 = foodamt;
	if food_category = 37 then food_37 = foodamt;
	if food_category = 38 then food_38 = foodamt;
	if food_category = 39 then food_39 = foodamt;
	if food_category = 40 then food_40 = foodamt;

	drop food_category foodamt;
	label 	food_1 = "Milk and milk drinks"									food_2 = "Milk desserts"		
			food_3 = "Cheese"												food_4 = "Poultry"
			food_5 = "Fish and shellfish"									food_6 = "Meat"
			food_7 = "Cured and organ meat"									food_8 = "Eggs"
			food_9 = "Legumes, nuts and seeds"								food_10 = "Breads from refined grains"

		 	food_11 = "Breads from whole grains"							food_12 = "Cakes, cookies, pies, pastries, bars"		
			food_13 = "Pancakes, waffles, French toast, other grain products"	food_14 = "Savory pies and pastries"
			food_15 = "Sandwiches"											food_16 = "Protein-based patties and loaves"
			food_17 = "Pasta-based mixed dishes"							food_18 = "Tortilla-based mixed dishes"
			food_19 = "Mayonnaise-based salads"								food_20 = "Pastas, cooked cereals, rice"

		 	food_21 = "Crackers and salty snacks from grain products"		food_22 = "Breakfast cereals, higher sugar"		
			food_23 = "Breakfast cereals, lower sugar"						food_24 = "Fruit juices"
			food_25 = "Whole fruits"										food_26 = "White potatoes and starchy vegetables"
			food_27 = "White potatoes, fried, chips and sticks"				food_28 = "Dark green vegetables"
			food_29 = "Red and orange vegetables"							food_30 = "Other vegetables"

		 	food_31 = "Solid fats"											food_32 = "Oils"		
			food_33 = "Sauces, dressings and condiments"					food_34 = "Soups"
			food_35 = "Sugars and sweets"									food_36 = "Coffee and tea"
			food_37 = "Soft drinks and sugar-sweetened drinks"				food_38 = "Alcoholic drinks"

			food_39 = "Water, noncarbonated"								food_40 = "Nutritional drinks";
run;

*condense by occ_name;
proc means data = infitems_foods_wide noprint;
	class patid pregpost visit recallno occ_no occ_name;
	ways 6;
	var food_1--food_40;
	output out= infitems_finalfoods_wide sum=;
run;

*replace missings with 0 (food categories - when a food was not consumed;
data infitems_finalfoods_wide; set infitems_finalfoods_wide;
	if food_1 = . then food_1 = 0;
	if food_2 = . then food_2 = 0;
	if food_3 = . then food_3 = 0;
	if food_4 = . then food_4 = 0;
	if food_5 = . then food_5 = 0;
	if food_6 = . then food_6 = 0;
	if food_7 = . then food_7 = 0;
	if food_8 = . then food_8 = 0;
	if food_9 = . then food_9 = 0;
	if food_10 = . then food_10 = 0;

	if food_11 = . then food_11 = 0;
	if food_12 = . then food_12 = 0;
	if food_13 = . then food_13 = 0;
	if food_14 = . then food_14 = 0;
	if food_15 = . then food_15 = 0;
	if food_16 = . then food_16 = 0;
	if food_17 = . then food_17 = 0;
	if food_18 = . then food_18 = 0;
	if food_19 = . then food_19 = 0;
	if food_20 = . then food_20 = 0;

	if food_21 = . then food_21 = 0;
	if food_22 = . then food_22 = 0;
	if food_23 = . then food_23 = 0;
	if food_24 = . then food_24 = 0;
	if food_25 = . then food_25 = 0;
	if food_26 = . then food_26 = 0;
	if food_27 = . then food_27 = 0;
	if food_28 = . then food_28 = 0;
	if food_29 = . then food_29 = 0;
	if food_30 = . then food_30 = 0;

	if food_31 = . then food_31 = 0;
	if food_32 = . then food_32 = 0;
	if food_33 = . then food_33 = 0;
	if food_34 = . then food_34 = 0;
	if food_35 = . then food_35 = 0;
	if food_36 = . then food_36 = 0;
	if food_37 = . then food_37 = 0;
	if food_38 = . then food_38 = 0;
	if food_39 = . then food_39 = 0;
	if food_40 = . then food_40 = 0;

	drop _TYPE_ ;
run;

*delete eating occasions where just a supplement (occ_num = 9) or only non-carbonated water (food_category = 39);
data infitems_meals_wide; set infitems_finalfoods_wide;
	*if occ_name = 9 then delete;
	tot_foodamt = 	food_1 + food_2 + food_3 + food_4 + food_5 + food_6 + food_7 + food_8 + food_9 + food_10 +
					food_11 + food_12 + food_13 + food_14 + food_15 + food_16 + food_17 + food_18 + food_19 + food_20 +
					food_21 + food_22 + food_23 + food_24 + food_25 + food_26 + food_27 + food_28 + food_29 + food_30 +
					food_31 + food_32 + food_33 + food_34 + food_35 + food_36 + food_37 + food_38 + food_39 + food_40;
run;
/*
proc print data = infitems_meals_wide;													*1519 occasions of just water;
	where tot_foodamt = food_39;
run;
*/
/*
data infitems_meals_wide; set infitems_meals_wide;
	if tot_foodamt = food_39 then delete;
	*drop tot_foodamt;
run;
*/

*condense data by type of meal (occ_name);
proc means data=infitems_meals_wide noprint;
	class patid visit recallno occ_name;
	ways 4;
	var tot_foodamt;
	output out=infitems_byocc_name sum=;
run;
*check frequencies of meal types by recall;					* 22 occasions of 2 breakfasts!;
proc freq data=infitems_byocc_name;							* 5 occasions of 2 lunches!;
	table _FREQ_*occ_name;									* 5 occasions of 2 dinners!;
run;

/*
*create sequence number for occasion names
proc sort data = how_many_ingr; by sr_description;
data how_many_ingr1; set how_many_ingr;
	by sr_description;
		DO;
			ingr_num + 1;
		END;
run;
*/

/*
*save data set file to a local folder on server for importing to sas;
libname out 'P:/Carolina/NIH/Network test/SAS_output/';

*preg breakfast;
data out.PEAS_preg_occ1;
	set infitems_meals_wide;

	where pregpost = 1 and occ_name = 1;
	drop patid pregpost visit recallno occ_no occ_name _FREQ_ tot_foodamt food_8 food_41;
run;




*post breakfast;
data out.PEAS_post_occ1;
	set infitems_meals_wide;

	where pregpost = 2 and occ_name = 1;
	drop patid pregpost visit recallno occ_no occ_name _FREQ_ tot_foodamt;
run;

*breakfast per person (average);
proc means data =  infitems_meals_wide noprint;
	class patid occ_name;
	ways 2;
	var food_1--food_41;
	output out=meals_mean mean=;
run;

data out.PEAS_breakfast_mean;
	set meals_mean;

	where occ_name = 1;
	drop patid occ_name _TYPE_ _FREQ_;
run;


*/
/*
*check distribution;
proc univariate data=meals_mean;
	where occ_name = 1;
	var food_1--food_40;
	histogram food_1--food_40 / endpoints = 0 to 150 by 10;
run;

*check nonmeat sandwiches group 17;
proc print data=infitems_meals_wide;
	where food_17 ne 0;
run;
proc print data=infitems;
	where patid = '0014801' and visit = 7 and recallno = 1 and occ_no = 5;
run;

proc print data=infitems;																* no other nonmeat sandwiches;
	where foodcode in (41900000:42000000) or foodcode in (42300000:42400000);
run;
*/
