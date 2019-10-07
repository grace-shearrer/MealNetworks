********************************************************************************
* Project: 		Meal patterns and BMI/weight - PEAS.
* Program: 		foodgroup_coding_1_5
* Author: 		Carolina Schwedhelm
* Created: 		08/19/2019
* Last Changes: 09/26/2019, by Carolina Schwedhelm
* Origin: 		self made
* Category: 	creation of dataset
* Program before: 	macros_for_foodgroup_coding_1_1
					foodgroup_coding_1_1
					foodgroup_coding_1_2
					foodgroup_coding_1_3
					foodgroup_coding_1_4
* Short descr.:	1.1. Get list of all different ingredients
				1.2. Assign food group number to all different ingredients (food categories for network analysis)
				1.3. Replace food description with ingredient description


*******************************************************************************;

*********************************************************************************
run programs	macros_for_foodgroup_coding_1_1.sas
				foodgroup_coding_1_1.sas
				foodgroup_coding_1_2.sas
				foodgroup_coding_1_3.sas
				foodgroup_coding_1_4.sas
before			(directory: 'N:\DIPHRHBB\Staff Subdirectories\Carolina Schwedhelm\SAS programs\foodgroup_coding_1_1.sas')
********************************************************************************;

********************************************************************************
start with		data = infitems_mixed_w_proportions1		(5136 ingredients*foodcodes) - repeating.
				variables in dataset = 						PATID, pregpost, visit, recallno, occ_no, occ_name,
															foodcode, foodnum, food_description
															num_ingr (total number of ingredients in mixed dish)
															seq_num (sequence number of ingredient in mixed dish)
															sr_description (ingredient description)
															foodamt (food amount broken down by ingredients - using proportions)

********************************************************************************;


********************************************************************************
1.1. Get list of all different ingredients
********************************************************************************;
/*
proc print data = infitems_mixed_w_proportions1;
	where sr_description = "Salt, table";
run;
*/

proc means data = infitems_mixed_w_proportions1 noprint;
	class sr_description;														* 381 different ingredients;
	ways 1;
	var seq_num;
	output out=how_many_ingr sum=;
run;
data how_many_ingr; set how_many_ingr;
	drop _TYPE_ seq_num;
run;
/*
proc print data = by_ingredient_final;
	where sr_description =: 'dressing';
run;
*/


********************************************************************************
1.2. Assign food group number to all different ingredients (food categories for network analysis)
********************************************************************************;
*first create sequence variable for the ingredient list;
proc sort data = how_many_ingr; by sr_description;
data how_many_ingr1; set how_many_ingr;
	by sr_description;
		DO;
			ingr_num + 1;
		END;
run;
/*
proc print data = how_many_ingr1;
run;
*/

*ingredients;
data how_many_ingr2; set how_many_ingr1;
*all sauces except for a few that have sauce in name but are not sauces;
	if find(sr_description,'sauce') then food_category = 33;	* sauces;						* watch the order of coding. Other foods with "sauce" that don't belong here;
	if ingr_num in (111,160,256,306,310,311) then food_category = .;
	if find(sr_description,'sandwich') then food_category = 15;	* meat sandwiches;
	if ingr_num in (320) then food_category = 15;				* nonmeat sandwiches;
	if find(sr_description,'Pizza') then food_category = 14;	* savory pies and pastries;

	*rest of ingredients;
	if sr_description =: 'Egg' then food_category = 8;			* eggs;							* watch the order of coding. Other foods with "egg" that don't belong here;
	if sr_description =: 'Bamboo' then food_category = 30;		* other vegetables;
	if sr_description =: 'Cabbage' then food_category = 30;		* other vegetables;
	if sr_description =: 'Celery' then food_category = 30;		* other vegetables;
	if sr_description =: 'Corn' then food_category = 30;		* other vegetables;
	if sr_description =: 'Cucumber' then food_category = 30;	* other vegetables;
	if sr_description =: 'Garlic' then food_category = 30;		* other vegetables;
	if sr_description =: 'Mushrooms' then food_category = 30;	* other vegetables;
	if sr_description =: 'Olives' then food_category = 30;		* other vegetables;
	if sr_description =: 'Onions' then food_category = 30;		* other vegetables;
	if sr_description =: 'Peas' then food_category = 30;		* other vegetables;
	if sr_description =: 'Peppers' then food_category = 30;		* other vegetables;
	if sr_description =: 'Vegetable combination' then food_category = 30;	* other vegetables;
	if sr_description =: 'Waterchestnuts' then food_category = 30;			* other vegetables;
	if sr_description =: 'Carrots' then food_category = 29;		* red and orange vegetables;
	if sr_description =: 'Tomatoes' then food_category = 29;	* red and orange vegetables;
	if sr_description =: 'Beans' then food_category = 9;		* legumes, nuts and seeds;
	if sr_description =: 'Lima beans' then food_category = 9;	* legumes, nuts and seeds;
	if sr_description =: 'Mung beans' then food_category = 9;	* legumes, nuts and seeds;
	if sr_description =: 'Beef' then food_category = 6;			* meat;
	if sr_description =: 'Ground beef' then food_category = 6;	* meat;
	if sr_description =: 'Pork, fresh' then food_category = 6;	* meat;
	if sr_description =: 'Ham' then food_category = 7;			* cured and organ meat;
	if sr_description =: 'Pork sausage' then food_category = 7;	* cured and organ meat;
	if sr_description =: 'Pork, cured' then food_category = 7;	* cured and organ meat;
	if sr_description =: 'Broccoli' then food_category = 28;	* dark green vegetables;
	if sr_description =: 'Coriander' then food_category = 28;	* dark green vegetables;
	if sr_description =: 'Spinach' then food_category = 28;		* dark green vegetables;		* watch the order of coding. Other foods with "Spinach" that don't belong here;
	if sr_description =: 'Burrito' then food_category = 18;		* tortilla-based mixed dishes;
	if sr_description =: 'Quesadilla' then food_category = 18;	* tortilla-based mixed dishes;
	if sr_description =: 'Taco' then food_category = 18;		* tortilla-based mixed dishes;
	if sr_description =: 'Tamale' then food_category = 18;		* tortilla-based mixed dishes;
	if sr_description =: 'Soft taco' then food_category = 18;	* tortilla-based mixed dishes;
	if sr_description =: 'Calzone' then food_category = 14;		* savory pies and pastries;
	if sr_description =: 'Dumpling' then food_category = 14;	* savory pies and pastries;
	if sr_description =: 'Egg roll' then food_category = 14;	* savory pies and pastries;
	if sr_description =: 'Turnover' then food_category = 14;	* savory pies and pastries;
	if sr_description =: 'Chicken' then food_category = 4;		* poultry;
	if sr_description =: 'Crustaceans' then food_category = 5;	* fish and shellfish;
	if sr_description =: 'Fish' then food_category = 5;			* fish and shellfish;
	if sr_description =: 'Shrimp' then food_category = 5;		* fish and shellfish;
	if sr_description =: 'Gnocchi' then food_category = 20;		* pastas, cooked cereals, rice;
	if sr_description =: 'Noodles' then food_category = 20;		* pastas, cooked cereals, rice;
	if sr_description =: 'Rice' then food_category = 20;		* pastas, cooked cereals, rice;
	if sr_description =: 'Spaghetti' then food_category = 20;	* pastas, cooked cereals, rice;
	if sr_description =: 'Lasagna' then food_category = 17;		* pasta-based mixed dishes;
	if sr_description =: 'Macaroni' then food_category = 17;	* pasta-based mixed dishes;		* watch the order of coding. Other foods with "Macaroni" that don't belong here;	
	if sr_description =: 'Tortellini' then food_category = 17;	* pasta-based mixed dishes;	
	if sr_description =: 'tortellini' then food_category = 17;	* pasta-based mixed dishes;	
	if find(sr_description,'ravioli') then food_category = 17;	* pasta-based mixed dishes;	
	if sr_description =: 'Margarine' then food_category = 31;	* solid fats;
	if sr_description =: 'Oil' then food_category = 32;			* oils;
	if sr_description =: 'Potato' then food_category = 26;		* white potatoes and starchy vegetables;
	if sr_description =: 'Sauce' then food_category = 33;		* sauces;
	if sr_description =: 'Snacks' then food_category = 21;		* crackers and salty snacks from grain products;
	if sr_description =: 'Soup' then food_category = 34;		* soups;

	if ingr_num in (1,39,272,325) then food_category = 31;		* solid fats;
	if ingr_num in (17,163) then food_category = 10;			* breads from refined grains;
	if ingr_num in (48,85,134,330,341) then food_category = 33;	* sauces;
	if ingr_num in (55:57) then food_category = 3;				* cheese;
	if ingr_num in (84,264,346,347) then food_category = 16;	* protein-based patties and loaves;
	if ingr_num in (322,323,360) then food_category = 6;		* meat;
	if ingr_num in (351) then food_category = 8;				* eggs;
	if ingr_num in (340) then food_category = 13;				* pancakes, waffles, french toast, other grain products;

	if ingr_num in (51,58,79,106:113,122,123,127,160,301) then food_category = 18;	* tortilla-based mixed dishes;
	if ingr_num in (59,102,152,153,308,329) then food_category = 19;					* mayonnaise-based salads;
	if ingr_num in (60,132,250,255,289,290,318,319,326,338) then food_category = 14;	* savory pies and pastries;
	if ingr_num in (119:121,125) then food_category = 15;						* meat sandwiches;
	if ingr_num in (124,249,258,359) then food_category = 4;					* poultry;
	if ingr_num in (230,274) then food_category = 7;							* cured meat;
	if ingr_num in (142) then food_category = 24;								* fruit juices;
	if ingr_num in (154,157,187,324,352,357,362) then food_category = 20;		* pastas, cooked cereals, rice;
	if ingr_num in (161,186) then food_category = 28;							* dark green vegetables;
	if ingr_num in (162,271,315,343) then food_category = 30;					* other vegetables;
	if ingr_num in (173,188,257,302,321) then food_category = 10;				* legumes, nuts and seeds;
	if ingr_num in (256,259,344,345,369) then food_category = 17;				* pasta-based mixed dishes;
	if ingr_num in (314,378) then food_category = 32;							* oils;
	if ingr_num in (358) then food_category = 33;								* sauces and salad dressings;
	if ingr_num in (364,367) then food_category = 34;							* soups;
run;
/*
*check they all have a category;
proc freq data = how_many_ingr2;
	table food_category;
run;
proc print data = how_many_ingr2;
	where food_category = .;
run;
*/

/*
	if ingr_num in () then food_category = 1;		* milk and milk drinks;
	if ingr_num in () then food_category = 2;		* milk desserts;
	if ingr_num in () then food_category = 3;		* cheese;
	if ingr_num in () then food_category = 4;		* poultry;
	if ingr_num in () then food_category = 5;		* fish and shellfish;
	if ingr_num in () then food_category = 6;		* meat;
	if ingr_num in () then food_category = 7;		* cured meat and organ meat;
	if ingr_num in () then food_category = 8;		* eggs;
	if ingr_num in () then food_category = 9;		* legumes, nuts and seeds;
	if ingr_num in () then food_category = 10;		* breads from refined grains;

	if ingr_num in () then food_category = 11;		* whole grain breads;
	if ingr_num in () then food_category = 12;		* cakes, cookies, pies, pastries, bars;
	if ingr_num in () then food_category = 13;		* pancakes, waffles, french toast, other grain products;
	if ingr_num in () then food_category = 14;		* savory pies and pastries;
	if ingr_num in () then food_category = 15;		* sandwiches;
	if ingr_num in () then food_category = 16;		* protein-based patties and loaves;
	if ingr_num in () then food_category = 17;		* pasta-based mixed dishes;
	if ingr_num in () then food_category = 18;		* tortilla-based mixed dishes;
	if ingr_num in () then food_category = 19;		* mayonnaise-based salads;
	if ingr_num in () then food_category = 20;		* pastas, cooked cereals, rice;

	if ingr_num in () then food_category = 21;		* crackers and salty snacks from grain products;
	*if ingr_num in () then food_category = 22;		* breakfast cereals, higher sugar;
	*if ingr_num in () then food_category = 23;		* breakfast cereals, lower sugar;
	if ingr_num in () then food_category = 24;		* fruit juices;
	if ingr_num in () then food_category = 25;		* whole fruits;
	if ingr_num in () then food_category = 26;		* white potatoes and starchy vegetables;
	if ingr_num in () then food_category = 27;		* white potatoes, fried, chips and sticks;
	if ingr_num in () then food_category = 28;		* dark green vegetables;
	if ingr_num in () then food_category = 29;		* red and orange vegetables;
	if ingr_num in () then food_category = 30;		* other vegetables;

	if ingr_num in (1) then food_category = 31;		* solid fats;
	if ingr_num in () then food_category = 32;		* oils;
	if ingr_num in () then food_category = 33;		* sauces and salad dressings;
	if ingr_num in () then food_category = 34;		* soups;
	if ingr_num in () then food_category = 35;		* sugars and sweets;
	if ingr_num in () then food_category = 36;		* coffee and tea;
	if ingr_num in () then food_category = 37;		* soft drinks and sugar-sweetened drinks;
	if ingr_num in () then food_category = 38;		* alcoholic drinks;
	if ingr_num in () then food_category = 39;		* water, noncarbonated;
	if ingr_num in () then food_category = 40;		* nutrition beverages, energy drinks;
*/


********************************************************************************
1.3. Replace food description with ingredient description
********************************************************************************;

*merge ingredients with food categories with infitems_mixed_w_proportions1;
data how_many_ingr3; set how_many_ingr2;
	drop _FREQ_ ingr_num;
run;
proc sort data= how_many_ingr3; by sr_description;
proc sort data= infitems_mixed_w_proportions1; by sr_description;

data mixed_dish_final;
	merge infitems_mixed_w_proportions1 (in =a) how_many_ingr3;
	by sr_description;
	if a;
run;


*replace food description with ingredient description;
data mixed_dish_final; set mixed_dish_final;
	if sr_description ne "" then food_description_new = sr_description;
	rename  food_description_new = food_description;
run;
data mixed_dish_final; set mixed_dish_final;
	drop sr_description;
run;
proc sort data = mixed_dish_final; by patid pregpost visit recallno occ_no occ_name foodnum foodcode food_category num_ingr seq_num food_description foodamt;
run;
proc contents data = mixed_dish_final;
run;
