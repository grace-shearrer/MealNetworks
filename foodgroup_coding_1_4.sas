********************************************************************************
* Project: 		Meal patterns and BMI/weight - PEAS.
* Program: 		foodgroup_coding_1_4
* Author: 		Carolina Schwedhelm
* Created: 		08/1/2019
* Last Changes: 08/30/2019, by Carolina Schwedhelm
* Origin: 		self made
* Category: 	creation of dataset
* Program before: 	macros_for_foodgroup_coding_1_1
					foodgroup_coding_1_1
					foodgroup_coding_1_2
					foodgroup_coding_1_3
* Short descr.: 1.1. Create variable for proportion of total dish weight for each new ingredient 
				1.2. Reconnect this data with PEAS diet recalls data
				1.3. Replace food amount (g) with weight corresponding to ingredient (g): FoodAmt_new = FoodAmt* prop_weight


*******************************************************************************;

*********************************************************************************
run programs	macros_for_foodgroup_coding_1_1.sas
				foodgroup_coding_1_1.sas
				foodgroup_coding_1_2.sas
				foodgroup_coding_1_3.sas
before			(directory: 'N:\DIPHRHBB\Staff Subdirectories\Carolina Schwedhelm\SAS programs\foodgroup_coding_1_1.sas')
********************************************************************************;


********************************************************************************
start with		data = by_ingredient_final		(1199 ingredients*foodcodes)
				variables in dataset = 			foodcode
												food_description
												num_ingr (total number of ingredients in mixed dish)
												seq_num (sequence number of ingredient in mixed dish)
												sr_description (ingredient description)
												weight (ingredient weight for calculating proportion later)
												sum_weight (total weight of mixed dish for calculating proportion later)

********************************************************************************;


********************************************************************************
1.1. Create variable for proportion of total dish weight for each new ingredient 
********************************************************************************;

*convert weight of ingredients into proportions;
data mixed_dish_prop;
	set by_ingredient_final;
		prop_weight = weight / sum_weight;
run;

/*
*check example;
proc print data = mixed_dish_prop;
	where FoodCode = 58106505;
run;

*check that all prop_weights add up to 1;
proc means data=mixed_dish_prop noprint;
	class foodcode;
	ways 1;
	var prop_weight;
	output out=test1 sum=;
run;
proc print data=test1;
	where prop_weight ne 1.00;
run;
*/

*	drop weight and sum weight (we are just interested in proportion)
	and re-name food_description in mixed_dish_prop to keep clear overview of changes in names;
data mixed_dish_prop;
	set mixed_dish_prop;
		rename food_description = food_description_new;
		drop weight sum_weight;
run;



********************************************************************************
1.2. Reconnect this data with PEAS diet recalls data
********************************************************************************;
/*
* check codes in infitems_mixed_dishes that were changed on mixed_dish_prop;
proc means data= infitems_mixed_dishes1 noprint;
	where foodcode in 	(27250040,272500401,272500402,27250070,272500701,58100320,581003201,58145110,581451101,581451102,
						58145114,581451141,581451142,58145170,581451701,58147310,581473101,58147330,581473301,581473302,
						581473303,58163380,581633801,581633802,58163410,581634101,581634102,32103000,321030001,32105010,
						321050101,32105050,321050501,32105080,321050801,32105122,321051221,32105130,321051301,321051302,
							
						27146350,27343470,27420500,27446200,27450060,27450090,58100110,58100220,58106225,58106550,
						58106555,58106610,58106625,58132310,32105000);
	class foodcode food_description;
	ways 2;
	var foodamt;
	output out=test2 sum=;
run;
proc print data= test2;
run;
*/

* before merging, re-assign foodcodes in infitems_mixed_dishes that were changed on mixed_dish_prop;
data infitems_mixed_dishes1; set infitems_mixed_dishes;
	if foodcode in (27146050) and food_description = "Chicken wing with hot pepper sauce W/O FAT" then foodcode = 271460501;
	if foodcode = 27146350 then food_description = "Lemon chicken, Chinese style";
	if foodcode = 27243000 and food_description = "Chicken or turkey and rice, no sauce (mixture) W/ BUTTER, NFS" then foodcode = 272430001;
	if foodcode = 27243000 and food_description = "Chicken or turkey and rice, no sauce (mixture) W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)" then foodcode = 272430002;
	if foodcode = 27243500 and food_description = "Chicken or turkey and rice with tomato-based sauce (mixture) W/ VEGETABLE OIL, NFS (OIL, NFS)" then foodcode = 272435001;
	if foodcode = 27246100 and food_description = "Chicken or turkey with dumplings (mixture) W/O FAT" then foodcode = 272461001;
	if foodcode in (27250040) and food_description = "Crab cake W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)" then foodcode = 272500401;
	if foodcode in (27250040) and food_description = "Crab cake W/O FAT" then foodcode = 272500402;
	if foodcode in (27250070) and food_description = "Salmon cake or patty W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)" then foodcode = 272500701;
	if foodcode = 27343470 then food_description = 
"Chicken or turkey, noodles, and vegetables (including carrots, broccoli, and/or dark-green leafy), cream sauce, white sauce, or mushroom soup-based sauce (mixture)";
	if foodcode = 27420500 then food_description = 
"Pork and vegetables (including carrots, broccoli, and/or dark-green leafy), soy-based sauce (mixture)";
	if foodcode = 27446200 then food_description = "Chicken or turkey salad, made with mayonnaise";
	if foodcode in (27450060) and food_description = "Tuna salad W/O SALAD DRESSING" then foodcode = 274500601;
	if foodcode in (27450060) then food_description = "Tuna salad, made with mayonnaise";
	if foodcode = 27450090 then food_description = "Tuna salad with cheese, made with mayonnaise";

	if foodcode = 32103000 and food_description = "Egg salad W/ LOW CALORIE OR DIET MAYONNAISE (INCLUDE HELLMAN'S LIGHT... )" then foodcoe = 321030001;
	if foodcode = 32103000 and food_description = "Egg salad" then food_description = "Egg salad, made with mayonnaise";
	if foodcode = 32105000 and food_description = "Egg omelet or scrambled egg, fat added in cooking W/ ANIMAL FAT OR MEAT DRIPPINGS" then foodcode = 321050001;
	if foodcode = 32105000 and food_description = "Egg omelet or scrambled egg, fat added in cooking W/ BUTTER, NFS" then foodcode = 321050002;
	if foodcode = 32105000 and food_description = "Egg omelet or scrambled egg, fat added in cooking W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)" then foodcode = 321050003;
	if foodcode = 32105010 and food_description = "Egg omelet or scrambled egg, with cheese W/ BUTTER, NFS" then foodcode = 321050102;
	if foodcode = 32105010 and food_description = "Egg omelet or scrambled egg, with cheese W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)" then foodcode = 321050103;
	if foodcode = 32105010 and food_description = "Egg omelet or scrambled egg, with cheese W/O FAT OR W/ NONSTICK SPRAY (INCLUDE PAM...)" then foodcode = 321050101;
	if foodcode = 32105050 and food_description = "Egg omelet or scrambled egg, with vegetables other than dark-green vegetables W/O FAT OR W/ NONSTICK SPRAY (INCLUDE PAM...)"
 then foodcode = 321050501;
	if foodcode = 32105122 and food_description = "Egg omelet or scrambled egg, with sausage W/O FAT OR W/ NONSTICK SPRAY (INCLUDE PAM...)" then foodcode = 321051221;
	if foodcode = 32105080 and food_description = "Egg omelet or scrambled egg, with cheese and ham or bacon W/O FAT OR W/ NONSTICK SPRAY (INCLUDE PAM...)" then foodcode = 321050801;
	if foodcode = 32105130 and food_description = "Egg omelet or scrambled egg, Spanish omelet, made with onions, peppers, tomatoes, and mushrooms" then foodcode = 321051302;
	if foodcode = 32105130 and food_description = "Egg omelet or scrambled egg, with onions, peppers, tomatoes, and mushrooms W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)" 
then foodcode = 321051301;

	if foodcode = 58100220 then food_description = "Burrito with chicken, beans, and cheese";
	if foodcode in (58100320) and food_description = "Burrito with beans, meatless" then foodcode = 581003201;
	if foodcode = 58106225 then food_description = "Pizza, cheese, regular crust";
	if foodcode = 58106550 then food_description = "Pizza with pepperoni, thin crust";
	if foodcode = 58106555 then food_description = "Pizza with pepperoni, regular crust";
	if foodcode = 58106610 then food_description = "Pizza with meat other than pepperoni, NS as to type of crust";
	if foodcode in (58106625) then food_description = "Pizza with meat other than pepperoni, regular crust";
	if foodcode in (58132110) and food_description = "Spaghetti with tomato sauce, meatless W/O FAT" then foodcode = 581321101;
	if foodcode in (58132310) and food_description = "Pasta with tomato sauce and meat or meatballs, canned" then foodcode = 58132313;
	if foodcode in (58132310) and food_description = "Spaghetti with tomato sauce and meatballs or spaghetti with meat sauce or spaghetti with meat sauce  and meatballs W/O FAT"
then foodcode = 581323101;
	if foodcode = 58132360 and food_description = 
"Spaghetti with tomato sauce and meatballs, whole wheat noodles or spaghetti with meat sauce, whole wheat noodles or spaghetti with meat sauce and meatballs, whole wheat noodles W/O FAT"
 then foodcode = 581323601;
	if foodcode = 58132910 and food_description = "Spaghetti with tomato sauce and poultry, W/O FAT" then foodcode = 581329101;
	if foodcode = 58148180 and food_description = "Macaroni or pasta salad with cheese W/ ITALIAN DRESSING" then foodcode = 581481801;
	if foodcode in (58145110) and food_description = "Macaroni or noodles with cheese W/ BUTTER, NFS" then foodcode = 581451101;
	if foodcode in (58145110) and food_description = "Macaroni or noodles with cheese W/O FAT" then foodcode = 581451102;
	if foodcode in (58145114) and food_description = "Macaroni or noodles with cheese, made from dry mix W/ BUTTER, NFS" then foodcode = 581451141;
	if foodcode in (58145114) and food_description = "Macaroni or noodles with cheese, made from dry mix W/O FAT" then foodcode = 581451142;
	if foodcode in (58145170) and food_description = "Macaroni and cheese with egg W/O FAT" then foodcode = 581451701;
	if foodcode in (58147310) and food_description = "Macaroni, creamed W/O FAT" then foodcode = 581473101;
	if foodcode in (58147330) and food_description = "Macaroni, creamed, with cheese W/ BUTTER, NFS" then foodcode = 581473301;
	if foodcode in (58147330) and food_description = "Macaroni, creamed, with cheese W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)" then foodcode = 581473302;
	if foodcode in (58147330) and food_description = "Macaroni, creamed, with cheese W/O FAT" then foodcode = 581473303;
	if foodcode in (58147330) then food_description = "Macaroni, creamed, with cheese";

	if foodcode = 58160110 and food_description = "Rice with beans W/ BUTTER, NFS" then foodcode = 581601101;
	if foodcode = 58160110 and food_description = "Rice with beans W/O FAT" then foodcode = 581601102;
	if foodcode = 58160120 and food_description = "Rice with beans and tomatoes W/O FAT" then foodcode = 581601201;
	if foodcode = 58160130 and food_description = "Rice with beans and chicken W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)" then foodcode = 581601301;
	if foodcode = 58160130 and food_description = "Rice with beans and chicken W/O FAT" then foodcode = 581601302;
	if foodcode = 58163130 and food_description = "Dirty rice W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)" then foodcode = 581631301;
	if foodcode in (58163380) and food_description = "Flavored rice and pasta mixture W/ BUTTER, NFS" then foodcode = 581633801;
	if foodcode in (58163380) and food_description = "Flavored rice and pasta mixture W/ VEGETABLE OIL, NFS (INCLUDE OIL, NFS)" then foodcode = 581633802;
	if foodcode in (58163410) and food_description = "Spanish rice W/ BUTTER, NFS" then foodcode = 581634101;
	if foodcode in (58163410) and food_description = "Spanish rice W/O FAT" then foodcode = 581634102;
	if foodcode in (58163410) then food_description = "Spanish rice";
	if foodcode = 74506000 and food_description = 
"Tomato and cucumber salad made with tomato, cucumber, oil, and vinegar W/ ITALIAN DRESSING, LOW CALORIE (INCLUDE WISHBONE LITE DIJON VINAIGRETTE, MCDONALD'S LITE VINAIGRETTE)"
 then foodcode = 745060001;
run;


********************************************************************************
Prepare mixed_dish_prop to merge with participant info data (infitems_mixed_dishes1)
1. make seq_num with proportion weights wide
2. merge with infitems
3. transpose (make long again)
4. add ingredient names and updated food descriptions
5. 
********************************************************************************;
/*
*check maximum number of ingredients in dishes;
proc freq data = mixed_dish_prop;							* 11 ingredients is maximum;
	table num_ingr;
run;
*/
/*
proc print data = mixed_dish_prop;
	where num_ingr = 2;
run;
*/

*1. make seq_num with proportion weights wide;
data mixed_dish_prop_wide;
	set mixed_dish_prop;
		if seq_num = 1 then seq_num1 = prop_weight;
		if seq_num = 2 then seq_num2 = prop_weight;
		if seq_num = 3 then seq_num3 = prop_weight;
		if seq_num = 4 then seq_num4 = prop_weight;
		if seq_num = 5 then seq_num5 = prop_weight;

		if seq_num = 6 then seq_num6 = prop_weight;
		if seq_num = 7 then seq_num7 = prop_weight;
		if seq_num = 8 then seq_num8 = prop_weight;
		if seq_num = 9 then seq_num9 = prop_weight;
		if seq_num = 10 then seq_num10 = prop_weight;

		if seq_num = 11 then seq_num11 = prop_weight;
run;
*collapse by food code;
proc means data = mixed_dish_prop_wide noprint;
	class foodcode num_ingr;
	ways 2;
	var seq_num1--seq_num11;
	output out=mixed_dish_prop_wide1 sum=;
run;

*2. merge with infitems;
proc sort data = infitems_mixed_dishes; by foodcode;
proc sort data = mixed_dish_prop_wide1; by foodcode;

data infitems_mixed_dishes_merged; 
	merge infitems_mixed_dishes (in=a) mixed_dish_prop_wide1;	
	by foodcode;													* in=a because all dishes in infitems_mixed_dishes are already the ones we worked on in mixed_dish_prop;
	if a;															* in=a so we have long - by ingredient information (not by dish);
	drop foodcode_fndds fndds_desc _TYPE_ _FREQ_;
run;


* 3. transpose (make long again)
make long to include new observation for ingredients (and updated food description - food_description_new;
proc sort data = infitems_mixed_dishes_merged; by patid visit recallno occ_no occ_name foodcode foodnum foodamt food_description pregpost num_ingr; 

proc transpose data= infitems_mixed_dishes_merged out = long1;
	by patid visit recallno occ_no occ_name foodcode foodnum foodamt food_description pregpost num_ingr;
	var seq_num1-seq_num11;
run;
*delete where seq_num = 0;
data long2;
	set long1;
	rename COL1 = prop_weight;
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
run;												* done! there are 5136 observations (ingredients/food components from mixed dishes);


* 4. add ingredient names and updated food descriptions;
proc sort data=long2; by foodcode seq_num;
proc sort data=mixed_dish_prop; by foodcode seq_num;

data infitems_mixed_w_proportions;
	merge long2 (in=a) mixed_dish_prop;
	by foodcode seq_num;
	if a;
	drop food_description;
run;

proc sort data=infitems_mixed_w_proportions; by patid visit recallno occ_no occ_name foodnum foodcode seq_num;
run; 		
/*
*check if there are any missing names for food or ingredient;
proc print data = infitems_mixed_w_proportions;
	where sr_description = "";
run;
*/


********************************************************************************
1.3. Replace food amount (g) with weight corresponding to ingredient (g): FoodAmt_new = FoodAmt* prop_weight
********************************************************************************;

data infitems_mixed_w_proportions; set infitems_mixed_w_proportions;
	foodamt_new = foodamt*prop_weight;
run;
data infitems_mixed_w_proportions1; set infitems_mixed_w_proportions;
	drop foodamt prop_weight;
	foodamt_new = round(foodamt_new,0.01);
run;
data infitems_mixed_w_proportions1; set infitems_mixed_w_proportions1;
	rename foodamt_new = foodamt;
run;
