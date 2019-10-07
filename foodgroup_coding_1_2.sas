********************************************************************************
* Project: 		Meal patterns and BMI/weight - PEAS.
* Program: 		foodgroup_coding_1_2
* Author: 		Carolina Schwedhelm
* Created: 		08/1/2019
* Last Changes: 08/30/2019, by Carolina Schwedhelm and Grace Betts
* Origin: 		self made
* Category: 	creation of dataset
* Program before: 	1. macros_for_foodgroup_coding_1_1
					2. foodgroup_coding_1_1
* Short descr.: Reaggregate ingredients that belong together (e.g. sauces). Food groups for mixed dishes with code < 50000000
*******************************************************************************;

*********************************************************************************
run programs	1. macros_for_foodgroup_coding_1_1.sas
				2. foodgroup_coding_1_1
before			(directory: 'N:\DIPHRHBB\Staff Subdirectories\Carolina Schwedhelm\SAS programs\foodgroup_coding_1_1.sas')
********************************************************************************;

********************************************************************************
start with		data = by_ingredient		(2687 ingredients*foodcodes)
				variables in dataset = 		foodcode
											food_description
											num_ingr (total number of ingredients in mixed dish)
											seq_num (sequence number of ingredient in mixed dish)
											sr_code (ingredient code)
											sr_description (ingredient description)
											weight (ingredient weight for calculating proportion later)
											sum_weight (total weight of mixed dish for calculating proportion later)
********************************************************************************;

********************************************************************************
Reaggregating ingredients for food codes 27100000 to < 50000000 
********************************************************************************;
*make changes in by_ingredient_1;
data by_ingredient_1; set by_ingredient;
run;

%macro reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
data by_ingredient_1; set by_ingredient_1;
	if foodcode = &foodcode and seq_num = &seq_num_before then seq_num = &seq_num_after;
	if foodcode = &foodcode and seq_num = &seq_num_after then sr_description = &sr_description_after;
run;
%mend reaggreg_ingr;

%macro new_num_ingr(FoodCode,num_ingr_new);
data by_ingredient_1; set by_ingredient_1;
	if foodcode = &foodcode then num_ingr = &num_ingr_new;
run;
%mend new_num_ingr;


*FoodCode 27111050 example;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(27111050,1,1,"spaghetti sauce");									* putting ingredients 1-10 into a sauce ingredient;
%reaggreg_ingr(27111050,2,2,sr_description);
%reaggreg_ingr(27111050,3,1,"spaghetti sauce");
%reaggreg_ingr(27111050,4,1,"spaghetti sauce");
%reaggreg_ingr(27111050,5,1,"spaghetti sauce");
%reaggreg_ingr(27111050,6,3,sr_description);
%reaggreg_ingr(27111050,7,1,"spaghetti sauce");
%reaggreg_ingr(27111050,8,1,"spaghetti sauce");
%reaggreg_ingr(27111050,9,1,"spaghetti sauce");
%reaggreg_ingr(27111050,10,1,"spaghetti sauce");
%reaggreg_ingr(27111050,11,1,"spaghetti sauce");									* ingredient 2 becomes the meat. Description stays same;
%new_num_ingr(27111050,3);														* now total ingredients is 2;

*proc print data = by_ingredient_1;
*	where foodcode = 27111050;
*run;

%reaggreg_ingr(27111410,1,1,"chili");
%reaggreg_ingr(27111410,2,2,sr_description);
%reaggreg_ingr(27111410,3,3,sr_description);
%reaggreg_ingr(27111410,4,1,"chili");
%reaggreg_ingr(27111410,5,1,"chili");
%reaggreg_ingr(27111410,6,1,"chili");
%reaggreg_ingr(27111410,7,1,"chili");
%reaggreg_ingr(27111410,8,1,"chili");
%new_num_ingr(27111410,3);
run;

%reaggreg_ingr(27111420,1,1,"chili");
%reaggreg_ingr(27111420,2,2,sr_description);
%reaggreg_ingr(27111420,3,1,"chili");
%reaggreg_ingr(27111420,4,1,"chili");
%reaggreg_ingr(27111420,5,1,"chili");
%reaggreg_ingr(27111420,6,1,"chili");
%reaggreg_ingr(27111420,7,1,"chili");
%new_num_ingr(27111420,2);
run;

%reaggreg_ingr(27111440,1,1,"chili");
%reaggreg_ingr(27111440,2,2,sr_description);
%reaggreg_ingr(27111440,3,3,sr_description);
%reaggreg_ingr(27111440,4,1,"chili");
%reaggreg_ingr(27111440,5,4,sr_description);
%reaggreg_ingr(27111440,6,1,"chili");
%reaggreg_ingr(27111440,7,1,"chili");
%reaggreg_ingr(27111440,8,1,"chili");
%reaggreg_ingr(27111440,9,1,"chili");
%new_num_ingr(27111440,4);
run;

%reaggreg_ingr(27111500,1,1,sr_description);
%reaggreg_ingr(27111500,2,2,"sloppy joe sauce");
%reaggreg_ingr(27111500,3,2,"sloppy joe sauce");
%reaggreg_ingr(27111500,4,2,"sloppy joe sauce");
%reaggreg_ingr(27111500,5,2,"sloppy joe sauce");
%reaggreg_ingr(27111500,6,2,"sloppy joe sauce");
%reaggreg_ingr(27111500,7,2,"sloppy joe sauce");
%reaggreg_ingr(27111500,8,2,"sloppy joe sauce");
%reaggreg_ingr(27111500,9,2,"sloppy joe sauce");
%reaggreg_ingr(27111500,10,2,"sloppy joe sauce");
%reaggreg_ingr(27111500,11,2,"sloppy joe sauce");
%new_num_ingr(27111500,2);
run;

%reaggreg_ingr(27112010,1,1,"gravy");
%reaggreg_ingr(27112010,2,2,sr_description);
%reaggreg_ingr(27112010,3,1,"gravy");
%reaggreg_ingr(27112010,4,1,"gravy");
%reaggreg_ingr(27112010,5,1,"gravy");
%reaggreg_ingr(27112010,6,1,"gravy");
%reaggreg_ingr(27112010,7,1,"gravy");
%reaggreg_ingr(27112010,8,1,"gravy");
%reaggreg_ingr(27112010,9,1,"gravy");
%reaggreg_ingr(27112010,10,1,"gravy");
%new_num_ingr(27112010,2);
run;

%reaggreg_ingr(27113300,1,1,sr_description);
%reaggreg_ingr(27113300,2,2,"white sauce");
%reaggreg_ingr(27113300,3,2,"white sauce");
%reaggreg_ingr(27113300,4,3,sr_description);
%reaggreg_ingr(27113300,5,2,"white sauce");
%reaggreg_ingr(27113300,6,2,"white sauce");
%reaggreg_ingr(27113300,7,2,"white sauce");
%reaggreg_ingr(27113300,8,2,"white sauce");
%reaggreg_ingr(27113300,9,2,"white sauce");
%reaggreg_ingr(27113300,10,2,"white sauce");
%reaggreg_ingr(27113300,11,2,"white sauce");
%reaggreg_ingr(27113300,12,2,"white sauce");
%reaggreg_ingr(27113300,13,2,"white sauce");
%reaggreg_ingr(27113300,14,2,"white sauce");
%reaggreg_ingr(27113300,15,2,"white sauce");
%new_num_ingr(27113300,3);
run;

%reaggreg_ingr(27115100,1,1,sr_description);
%reaggreg_ingr(27115100,2,2,"teriyaki sauce");
%reaggreg_ingr(27115100,3,2,"teriyaki sauce");
%reaggreg_ingr(27115100,4,2,"teriyaki sauce");
%reaggreg_ingr(27115100,5,3,sr_description);
%reaggreg_ingr(27115100,6,2,"teriyaki sauce");
%reaggreg_ingr(27115100,7,2,"teriyaki sauce");
%new_num_ingr(27115100,3);
run;

%reaggreg_ingr(27116100,1,1,sr_description);
%reaggreg_ingr(27116100,2,2,"curry sauce");
%reaggreg_ingr(27116100,3,2,"curry sauce");
%reaggreg_ingr(27116100,4,2,"curry sauce");
%reaggreg_ingr(27116100,5,2,"curry sauce");
%reaggreg_ingr(27116100,6,2,"curry sauce");
%reaggreg_ingr(27116100,7,2,"curry sauce");
%reaggreg_ingr(27116100,8,2,"curry sauce");
%reaggreg_ingr(27116100,9,2,"curry sauce");
%reaggreg_ingr(27116100,10,2,"curry sauce");
%new_num_ingr(27116100,2);
run;

%reaggreg_ingr(27120060,1,1,"sweet and sour sauce");
%reaggreg_ingr(27120060,2,1,"sweet and sour sauce");
%reaggreg_ingr(27120060,3,2,sr_description);
%reaggreg_ingr(27120060,4,1,"sweet and sour sauce");
%reaggreg_ingr(27120060,5,1,"sweet and sour sauce");
%reaggreg_ingr(27120060,6,1,"sweet and sour sauce");
%reaggreg_ingr(27120060,7,1,"sweet and sour sauce");
%reaggreg_ingr(27120060,8,1,"sweet and sour sauce");
%reaggreg_ingr(27120060,9,1,"sweet and sour sauce");
%reaggreg_ingr(27120060,10,3,sr_description);
%reaggreg_ingr(27120060,11,1,"sweet and sour sauce");
%reaggreg_ingr(27120060,12,1,"sweet and sour sauce");
%reaggreg_ingr(27120060,13,1,"sweet and sour sauce");
%reaggreg_ingr(27120060,14,1,"sweet and sour sauce");
%reaggreg_ingr(27120060,15,1,"sweet and sour sauce");
%reaggreg_ingr(27120060,16,1,"sweet and sour sauce");
%reaggreg_ingr(27120060,17,1,"sweet and sour sauce");
%new_num_ingr(27120060,3);
run;

%reaggreg_ingr(27120120,1,1,"gravy");
%reaggreg_ingr(27120120,2,2,sr_description);
%reaggreg_ingr(27120120,3,3,sr_description);
%reaggreg_ingr(27120120,4,1,"gravy");
%reaggreg_ingr(27120120,5,1,"gravy");
%new_num_ingr(27120120,3);
run;

%reaggreg_ingr(27121410,1,1,"chili");
%reaggreg_ingr(27121410,2,2,sr_description);
%reaggreg_ingr(27121410,3,3,sr_description);
%reaggreg_ingr(27121410,4,1,"chili");
%reaggreg_ingr(27121410,5,1,"chili");
%reaggreg_ingr(27121410,6,1,"chili");
%reaggreg_ingr(27121410,7,1,"chili");
%reaggreg_ingr(27121410,8,1,"chili");
%new_num_ingr(27121410,3);
run;

%reaggreg_ingr(27141500,1,1,"chili");
%reaggreg_ingr(27141500,2,2,sr_description);
%reaggreg_ingr(27141500,3,3,sr_description);
%reaggreg_ingr(27141500,4,1,"chili");
%reaggreg_ingr(27141500,5,1,"chili");
%reaggreg_ingr(27141500,6,1,"chili");
%reaggreg_ingr(27141500,7,1,"chili");
%reaggreg_ingr(27141500,8,1,"chili");
%new_num_ingr(27141500,3);
run;

%reaggreg_ingr(27143000,1,1,"cream sauce");
%reaggreg_ingr(27143000,2,2,sr_description);
%reaggreg_ingr(27143000,3,3,sr_description);
%reaggreg_ingr(27143000,4,1,"cream sauce");
%reaggreg_ingr(27143000,5,1,"cream sauce");
%reaggreg_ingr(27143000,6,1,"cream sauce");
%new_num_ingr(27143000,3);
run;

%reaggreg_ingr(27144000,1,1,sr_description);
%reaggreg_ingr(27144000,2,2,"soup");
%reaggreg_ingr(27144000,3,2,"soup");
%new_num_ingr(27144000,2);
run;

%reaggreg_ingr(27145000,1,1,sr_description);
%reaggreg_ingr(27145000,2,2,"teriyaki sauce");
%reaggreg_ingr(27145000,3,2,"teriyaki sauce");
%reaggreg_ingr(27145000,4,2,"teriyaki sauce");
%reaggreg_ingr(27145000,5,2,"teriyaki sauce");
%reaggreg_ingr(27145000,6,2,"teriyaki sauce");
%reaggreg_ingr(27145000,7,2,"teriyaki sauce");
%new_num_ingr(27145000,2);
run;

%reaggreg_ingr(27146050,1,1,sr_description);
%reaggreg_ingr(27146050,2,2,sr_description);
%reaggreg_ingr(27146050,3,3,"hot pepper sauce");
%reaggreg_ingr(27146050,4,3,"hot pepper sauce");
%reaggreg_ingr(27146050,5,3,"hot pepper sauce");
%new_num_ingr(27146050,3);
run;

%reaggreg_ingr(27146100,1,1,"sweet and sour sauce");
%reaggreg_ingr(27146100,2,1,"sweet and sour sauce");
%reaggreg_ingr(27146100,3,2,sr_description);
%reaggreg_ingr(27146100,4,1,"sweet and sour sauce");
%reaggreg_ingr(27146100,5,1,"sweet and sour sauce");
%reaggreg_ingr(27146100,6,1,"sweet and sour sauce");
%reaggreg_ingr(27146100,7,1,"sweet and sour sauce");
%reaggreg_ingr(27146100,8,1,"sweet and sour sauce");
%reaggreg_ingr(27146100,9,3,sr_description);
%reaggreg_ingr(27146100,10,1,"sweet and sour sauce");
%reaggreg_ingr(27146100,11,1,"sweet and sour sauce");
%reaggreg_ingr(27146100,12,1,"sweet and sour sauce");
%reaggreg_ingr(27146100,13,1,"sweet and sour sauce");
%reaggreg_ingr(27146100,14,1,"sweet and sour sauce");
%reaggreg_ingr(27146100,15,1,"sweet and sour sauce");
%reaggreg_ingr(27146100,16,1,"sweet and sour sauce");
%new_num_ingr(27146100,3);
run;

%reaggreg_ingr(27146150,1,1,sr_description);
%reaggreg_ingr(27146150,2,2,"curry sauce");
%reaggreg_ingr(27146150,3,2,"curry sauce");
%reaggreg_ingr(27146150,4,3,sr_description);
%reaggreg_ingr(27146150,5,2,"curry sauce");
%reaggreg_ingr(27146150,6,2,"curry sauce");
%reaggreg_ingr(27146150,7,2,"curry sauce");
%reaggreg_ingr(27146150,8,2,"curry sauce");
%reaggreg_ingr(27146150,9,2,"curry sauce");
%new_num_ingr(27146150,3);
run;

%reaggreg_ingr(27146300,1,1,sr_description);
%reaggreg_ingr(27146300,2,2,"tomato sauce");
%reaggreg_ingr(27146300,3,2,"tomato sauce");
%reaggreg_ingr(27146300,4,2,"tomato sauce");
%reaggreg_ingr(27146300,5,2,"tomato sauce");
%reaggreg_ingr(27146300,6,3,sr_description);
%reaggreg_ingr(27146300,7,2,"tomato sauce");
%reaggreg_ingr(27146300,8,2,"tomato sauce");
%reaggreg_ingr(27146300,9,2,"tomato sauce");
%new_num_ingr(27146300,3);
run;

%reaggreg_ingr(27146350,1,1,sr_description);
%reaggreg_ingr(27146350,2,2,"chinese lemon sauce");
%reaggreg_ingr(27146350,3,2,"chinese lemon sauce");
%reaggreg_ingr(27146350,4,2,"chinese lemon sauce");
%reaggreg_ingr(27146350,5,2,"chinese lemon sauce");
%reaggreg_ingr(27146350,6,2,"chinese lemon sauce");
%reaggreg_ingr(27146350,7,3,sr_description);
%reaggreg_ingr(27146350,8,2,"chinese lemon sauce");
%reaggreg_ingr(27146350,9,2,"chinese lemon sauce");
%reaggreg_ingr(27146350,10,2,"chinese lemon sauce");
%new_num_ingr(27146350,3);
run;

%reaggreg_ingr(27150110,1,1,sr_description);
%reaggreg_ingr(27150110,2,2,"cocktail sauce");
%reaggreg_ingr(27150110,3,2,"cocktail sauce");
%reaggreg_ingr(27150110,4,2,"cocktail sauce");
%reaggreg_ingr(27150110,5,2,"cocktail sauce");
%reaggreg_ingr(27150110,6,2,"cocktail sauce");
%new_num_ingr(27150110,2);
run;

%reaggreg_ingr(27150410,1,1,sr_description);
%reaggreg_ingr(27150410,2,2,"soy-based sauce");
%reaggreg_ingr(27150410,3,2,"soy-based sauce");
%reaggreg_ingr(27150410,4,2,"soy-based sauce");
%reaggreg_ingr(27150410,5,2,"soy-based sauce");
%reaggreg_ingr(27150410,6,2,"soy-based sauce");
%reaggreg_ingr(27150410,7,2,"soy-based sauce");
%new_num_ingr(27150410,2);
run;

*/%reaggreg_ingr(27160100,1,1,food_description);
*/%reaggreg_ingr(27160100,2,1,food_description);
*/%reaggreg_ingr(27160100,3,1,food_description);
*/%reaggreg_ingr(27160100,4,1,food_description);
*/%new_num_ingr(27160100,1);
*/run;

%reaggreg_ingr(27211190,1,1,"cream of mushroom sauce");
%reaggreg_ingr(27211190,2,2,sr_description);
%reaggreg_ingr(27211190,3,3,sr_description);
%reaggreg_ingr(27211190,4,1,"cream of mushroom sauce");
%new_num_ingr(27211190,3);
run;

%reaggreg_ingr(27212000,1,1,"Noodles, egg, cooked");
%reaggreg_ingr(27212000,2,2,sr_description);
%reaggreg_ingr(27212000,3,3,sr_description);
%reaggreg_ingr(27212000,4,1,"Noodles, egg, cooked");
%new_num_ingr(27212000,3);
run;

%reaggreg_ingr(27212050,1,1,"mac & cheese");
%reaggreg_ingr(27212050,2,2,sr_description);
%reaggreg_ingr(27212050,3,1,"mac & cheese");
%reaggreg_ingr(27212050,4,1,"mac & cheese");
%reaggreg_ingr(27212050,5,1,"mac & cheese");
%reaggreg_ingr(27212050,6,1,"mac & cheese");
%reaggreg_ingr(27212050,7,1,"mac & cheese");
%reaggreg_ingr(27212050,8,1,"mac & cheese");
%reaggreg_ingr(27212050,9,1,"mac & cheese");
%reaggreg_ingr(27212050,10,1,"mac & cheese");
%reaggreg_ingr(27212050,11,1,"mac & cheese");
%reaggreg_ingr(27212050,12,1,"mac & cheese");
%reaggreg_ingr(27212050,13,1,"mac & cheese");
%reaggreg_ingr(27212050,14,1,"mac & cheese");
%reaggreg_ingr(27212050,15,1,"mac & cheese");
%reaggreg_ingr(27212050,16,1,"mac & cheese");
%new_num_ingr(27212050,2);
run;

%reaggreg_ingr(27212350,1,1,sr_description);
%reaggreg_ingr(27212350,2,2,sr_description);
%reaggreg_ingr(27212350,3,3,"stroganoff sauce");
%reaggreg_ingr(27212350,4,3,"stroganoff sauce");
%reaggreg_ingr(27212350,5,3,"stroganoff sauce");
%reaggreg_ingr(27212350,6,3,"stroganoff sauce");
%reaggreg_ingr(27212350,7,3,"stroganoff sauce");
%reaggreg_ingr(27212350,8,3,"stroganoff sauce");
%reaggreg_ingr(27212350,9,4,sr_description);
%reaggreg_ingr(27212350,10,3,"stroganoff sauce");
%reaggreg_ingr(27212350,11,3,"stroganoff sauce");
%new_num_ingr(27212350,4);
run;

%reaggreg_ingr(27213100,1,1,"tomato sauce");
%reaggreg_ingr(27213100,2,2,sr_description);
%reaggreg_ingr(27213100,3,3,sr_description);
%reaggreg_ingr(27213100,4,1,"tomato sauce");
%reaggreg_ingr(27213100,5,4,sr_description);
%reaggreg_ingr(27213100,6,1,"tomato sauce");
%new_num_ingr(27213100,4);
run;

*/%reaggreg_ingr(27214100,1,1,sr_description);
*/%reaggreg_ingr(27214100,2,2,"meat loaf filling");
*/%reaggreg_ingr(27214100,3,2,"meat loaf filling");
*/%reaggreg_ingr(27214100,4,3,sr_description);
*/%reaggreg_ingr(27214100,5,2,"meat loaf filling");
*/%reaggreg_ingr(27214100,6,2,"meat loaf filling");
*/%reaggreg_ingr(27214100,7,2,"meat loaf filling");
*/%new_num_ingr(27214100,3);
*/run;

*/%reaggreg_ingr(27214110,1,1,sr_description);
*/%reaggreg_ingr(27214110,2,2,"tomato meat loaf filling");
*/%reaggreg_ingr(27214110,3,2,"tomato meat loaf filling");
*/%reaggreg_ingr(27214110,4,2,"tomato meat loaf filling");
*/%reaggreg_ingr(27214110,5,3,sr_description);
*/%reaggreg_ingr(27214110,6,2,"tomato meat loaf filling");
*/%reaggreg_ingr(27214110,7,2,"tomato meat loaf filling");
*/%reaggreg_ingr(27214110,8,2,"tomato meat loaf filling");
*/%new_num_ingr(27214110,3);
*/run;

%reaggreg_ingr(27242000,1,1,"Noodles, egg, cooked");
%reaggreg_ingr(27242000,2,2,sr_description);
%reaggreg_ingr(27242000,3,1,"Noodles, egg, cooked");
%reaggreg_ingr(27242000,4,1,"Noodles, egg, cooked");
%new_num_ingr(27242000,2);
run;

%reaggreg_ingr(27242300,1,1,"cream sauce");
%reaggreg_ingr(27242300,2,2,sr_description);
%reaggreg_ingr(27242300,3,3,sr_description);
%reaggreg_ingr(27242300,4,1,"cream sauce");
%reaggreg_ingr(27242300,5,4,sr_description);
%reaggreg_ingr(27242300,6,1,"cream sauce");
%reaggreg_ingr(27242300,7,1,"cream sauce");
%new_num_ingr(27242300,4);
run;

%reaggreg_ingr(27242310,1,1,"cheese sauce");
%reaggreg_ingr(27242310,2,2,sr_description);
%reaggreg_ingr(27242310,3,3,sr_description);
%reaggreg_ingr(27242310,4,1,"cheese sauce");
%reaggreg_ingr(27242310,5,4,sr_description);
%reaggreg_ingr(27242310,6,1,"cheese sauce");
%new_num_ingr(27242310,4);
run;

%reaggreg_ingr(27242400,1,1,"tomato sauce");
%reaggreg_ingr(27242400,2,2,sr_description);
%reaggreg_ingr(27242400,3,3,sr_description);
%reaggreg_ingr(27242400,4,4,sr_description);
%reaggreg_ingr(27242400,5,1,"tomato sauce");
%reaggreg_ingr(27242400,6,1,"tomato sauce");
%new_num_ingr(27242400,4);
run;

%reaggreg_ingr(27243000,1,1,"rice");
%reaggreg_ingr(27243000,2,2,sr_description);
%reaggreg_ingr(27243000,3,3,sr_description);
%reaggreg_ingr(27243000,4,1,"rice");
%new_num_ingr(27243000,3);
run;

%reaggreg_ingr(27243400,1,1,sr_description);
%reaggreg_ingr(27243400,2,2,"cream of mushroom sauce");
%reaggreg_ingr(27243400,3,2,"cream of mushroom sauce");
%reaggreg_ingr(27243400,4,2,"cream of mushroom sauce");
%reaggreg_ingr(27243400,5,3,sr_description);
%reaggreg_ingr(27243400,6,4,sr_description);
%new_num_ingr(27243400,4);
run;

%reaggreg_ingr(27243500,1,1,"tomato sauce");
%reaggreg_ingr(27243500,2,2,sr_description);
%reaggreg_ingr(27243500,3,3,sr_description);
%reaggreg_ingr(27243500,4,1,"tomato sauce");
%reaggreg_ingr(27243500,5,4,sr_description);
%reaggreg_ingr(27243500,6,1,"tomato sauce");
%new_num_ingr(27243500,4);
run;

%reaggreg_ingr(27246100,1,1,sr_description);
%reaggreg_ingr(27246100,2,2,"dumpling");
%reaggreg_ingr(27246100,3,2,"dumpling");
%reaggreg_ingr(27246100,4,2,"dumpling");
%reaggreg_ingr(27246100,5,2,"dumpling");
%reaggreg_ingr(27246100,6,2,"dumpling");
%reaggreg_ingr(27246100,7,2,"dumpling");
%reaggreg_ingr(27246100,8,2,"dumpling");
%new_num_ingr(27246100,2);
run;

%reaggreg_ingr(27246300,1,1,food_description);
%reaggreg_ingr(27246300,2,1,food_description);
%reaggreg_ingr(27246300,3,1,food_description);
%reaggreg_ingr(27246300,4,1,food_description);
%reaggreg_ingr(27246300,5,1,food_description);
%reaggreg_ingr(27246300,6,1,food_description);
%reaggreg_ingr(27246300,7,1,food_description);
%reaggreg_ingr(27246300,8,1,food_description);
%reaggreg_ingr(27246300,9,1,food_description);
%new_num_ingr(27246300,1);
run;

*/%reaggreg_ingr(27246500,1,1,sr_description);
*/%reaggreg_ingr(27246500,2,2,"meat loaf filling");
*/%reaggreg_ingr(27246500,3,2,"meat loaf filling");
*/%reaggreg_ingr(27246500,4,3,sr_description);
*/%reaggreg_ingr(27246500,5,2,"meat loaf filling");
*/%reaggreg_ingr(27246500,6,2,"meat loaf filling");
*/%reaggreg_ingr(27246500,7,2,"meat loaf filling");
*/%reaggreg_ingr(27246500,8,2,"meat loaf filling");
*/%new_num_ingr(27246500,3);
*/run;

%reaggreg_ingr(27250040,1,1,food_description);
%reaggreg_ingr(27250040,2,1,food_description);
%reaggreg_ingr(27250040,3,1,food_description);
%reaggreg_ingr(27250040,4,1,food_description);
%reaggreg_ingr(27250040,5,1,food_description);
%reaggreg_ingr(27250040,6,1,food_description);
%new_num_ingr(27250040,1);
run;

%reaggreg_ingr(27250070,1,1,food_description);
%reaggreg_ingr(27250070,2,1,food_description);
%reaggreg_ingr(27250070,3,1,food_description);
%reaggreg_ingr(27250070,4,1,food_description);
%reaggreg_ingr(27250070,5,1,food_description);
%new_num_ingr(27250070,1);
run;

%reaggreg_ingr(27250120,1,1,"Noodles, egg, cooked");
%reaggreg_ingr(27250120,2,2,sr_description);
%reaggreg_ingr(27250120,3,3,sr_description);
%reaggreg_ingr(27250120,4,1,"Noodles, egg, cooked");
%new_num_ingr(27250120,3);
run;

%reaggreg_ingr(27250130,1,1,sr_description);
%reaggreg_ingr(27250130,2,2,"cheese sauce");
%reaggreg_ingr(27250130,3,3,sr_description);
%reaggreg_ingr(27250130,4,2,"cheese sauce");
%reaggreg_ingr(27250130,5,2,"cheese sauce");
%reaggreg_ingr(27250130,6,4,sr_description);
%reaggreg_ingr(27250130,7,2,"cheese sauce");
%new_num_ingr(27250130,4);
run;

*/%reaggreg_ingr(27260010,1,1,sr_description);
*/%reaggreg_ingr(27260010,2,2,"meat loaf filling");
*/%reaggreg_ingr(27260010,3,2,"meat loaf filling");
*/%reaggreg_ingr(27260010,4,3,sr_description);
*/%reaggreg_ingr(27260010,5,2,"meat loaf filling");
*/%reaggreg_ingr(27260010,6,2,"meat loaf filling");
*/%reaggreg_ingr(27260010,7,2,"meat loaf filling");
*/%new_num_ingr(27260010,3);
*/run;

*/%reaggreg_ingr(27260080,1,1,sr_description);
*/%reaggreg_ingr(27260080,2,2,sr_description);
*/%reaggreg_ingr(27260080,3,3,"meat loaf filling");
*/%reaggreg_ingr(27260080,4,3,"meat loaf filling");
*/%reaggreg_ingr(27260080,5,4,sr_description);
*/%reaggreg_ingr(27260080,6,3,"meat loaf filling");
*/%reaggreg_ingr(27260080,7,3,"meat loaf filling");
*/%reaggreg_ingr(27260080,8,3,"meat loaf filling");
*/%new_num_ingr(27260080,4);
*/run;

*/%reaggreg_ingr(27260090,1,1,sr_description);
*/%reaggreg_ingr(27260090,2,2,sr_description);
*/%reaggreg_ingr(27260090,3,3,sr_description);
*/%reaggreg_ingr(27260090,4,4,"meat loaf filling");
*/%reaggreg_ingr(27260090,5,4,"meat loaf filling");
*/%reaggreg_ingr(27260090,6,5,sr_description);
*/%reaggreg_ingr(27260090,7,4,"meat loaf filling");
*/%reaggreg_ingr(27260090,8,4,"meat loaf filling");
*/%reaggreg_ingr(27260090,9,4,"meat loaf filling");
*/%new_num_ingr(27260090,5);
*/run;

%reaggreg_ingr(27260100,1,1,"meat loaf, beef and pork");
%reaggreg_ingr(27260100,2,2,sr_description);
%reaggreg_ingr(27260100,3,1,"meat loaf, beef and pork");
%reaggreg_ingr(27260100,4,1,"meat loaf, beef and pork");
%reaggreg_ingr(27260100,5,1,"meat loaf, beef and pork");
%reaggreg_ingr(27260100,6,1,"meat loaf, beef and pork");
%reaggreg_ingr(27260100,7,1,"meat loaf, beef and pork");
%reaggreg_ingr(27260100,8,1,"meat loaf, beef and pork");
%reaggreg_ingr(27260100,9,1,"meat loaf, beef and pork");
%new_num_ingr(27260100,2);
run;

%reaggreg_ingr(27311310,1,1,"stew");
%reaggreg_ingr(27311310,2,1,"stew");
%reaggreg_ingr(27311310,3,2,sr_description);
%reaggreg_ingr(27311310,4,3,sr_description);
%reaggreg_ingr(27311310,5,4,sr_description);
%reaggreg_ingr(27311310,6,5,sr_description);
%reaggreg_ingr(27311310,7,6,sr_description);
%reaggreg_ingr(27311310,8,1,"stew");
%reaggreg_ingr(27311310,9,1,"stew");
%reaggreg_ingr(27311310,10,7,sr_description);
%reaggreg_ingr(27311310,11,1,"stew");
%new_num_ingr(27311310,7);
run;

%reaggreg_ingr(27311410,1,1,"stew");
%reaggreg_ingr(27311410,2,2,sr_description);
%reaggreg_ingr(27311410,3,3,sr_description);
%reaggreg_ingr(27311410,4,4,sr_description);
%reaggreg_ingr(27311410,5,5,sr_description);
%reaggreg_ingr(27311410,6,6,sr_description);
%reaggreg_ingr(27311410,7,1,"stew");
%reaggreg_ingr(27311410,8,7,sr_description);
%reaggreg_ingr(27311410,9,1,"stew");
%new_num_ingr(27311410,7);
run;

*/%reaggreg_ingr(27311510,1,1,sr_description);
*/%reaggreg_ingr(27311510,2,2,sr_description);
*/%reaggreg_ingr(27311510,3,3,"shepard's pie filling");
*/%reaggreg_ingr(27311510,4,3,"shepard's pie filling");
*/%reaggreg_ingr(27311510,5,3,"shepard's pie filling");
*/%reaggreg_ingr(27311510,6,4,sr_description);
*/%reaggreg_ingr(27311510,7,5,sr_description);
*/%reaggreg_ingr(27311510,8,6,sr_description);
*/%reaggreg_ingr(27311510,9,7,sr_description);
*/%reaggreg_ingr(27311510,10,3,"shepard's pie filling");
*/%reaggreg_ingr(27311510,11,3,"shepard's pie filling");
*/%reaggreg_ingr(27311510,12,3,"shepard's pie filling");
*/%new_num_ingr(27311510,7);
*/run;

%reaggreg_ingr(27311610,1,1,sr_description);
%reaggreg_ingr(27311610,2,2,sr_description);
%reaggreg_ingr(27311610,3,3,"cream of mushroom sauce");
%reaggreg_ingr(27311610,4,4,sr_description);
%reaggreg_ingr(27311610,5,5,sr_description);
%reaggreg_ingr(27311610,6,3,"cream of mushroom sauce");
%reaggreg_ingr(27311610,7,6,sr_description);
%reaggreg_ingr(27311610,8,3,"cream of mushroom sauce");
%new_num_ingr(27311610,6);
run;

%reaggreg_ingr(27313410,1,1,"gravy");
%reaggreg_ingr(27313410,2,2,sr_description);
%reaggreg_ingr(27313410,3,3,sr_description);
%reaggreg_ingr(27313410,4,4,sr_description);
%reaggreg_ingr(27313410,5,5,sr_description);
%reaggreg_ingr(27313410,6,6,sr_description);
%reaggreg_ingr(27313410,7,1,"gravy");
%new_num_ingr(27313410,6);
run;

%reaggreg_ingr(27315250,1,1,sr_description);
%reaggreg_ingr(27315250,2,2,sr_description);
%reaggreg_ingr(27315250,3,3,"tomato-egg sauce");
%reaggreg_ingr(27315250,4,4,sr_description);
%reaggreg_ingr(27315250,5,5,sr_description);
%reaggreg_ingr(27315250,6,6,sr_description);
%reaggreg_ingr(27315250,7,3,"tomato-egg sauce");
%reaggreg_ingr(27315250,8,7,sr_description);
%reaggreg_ingr(27315250,9,8,sr_description);
%reaggreg_ingr(27315250,10,3,"tomato-egg sauce");
%reaggreg_ingr(27315250,11,3,"tomato-egg sauce");
%new_num_ingr(27315250,8);
run;

%reaggreg_ingr(27315510,1,1,sr_description);
%reaggreg_ingr(27315510,2,2,sr_description);
%reaggreg_ingr(27315510,3,3,"soy-based sauce");
%reaggreg_ingr(27315510,4,4,sr_description);
%reaggreg_ingr(27315510,5,5,sr_description);
%reaggreg_ingr(27315510,6,6,sr_description);
%reaggreg_ingr(27315510,7,7,sr_description);
%reaggreg_ingr(27315510,8,8,sr_description);
%reaggreg_ingr(27315510,9,3,"soy-based sauce");
%reaggreg_ingr(27315510,10,3,"soy-based sauce");
%reaggreg_ingr(27315510,11,9,sr_description);
%reaggreg_ingr(27315510,12,3,"soy-based sauce");
%reaggreg_ingr(27315510,13,3,"soy-based sauce");
%new_num_ingr(27315510,9);
run;

%reaggreg_ingr(27341010,1,1,"salted chicken");
%reaggreg_ingr(27341010,2,2,sr_description);
%reaggreg_ingr(27341010,3,3,sr_description);
%reaggreg_ingr(27341010,4,4,sr_description);
%reaggreg_ingr(27341010,5,1,"salted chicken");
%reaggreg_ingr(27341010,6,5,sr_description);
%new_num_ingr(27341010,5);
run;

%reaggreg_ingr(27341510,1,1,"tomato sauce");
%reaggreg_ingr(27341510,2,2,sr_description);
%reaggreg_ingr(27341510,3,3,sr_description);
%reaggreg_ingr(27341510,4,4,sr_description);
%reaggreg_ingr(27341510,5,5,sr_description);
%reaggreg_ingr(27341510,6,6,sr_description);
%reaggreg_ingr(27341510,7,7,sr_description);
%reaggreg_ingr(27341510,8,1,"tomato sauce");
%reaggreg_ingr(27341510,9,8,sr_description);
%reaggreg_ingr(27341510,10,1,"tomato sauce");
%reaggreg_ingr(27341510,11,1,"tomato sauce");
%new_num_ingr(27341510,8);
run;

%reaggreg_ingr(27343470,1,1,sr_description);
%reaggreg_ingr(27343470,2,2,sr_description);
%reaggreg_ingr(27343470,3,3,"mushroom soup-based sauce");
%reaggreg_ingr(27343470,4,4,sr_description);
%reaggreg_ingr(27343470,5,3,"mushroom soup-based sauce");
%reaggreg_ingr(27343470,6,3,"mushroom soup-based sauce");
%reaggreg_ingr(27343470,7,5,sr_description);
%reaggreg_ingr(27343470,8,3,"mushroom soup-based sauce");
%new_num_ingr(27343470,5);
run;

%reaggreg_ingr(27343480,1,1,sr_description);
%reaggreg_ingr(27343480,2,2,sr_description);
%reaggreg_ingr(27343480,3,3,"mushroom soup-based sauce");
%reaggreg_ingr(27343480,4,4,sr_description);
%reaggreg_ingr(27343480,5,3,"mushroom soup-based sauce");
%reaggreg_ingr(27343480,6,3,"mushroom soup-based sauce");
%reaggreg_ingr(27343480,7,5,sr_description);
%reaggreg_ingr(27343480,8,3,"mushroom soup-based sauce");
%new_num_ingr(27343480,5);
run;

%reaggreg_ingr(27343510,1,1,sr_description);
%reaggreg_ingr(27343510,2,2,sr_description);
%reaggreg_ingr(27343510,3,3,"tomato sauce");
%reaggreg_ingr(27343510,4,3,"tomato sauce");
%reaggreg_ingr(27343510,5,4,sr_description);
%reaggreg_ingr(27343510,6,5,sr_description);
%reaggreg_ingr(27343510,7,3,"tomato sauce");
%reaggreg_ingr(27343510,8,3,"tomato sauce");
%reaggreg_ingr(27343510,9,3,"tomato sauce");
%new_num_ingr(27343510,5);
run;

%reaggreg_ingr(27343910,1,1,sr_description);
%reaggreg_ingr(27343910,2,2,"chop suey sauce");
%reaggreg_ingr(27343910,3,3,sr_description);
%reaggreg_ingr(27343910,4,4,sr_description);
%reaggreg_ingr(27343910,5,5,sr_description);
%reaggreg_ingr(27343910,6,6,sr_description);
%reaggreg_ingr(27343910,7,7,sr_description);
%reaggreg_ingr(27343910,8,2,"chop suey sauce");
%reaggreg_ingr(27343910,9,2,"chop suey sauce");
%reaggreg_ingr(27343910,10,8,sr_description);
%reaggreg_ingr(27343910,11,2,"chop suey sauce");
%reaggreg_ingr(27343910,12,2,"chop suey sauce");
%reaggreg_ingr(27343910,13,2,"chop suey sauce");
%new_num_ingr(27343910,8);
run;

%reaggreg_ingr(27343950,1,1,"cheese sauce");
%reaggreg_ingr(27343950,2,2,sr_description);
%reaggreg_ingr(27343950,3,3,sr_description);
%reaggreg_ingr(27343950,4,4,sr_description);
%reaggreg_ingr(27343950,5,1,"cheese sauce");
%reaggreg_ingr(27343950,6,5,sr_description);
%reaggreg_ingr(27343950,7,1,"cheese sauce");
%reaggreg_ingr(27343950,8,1,"cheese sauce");
%reaggreg_ingr(27343950,9,1,"cheese sauce");
%new_num_ingr(27343950,5);
run;

%reaggreg_ingr(27343960,1,1,"cheese sauce");
%reaggreg_ingr(27343960,2,2,sr_description);
%reaggreg_ingr(27343960,3,3,sr_description);
%reaggreg_ingr(27343960,4,4,sr_description);
%reaggreg_ingr(27343960,5,1,"cheese sauce");
%reaggreg_ingr(27343960,6,5,sr_description);
%reaggreg_ingr(27343960,7,1,"cheese sauce");
%reaggreg_ingr(27343960,8,1,"cheese sauce");
%reaggreg_ingr(27343960,9,1,"cheese sauce");
%new_num_ingr(27343960,5);
run;

%reaggreg_ingr(27345010,1,1,sr_description);
%reaggreg_ingr(27345010,2,2,"salted chicken");
%reaggreg_ingr(27345010,3,3,sr_description);
%reaggreg_ingr(27345010,4,4,sr_description);
%reaggreg_ingr(27345010,5,5,sr_description);
%reaggreg_ingr(27345010,6,6,sr_description);
%reaggreg_ingr(27345010,7,2,"salted chicken");
%new_num_ingr(27345010,6);
run;

%reaggreg_ingr(27345310,1,1,"soy-based sauce");
%reaggreg_ingr(27345310,2,2,sr_description);
%reaggreg_ingr(27345310,3,3,sr_description);
%reaggreg_ingr(27345310,4,4,sr_description);
%reaggreg_ingr(27345310,5,5,sr_description);
%reaggreg_ingr(27345310,6,6,sr_description);
%reaggreg_ingr(27345310,7,1,"soy-based sauce");
%reaggreg_ingr(27345310,8,1,"soy-based sauce");
%reaggreg_ingr(27345310,9,1,"soy-based sauce");
%new_num_ingr(27345310,6);
run;

%reaggreg_ingr(27345410,1,1,sr_description);
%reaggreg_ingr(27345410,2,2,sr_description);
%reaggreg_ingr(27345410,3,3,"mushroom soup-based sauce");
%reaggreg_ingr(27345410,4,4,sr_description);
%reaggreg_ingr(27345410,5,5,sr_description);
%reaggreg_ingr(27345410,6,6,sr_description);
%reaggreg_ingr(27345410,7,7,sr_description);
%reaggreg_ingr(27345410,8,8,sr_description);
%reaggreg_ingr(27345410,9,3,"mushroom soup-based sauce");
%new_num_ingr(27345410,8);
run;

%reaggreg_ingr(27345440,1,1,sr_description);
%reaggreg_ingr(27345440,2,2,"salted chicken");
%reaggreg_ingr(27345440,3,3,sr_description);
%reaggreg_ingr(27345440,4,4,sr_description);
%reaggreg_ingr(27345440,5,5,sr_description);
%reaggreg_ingr(27345440,6,6,sr_description);
%reaggreg_ingr(27345440,7,7,sr_description);
%reaggreg_ingr(27345440,8,8,sr_description);
%reaggreg_ingr(27345440,9,2,"salted chicken");
%new_num_ingr(27345440,8);
run;

%reaggreg_ingr(27345510,1,1,sr_description);
%reaggreg_ingr(27345510,2,2,"tomato sauce");
%reaggreg_ingr(27345510,3,3,sr_description);
%reaggreg_ingr(27345510,4,4,sr_description);
%reaggreg_ingr(27345510,5,5,sr_description);
%reaggreg_ingr(27345510,6,6,sr_description);
%reaggreg_ingr(27345510,7,7,sr_description);
%reaggreg_ingr(27345510,8,8,sr_description);
%reaggreg_ingr(27345510,9,2,"tomato sauce");
%new_num_ingr(27345510,8);
run;

%reaggreg_ingr(27345520,1,1,sr_description);
%reaggreg_ingr(27345520,2,2,sr_description);
%reaggreg_ingr(27345520,3,3,"tomato sauce");
%reaggreg_ingr(27345520,4,4,sr_description);
%reaggreg_ingr(27345520,5,5,sr_description);
%reaggreg_ingr(27345520,6,6,sr_description);
%reaggreg_ingr(27345520,7,7,sr_description);
%reaggreg_ingr(27345520,8,8,sr_description);
%reaggreg_ingr(27345520,9,3,"tomato sauce");
%new_num_ingr(27345520,7);
run;


*/%reaggreg_ingr(27347100,1,1,"pot pie sauce");
*/%reaggreg_ingr(27347100,2,2,sr_description);
*/%reaggreg_ingr(27347100,3,1,"pot pie sauce");
*/%reaggreg_ingr(27347100,4,1,"pot pie sauce");
*/%reaggreg_ingr(27347100,5,3,sr_description);
*/%reaggreg_ingr(27347100,6,4,sr_description);
*/%reaggreg_ingr(27347100,7,5,sr_description);
*/%reaggreg_ingr(27347100,8,1,"pot pie sauce");
*/%reaggreg_ingr(27347100,9,1,"pot pie sauce");
*/%reaggreg_ingr(27347100,10,1,"pot pie sauce");
*/%reaggreg_ingr(27347100,11,1,"pot pie sauce");
*/%new_num_ingr(27347100,5);
*/run;

%reaggreg_ingr(27347240,1,1,sr_description);
%reaggreg_ingr(27347240,2,2,sr_description);
%reaggreg_ingr(27347240,3,3,"gravy");
%reaggreg_ingr(27347240,4,4,sr_description);
%reaggreg_ingr(27347240,5,5,sr_description);
%reaggreg_ingr(27347240,6,6,sr_description);
%reaggreg_ingr(27347240,7,7,sr_description);
%reaggreg_ingr(27347240,8,8,sr_description);
%reaggreg_ingr(27347240,9,3,"gravy");
%new_num_ingr(27347240,8);
run;

%reaggreg_ingr(27347250,1,1,"gravy");
%reaggreg_ingr(27347250,2,2,sr_description);
%reaggreg_ingr(27347250,3,3,sr_description);
%reaggreg_ingr(27347250,4,4,sr_description);
%reaggreg_ingr(27347250,5,5,sr_description);
%reaggreg_ingr(27347250,6,6,sr_description);
%reaggreg_ingr(27347250,7,7,sr_description);
%reaggreg_ingr(27347250,8,1,"gravy");
%new_num_ingr(27347250,7);
run;

*/%reaggreg_ingr(27350410,1,1,sr_description);
*/%reaggreg_ingr(27350410,2,2,"casserole filling");
*/%reaggreg_ingr(27350410,3,3,sr_description);
*/%reaggreg_ingr(27350410,4,2,"casserole filling");
*/%reaggreg_ingr(27350410,5,4,sr_description);
*/%reaggreg_ingr(27350410,6,2,"casserole filling");
*/%reaggreg_ingr(27350410,7,2,"casserole filling");
*/%new_num_ingr(27350410,4);
*/run;

%reaggreg_ingr(27360100,1,1,"stew");
%reaggreg_ingr(27360100,2,2,sr_description);
%reaggreg_ingr(27360100,3,3,sr_description);
%reaggreg_ingr(27360100,4,1,"stew");
%reaggreg_ingr(27360100,5,4,sr_description);
%reaggreg_ingr(27360100,6,5,sr_description);
%reaggreg_ingr(27360100,7,6,sr_description);
%reaggreg_ingr(27360100,8,7,sr_description);
%reaggreg_ingr(27360100,9,1,"stew");
%reaggreg_ingr(27360100,10,1,"stew");
%reaggreg_ingr(27360100,11,1,"stew");
%new_num_ingr(27360100,7);
run;

%reaggreg_ingr(27363100,1,1,sr_description);
%reaggreg_ingr(27363100,2,2,"tomato sauce");
%reaggreg_ingr(27363100,3,3,sr_description);
%reaggreg_ingr(27363100,4,4,sr_description);
%reaggreg_ingr(27363100,5,5,sr_description);
%reaggreg_ingr(27363100,6,2,"tomato sauce");
%reaggreg_ingr(27363100,7,2,"tomato sauce");
%reaggreg_ingr(27363100,8,2,"tomato sauce");
%reaggreg_ingr(27363100,9,2,"tomato sauce");
%reaggreg_ingr(27363100,10,2,"tomato sauce");
%reaggreg_ingr(27363100,11,2,"tomato sauce");
%new_num_ingr(27363100,5);
run;

%reaggreg_ingr(27410210,1,1,sr_description);
%reaggreg_ingr(27410210,2,2,"breaded beef");
%reaggreg_ingr(27410210,3,3,sr_description);
%reaggreg_ingr(27410210,4,4,sr_description);
%reaggreg_ingr(27410210,5,5,sr_description);
%reaggreg_ingr(27410210,6,2,"breaded beef");
%reaggreg_ingr(27410210,7,6,sr_description);
%reaggreg_ingr(27410210,8,2,"breaded beef");
%new_num_ingr(27410210,6);
run;

*/%reaggreg_ingr(27411200,1,1,"tomato sauce");
*/%reaggreg_ingr(27411200,2,2,sr_description);
*/%reaggreg_ingr(27411200,3,3,sr_description);
*/%reaggreg_ingr(27411200,4,1,"tomato sauce");
*/%new_num_ingr(27411200,3);
*/run;

%reaggreg_ingr(27415100,1,1,"soy-based sauce");
%reaggreg_ingr(27415100,2,2,sr_description);
%reaggreg_ingr(27415100,3,3,sr_description);
%reaggreg_ingr(27415100,4,4,sr_description);
%reaggreg_ingr(27415100,5,5,sr_description);
%reaggreg_ingr(27415100,6,1,"soy-based sauce");
%reaggreg_ingr(27415100,7,1,"soy-based sauce");
%new_num_ingr(27415100,5);
run;

%reaggreg_ingr(27416450,1,1,"gravy");
%reaggreg_ingr(27416450,2,2,sr_description);
%reaggreg_ingr(27416450,3,3,sr_description);
%reaggreg_ingr(27416450,4,4,sr_description);
%reaggreg_ingr(27416450,5,5,sr_description);
%reaggreg_ingr(27416450,6,6,sr_description);
%reaggreg_ingr(27416450,7,1,"gravy");
%reaggreg_ingr(27416450,8,1,"gravy");
%new_num_ingr(27416450,6);
run;

%reaggreg_ingr(27420400,1,1,sr_description);
%reaggreg_ingr(27420400,2,2,sr_description);
%reaggreg_ingr(27420400,3,3,sr_description);
%reaggreg_ingr(27420400,4,4,sr_description);
%reaggreg_ingr(27420400,5,5,sr_description);
%reaggreg_ingr(27420400,6,6,"tomato sauce");
%reaggreg_ingr(27420400,7,7,sr_description);
%reaggreg_ingr(27420400,8,6,"tomato sauce");
%new_num_ingr(27420400,7);
run;

%reaggreg_ingr(27420500,1,1,sr_description);
%reaggreg_ingr(27420500,2,2,sr_description);
%reaggreg_ingr(27420500,3,3,sr_description);
%reaggreg_ingr(27420500,4,4,sr_description);
%reaggreg_ingr(27420500,5,5,"soy-based sauce");
%reaggreg_ingr(27420500,6,6,sr_description);
%reaggreg_ingr(27420500,7,5,"soy-based sauce");
%reaggreg_ingr(27420500,8,7,sr_description);
%reaggreg_ingr(27420500,9,5,"soy-based sauce");
%reaggreg_ingr(27420500,10,5,"soy-based sauce");
%reaggreg_ingr(27420500,11,5,"soy-based sauce");
%reaggreg_ingr(27420500,12,5,"soy-based sauce");
%reaggreg_ingr(27420500,13,5,"soy-based sauce");
%reaggreg_ingr(27420500,14,5,"soy-based sauce");
%new_num_ingr(27420500,7);
run;

%reaggreg_ingr(27420510,1,1,sr_description);
%reaggreg_ingr(27420510,2,2,sr_description);
%reaggreg_ingr(27420510,3,3,"soy-based sauce");
%reaggreg_ingr(27420510,4,3,"soy-based sauce");
%reaggreg_ingr(27420510,5,3,"soy-based sauce");
%reaggreg_ingr(27420510,6,3,"soy-based sauce");
%reaggreg_ingr(27420510,7,3,"soy-based sauce");
%reaggreg_ingr(27420510,8,3,"soy-based sauce");
%reaggreg_ingr(27420510,9,4,sr_description);
%reaggreg_ingr(27420510,10,3,"soy-based sauce");
%reaggreg_ingr(27420510,11,3,"soy-based sauce");
%new_num_ingr(27420510,4);
run;

%reaggreg_ingr(27430610,1,1,"salted meat");
%reaggreg_ingr(27430610,2,2,sr_description);
%reaggreg_ingr(27430610,3,3,sr_description);
%reaggreg_ingr(27430610,4,4,sr_description);
%reaggreg_ingr(27430610,5,1,"salted meat");
%new_num_ingr(27430610,4);
run;

%reaggreg_ingr(27440110,1,1,"salted chicken");
%reaggreg_ingr(27440110,2,2,sr_description);
%reaggreg_ingr(27440110,3,3,sr_description);
%reaggreg_ingr(27440110,4,4,sr_description);
%reaggreg_ingr(27440110,5,5,sr_description);
%reaggreg_ingr(27440110,6,6,sr_description);
%reaggreg_ingr(27440110,7,7,sr_description);
%reaggreg_ingr(27440110,8,1,"salted chicken");
%new_num_ingr(27440110,7);
run;

%reaggreg_ingr(27440120,1,1,"salted chicken");
%reaggreg_ingr(27440120,2,2,sr_description);
%reaggreg_ingr(27440120,3,3,sr_description);
%reaggreg_ingr(27440120,4,4,sr_description);
%reaggreg_ingr(27440120,5,5,sr_description);
%reaggreg_ingr(27440120,6,6,sr_description);
%reaggreg_ingr(27440120,7,1,"salted chicken");
%new_num_ingr(27440120,6);
run;

%reaggreg_ingr(27440130,1,1,"salted chicken");
%reaggreg_ingr(27440130,2,2,sr_description);
%reaggreg_ingr(27440130,3,3,sr_description);
%reaggreg_ingr(27440130,4,4,sr_description);
%reaggreg_ingr(27440130,5,1,"salted chicken");
%new_num_ingr(27440130,4);
run;

%reaggreg_ingr(27443110,1,1,sr_description);
%reaggreg_ingr(27443110,2,2,"white sauce");
%reaggreg_ingr(27443110,3,2,"white sauce");
%reaggreg_ingr(27443110,4,3,sr_description);
%reaggreg_ingr(27443110,5,4,sr_description);
%reaggreg_ingr(27443110,6,2,"white sauce");
%reaggreg_ingr(27443110,7,2,"white sauce");
%reaggreg_ingr(27443110,8,2,"white sauce");
%reaggreg_ingr(27443110,9,2,"white sauce");
%reaggreg_ingr(27443110,10,2,"white sauce");
%new_num_ingr(27443110,4);
run;

%reaggreg_ingr(27443150,1,1,sr_description);
%reaggreg_ingr(27443150,2,2,sr_description);
%reaggreg_ingr(27443150,3,3,"white sauce");
%reaggreg_ingr(27443150,4,3,"white sauce");
%reaggreg_ingr(27443150,5,3,"white sauce");
%reaggreg_ingr(27443150,6,3,"white sauce");
%reaggreg_ingr(27443150,7,3,"white sauce");
%reaggreg_ingr(27443150,8,3,"white sauce");
%reaggreg_ingr(27443150,9,4,sr_description);
%reaggreg_ingr(27443150,10,3,"white sauce");
%new_num_ingr(27443150,4);
run;

%reaggreg_ingr(27445110,1,1,sr_description);
%reaggreg_ingr(27445110,2,2,"soy-based sauce");
%reaggreg_ingr(27445110,3,3,sr_description);
%reaggreg_ingr(27445110,4,4,sr_description);
%reaggreg_ingr(27445110,5,5,sr_description);
%reaggreg_ingr(27445110,6,6,sr_description);
%reaggreg_ingr(27445110,7,7,sr_description);
%reaggreg_ingr(27445110,8,2,"soy-based sauce");
%reaggreg_ingr(27445110,9,2,"soy-based sauce");
%reaggreg_ingr(27445110,10,8,sr_description);
%reaggreg_ingr(27445110,11,2,"soy-based sauce");
%reaggreg_ingr(27445110,12,2,"soy-based sauce");
%reaggreg_ingr(27445110,13,2,"soy-based sauce");
%reaggreg_ingr(27445110,14,2,"soy-based sauce");
%reaggreg_ingr(27445110,15,2,"soy-based sauce");
%new_num_ingr(27445110,8);
run;

%reaggreg_ingr(27445120,1,1,sr_description);
%reaggreg_ingr(27445120,2,2,"soy-based sauce");
%reaggreg_ingr(27445120,3,3,sr_description);
%reaggreg_ingr(27445120,4,4,sr_description);
%reaggreg_ingr(27445120,5,5,sr_description);
%reaggreg_ingr(27445120,6,2,"soy-based sauce");
%reaggreg_ingr(27445120,7,2,"soy-based sauce");
%reaggreg_ingr(27445120,8,6,sr_description);
%reaggreg_ingr(27445120,9,2,"soy-based sauce");
%reaggreg_ingr(27445120,10,2,"soy-based sauce");
%reaggreg_ingr(27445120,11,2,"soy-based sauce");
%new_num_ingr(27445120,6);
run;

%reaggreg_ingr(27445150,1,1,sr_description);
%reaggreg_ingr(27445150,2,2,"soy-based sauce");
%reaggreg_ingr(27445150,3,3,sr_description);
%reaggreg_ingr(27445150,4,2,"soy-based sauce");
%reaggreg_ingr(27445150,5,2,"soy-based sauce");
%reaggreg_ingr(27445150,6,4,sr_description);
%reaggreg_ingr(27445150,7,2,"soy-based sauce");
%reaggreg_ingr(27445150,8,2,"soy-based sauce");
%reaggreg_ingr(27445150,9,2,"soy-based sauce");
%reaggreg_ingr(27445150,10,2,"soy-based sauce");
%new_num_ingr(27445150,4);
run;

%reaggreg_ingr(27445220,1,1,sr_description);
%reaggreg_ingr(27445220,2,2,sr_description);
%reaggreg_ingr(27445220,3,3,"soy-based sauce");
%reaggreg_ingr(27445220,4,3,"soy-based sauce");
%reaggreg_ingr(27445220,5,3,"soy-based sauce");
%reaggreg_ingr(27445220,6,3,"soy-based sauce");
%reaggreg_ingr(27445220,7,3,"soy-based sauce");
%reaggreg_ingr(27445220,8,3,"soy-based sauce");
%reaggreg_ingr(27445220,9,3,"soy-based sauce");
%reaggreg_ingr(27445220,10,4,sr_description);
%reaggreg_ingr(27445220,11,3,"soy-based sauce");
%reaggreg_ingr(27445220,12,3,"soy-based sauce");
%new_num_ingr(27445220,4);
run;

%reaggreg_ingr(27446200,1,1,food_description);
%reaggreg_ingr(27446200,2,1,food_description);
%reaggreg_ingr(27446200,3,1,food_description);
%new_num_ingr(27446200,1);
run;

%reaggreg_ingr(27446220,1,1,"chicken or turkey salad");
%reaggreg_ingr(27446220,2,1,"chicken or turkey salad");
%reaggreg_ingr(27446220,3,2,sr_description);
%reaggreg_ingr(27446220,4,1,"chicken or turkey salad");
%reaggreg_ingr(27446220,5,1,"chicken or turkey salad");
%reaggreg_ingr(27446220,6,1,"chicken or turkey salad");
%reaggreg_ingr(27446220,7,1,"chicken or turkey salad");
%new_num_ingr(27446220,2);
run;

%reaggreg_ingr(27446400,1,1,sr_description);
%reaggreg_ingr(27446400,2,2,"cheese sauce");
%reaggreg_ingr(27446400,3,3,sr_description);
%reaggreg_ingr(27446400,4,4,sr_description);
%reaggreg_ingr(27446400,5,2,sr_description);
%reaggreg_ingr(27446400,6,2,"cheese sauce");
%reaggreg_ingr(27446400,7,2,"cheese sauce");
%new_num_ingr(27446400,4);
run;

%reaggreg_ingr(27450060,1,1,food_description);
%reaggreg_ingr(27450060,2,1,food_description);
%reaggreg_ingr(27450060,3,1,food_description);
%reaggreg_ingr(27450060,4,1,food_description);
%reaggreg_ingr(27450060,5,1,food_description);
%new_num_ingr(27450060,1);
run;

*/%reaggreg_ingr(27450070,1,1,sr_description);
*/%reaggreg_ingr(27450070,2,2,sr_description);
*/%reaggreg_ingr(27450070,3,3,"dressing");
*/%reaggreg_ingr(27450070,4,3,"dressing");
*/%reaggreg_ingr(27450070,5,4,sr_description);
*/%new_num_ingr(27450070,4);
*/run;

%reaggreg_ingr(27450090,1,1,"Tuna salad, made with mayonnaise");
%reaggreg_ingr(27450090,2,1,"Tuna salad, made with mayonnaise");
%reaggreg_ingr(27450090,3,1,"Tuna salad, made with mayonnaise");
%reaggreg_ingr(27450090,4,2,sr_description);
%reaggreg_ingr(27450090,5,1,"Tuna salad, made with mayonnaise");
%reaggreg_ingr(27450090,6,1,"Tuna salad, made with mayonnaise");
%new_num_ingr(27450090,2); 
run;

*/%reaggreg_ingr(27450130,1,1,"salted seafood");
*/%reaggreg_ingr(27450130,2,2,sr_description);
*/%reaggreg_ingr(27450130,3,3,sr_description);
*/%reaggreg_ingr(27450130,4,4,sr_description);
*/%reaggreg_ingr(27450130,5,1,"salted seafood");
*/%new_num_ingr(27450130,4);
*/run;

%reaggreg_ingr(27450410,1,1,sr_description);
%reaggreg_ingr(27450410,2,2,sr_description);
%reaggreg_ingr(27450410,3,3,sr_description);
%reaggreg_ingr(27450410,4,4,"soy-based sauce");
%reaggreg_ingr(27450410,5,5,sr_description);
%reaggreg_ingr(27450410,6,6,sr_description);
%reaggreg_ingr(27450410,7,7,sr_description);
%reaggreg_ingr(27450410,8,8,sr_description);
%reaggreg_ingr(27450410,9,4,"soy-based sauce");
%reaggreg_ingr(27450410,10,4,"soy-based sauce");
%reaggreg_ingr(27450410,11,4,"soy-based sauce");
%reaggreg_ingr(27450410,12,4,"soy-based sauce");
%new_num_ingr(27450410,8);
run;

%reaggreg_ingr(32103000,1,1,food_description);
%reaggreg_ingr(32103000,2,1,food_description);
%reaggreg_ingr(32103000,3,1,food_description);
%new_num_ingr(32103000,1);
run;

%reaggreg_ingr(321030001,1,1,food_description);
%reaggreg_ingr(321030001,2,1,food_description);
%reaggreg_ingr(321030001,3,1,food_description);
%new_num_ingr(321030001,1);
run;

%reaggreg_ingr(32104900,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32104900,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32104900,3,2,sr_description);
%reaggreg_ingr(32104900,4,1,"omelet/scrambled egg");
%new_num_ingr(32104900,2);
run;

%reaggreg_ingr(32105000,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32105000,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32105000,3,2,sr_description);
%reaggreg_ingr(32105000,4,1,"omelet/scrambled egg");
%new_num_ingr(32105000,2);
run;

%reaggreg_ingr(321050001,1,1,"omelet/scrambled egg");
%reaggreg_ingr(321050001,2,1,"omelet/scrambled egg");
%reaggreg_ingr(321050001,3,2,sr_description);
%reaggreg_ingr(321050001,4,1,"omelet/scrambled egg");
%new_num_ingr(321050001,2);
run;

%reaggreg_ingr(321050002,1,1,"omelet/scrambled egg");
%reaggreg_ingr(321050002,2,1,"omelet/scrambled egg");
%reaggreg_ingr(321050002,3,2,sr_description);
%reaggreg_ingr(321050002,4,1,"omelet/scrambled egg");
%new_num_ingr(321050002,2);
run;

%reaggreg_ingr(321050003,1,1,"omelet/scrambled egg");
%reaggreg_ingr(321050003,2,1,"omelet/scrambled egg");
%reaggreg_ingr(321050003,3,2,sr_description);
%reaggreg_ingr(321050003,4,1,"omelet/scrambled egg");
%new_num_ingr(321050003,2);
run;

%reaggreg_ingr(32105010,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32105010,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32105010,3,2,sr_description);
%reaggreg_ingr(32105010,4,3,sr_description);
%reaggreg_ingr(32105010,5,1,"omelet/scrambled egg");
%new_num_ingr(32105010,3);
run;

%reaggreg_ingr(321050101,1,1,"omelet/scrambled egg");
%reaggreg_ingr(321050101,2,1,"omelet/scrambled egg");
%reaggreg_ingr(321050101,3,2,sr_description);
%reaggreg_ingr(321050101,4,1,"omelet/scrambled egg");
%new_num_ingr(321050101,2);
run;

%reaggreg_ingr(321050102,1,1,"omelet/scrambled egg");
%reaggreg_ingr(321050102,2,1,"omelet/scrambled egg");
%reaggreg_ingr(321050102,3,2,sr_description);
%reaggreg_ingr(321050102,4,3,sr_description);
%reaggreg_ingr(321050102,5,1,"omelet/scrambled egg");
%new_num_ingr(321050102,3);
run;

%reaggreg_ingr(321050103,1,1,"omelet/scrambled egg");
%reaggreg_ingr(321050103,2,1,"omelet/scrambled egg");
%reaggreg_ingr(321050103,3,2,sr_description);
%reaggreg_ingr(321050103,4,3,sr_description);
%reaggreg_ingr(321050103,5,1,"omelet/scrambled egg");
%new_num_ingr(321050103,3);
run;

%reaggreg_ingr(32105040,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32105040,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32105040,3,2,sr_description);
%reaggreg_ingr(32105040,4,3,sr_description);
%reaggreg_ingr(32105040,5,4,sr_description);
%reaggreg_ingr(32105040,6,5,sr_description);
%reaggreg_ingr(32105040,7,1,"omelet/scrambled egg");
%new_num_ingr(32105040,5);
run;
/*
*please check - repeated code;
%reaggreg_ingr(321050101,1,1,"omelet/scrambled egg");
%reaggreg_ingr(321050101,2,1,"omelet/scrambled egg");
%reaggreg_ingr(321050101,3,2,sr_description);
%reaggreg_ingr(321050101,4,1,"omelet/scrambled egg");
%new_num_ingr(321050101,2);
run;

*please check - repeated code;
%reaggreg_ingr(32105010,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32105010,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32105010,3,2,sr_description);
%reaggreg_ingr(32105010,4,1,"omelet/scrambled egg");
%reaggreg_ingr(32105010,5,1,"omelet/scrambled egg");
%new_num_ingr(32105010,2);
run;
*/
%reaggreg_ingr(32105030,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32105030,2,2,sr_description);
%reaggreg_ingr(32105030,3,1,"omelet/scrambled egg");
%reaggreg_ingr(32105030,4,1,"omelet/scrambled egg");
%new_num_ingr(32105030,2);
run;
/*
*please check - repeated code;
%reaggreg_ingr(32105040,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32105040,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32105040,3,2,sr_description);
%reaggreg_ingr(32105040,4,3,sr_description);
%reaggreg_ingr(32105040,5,1,"omelet/scrambled egg");
%reaggreg_ingr(32105040,6,1,"omelet/scrambled egg");
%reaggreg_ingr(32105040,7,1,"omelet/scrambled egg");
%new_num_ingr(32105040,3);
run;
*/
%reaggreg_ingr(32105050,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32105050,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32105050,3,2,sr_description);
%reaggreg_ingr(32105050,4,3,sr_description);
%reaggreg_ingr(32105050,5,4,sr_description);
%reaggreg_ingr(32105050,6,5,sr_description);
%reaggreg_ingr(32105050,7,1,"omelet/scrambled egg");
%new_num_ingr(32105050,5);
run;

%reaggreg_ingr(321050501,1,1,"omelet/scrambled egg");
%reaggreg_ingr(321050501,2,1,"omelet/scrambled egg");
%reaggreg_ingr(321050501,3,2,sr_description);
%reaggreg_ingr(321050501,4,3,sr_description);
%reaggreg_ingr(321050501,5,4,sr_description);
%reaggreg_ingr(321050501,6,1,"omelet/scrambled egg");
%new_num_ingr(321050501,4);
run;

%reaggreg_ingr(32105060,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32105060,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32105060,3,2,sr_description);
%reaggreg_ingr(32105060,4,3,sr_description);
%reaggreg_ingr(32105060,5,4,sr_description);
%reaggreg_ingr(32105060,6,5,sr_description);
%reaggreg_ingr(32105060,7,1,"omelet/scrambled egg");
%new_num_ingr(32105060,5);
run;

%reaggreg_ingr(321050801,1,1,"omelet/scrambled egg");
%reaggreg_ingr(321050801,2,1,"omelet/scrambled egg");
%reaggreg_ingr(321050801,3,2,sr_description);
%reaggreg_ingr(321050801,4,3,sr_description);
%reaggreg_ingr(321050801,5,1,"omelet/scrambled egg");
%new_num_ingr(321050801,3);
run;

%reaggreg_ingr(32105080,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32105080,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32105080,3,2,sr_description);
%reaggreg_ingr(32105080,4,3,sr_description);
%reaggreg_ingr(32105080,5,4,sr_description);
%reaggreg_ingr(32105080,6,1,"omelet/scrambled egg");
%new_num_ingr(32105080,4);
run;

%reaggreg_ingr(32105085,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32105085,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32105085,3,2,sr_description);
%reaggreg_ingr(32105085,4,3,sr_description);
%reaggreg_ingr(32105085,5,4,sr_description);
%reaggreg_ingr(32105085,6,5,sr_description);
%reaggreg_ingr(32105085,7,1,"omelet/scrambled egg");
%new_num_ingr(32105085,5);
run;

%reaggreg_ingr(32105121,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32105121,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32105121,3,2,sr_description);
%reaggreg_ingr(32105121,4,3,sr_description);
%reaggreg_ingr(32105121,5,1,"omelet/scrambled egg");
%new_num_ingr(32105121,3);
run;

%reaggreg_ingr(321051221,1,1,"omelet/scrambled egg");
%reaggreg_ingr(321051221,2,2,sr_description);
%reaggreg_ingr(321051221,3,1,"omelet/scrambled egg");
%reaggreg_ingr(321051221,4,1,"omelet/scrambled egg");
%new_num_ingr(321051221,2);
run;

%reaggreg_ingr(32105122,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32105122,2,2,sr_description);
%reaggreg_ingr(32105122,3,1,"omelet/scrambled egg");
%reaggreg_ingr(32105122,4,3,sr_description);
%reaggreg_ingr(32105122,5,1,"omelet/scrambled egg");
%new_num_ingr(32105122,3);
run;

%reaggreg_ingr(32105130,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32105130,2,2,sr_description);
%reaggreg_ingr(32105130,3,3,sr_description);
%reaggreg_ingr(32105130,4,4,sr_description);
%reaggreg_ingr(32105130,5,1,"omelet/scrambled egg");
%reaggreg_ingr(32105130,6,5,sr_description);
%reaggreg_ingr(32105130,7,1,"omelet/scrambled egg");
%new_num_ingr(32105130,5);
run;

%reaggreg_ingr(321051301,1,1,"omelet/scrambled egg");
%reaggreg_ingr(321051301,2,2,sr_description);
%reaggreg_ingr(321051301,3,3,sr_description);
%reaggreg_ingr(321051301,4,4,sr_description);
%reaggreg_ingr(321051301,5,1,"omelet/scrambled egg");
%reaggreg_ingr(321051301,6,5,sr_description);
%reaggreg_ingr(321051301,7,6,sr_description);
%reaggreg_ingr(321051301,8,1,"omelet/scrambled egg");
%new_num_ingr(321051301,6);
run;

%reaggreg_ingr(321051302,1,1,"omelet/scrambled egg");
%reaggreg_ingr(321051302,2,2,sr_description);
%reaggreg_ingr(321051302,3,3,sr_description);
%reaggreg_ingr(321051302,4,4,sr_description);
%reaggreg_ingr(321051302,5,1,"omelet/scrambled egg");
%reaggreg_ingr(321051302,6,5,sr_description);
%reaggreg_ingr(321051302,7,6,sr_description);
%reaggreg_ingr(321051302,8,1,"omelet/scrambled egg");
%new_num_ingr(321051302,6);
run;

%reaggreg_ingr(32105170,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32105170,2,2,sr_description);
%reaggreg_ingr(32105170,3,1,"omelet/scrambled egg");
%reaggreg_ingr(32105170,4,3,sr_description);
%reaggreg_ingr(32105170,5,1,"omelet/scrambled egg");
%new_num_ingr(32105170,3);
run;

%reaggreg_ingr(32130000,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32130000,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32130000,3,2,sr_description);
%reaggreg_ingr(32130000,4,1,"omelet/scrambled egg");
%new_num_ingr(32130000,2);
run;

%reaggreg_ingr(32130010,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32130010,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32130010,3,2,sr_description);
%reaggreg_ingr(32130010,4,1,"omelet/scrambled egg");
%new_num_ingr(32130010,2);
run;

%reaggreg_ingr(32130020,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32130020,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32130020,3,2,sr_description);
%reaggreg_ingr(32130020,4,1,"omelet/scrambled egg");
%new_num_ingr(32130020,2);
run;

%reaggreg_ingr(32130040,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32130040,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32130040,3,2,sr_description);
%reaggreg_ingr(32130040,4,1,"omelet/scrambled egg");
%new_num_ingr(32130040,2);
run;

%reaggreg_ingr(32130060,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32130060,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32130060,3,1,"omelet/scrambled egg");
%reaggreg_ingr(32130060,4,2,sr_description);
%new_num_ingr(32130060,2);
run;

%reaggreg_ingr(32130120,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32130120,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32130120,3,2,sr_description);
%reaggreg_ingr(32130120,4,3,sr_description);
%reaggreg_ingr(32130120,5,1,"omelet/scrambled egg");
%new_num_ingr(32130120,3);
run;

%reaggreg_ingr(32130160,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32130160,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32130160,3,2,sr_description);
%reaggreg_ingr(32130160,4,1,"omelet/scrambled egg");
%reaggreg_ingr(32130160,5,3,sr_description);
%new_num_ingr(32130160,3);
run;

%reaggreg_ingr(32130170,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32130170,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32130170,3,2,sr_description);
%reaggreg_ingr(32130170,4,1,"omelet/scrambled egg");
%new_num_ingr(32130170,2);
run;

%reaggreg_ingr(32130310,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32130310,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32130310,3,2,sr_description);
%reaggreg_ingr(32130310,4,3,sr_description);
%reaggreg_ingr(32130310,5,4,sr_description);
%reaggreg_ingr(32130310,6,5,sr_description);
%reaggreg_ingr(32130310,7,6,sr_description);
%reaggreg_ingr(32130310,8,1,"omelet/scrambled egg");
%new_num_ingr(32130310,6);
run;

%reaggreg_ingr(32130460,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32130460,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32130460,3,2,sr_description);
%reaggreg_ingr(32130460,4,3,sr_description);
%reaggreg_ingr(32130460,5,4,sr_description);
%reaggreg_ingr(32130460,6,5,sr_description);
%reaggreg_ingr(32130460,7,1,"omelet/scrambled egg");
%new_num_ingr(32130460,5);
run;

%reaggreg_ingr(32130630,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32130630,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32130630,3,2,sr_description);
%reaggreg_ingr(32130630,4,3,sr_description);
%reaggreg_ingr(32130630,5,4,sr_description);
%reaggreg_ingr(32130630,6,5,sr_description);
%reaggreg_ingr(32130630,7,1,"omelet/scrambled egg");
%new_num_ingr(32130630,5);
run;

%reaggreg_ingr(32130670,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32130670,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32130670,3,2,sr_description);
%reaggreg_ingr(32130670,4,3,sr_description);
%reaggreg_ingr(32130670,5,4,sr_description);
%reaggreg_ingr(32130670,6,5,sr_description);
%reaggreg_ingr(32130670,7,1,"omelet/scrambled egg");
%new_num_ingr(32130670,5);
run;

%reaggreg_ingr(32130860,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32130860,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32130860,3,2,sr_description);
%reaggreg_ingr(32130860,4,3,sr_description);
%reaggreg_ingr(32130860,5,4,sr_description);
%reaggreg_ingr(32130860,6,5,sr_description);
%reaggreg_ingr(32130860,7,6,sr_description);
%reaggreg_ingr(32130860,8,7,sr_description);
%reaggreg_ingr(32130860,9,8,sr_description);
%reaggreg_ingr(32130860,10,1,"omelet/scrambled egg");
%new_num_ingr(32130860,8);
run;

%reaggreg_ingr(32131090,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32131090,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32131090,3,2,sr_description);
%reaggreg_ingr(32131090,4,3,sr_description);
%reaggreg_ingr(32131090,5,4,sr_description);
%reaggreg_ingr(32131090,6,5,sr_description);
%reaggreg_ingr(32131090,7,6,sr_description);
%reaggreg_ingr(32131090,8,7,sr_description);
%reaggreg_ingr(32131090,9,8,sr_description);
%reaggreg_ingr(32131090,10,9,sr_description);
%reaggreg_ingr(32131090,11,1,"omelet/scrambled egg");
%new_num_ingr(32131090,9);
run;

%reaggreg_ingr(32131110,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32131110,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32131110,3,2,sr_description);
%reaggreg_ingr(32131110,4,3,sr_description);
%reaggreg_ingr(32131110,5,4,sr_description);
%reaggreg_ingr(32131110,6,5,sr_description);
%reaggreg_ingr(32131110,7,6,sr_description);
%reaggreg_ingr(32131110,8,7,sr_description);
%reaggreg_ingr(32131110,9,8,sr_description);
%reaggreg_ingr(32131110,10,9,sr_description);
%reaggreg_ingr(32131110,11,1,"omelet/scrambled egg");
%new_num_ingr(32131110,9);
run;

%reaggreg_ingr(32400070,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32400070,2,2,sr_description);
%reaggreg_ingr(32400070,3,1,"omelet/scrambled egg");
%new_num_ingr(32400070,2);
run;

%reaggreg_ingr(32400075,1,1,"omelet/scrambled egg");
%reaggreg_ingr(32400075,2,1,"omelet/scrambled egg");
%reaggreg_ingr(32400075,3,2,sr_description);
%new_num_ingr(32400075,2);
run;






******************/275 FOOD CODES ARE NO LONGER INCLUDED/*************************;

*/%reaggreg_ingr(27510210,1,1,sr_description);
*/%reaggreg_ingr(27510210,2,2,"salted beef");
*/%reaggreg_ingr(27510210,3,3,sr_description);
*/%reaggreg_ingr(27510210,4,2,"salted beef");
*/%new_num_ingr(27510210,3);
*/run;
*/
*/%reaggreg_ingr(27510230,1,1,sr_description);
*/%reaggreg_ingr(27510230,2,2,"salted beef");
*/%reaggreg_ingr(27510230,3,3,sr_description);
*/%reaggreg_ingr(27510230,4,4,sr_description);
*/%reaggreg_ingr(27510230,5,5,sr_description);
*/%reaggreg_ingr(27510230,6,6,sr_description);
*/%reaggreg_ingr(27510230,7,7,sr_description);
*/%reaggreg_ingr(27510230,8,8,sr_description);
*/%reaggreg_ingr(27510230,9,9,sr_description);
*/%reaggreg_ingr(27510230,10,2,"salted beef");
*/%new_num_ingr(27510230,9);
*/run;
*/
*/%reaggreg_ingr(27510300,1,1,sr_description);
*/%reaggreg_ingr(27510300,2,2,"salted beef");
*/%reaggreg_ingr(27510300,3,3,sr_description);
*/%reaggreg_ingr(27510300,4,4,sr_description);
*/%reaggreg_ingr(27510300,5,5,sr_description);
*/%reaggreg_ingr(27510300,6,6,sr_description);
*/%reaggreg_ingr(27510300,7,7,sr_description);
*/%reaggreg_ingr(27510300,8,8,sr_description);
*/%reaggreg_ingr(27510300,9,9,sr_description);
*/%reaggreg_ingr(27510300,10,2,"salted beef");
*/%new_num_ingr(27510300,9);
*/run;

*/%reaggreg_ingr(27510310,1,1,sr_description);
*/%reaggreg_ingr(27510310,2,2,"salted beef");
*/%reaggreg_ingr(27510310,3,3,sr_description);
*/%reaggreg_ingr(27510310,4,4,sr_description);
*/%reaggreg_ingr(27510310,5,5,sr_description);
*/%reaggreg_ingr(27510310,6,6,sr_description);
*/%reaggreg_ingr(27510310,7,7,sr_description);
*/%reaggreg_ingr(27510310,8,8,sr_description);
*/%reaggreg_ingr(27510310,9,2,"salted beef");
*/%new_num_ingr(27510310,8);
*/run;
*/
*/%reaggreg_ingr(27510311,1,1,sr_description);
*/%reaggreg_ingr(27510311,2,2,"salted beef");
*/%reaggreg_ingr(27510311,3,3,sr_description);
*/%reaggreg_ingr(27510311,4,2,"salted beef");
*/%new_num_ingr(27510311,3);
*/run;

*/%reaggreg_ingr(27510320,1,1,"salted beef");
*/%reaggreg_ingr(27510320,2,2,sr_description);
*/%reaggreg_ingr(27510320,3,3,sr_description);
*/%reaggreg_ingr(27510320,4,4,sr_description);
*/%reaggreg_ingr(27510320,5,5,sr_description);
*/%reaggreg_ingr(27510320,6,6,sr_description);
*/%reaggreg_ingr(27510320,7,7,sr_description);
*/%reaggreg_ingr(27510320,8,8,sr_description);
*/%reaggreg_ingr(27510320,9,1,"salted beef");
*/%new_num_ingr(27510320,8);
*/run;

*/%reaggreg_ingr(27510330,1,1,"salted beef");
*/%reaggreg_ingr(27510330,2,2,sr_description);
*/%reaggreg_ingr(27510330,3,3,sr_description);
*/%reaggreg_ingr(27510330,4,4,sr_description);
*/%reaggreg_ingr(27510330,5,5,sr_description);
*/%reaggreg_ingr(27510330,6,6,sr_description);
*/%reaggreg_ingr(27510330,7,1,"salted beef");
*/%new_num_ingr(27510330,6);
*/run;

*/%reaggreg_ingr(27510350,1,1,"salted beef");
*/%reaggreg_ingr(27510350,2,2,sr_description);
*/%reaggreg_ingr(27510350,3,3,sr_description);
*/%reaggreg_ingr(27510350,4,4,sr_description);
*/%reaggreg_ingr(27510350,5,5,sr_description);
*/%reaggreg_ingr(27510350,6,6,sr_description);
*/%reaggreg_ingr(27510350,7,7,sr_description);
*/%reaggreg_ingr(27510350,8,8,sr_description);
*/%reaggreg_ingr(27510350,9,9,sr_description);
*/%reaggreg_ingr(27510350,10,1,"salted beef");
*/%new_num_ingr(27510350,9);
*/run;

*/%reaggreg_ingr(27510360,1,1,sr_description);
*/%reaggreg_ingr(27510360,2,2,"salted beef");
*/%reaggreg_ingr(27510360,3,3,sr_description);
*/%reaggreg_ingr(27510360,4,4,sr_description);
*/%reaggreg_ingr(27510360,5,5,sr_description);
*/%reaggreg_ingr(27510360,6,6,sr_description);
*/%reaggreg_ingr(27510360,7,7,sr_description);
*/%reaggreg_ingr(27510360,8,8,sr_description);
*/%reaggreg_ingr(27510360,9,9,sr_description);
*/%reaggreg_ingr(27510360,10,2,"salted beef");
*/%new_num_ingr(27510360,9);
*/run;
*/
*/%reaggreg_ingr(27510390,1,1,"salted beef");
*/%reaggreg_ingr(27510390,2,2,sr_description);
*/%reaggreg_ingr(27510390,3,3,sr_description);
*/%reaggreg_ingr(27510390,4,4,sr_description);
*/%reaggreg_ingr(27510390,5,5,sr_description);
*/%reaggreg_ingr(27510390,6,6,sr_description);
*/%reaggreg_ingr(27510390,7,7,sr_description);
*/%reaggreg_ingr(27510390,8,1,"salted beef");
*/%new_num_ingr(27510390,7);
*/run;
*/

*/%reaggreg_ingr(27510440,1,1,"salted beef");
*/%reaggreg_ingr(27510440,2,2,sr_description);
*/%reaggreg_ingr(27510440,3,3,sr_description);
*/%reaggreg_ingr(27510440,4,4,sr_description);
*/%reaggreg_ingr(27510440,5,5,sr_description);
*/%reaggreg_ingr(27510440,6,6,sr_description);
*/%reaggreg_ingr(27510440,7,7,sr_description);
*/%reaggreg_ingr(27510440,8,8,sr_description);
*/%reaggreg_ingr(27510440,9,9,sr_description);
*/%reaggreg_ingr(27510440,10,10,sr_description);
*/%reaggreg_ingr(27510440,11,1,"salted beef");
*/%new_num_ingr(27510440,10);
*/run;

*/%reaggreg_ingr(27510510,1,1,sr_description);
*/%reaggreg_ingr(27510510,2,2,"salted beef");
*/%reaggreg_ingr(27510510,3,3,sr_description);
*/%reaggreg_ingr(27510510,4,4,sr_description);
*/%reaggreg_ingr(27510510,5,5,sr_description);
*/%reaggreg_ingr(27510510,6,6,sr_description);
*/%reaggreg_ingr(27510510,7,7,sr_description);
*/%reaggreg_ingr(27510510,8,2,"salted beef");
*/%new_num_ingr(27510510,7);
*/run;
*/
*/%reaggreg_ingr(27510520,1,1,sr_description);
*/%reaggreg_ingr(27510520,2,2,"salted beef");
*/%reaggreg_ingr(27510520,3,3,sr_description);
*/%reaggreg_ingr(27510520,4,4,sr_description);
*/%reaggreg_ingr(27510520,5,5,sr_description);
*/%reaggreg_ingr(27510520,6,6,sr_description);
*/%reaggreg_ingr(27510520,7,7,sr_description);
*/%reaggreg_ingr(27510520,8,8,sr_description);
*/%reaggreg_ingr(27510520,9,2,"salted beef");
*/%new_num_ingr(27510520,8);
*/run;
*/
*/%reaggreg_ingr(27510560,1,1,"salted beef");
*/%reaggreg_ingr(27510560,2,2,sr_description);
*/%reaggreg_ingr(27510560,3,3,sr_description);
*/%reaggreg_ingr(27510560,4,4,sr_description);
*/%reaggreg_ingr(27510560,5,5,sr_description);
*/%reaggreg_ingr(27510560,6,6,sr_description);
*/%reaggreg_ingr(27510560,7,7,sr_description);
*/%reaggreg_ingr(27510560,8,8,sr_description);
*/%reaggreg_ingr(27510560,9,1,"salted beef");
*/%new_num_ingr(27510560,8);
*/run;
*/
*/%reaggreg_ingr(27513010,1,1,"salted beef");
*/%reaggreg_ingr(27513010,2,2,sr_description);
*/%reaggreg_ingr(27513010,3,1,"salted beef");
*/%new_num_ingr(27513010,2);
*/run;
*/
*/%reaggreg_ingr(27513050,1,1,"salted beef");
*/%reaggreg_ingr(27513050,2,2,sr_description);
*/%reaggreg_ingr(27513050,3,3,sr_description);
*/%reaggreg_ingr(27513050,4,1,"salted beef");
*/%new_num_ingr(27513050,3);
*/run;
*/
*/%reaggreg_ingr(27520150,1,1,sr_description);
*/%reaggreg_ingr(27520150,2,2,sr_description);
*/%reaggreg_ingr(27520150,3,3,"salted pork");
*/%reaggreg_ingr(27520150,4,4,sr_description);
*/%reaggreg_ingr(27520150,5,5,sr_description);
*/%reaggreg_ingr(27520150,6,3,"salted pork");
*/%new_num_ingr(27520150,5);
*/run;
*/
*/%reaggreg_ingr(27540110,1,1,"salted chicken");
*/%reaggreg_ingr(27540110,2,2,sr_description);
*/%reaggreg_ingr(27540110,3,3,sr_description);
*/%reaggreg_ingr(27540110,4,1,"salted chicken");
*/%new_num_ingr(27540110,3);
*/run;
*/
*/%reaggreg_ingr(27540150,1,1,"salted chicken");
*/%reaggreg_ingr(27540150,2,2,sr_description);
*/%reaggreg_ingr(27540150,3,3,sr_description);
*/%reaggreg_ingr(27540150,4,4,sr_description);
*/%reaggreg_ingr(27540150,5,5,sr_description);
*/%reaggreg_ingr(27540150,6,1,"salted chicken");
*/%new_num_ingr(27540150,5);
*/run;
*/
*/%reaggreg_ingr(27540180,1,1,"biscuit");
*/%reaggreg_ingr(27540180,2,2,sr_description);
*/%reaggreg_ingr(27540180,3,1,"biscuit");
*/%reaggreg_ingr(27540180,4,1,"biscuit");
*/%reaggreg_ingr(27540180,5,1,"biscuit");
*/%reaggreg_ingr(27540180,6,1,"biscuit");
*/%reaggreg_ingr(27540180,7,1,"biscuit");
*/%reaggreg_ingr(27540180,8,1,"biscuit");
*/%reaggreg_ingr(27540180,9,1,"biscuit");
*/%new_num_ingr(27540180,2);
*/run;
*/
*/%reaggreg_ingr(27540190,1,1,"salted chicken");
*/%reaggreg_ingr(27540190,2,2,sr_description);
*/%reaggreg_ingr(27540190,3,3,sr_description);
*/%reaggreg_ingr(27540190,4,4,sr_description);
*/%reaggreg_ingr(27540190,5,5,sr_description);
*/%reaggreg_ingr(27540190,6,1,"salted chicken");
*/%new_num_ingr(27540190,5);
*/run;
*/
*/%reaggreg_ingr(27540210,1,1,sr_description);
*/%reaggreg_ingr(27540210,2,2,"salted chicken");
*/%reaggreg_ingr(27540210,3,3,sr_description);
*/%reaggreg_ingr(27540210,4,4,sr_description);
*/%reaggreg_ingr(27540210,5,5,sr_description);
*/%reaggreg_ingr(27540210,6,2,"salted chicken");
*/%new_num_ingr(27540210,5);
*/run;
*/
*/%reaggreg_ingr(27540270,1,1,"salted chicken");
*/%reaggreg_ingr(27540270,2,2,sr_description);
*/%reaggreg_ingr(27540270,3,3,sr_description);
*/%reaggreg_ingr(27540270,4,4,sr_description);
*/%reaggreg_ingr(27540270,5,5,sr_description);
*/%reaggreg_ingr(27540270,6,6,sr_description);
*/%reaggreg_ingr(27540270,7,1,"salted chicken");
*/%new_num_ingr(27540270,6);
*/run;
*/
*/%reaggreg_ingr(27540290,1,1,sr_description);
*/%reaggreg_ingr(27540290,2,2,"salted chicken");
*/%reaggreg_ingr(27540290,3,3,sr_description);
*/%reaggreg_ingr(27540290,4,4,sr_description);
*/%reaggreg_ingr(27540290,5,5,sr_description);
*/%reaggreg_ingr(27540290,6,6,sr_description);
*/%reaggreg_ingr(27540290,7,7,sr_description);
*/%reaggreg_ingr(27540290,8,2,"salted chicken");
*/%new_num_ingr(27540290,7);
*/run;
*/
*/%reaggreg_ingr(27540300,1,1,"salted chicken");
*/%reaggreg_ingr(27540300,2,2,sr_description);
*/%reaggreg_ingr(27540300,3,3,sr_description);
*/%reaggreg_ingr(27540300,4,4,sr_description);
*/%reaggreg_ingr(27540300,5,5,sr_description);
*/%reaggreg_ingr(27540300,6,1,"salted chicken");
*/%new_num_ingr(27540300,5);
*/run;
*/
*/%reaggreg_ingr(27541000,1,1,sr_description);
*/%reaggreg_ingr(27541000,2,2,sr_description);
*/%reaggreg_ingr(27541000,3,3,sr_description);
*/%reaggreg_ingr(27541000,4,4,sr_description);
*/%reaggreg_ingr(27541000,5,5,sr_description);
*/%reaggreg_ingr(27541000,6,6,sr_description);
*/%reaggreg_ingr(27541000,7,7,sr_description);
*/%reaggreg_ingr(27541000,8,8,"salted beef");
*/%reaggreg_ingr(27541000,9,9,sr_description);
*/%reaggreg_ingr(27541000,10,10,sr_description);
*/%reaggreg_ingr(27541000,11,8,"salted beef");
*/%new_num_ingr(27541000,10);
*/run;

*/%reaggreg_ingr(27550000,1,1,sr_description);
*/%reaggreg_ingr(27550000,2,2,sr_description);
*/%reaggreg_ingr(27550000,3,3,sr_description);
*/%reaggreg_ingr(27550000,4,4,"breading");
*/%reaggreg_ingr(27550000,5,4,"breading");
*/%reaggreg_ingr(27550000,6,4,"breading");
*/%reaggreg_ingr(27550000,7,4,"breading");
*/%new_num_ingr(27550000,4);
*/run;


*/%reaggreg_ingr(27560300,1,1,sr_description);
*/%reaggreg_ingr(27560300,2,2,"breading");
*/%reaggreg_ingr(27560300,3,2,"breading");
*/%reaggreg_ingr(27560300,4,2,"breading");
*/%reaggreg_ingr(27560300,5,2,"breading");
*/%reaggreg_ingr(27560300,6,2,"breading");
*/%reaggreg_ingr(27560300,7,2,"breading");
*/%reaggreg_ingr(27560300,8,2,"breading");
*/%reaggreg_ingr(27560300,9,2,"breading");
*/%new_num_ingr(27560300,2);
*/run;


/*
*condense reaggregated ingredients;
proc means data=by_ingredient_1 noprint;
	class foodcode food_description num_ingr seq_num sr_description sum_weight;
	ways 6;
	var weight;
	output out=by_ingredient_2 sum=weight;
run;
data by_ingredient_2; set by_ingredient_2; drop _TYPE_ _FREQ_;
run;
*/


/*
*check;
proc print data= by_ingredient_2;
	where foodcode < 50000000;
run;
*/
