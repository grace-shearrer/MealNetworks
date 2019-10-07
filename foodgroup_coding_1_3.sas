********************************************************************************
* Project: 		Meal patterns and BMI/weight - PEAS.
* Program: 		foodgroup_coding_1_3
* Author: 		Carolina Schwedhelm
* Created: 		08/1/2019
* Last Changes: 08/30/2019, by Carolina Schwedhelm
* Origin: 		self made
* Category: 	creation of dataset
* Program before: 	macros_for_foodgroup_coding_1_1
					foodgroup_coding_1_1
* Short descr.: Reaggregate ingredients that belong together (e.g. sauces) - for food codes > 50000000
*******************************************************************************;

*********************************************************************************
run programs	macros_for_foodgroup_coding_1_1
				foodgroup_coding_1_1.sas
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
/*
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
*/


*FoodCode 58100015;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58100015,1,1,food_description);									
%reaggreg_ingr(58100015,2,1,food_description);
%reaggreg_ingr(58100015,3,1,food_description);
%reaggreg_ingr(58100015,4,1,food_description);
%reaggreg_ingr(58100015,5,1,food_description);
%reaggreg_ingr(58100015,6,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100015,1);	


*FoodCode 58100110;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58100110,1,1,food_description);									* putting ingredients 1+3 into a meat ingredient;
%reaggreg_ingr(58100110,2,1,food_description);
%reaggreg_ingr(58100110,3,1,food_description);
%reaggreg_ingr(58100110,4,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100110,1);														* now total ingredients is 3;


*FoodCode 58100120;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58100120,1,1,food_description);									
%reaggreg_ingr(58100120,2,1,food_description);
%reaggreg_ingr(58100120,3,1,food_description);
%reaggreg_ingr(58100120,4,1,food_description);
%reaggreg_ingr(58100120,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100120,1);	


*FoodCode 58100135;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58100135,1,1,food_description);									
%reaggreg_ingr(58100135,2,1,food_description);
%reaggreg_ingr(58100135,3,1,food_description);
%reaggreg_ingr(58100135,4,1,food_description);
%reaggreg_ingr(58100135,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100135,1);	


*FoodCode 58100145;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58100145,1,1,food_description);									
%reaggreg_ingr(58100145,2,1,food_description);
%reaggreg_ingr(58100145,3,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100145,1);	


*FoodCode 58100165;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58100165,1,1,food_description);									
%reaggreg_ingr(58100165,2,1,food_description);
%reaggreg_ingr(58100165,3,1,food_description);
%reaggreg_ingr(58100165,4,1,food_description);
%reaggreg_ingr(58100165,5,1,food_description);
%reaggreg_ingr(58100165,6,1,food_description);
%reaggreg_ingr(58100165,7,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100165,1);	


*FoodCode 58100180;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58100180,1,1,food_description);									
%reaggreg_ingr(58100180,2,1,food_description);
%reaggreg_ingr(58100180,3,1,food_description);
%reaggreg_ingr(58100180,4,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100180,1);	


*FoodCode 58100210;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58100210,1,1,food_description);									
%reaggreg_ingr(58100210,2,1,food_description);
%reaggreg_ingr(58100210,3,1,food_description);
%reaggreg_ingr(58100210,4,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100210,1);	


*FoodCode 58100220;
%reaggreg_ingr(58100220,1,1,food_description);									
%reaggreg_ingr(58100220,2,1,food_description);
%reaggreg_ingr(58100220,3,1,food_description);
%reaggreg_ingr(58100220,4,1,food_description);
%reaggreg_ingr(58100220,5,1,food_description);
%reaggreg_ingr(58100220,6,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100220,1);	


*FoodCode 58100230;
%reaggreg_ingr(58100230,1,1,food_description);									
%reaggreg_ingr(58100230,2,1,food_description);
%reaggreg_ingr(58100230,3,1,food_description);
%reaggreg_ingr(58100230,4,1,food_description);
%reaggreg_ingr(58100230,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100230,1);	


*FoodCode 58100240;
%reaggreg_ingr(58100240,1,1,food_description);									
%reaggreg_ingr(58100240,2,1,food_description);
%reaggreg_ingr(58100240,3,1,food_description);
%reaggreg_ingr(58100240,4,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100240,1);	


*FoodCode 58100300;
%reaggreg_ingr(58100300,1,1,food_description);									
%reaggreg_ingr(58100300,2,1,food_description);
%reaggreg_ingr(58100300,3,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100300,1);	


*FoodCode 58100320;
%reaggreg_ingr(58100320,1,1,food_description);									
%reaggreg_ingr(58100320,2,1,food_description);
%reaggreg_ingr(58100320,3,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100320,1);	


*FoodCode 58100330;
%reaggreg_ingr(58100330,1,1,food_description);									
%reaggreg_ingr(58100330,2,1,food_description);
%reaggreg_ingr(58100330,3,1,food_description);
%reaggreg_ingr(58100330,4,1,food_description);
%reaggreg_ingr(58100330,5,1,food_description);									
%reaggreg_ingr(58100330,6,1,food_description);
%reaggreg_ingr(58100330,7,1,food_description);
%reaggreg_ingr(58100330,8,1,food_description);
%reaggreg_ingr(58100330,9,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100330,1);	


*FoodCode 58100340;
%reaggreg_ingr(58100340,1,1,food_description);									
%reaggreg_ingr(58100340,2,1,food_description);
%reaggreg_ingr(58100340,3,1,food_description);
%reaggreg_ingr(58100340,4,1,food_description);
%reaggreg_ingr(58100340,5,1,food_description);									
%reaggreg_ingr(58100340,6,1,food_description);
%reaggreg_ingr(58100340,7,1,food_description);
%reaggreg_ingr(58100340,8,1,food_description);
%reaggreg_ingr(58100340,9,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100340,1);	


*FoodCode 58100350;
%reaggreg_ingr(58100350,1,1,food_description);									
%reaggreg_ingr(58100350,2,1,food_description);
%reaggreg_ingr(58100350,3,1,food_description);
%reaggreg_ingr(58100350,4,1,food_description);
%reaggreg_ingr(58100350,5,1,food_description);									
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100350,1);	


*FoodCode 58100400;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58100400,1,1,food_description);								
%reaggreg_ingr(58100400,2,1,food_description);
%reaggreg_ingr(58100400,3,1,food_description);
%reaggreg_ingr(58100400,4,1,food_description);
%reaggreg_ingr(58100400,5,1,food_description);
%reaggreg_ingr(58100400,6,1,food_description);
%reaggreg_ingr(58100400,7,1,food_description);
%reaggreg_ingr(58100400,8,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100400,1);												


*FoodCode 58100530;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58100530,1,1,food_description);				
%reaggreg_ingr(58100530,2,1,food_description);
%reaggreg_ingr(58100530,3,1,food_description);
%reaggreg_ingr(58100530,4,1,food_description);
%reaggreg_ingr(58100530,5,1,food_description);
%reaggreg_ingr(58100530,6,1,food_description);
%reaggreg_ingr(58100530,7,1,food_description);
%reaggreg_ingr(58100530,8,1,food_description);
%reaggreg_ingr(58100530,9,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100530,1);		


*FoodCode 58100600;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58100600,1,1,food_description);				
%reaggreg_ingr(58100600,2,1,food_description);
%reaggreg_ingr(58100600,3,1,food_description);
%reaggreg_ingr(58100600,4,1,food_description);
%reaggreg_ingr(58100600,5,1,food_description);
%reaggreg_ingr(58100600,6,1,food_description);
%reaggreg_ingr(58100600,7,1,food_description);
%reaggreg_ingr(58100600,8,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100600,1);	


*FoodCode 58100630;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58100630,1,1,food_description);				
%reaggreg_ingr(58100630,2,1,food_description);
%reaggreg_ingr(58100630,3,1,food_description);
%reaggreg_ingr(58100630,4,1,food_description);
%reaggreg_ingr(58100630,5,1,food_description);
%reaggreg_ingr(58100630,6,1,food_description);
%reaggreg_ingr(58100630,7,1,food_description);
%reaggreg_ingr(58100630,8,1,food_description);
%reaggreg_ingr(58100630,8,1,food_description);
%reaggreg_ingr(58100630,9,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100630,1);	


*FoodCode 58100720;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58100720,1,1,food_description);				
%reaggreg_ingr(58100720,2,1,food_description);
%reaggreg_ingr(58100720,3,1,food_description);
%reaggreg_ingr(58100720,4,1,food_description);
%reaggreg_ingr(58100720,5,1,food_description);
%reaggreg_ingr(58100720,6,1,food_description);
%reaggreg_ingr(58100720,7,1,food_description);
%reaggreg_ingr(58100720,8,1,food_description);
%reaggreg_ingr(58100720,8,1,food_description);
%reaggreg_ingr(58100720,9,1,food_description);
%reaggreg_ingr(58100720,10,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58100720,1);


*FoodCode 58101300;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58101300,1,1,food_description);				
%reaggreg_ingr(58101300,2,1,food_description);
%reaggreg_ingr(58101300,3,1,food_description);
%reaggreg_ingr(58101300,4,1,food_description);
%reaggreg_ingr(58101300,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58101300,1);


*FoodCode 58101310;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58101310,1,1,food_description);				
%reaggreg_ingr(58101310,2,1,food_description);
%reaggreg_ingr(58101310,3,1,food_description);
%reaggreg_ingr(58101310,4,1,food_description);
%reaggreg_ingr(58101310,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58101310,1);


*FoodCode 58101320;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58101320,1,1,food_description);				
%reaggreg_ingr(58101320,2,1,food_description);
%reaggreg_ingr(58101320,3,1,food_description);
%reaggreg_ingr(58101320,4,1,food_description);
%reaggreg_ingr(58101320,5,1,food_description);
%reaggreg_ingr(58101320,6,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58101320,1);


*FoodCode 58101345;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58101345,1,1,food_description);				
%reaggreg_ingr(58101345,2,1,food_description);
%reaggreg_ingr(58101345,3,1,food_description);
%reaggreg_ingr(58101345,4,1,food_description);
%reaggreg_ingr(58101345,5,1,food_description);
%reaggreg_ingr(58101345,6,1,food_description);				
%reaggreg_ingr(58101345,7,1,food_description);
%reaggreg_ingr(58101345,8,1,food_description);
%reaggreg_ingr(58101345,9,1,food_description);
%reaggreg_ingr(58101345,10,1,food_description);
%reaggreg_ingr(58101345,11,1,food_description);
%reaggreg_ingr(58101345,12,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58101345,1);


*FoodCode 58101350;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58101350,1,1,food_description);				
%reaggreg_ingr(58101350,2,1,food_description);
%reaggreg_ingr(58101350,3,1,food_description);
%reaggreg_ingr(58101350,4,1,food_description);
%reaggreg_ingr(58101350,5,1,food_description);
%reaggreg_ingr(58101350,6,1,food_description);				
%reaggreg_ingr(58101350,7,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58101350,1);


*FoodCode 58101400;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58101400,1,1,food_description);
%reaggreg_ingr(58101400,2,1,food_description);
%reaggreg_ingr(58101400,3,1,food_description);
%reaggreg_ingr(58101400,4,1,food_description);
%reaggreg_ingr(58101400,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58101400,1);


*FoodCode 58101450;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58101450,1,1,food_description);
%reaggreg_ingr(58101450,2,1,food_description);
%reaggreg_ingr(58101450,3,1,food_description);
%reaggreg_ingr(58101450,4,1,food_description);
%reaggreg_ingr(58101450,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58101450,1);


*FoodCode 58101460;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58101460,1,1,food_description);
%reaggreg_ingr(58101460,2,1,food_description);
%reaggreg_ingr(58101460,3,1,food_description);
%reaggreg_ingr(58101460,4,1,food_description);
%reaggreg_ingr(58101460,5,1,food_description);
%reaggreg_ingr(58101460,6,1,food_description);				
%reaggreg_ingr(58101460,7,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58101460,1);


*FoodCode 58101530;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58101530,1,1,food_description);
%reaggreg_ingr(58101530,2,1,food_description);
%reaggreg_ingr(58101530,3,1,food_description);
%reaggreg_ingr(58101530,4,1,food_description);
%reaggreg_ingr(58101530,5,1,food_description);
%reaggreg_ingr(58101530,6,1,food_description);				
%reaggreg_ingr(58101530,7,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58101530,1);


*FoodCode 58101720;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58101720,1,1,food_description);
%reaggreg_ingr(58101720,2,1,food_description);
%reaggreg_ingr(58101720,3,1,food_description);
%reaggreg_ingr(58101720,4,1,food_description);
%reaggreg_ingr(58101720,5,1,food_description);
%reaggreg_ingr(58101720,6,1,food_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58101720,1);


*FoodCode 58101820;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58101820,1,1,food_description);
%reaggreg_ingr(58101820,2,1,food_description);
%reaggreg_ingr(58101820,3,1,food_description);
%reaggreg_ingr(58101820,4,1,food_description);
%reaggreg_ingr(58101820,5,1,food_description);
%reaggreg_ingr(58101820,6,1,food_description);				
%reaggreg_ingr(58101820,7,1,food_description);
%reaggreg_ingr(58101820,8,1,food_description);
%reaggreg_ingr(58101820,9,1,food_description);
%reaggreg_ingr(58101820,10,1,food_description);
%reaggreg_ingr(58101820,11,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58101820,1);


*FoodCode 58101910;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58101910,1,1,food_description);
%reaggreg_ingr(58101910,2,1,food_description);
%reaggreg_ingr(58101910,3,1,food_description);
%reaggreg_ingr(58101910,4,1,food_description);
%reaggreg_ingr(58101910,5,1,food_description);
%reaggreg_ingr(58101910,6,1,food_description);				
%reaggreg_ingr(58101910,7,1,food_description);
%reaggreg_ingr(58101910,8,1,food_description);
%reaggreg_ingr(58101910,9,1,food_description);
%reaggreg_ingr(58101910,10,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58101910,1);


*FoodCode 58101930;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58101930,1,1,food_description);
%reaggreg_ingr(58101930,2,1,food_description);
%reaggreg_ingr(58101930,3,1,food_description);
%reaggreg_ingr(58101930,4,1,food_description);
%reaggreg_ingr(58101930,5,1,food_description);
%reaggreg_ingr(58101930,6,1,food_description);				
%reaggreg_ingr(58101930,7,1,food_description);
%reaggreg_ingr(58101930,8,1,food_description);
%reaggreg_ingr(58101930,9,1,food_description);
%reaggreg_ingr(58101930,10,1,food_description);
%reaggreg_ingr(58101930,11,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58101930,1);


*FoodCode 58101940;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58101940,1,1,food_description);
%reaggreg_ingr(58101940,2,1,food_description);
%reaggreg_ingr(58101940,3,1,food_description);
%reaggreg_ingr(58101940,4,1,food_description);
%reaggreg_ingr(58101940,5,1,food_description);
%reaggreg_ingr(58101940,6,1,food_description);				
%reaggreg_ingr(58101940,7,1,food_description);
%reaggreg_ingr(58101940,8,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58101940,1);


*FoodCode 58103130;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58103130,1,1,food_description);
%reaggreg_ingr(58103130,2,1,food_description);
%reaggreg_ingr(58103130,3,1,food_description);
%reaggreg_ingr(58103130,4,1,food_description);
%reaggreg_ingr(58103130,5,1,food_description);
%reaggreg_ingr(58103130,6,1,food_description);				
%reaggreg_ingr(58103130,7,1,food_description);
%reaggreg_ingr(58103130,8,1,food_description);
%reaggreg_ingr(58103130,9,1,food_description);
%reaggreg_ingr(58103130,10,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58103130,1);


*FoodCode 58103310;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58103310,1,1,food_description);
%reaggreg_ingr(58103310,2,1,food_description);
%reaggreg_ingr(58103310,3,1,food_description);
%reaggreg_ingr(58103310,4,1,food_description);
%reaggreg_ingr(58103310,5,1,food_description);
%reaggreg_ingr(58103310,6,1,food_description);				
%reaggreg_ingr(58103310,7,1,food_description);
%reaggreg_ingr(58103310,8,1,food_description);
%reaggreg_ingr(58103310,9,1,food_description);
%reaggreg_ingr(58103310,10,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58103310,1);


*FoodCode 58104280;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58104280,1,1,food_description);
%reaggreg_ingr(58104280,2,1,food_description);
%reaggreg_ingr(58104280,3,1,food_description);
%reaggreg_ingr(58104280,4,1,food_description);
%reaggreg_ingr(58104280,5,1,food_description);
%reaggreg_ingr(58104280,6,1,food_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58104280,1);


*FoodCode 58104550;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58104550,1,1,food_description);
%reaggreg_ingr(58104550,2,1,food_description);
%reaggreg_ingr(58104550,3,1,food_description);
%reaggreg_ingr(58104550,4,1,food_description);
%reaggreg_ingr(58104550,5,1,food_description);
%reaggreg_ingr(58104550,6,1,food_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58104550,1);


*FoodCode 58104710;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58104710,1,1,food_description);
%reaggreg_ingr(58104710,2,1,food_description);
%reaggreg_ingr(58104710,3,1,food_description);
%reaggreg_ingr(58104710,4,1,food_description);
%reaggreg_ingr(58104710,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58104710,1);


*FoodCode 58104730;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58104730,1,1,food_description);
%reaggreg_ingr(58104730,2,1,food_description);
%reaggreg_ingr(58104730,3,1,food_description);
%reaggreg_ingr(58104730,4,1,food_description);
%reaggreg_ingr(58104730,5,1,food_description);
%reaggreg_ingr(58104730,6,1,food_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58104730,1);


*FoodCode 58104740;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58104740,1,1,food_description);
%reaggreg_ingr(58104740,2,1,food_description);
%reaggreg_ingr(58104740,3,1,food_description);
%reaggreg_ingr(58104740,4,1,food_description);
%reaggreg_ingr(58104740,5,1,food_description);
%reaggreg_ingr(58104740,6,1,food_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58104740,1);


*FoodCode 58104750;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58104750,1,1,food_description);
%reaggreg_ingr(58104750,2,1,food_description);
%reaggreg_ingr(58104750,3,1,food_description);
%reaggreg_ingr(58104750,4,1,food_description);
%reaggreg_ingr(58104750,5,1,food_description);
%reaggreg_ingr(58104750,6,1,food_description);				
%reaggreg_ingr(58104750,7,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58104750,1);


*FoodCode 58104830;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58104830,1,1,food_description);
%reaggreg_ingr(58104830,2,1,food_description);
%reaggreg_ingr(58104830,3,1,food_description);
%reaggreg_ingr(58104830,4,1,food_description);
%reaggreg_ingr(58104830,5,1,food_description);
%reaggreg_ingr(58104830,6,1,food_description);				
%reaggreg_ingr(58104830,7,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58104830,1);


*FoodCode 58105000;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58105000,1,1,food_description);
%reaggreg_ingr(58105000,2,1,food_description);
%reaggreg_ingr(58105000,3,1,food_description);
%reaggreg_ingr(58105000,4,1,food_description);
%reaggreg_ingr(58105000,5,1,food_description);
%reaggreg_ingr(58105000,6,1,food_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58105000,1);


*FoodCode 58105050;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58105050,1,1,food_description);
%reaggreg_ingr(58105050,2,1,food_description);
%reaggreg_ingr(58105050,3,1,food_description);
%reaggreg_ingr(58105050,4,1,food_description);
%reaggreg_ingr(58105050,5,1,food_description);
%reaggreg_ingr(58105050,6,1,food_description);				
%reaggreg_ingr(58105050,7,1,food_description);
%reaggreg_ingr(58105050,8,1,food_description);
%reaggreg_ingr(58105050,9,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58105050,1);


*FoodCode 58106300;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58106300,1,1,food_description);
%reaggreg_ingr(58106300,2,1,food_description);
%reaggreg_ingr(58106300,3,1,food_description);
%reaggreg_ingr(58106300,4,1,food_description);
%reaggreg_ingr(58106300,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106300,1);


*FoodCode 58106310;
%reaggreg_ingr(58106310,1,1,food_description);
%reaggreg_ingr(58106310,2,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106310,1);


*FoodCode 58106320;
%reaggreg_ingr(58106320,1,1,food_description);
%reaggreg_ingr(58106320,2,1,food_description);
%reaggreg_ingr(58106320,3,1,food_description);
%reaggreg_ingr(58106320,4,1,food_description);
%reaggreg_ingr(58106320,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106320,1);


*FoodCode 58106325;
%reaggreg_ingr(58106325,1,1,food_description);
%reaggreg_ingr(58106325,2,1,food_description);
%reaggreg_ingr(58106325,3,1,food_description);
%reaggreg_ingr(58106325,4,1,food_description);
%reaggreg_ingr(58106325,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106325,1);


*FoodCode 58106330;
%reaggreg_ingr(58106330,1,1,food_description);
%reaggreg_ingr(58106330,2,1,food_description);
%reaggreg_ingr(58106330,3,1,food_description);
%reaggreg_ingr(58106330,4,1,food_description);
%reaggreg_ingr(58106330,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106330,1);


*FoodCode 58106345;
%reaggreg_ingr(58106345,1,1,food_description);
%reaggreg_ingr(58106345,2,1,food_description);
%reaggreg_ingr(58106345,3,1,food_description);
%reaggreg_ingr(58106345,4,1,food_description);
%reaggreg_ingr(58106345,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106345,1);


*FoodCode 58106347;
%reaggreg_ingr(58106347,1,1,food_description);
%reaggreg_ingr(58106347,2,1,food_description);
%reaggreg_ingr(58106347,3,1,food_description);
%reaggreg_ingr(58106347,4,1,food_description);
%reaggreg_ingr(58106347,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106347,1);


*FoodCode 58106350;
%reaggreg_ingr(58106350,1,1,food_description);
%reaggreg_ingr(58106350,2,1,food_description);
%reaggreg_ingr(58106350,3,1,food_description);
%reaggreg_ingr(58106350,4,1,food_description);
%reaggreg_ingr(58106350,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106350,1);


*FoodCode 58106360;
%reaggreg_ingr(58106360,1,1,food_description);
%reaggreg_ingr(58106360,2,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106360,1);


*FoodCode 58106500;
%reaggreg_ingr(58106500,1,1,food_description);
%reaggreg_ingr(58106500,2,1,food_description);
%reaggreg_ingr(58106500,3,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106500,1);


*FoodCode 58106505;
%reaggreg_ingr(58106505,1,1,food_description);
%reaggreg_ingr(58106505,2,1,food_description);
%reaggreg_ingr(58106505,3,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106505,1);


*FoodCode 58106540;
%reaggreg_ingr(58106540,1,1,food_description);
%reaggreg_ingr(58106540,2,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106540,1);


*FoodCode 58106550;
%reaggreg_ingr(58106550,1,1,food_description);
%reaggreg_ingr(58106550,2,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106550,1);


*FoodCode 58106560;
%reaggreg_ingr(58106560,1,1,food_description);
%reaggreg_ingr(58106560,2,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106560,1);


*FoodCode 58106610;
%reaggreg_ingr(58106610,1,1,food_description);
%reaggreg_ingr(58106610,2,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106610,1);


*FoodCode 58106620;
%reaggreg_ingr(58106620,1,1,food_description);
%reaggreg_ingr(58106620,2,1,food_description);
%reaggreg_ingr(58106620,3,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106620,1);


*FoodCode 58106625;
%reaggreg_ingr(58106625,1,1,food_description);
%reaggreg_ingr(58106625,2,1,food_description);
%reaggreg_ingr(58106625,3,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106625,1);


*FoodCode 58106630;
%reaggreg_ingr(58106630,1,1,food_description);
%reaggreg_ingr(58106630,2,1,food_description);
%reaggreg_ingr(58106630,3,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106630,1);


*FoodCode 58106650;
%reaggreg_ingr(58106650,1,1,food_description);
%reaggreg_ingr(58106650,2,1,food_description);
%reaggreg_ingr(58106650,3,1,food_description);
%reaggreg_ingr(58106650,4,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106650,1);


*FoodCode 58106655;
%reaggreg_ingr(58106655,1,1,food_description);
%reaggreg_ingr(58106655,2,1,food_description);
%reaggreg_ingr(58106655,3,1,food_description);
%reaggreg_ingr(58106655,4,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106655,1);


*FoodCode 58106660;
%reaggreg_ingr(58106660,1,1,food_description);
%reaggreg_ingr(58106660,2,1,food_description);
%reaggreg_ingr(58106660,3,1,food_description);
%reaggreg_ingr(58106660,4,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106660,1);


*FoodCode 58106720;
%reaggreg_ingr(58106720,1,1,food_description);
%reaggreg_ingr(58106720,2,1,food_description);
%reaggreg_ingr(58106720,3,1,food_description);
%reaggreg_ingr(58106720,4,1,food_description);
%reaggreg_ingr(58106720,5,1,food_description);
%reaggreg_ingr(58106720,6,1,food_description);				
%reaggreg_ingr(58106720,7,1,food_description);
%reaggreg_ingr(58106720,8,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106720,1);


*FoodCode 58106730;
%reaggreg_ingr(58106730,1,1,food_description);
%reaggreg_ingr(58106730,2,1,food_description);
%reaggreg_ingr(58106730,3,1,food_description);
%reaggreg_ingr(58106730,4,1,food_description);
%reaggreg_ingr(58106730,5,1,food_description);
%reaggreg_ingr(58106730,6,1,food_description);				
%reaggreg_ingr(58106730,7,1,food_description);
%reaggreg_ingr(58106730,8,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106730,1);


*FoodCode 58106737;
%reaggreg_ingr(58106737,1,1,food_description);
%reaggreg_ingr(58106737,2,1,food_description);
%reaggreg_ingr(58106737,3,1,food_description);
%reaggreg_ingr(58106737,4,1,food_description);
%reaggreg_ingr(58106737,5,1,food_description);
%reaggreg_ingr(58106737,6,1,food_description);				
%reaggreg_ingr(58106737,7,1,food_description);
%reaggreg_ingr(58106737,8,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106737,1);


*FoodCode 58106750;
%reaggreg_ingr(58106750,1,1,food_description);
%reaggreg_ingr(58106750,2,1,food_description);
%reaggreg_ingr(58106750,3,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106750,1);


*FoodCode 58106755;
%reaggreg_ingr(58106755,1,1,food_description);
%reaggreg_ingr(58106755,2,1,food_description);
%reaggreg_ingr(58106755,3,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106755,1);


*FoodCode 58106820;
%reaggreg_ingr(58106820,1,1,food_description);
%reaggreg_ingr(58106820,2,1,food_description);
%reaggreg_ingr(58106820,3,1,food_description);
%reaggreg_ingr(58106820,4,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58106820,1);


*FoodCode 58107225;
%reaggreg_ingr(58107225,1,1,food_description);
%reaggreg_ingr(58107225,2,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58107225,1);


*FoodCode 58108000;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58108000,1,1,food_description);
%reaggreg_ingr(58108000,2,1,food_description);
%reaggreg_ingr(58108000,3,1,food_description);
%reaggreg_ingr(58108000,4,1,food_description);
%reaggreg_ingr(58108000,5,1,food_description);
%reaggreg_ingr(58108000,6,1,food_description);				
%reaggreg_ingr(58108000,7,1,food_description);
%reaggreg_ingr(58108000,8,1,food_description);
%reaggreg_ingr(58108000,9,1,food_description);
%reaggreg_ingr(58108000,10,1,food_description);
%reaggreg_ingr(58108000,11,1,food_description);
%reaggreg_ingr(58108000,12,1,food_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58108000,1);


*FoodCode 58108010;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58108010,1,1,food_description);
%reaggreg_ingr(58108010,2,1,food_description);
%reaggreg_ingr(58108010,3,1,food_description);
%reaggreg_ingr(58108010,4,1,food_description);
%reaggreg_ingr(58108010,5,1,food_description);
%reaggreg_ingr(58108010,6,1,food_description);				
%reaggreg_ingr(58108010,7,1,food_description);
%reaggreg_ingr(58108010,8,1,food_description);
%reaggreg_ingr(58108010,9,1,food_description);
%reaggreg_ingr(58108010,10,1,food_description);
%reaggreg_ingr(58108010,11,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58108010,1);


*FoodCode 58108050;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58108050,1,1,food_description);
%reaggreg_ingr(58108050,2,1,food_description);
%reaggreg_ingr(58108050,3,1,food_description);
%reaggreg_ingr(58108050,4,1,food_description);
%reaggreg_ingr(58108050,5,1,food_description);
%reaggreg_ingr(58108050,6,1,food_description);				
%reaggreg_ingr(58108050,7,1,food_description);
%reaggreg_ingr(58108050,8,1,food_description);
%reaggreg_ingr(58108050,9,1,food_description);
%reaggreg_ingr(58108050,10,1,food_description);
%reaggreg_ingr(58108050,11,1,food_description);
%reaggreg_ingr(58108050,12,1,food_description);				
%reaggreg_ingr(58108050,13,1,food_description);
%reaggreg_ingr(58108050,14,1,food_description);
%reaggreg_ingr(58108050,15,1,food_description);				
%reaggreg_ingr(58108050,16,1,food_description);
%reaggreg_ingr(58108050,17,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58108050,1);


*FoodCode 58110120;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58110120,1,1,food_description);
%reaggreg_ingr(58110120,2,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58110120,1);


*FoodCode 58111110;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58111110,1,1,food_description);
%reaggreg_ingr(58111110,2,1,food_description);
%reaggreg_ingr(58111110,3,1,food_description);
%reaggreg_ingr(58111110,4,1,food_description);
%reaggreg_ingr(58111110,5,1,food_description);
%reaggreg_ingr(58111110,6,1,food_description);				
%reaggreg_ingr(58111110,7,1,food_description);
%reaggreg_ingr(58111110,8,1,food_description);
%reaggreg_ingr(58111110,9,1,food_description);
%reaggreg_ingr(58111110,10,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58111110,1);


*FoodCode 58111200;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58111200,1,1,food_description);
%reaggreg_ingr(58111200,2,1,food_description);
%reaggreg_ingr(58111200,3,1,food_description);
%reaggreg_ingr(58111200,4,1,food_description);
%reaggreg_ingr(58111200,5,1,food_description);
%reaggreg_ingr(58111200,6,1,food_description);				
%reaggreg_ingr(58111200,7,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58111200,1);


*FoodCode 58112510;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58112510,1,1,food_description);
%reaggreg_ingr(58112510,2,1,food_description);
%reaggreg_ingr(58112510,3,1,food_description);
%reaggreg_ingr(58112510,4,1,food_description);
%reaggreg_ingr(58112510,5,1,food_description);
%reaggreg_ingr(58112510,6,1,food_description);				
%reaggreg_ingr(58112510,7,1,food_description);
%reaggreg_ingr(58112510,8,1,food_description);
%reaggreg_ingr(58112510,9,1,food_description);
%reaggreg_ingr(58112510,10,1,food_description);
%reaggreg_ingr(58112510,11,1,food_description);
%reaggreg_ingr(58112510,12,1,food_description);				
%reaggreg_ingr(58112510,13,1,food_description);
%reaggreg_ingr(58112510,14,1,food_description);
%reaggreg_ingr(58112510,15,1,food_description);				
%reaggreg_ingr(58112510,16,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58112510,1);


*FoodCode 58116120;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58116120,1,1,food_description);
%reaggreg_ingr(58116120,2,1,food_description);
%reaggreg_ingr(58116120,3,1,food_description);
%reaggreg_ingr(58116120,4,1,food_description);
%reaggreg_ingr(58116120,5,1,food_description);
%reaggreg_ingr(58116120,6,1,food_description);				
%reaggreg_ingr(58116120,7,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58116120,1);


*FoodCode 58121610;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58121610,1,1,food_description);
%reaggreg_ingr(58121610,2,1,food_description);
%reaggreg_ingr(58121610,3,1,food_description);
%reaggreg_ingr(58121610,4,1,food_description);
%reaggreg_ingr(58121610,5,1,food_description);
%reaggreg_ingr(58121610,6,1,food_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58121610,1);


*FoodCode 58121620;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58121620,1,1,food_description);
%reaggreg_ingr(58121620,2,1,food_description);
%reaggreg_ingr(58121620,3,1,food_description);
%reaggreg_ingr(58121620,4,1,food_description);
%reaggreg_ingr(58121620,5,1,food_description);
%reaggreg_ingr(58121620,6,1,food_description);				
%reaggreg_ingr(58121620,7,1,food_description);
%reaggreg_ingr(58121620,8,1,food_description);
%reaggreg_ingr(58121620,9,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58121620,1);


*FoodCode 58122220;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58122220,1,1,food_description);
%reaggreg_ingr(58122220,2,1,food_description);
%reaggreg_ingr(58122220,3,1,food_description);
%reaggreg_ingr(58122220,4,1,food_description);
%reaggreg_ingr(58122220,5,1,food_description);
%reaggreg_ingr(58122220,6,1,food_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58122220,1);


*FoodCode 58124250;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58124250,1,1,food_description);
%reaggreg_ingr(58124250,2,1,food_description);
%reaggreg_ingr(58124250,3,1,food_description);
%reaggreg_ingr(58124250,4,1,food_description);
%reaggreg_ingr(58124250,5,1,food_description);
%reaggreg_ingr(58124250,6,1,food_description);				
%reaggreg_ingr(58124250,7,1,food_description);
%reaggreg_ingr(58124250,8,1,food_description);
%reaggreg_ingr(58124250,9,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58124250,1);


*FoodCode 58125110;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58125110,1,1,food_description);
%reaggreg_ingr(58125110,2,1,food_description);
%reaggreg_ingr(58125110,3,1,food_description);
%reaggreg_ingr(58125110,4,1,food_description);
%reaggreg_ingr(58125110,5,1,food_description);
%reaggreg_ingr(58125110,6,1,food_description);				
%reaggreg_ingr(58125110,7,1,food_description);
%reaggreg_ingr(58125110,8,1,food_description);
%reaggreg_ingr(58125110,9,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58125110,1);


*FoodCode 58125120;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58125120,1,1,food_description);
%reaggreg_ingr(58125120,2,1,food_description);
%reaggreg_ingr(58125120,3,1,food_description);
%reaggreg_ingr(58125120,4,1,food_description);
%reaggreg_ingr(58125120,5,1,food_description);
%reaggreg_ingr(58125120,6,1,food_description);				
%reaggreg_ingr(58125120,7,1,food_description);
%reaggreg_ingr(58125120,8,1,food_description);
%reaggreg_ingr(58125120,9,1,food_description);
%reaggreg_ingr(58125120,10,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58125120,1);


*FoodCode 58126150;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58126150,1,1,food_description);
%reaggreg_ingr(58126150,2,1,food_description);
%reaggreg_ingr(58126150,3,1,food_description);
%reaggreg_ingr(58126150,4,1,food_description);
%reaggreg_ingr(58126150,5,1,food_description);
%reaggreg_ingr(58126150,6,1,food_description);				
%reaggreg_ingr(58126150,7,1,food_description);
%reaggreg_ingr(58126150,8,1,food_description);
%reaggreg_ingr(58126150,9,1,food_description);
%reaggreg_ingr(58126150,10,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58126150,1);


*FoodCode 58126280;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58126280,1,1,food_description);
%reaggreg_ingr(58126280,2,1,food_description);
%reaggreg_ingr(58126280,3,1,food_description);
%reaggreg_ingr(58126280,4,1,food_description);
%reaggreg_ingr(58126280,5,1,food_description);
%reaggreg_ingr(58126280,6,1,food_description);				
%reaggreg_ingr(58126280,7,1,food_description);
%reaggreg_ingr(58126280,8,1,food_description);
%reaggreg_ingr(58126280,9,1,food_description);
%reaggreg_ingr(58126280,10,1,food_description);
%reaggreg_ingr(58126280,11,1,food_description);
%reaggreg_ingr(58126280,12,1,food_description);				
%reaggreg_ingr(58126280,13,1,food_description);
%reaggreg_ingr(58126280,14,1,food_description);
%reaggreg_ingr(58126280,15,1,food_description);				
%reaggreg_ingr(58126280,16,1,food_description);
%reaggreg_ingr(58126280,17,1,food_description);
%reaggreg_ingr(58126280,18,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58126280,1);


*FoodCode 58126300;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58126300,1,1,food_description);
%reaggreg_ingr(58126300,2,1,food_description);
%reaggreg_ingr(58126300,3,1,food_description);
%reaggreg_ingr(58126300,4,1,food_description);
%reaggreg_ingr(58126300,5,1,food_description);
%reaggreg_ingr(58126300,6,1,food_description);				
%reaggreg_ingr(58126300,7,1,food_description);
%reaggreg_ingr(58126300,8,1,food_description);
%reaggreg_ingr(58126300,9,1,food_description);
%reaggreg_ingr(58126300,10,1,food_description);
%reaggreg_ingr(58126300,11,1,food_description);
%reaggreg_ingr(58126300,12,1,food_description);				
%reaggreg_ingr(58126300,13,1,food_description);
%reaggreg_ingr(58126300,14,1,food_description);
%reaggreg_ingr(58126300,15,1,food_description);				
%reaggreg_ingr(58126300,16,1,food_description);
%reaggreg_ingr(58126300,17,1,food_description);
%reaggreg_ingr(58126300,18,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58126300,1);


*FoodCode 58127330;
%reaggreg_ingr(58127330,1,1,food_description);
%reaggreg_ingr(58127330,2,1,food_description);
%reaggreg_ingr(58127330,3,1,food_description);
%reaggreg_ingr(58127330,4,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58127330,1);


*FoodCode 58127350;
%reaggreg_ingr(58127350,1,1,food_description);
%reaggreg_ingr(58127350,2,1,food_description);
%reaggreg_ingr(58127350,3,1,food_description);
%reaggreg_ingr(58127350,4,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58127350,1);


*FoodCode 58128000;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58128000,1,1,"gravy");
%reaggreg_ingr(58128000,2,2,sr_description);
%reaggreg_ingr(58128000,3,3,sr_description);
%reaggreg_ingr(58128000,4,1,"gravy");
%reaggreg_ingr(58128000,5,1,"gravy");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58128000,3);


*FoodCode 58128120;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58128120,1,1,"cornmeal sauce");
%reaggreg_ingr(58128120,2,2,sr_description);
%reaggreg_ingr(58128120,3,3,sr_description);
%reaggreg_ingr(58128120,4,4,sr_description);
%reaggreg_ingr(58128120,5,5,sr_description);
%reaggreg_ingr(58128120,6,1,"cornmeal sauce");				
%reaggreg_ingr(58128120,7,1,"cornmeal sauce");
%reaggreg_ingr(58128120,8,1,"cornmeal sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58128120,5);


*FoodCode 58128220;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58128220,1,1,"flour-based sauce");
%reaggreg_ingr(58128220,2,2,sr_description);
%reaggreg_ingr(58128220,3,1,"flour-based sauce");
%reaggreg_ingr(58128220,4,3,sr_description);
%reaggreg_ingr(58128220,5,4,sr_description);
%reaggreg_ingr(58128220,6,5,sr_description);				
%reaggreg_ingr(58128220,7,1,"flour-based sauce");
%reaggreg_ingr(58128220,8,1,"flour-based sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58128220,5);


*FoodCode 58128250;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58128250,1,1,"flour-based sauce");
%reaggreg_ingr(58128250,2,2,sr_description);
%reaggreg_ingr(58128250,3,1,"flour-based sauce");
%reaggreg_ingr(58128250,4,3,sr_description);
%reaggreg_ingr(58128250,5,4,sr_description);
%reaggreg_ingr(58128250,6,5,sr_description);				
%reaggreg_ingr(58128250,7,1,"flour-based sauce");
%reaggreg_ingr(58128250,8,1,"flour-based sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58128250,5);


*FoodCode 58130011;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58130011,1,1,food_description);
%reaggreg_ingr(58130011,2,1,food_description);
%reaggreg_ingr(58130011,3,1,food_description);
%reaggreg_ingr(58130011,4,1,food_description);
%reaggreg_ingr(58130011,5,1,food_description);
%reaggreg_ingr(58130011,6,1,food_description);				
%reaggreg_ingr(58130011,7,1,food_description);
%reaggreg_ingr(58130011,8,1,food_description);
%reaggreg_ingr(58130011,9,1,food_description);
%reaggreg_ingr(58130011,10,1,food_description);
%reaggreg_ingr(58130011,11,1,food_description);
%reaggreg_ingr(58130011,12,1,food_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58130011,1);


*FoodCode 58130020;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58130020,1,1,food_description);
%reaggreg_ingr(58130020,2,1,food_description);
%reaggreg_ingr(58130020,3,1,food_description);
%reaggreg_ingr(58130020,4,1,food_description);
%reaggreg_ingr(58130020,5,1,food_description);
%reaggreg_ingr(58130020,6,1,food_description);				
%reaggreg_ingr(58130020,7,1,food_description);
%reaggreg_ingr(58130020,8,1,food_description);
%reaggreg_ingr(58130020,9,1,food_description);
%reaggreg_ingr(58130020,10,1,food_description);
%reaggreg_ingr(58130020,11,1,food_description);
%reaggreg_ingr(58130020,12,1,food_description);				
%reaggreg_ingr(58130020,13,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58130020,1);


*FoodCode 58130320;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58130320,1,1,food_description);
%reaggreg_ingr(58130320,2,1,food_description);
%reaggreg_ingr(58130320,3,1,food_description);
%reaggreg_ingr(58130320,4,1,food_description);
%reaggreg_ingr(58130320,5,1,food_description);
%reaggreg_ingr(58130320,6,1,food_description);				
%reaggreg_ingr(58130320,7,1,food_description);
%reaggreg_ingr(58130320,8,1,food_description);
%reaggreg_ingr(58130320,9,1,food_description);
%reaggreg_ingr(58130320,10,1,food_description);
%reaggreg_ingr(58130320,11,1,food_description);
%reaggreg_ingr(58130320,12,1,food_description);				
%reaggreg_ingr(58130320,13,1,food_description);
%reaggreg_ingr(58130320,14,1,food_description);
%reaggreg_ingr(58130320,15,1,food_description);				
%reaggreg_ingr(58130320,16,1,food_description);
%reaggreg_ingr(58130320,17,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58130320,1);


*FoodCode 58131310;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58131310,1,1,food_description);
%reaggreg_ingr(58131310,2,1,food_description);
%reaggreg_ingr(58131310,3,1,food_description);
%reaggreg_ingr(58131310,4,1,food_description);
%reaggreg_ingr(58131310,5,1,food_description);
%reaggreg_ingr(58131310,6,1,food_description);				
%reaggreg_ingr(58131310,7,1,food_description);
%reaggreg_ingr(58131310,8,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58131310,1);


*FoodCode 58131320;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58131320,1,1,"tomato/meat sauce");
%reaggreg_ingr(58131320,2,2,"ravioli, meat-filled");
%reaggreg_ingr(58131320,3,2,"ravioli, meat-filled");
%reaggreg_ingr(58131320,4,2,"ravioli, meat-filled");
%reaggreg_ingr(58131320,5,2,"ravioli, meat-filled");
%reaggreg_ingr(58131320,6,2,"ravioli, meat-filled");				
%reaggreg_ingr(58131320,7,2,"ravioli, meat-filled");
%reaggreg_ingr(58131320,8,1,"tomato/meat sauce");
%reaggreg_ingr(58131320,9,3,sr_description);
%reaggreg_ingr(58131320,10,2,"ravioli, meat-filled");
%reaggreg_ingr(58131320,11,1,"tomato/meat sauce");
%reaggreg_ingr(58131320,12,1,"tomato/meat sauce");				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58131320,3);


*FoodCode 58131323;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58131323,1,1,"ravioli, meat-filled");
%reaggreg_ingr(58131323,2,2,"tomato/meat sauce");
%reaggreg_ingr(58131323,3,1,"ravioli, meat-filled");
%reaggreg_ingr(58131323,4,1,"ravioli, meat-filled");
%reaggreg_ingr(58131323,5,2,"tomato/meat sauce");
%reaggreg_ingr(58131323,6,2,"tomato/meat sauce");				
%reaggreg_ingr(58131323,7,1,"ravioli, meat-filled");
%reaggreg_ingr(58131323,8,2,"tomato/meat sauce");
%reaggreg_ingr(58131323,9,3,sr_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58131323,3);


*FoodCode 58131510;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58131510,1,1,"ravioli, cheese-filled");
%reaggreg_ingr(58131510,2,1,"ravioli, cheese-filled");
%reaggreg_ingr(58131510,3,1,"ravioli, cheese-filled");
%reaggreg_ingr(58131510,4,1,"ravioli, cheese-filled");
%reaggreg_ingr(58131510,5,1,"ravioli, cheese-filled");
%reaggreg_ingr(58131510,6,1,"ravioli, cheese-filled");				
%reaggreg_ingr(58131510,7,2,sr_description);
%reaggreg_ingr(58131510,8,1,"ravioli, cheese-filled");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58131510,2);


*FoodCode 58131520;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58131520,1,1,"tomato sauce");
%reaggreg_ingr(58131520,2,2,"ravioli, cheese-filled");
%reaggreg_ingr(58131520,3,2,"ravioli, cheese-filled");
%reaggreg_ingr(58131520,4,2,"ravioli, cheese-filled");
%reaggreg_ingr(58131520,5,2,"ravioli, cheese-filled");
%reaggreg_ingr(58131520,6,2,"ravioli, cheese-filled");				
%reaggreg_ingr(58131520,7,2,"ravioli, cheese-filled");
%reaggreg_ingr(58131520,8,2,"ravioli, cheese-filled");
%reaggreg_ingr(58131520,9,1,"tomato sauce");
%reaggreg_ingr(58131520,10,3,sr_description);
%reaggreg_ingr(58131520,11,1,"tomato sauce");
%reaggreg_ingr(58131520,12,1,"tomato sauce");				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58131520,3);


*FoodCode 58131590;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58131590,1,1,"ravioli, cheese and spinach-filled");
%reaggreg_ingr(58131590,2,1,"ravioli, cheese and spinach-filled");
%reaggreg_ingr(58131590,3,1,"ravioli, cheese and spinach-filled");
%reaggreg_ingr(58131590,4,1,"ravioli, cheese and spinach-filled");
%reaggreg_ingr(58131590,5,1,"ravioli, cheese and spinach-filled");
%reaggreg_ingr(58131590,6,1,"ravioli, cheese and spinach-filled");				
%reaggreg_ingr(58131590,7,2,sr_description);
%reaggreg_ingr(58131590,8,1,"ravioli, cheese and spinach-filled");
%reaggreg_ingr(58131590,9,1,"ravioli, cheese and spinach-filled");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58131590,2);


*FoodCode 58131610;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58131610,1,1,sr_description);
%reaggreg_ingr(58131610,2,2,"ravioli, cheese and spinach-filled");
%reaggreg_ingr(58131610,3,2,"ravioli, cheese and spinach-filled");
%reaggreg_ingr(58131610,4,2,"ravioli, cheese and spinach-filled");
%reaggreg_ingr(58131610,5,2,"ravioli, cheese and spinach-filled");
%reaggreg_ingr(58131610,6,2,"ravioli, cheese and spinach-filled");				
%reaggreg_ingr(58131610,7,2,"ravioli, cheese and spinach-filled");
%reaggreg_ingr(58131610,8,3,sr_description);
%reaggreg_ingr(58131610,9,2,"ravioli, cheese and spinach-filled");
%reaggreg_ingr(58131610,10,2,"ravioli, cheese and spinach-filled");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58131610,3);


*FoodCode 58132110;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58132110,1,1,sr_description);
%reaggreg_ingr(58132110,2,2,"tomato sauce");
%reaggreg_ingr(58132110,3,3,sr_description);
%reaggreg_ingr(58132110,4,2,"tomato sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58132110,3);


*FoodCode 58132113;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58132113,1,1,sr_description);
%reaggreg_ingr(58132113,2,2,"tomato sauce");
%reaggreg_ingr(58132113,3,3,sr_description);
%reaggreg_ingr(58132113,4,4,sr_description);
%reaggreg_ingr(58132113,5,2,"tomato sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58132113,4);


*FoodCode 58132310;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58132310,1,1,sr_description);
%reaggreg_ingr(58132310,2,2,"tomato/meat sauce");
%reaggreg_ingr(58132310,3,3,"meatballs, beef and pork");
%reaggreg_ingr(58132310,4,2,"tomato/meat sauce");
%reaggreg_ingr(58132310,5,2,"tomato/meat sauce");
%reaggreg_ingr(58132310,6,3,"meatballs, beef and pork");				
%reaggreg_ingr(58132310,7,3,"meatballs, beef and pork");
%reaggreg_ingr(58132310,8,3,"meatballs, beef and pork");
%reaggreg_ingr(58132310,9,3,"meatballs, beef and pork");
%reaggreg_ingr(58132310,10,4,sr_description);
%reaggreg_ingr(58132310,11,5,sr_description);
%reaggreg_ingr(58132310,12,3,"meatballs, beef and pork");				
%reaggreg_ingr(58132310,13,3,"meatballs, beef and pork");
%reaggreg_ingr(58132310,14,2,"tomato/meat sauce");
%reaggreg_ingr(58132310,15,2,"tomato/meat sauce");				
%reaggreg_ingr(58132310,16,3,"meatballs, beef and pork");
%reaggreg_ingr(58132310,17,2,"tomato/meat sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58132310,5);


*FoodCode 58132313;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58132313,1,1,sr_description);
%reaggreg_ingr(58132313,2,2,"tomato/meat sauce");
%reaggreg_ingr(58132313,3,3,"meatballs, beef and pork");
%reaggreg_ingr(58132313,4,2,"tomato/meat sauce");
%reaggreg_ingr(58132313,5,2,"tomato/meat sauce");
%reaggreg_ingr(58132313,6,3,"meatballs, beef and pork");				
%reaggreg_ingr(58132313,7,3,"meatballs, beef and pork");
%reaggreg_ingr(58132313,8,3,"meatballs, beef and pork");
%reaggreg_ingr(58132313,9,3,"meatballs, beef and pork");
%reaggreg_ingr(58132313,10,4,sr_description);
%reaggreg_ingr(58132313,11,5,sr_description);
%reaggreg_ingr(58132313,12,3,"meatballs, beef and pork");				
%reaggreg_ingr(58132313,13,3,"meatballs, beef and pork");
%reaggreg_ingr(58132313,14,2,"tomato/meat sauce");
%reaggreg_ingr(58132313,15,2,"tomato/meat sauce");				
%reaggreg_ingr(58132313,16,3,"meatballs, beef and pork");
%reaggreg_ingr(58132313,17,2,"tomato/meat sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58132313,5);


*FoodCode 58132340;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58132340,1,1,sr_description);
%reaggreg_ingr(58132340,2,2,"tomato sauce");
%reaggreg_ingr(58132340,3,3,sr_description);
%reaggreg_ingr(58132340,4,2,"tomato sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58132340,3);


*FoodCode 58132350;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58132350,1,1,sr_description);
%reaggreg_ingr(58132350,2,2,"tomato sauce");
%reaggreg_ingr(58132350,3,3,sr_description);
%reaggreg_ingr(58132350,4,2,"tomato sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58132350,3);


*FoodCode 58132360;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58132360,1,1,sr_description);
%reaggreg_ingr(58132360,2,2,"tomato/meat sauce");
%reaggreg_ingr(58132360,3,3,"meatballs, beef and pork");
%reaggreg_ingr(58132360,4,2,"tomato/meat sauce");
%reaggreg_ingr(58132360,5,2,"tomato/meat sauce");
%reaggreg_ingr(58132360,6,3,"meatballs, beef and pork");				
%reaggreg_ingr(58132360,7,3,"meatballs, beef and pork");
%reaggreg_ingr(58132360,8,3,"meatballs, beef and pork");
%reaggreg_ingr(58132360,9,3,"meatballs, beef and pork");
%reaggreg_ingr(58132360,10,4,sr_description);
%reaggreg_ingr(58132360,11,5,sr_description);
%reaggreg_ingr(58132360,12,3,"meatballs, beef and pork");				
%reaggreg_ingr(58132360,13,3,"meatballs, beef and pork");
%reaggreg_ingr(58132360,14,2,"tomato/meat sauce");
%reaggreg_ingr(58132360,15,2,"tomato/meat sauce");				
%reaggreg_ingr(58132360,16,3,"meatballs, beef and pork");
%reaggreg_ingr(58132360,17,2,"tomato/meat sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58132360,5);


*FoodCode 58132910;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58132910,1,1,sr_description);
%reaggreg_ingr(58132910,2,2,"tomato sauce");
%reaggreg_ingr(58132910,3,3,sr_description);
%reaggreg_ingr(58132910,4,4,sr_description);
%reaggreg_ingr(58132910,5,5,sr_description);
%reaggreg_ingr(58132910,6,2,"tomato sauce");				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58132910,5);


*FoodCode 58133120;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58133120,1,1,"tomato sauce");
%reaggreg_ingr(58133120,2,2,"manicotti, cheese-filled");
%reaggreg_ingr(58133120,3,2,"manicotti, cheese-filled");
%reaggreg_ingr(58133120,4,2,"manicotti, cheese-filled");
%reaggreg_ingr(58133120,5,2,"manicotti, cheese-filled");
%reaggreg_ingr(58133120,6,3,sr_description);				
%reaggreg_ingr(58133120,7,1,"tomato sauce");
%reaggreg_ingr(58133120,8,2,"manicotti, cheese-filled");
%reaggreg_ingr(58133120,9,1,"tomato sauce");
%reaggreg_ingr(58133120,10,1,"tomato sauce");
%reaggreg_ingr(58133120,11,1,"tomato sauce");
%reaggreg_ingr(58133120,12,1,"tomato sauce");				
%reaggreg_ingr(58133120,13,1,"tomato sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58133120,3);


*FoodCode 58134160;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58134160,1,1,"stuffed shells");
%reaggreg_ingr(58134160,2,1,"stuffed shells");
%reaggreg_ingr(58134160,3,1,"stuffed shells");
%reaggreg_ingr(58134160,4,1,"stuffed shells");
%reaggreg_ingr(58134160,5,2,sr_description);
%reaggreg_ingr(58134160,6,1,"stuffed shells");				
%reaggreg_ingr(58134160,7,1,"stuffed shells");
%reaggreg_ingr(58134160,8,1,"stuffed shells");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58134160,2);


*FoodCode 58134310;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58134310,1,1,"tomato sauce");
%reaggreg_ingr(58134310,2,2,"stuffed shells");
%reaggreg_ingr(58134310,3,2,"stuffed shells");
%reaggreg_ingr(58134310,4,2,"stuffed shells");
%reaggreg_ingr(58134310,5,2,"stuffed shells");
%reaggreg_ingr(58134310,6,2,"stuffed shells");				
%reaggreg_ingr(58134310,7,2,"stuffed shells");
%reaggreg_ingr(58134310,8,1,"tomato sauce");
%reaggreg_ingr(58134310,9,1,"tomato sauce");
%reaggreg_ingr(58134310,10,1,"tomato sauce");
%reaggreg_ingr(58134310,11,1,"tomato sauce");
%reaggreg_ingr(58134310,12,1,"tomato sauce");				
%reaggreg_ingr(58134310,13,1,"tomato sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58134310,2);


*FoodCode 58134610;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58134610,1,1,"tortellini, meat-filled");
%reaggreg_ingr(58134610,2,2,"tomato sauce");
%reaggreg_ingr(58134610,3,1,"tortellini, meat-filled");
%reaggreg_ingr(58134610,4,1,"tortellini, meat-filled");
%reaggreg_ingr(58134610,5,1,"tortellini, meat-filled");
%reaggreg_ingr(58134610,6,3,sr_description);				
%reaggreg_ingr(58134610,7,1,"tortellini, meat-filled");
%reaggreg_ingr(58134610,8,1,"tortellini, meat-filled");
%reaggreg_ingr(58134610,9,1,"tortellini, meat-filled");
%reaggreg_ingr(58134610,10,1,"tortellini, meat-filled");
%reaggreg_ingr(58134610,11,1,"tortellini, meat-filled");
%reaggreg_ingr(58134610,12,2,"tomato sauce");				
%reaggreg_ingr(58134610,13,1,"tortellini, meat-filled");
%reaggreg_ingr(58134610,14,2,"tomato sauce");
%reaggreg_ingr(58134610,15,2,"tomato sauce");				
%reaggreg_ingr(58134610,16,2,"tomato sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58134610,3);


*FoodCode 58134650;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58134650,1,1,"tortellini, meat-filled");
%reaggreg_ingr(58134650,2,1,"tortellini, meat-filled");
%reaggreg_ingr(58134650,3,1,"tortellini, meat-filled");
%reaggreg_ingr(58134650,4,1,"tortellini, meat-filled");
%reaggreg_ingr(58134650,5,2,sr_description);
%reaggreg_ingr(58134650,6,1,"tortellini, meat-filled");				
%reaggreg_ingr(58134650,7,1,"tortellini, meat-filled");
%reaggreg_ingr(58134650,8,1,"tortellini, meat-filled");
%reaggreg_ingr(58134650,9,1,"tortellini, meat-filled");
%reaggreg_ingr(58134650,10,1,"tortellini, meat-filled");
%reaggreg_ingr(58134650,11,1,"tortellini, meat-filled");
%reaggreg_ingr(58134650,12,1,"tortellini, meat-filled");			
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58134650,2);


*FoodCode 58134660;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58134660,1,1,sr_description);
%reaggreg_ingr(58134660,2,2,"tortellini, cheese-filled");
%reaggreg_ingr(58134660,3,2,"tortellini, cheese-filled");
%reaggreg_ingr(58134660,4,2,"tortellini, cheese-filled");
%reaggreg_ingr(58134660,5,2,"tortellini, cheese-filled");
%reaggreg_ingr(58134660,6,2,"tortellini, cheese-filled");				
%reaggreg_ingr(58134660,7,2,"tortellini, cheese-filled");
%reaggreg_ingr(58134660,8,2,"tortellini, cheese-filled");
%reaggreg_ingr(58134660,9,3,sr_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58134660,3);


*FoodCode 58134710;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58134710,1,1,"tortellini, spinach-filled");
%reaggreg_ingr(58134710,2,2,"tomato sauce");
%reaggreg_ingr(58134710,3,1,"tortellini, spinach-filled");
%reaggreg_ingr(58134710,4,1,"tortellini, spinach-filled");
%reaggreg_ingr(58134710,5,1,"tortellini, spinach-filled");
%reaggreg_ingr(58134710,6,3,sr_description);				
%reaggreg_ingr(58134710,7,1,"tortellini, spinach-filled");
%reaggreg_ingr(58134710,8,1,"tortellini, spinach-filled");
%reaggreg_ingr(58134710,9,1,"tortellini, spinach-filled");
%reaggreg_ingr(58134710,10,1,"tortellini, spinach-filled");
%reaggreg_ingr(58134710,11,2,"tomato sauce");
%reaggreg_ingr(58134710,12,2,"tomato sauce");				
%reaggreg_ingr(58134710,13,2,"tomato sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58134710,3);


*FoodCode 58134720;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58134720,1,1,"tortellini, spinach-filled");
%reaggreg_ingr(58134720,2,1,"tortellini, spinach-filled");
%reaggreg_ingr(58134720,3,1,"tortellini, spinach-filled");
%reaggreg_ingr(58134720,4,1,"tortellini, spinach-filled");
%reaggreg_ingr(58134720,5,2,sr_description);
%reaggreg_ingr(58134720,6,1,"tortellini, spinach-filled");				
%reaggreg_ingr(58134720,7,1,"tortellini, spinach-filled");
%reaggreg_ingr(58134720,8,1,"tortellini, spinach-filled");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58134720,2);


*FoodCode 58134810;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58134810,1,1,"cannelloni, cheese- and spinach-filled");
%reaggreg_ingr(58134810,2,1,"cannelloni, cheese- and spinach-filled");
%reaggreg_ingr(58134810,3,1,"cannelloni, cheese- and spinach-filled");
%reaggreg_ingr(58134810,4,1,"cannelloni, cheese- and spinach-filled");
%reaggreg_ingr(58134810,5,1,"cannelloni, cheese- and spinach-filled");
%reaggreg_ingr(58134810,6,1,"cannelloni, cheese- and spinach-filled");				
%reaggreg_ingr(58134810,7,1,"cannelloni, cheese- and spinach-filled");
%reaggreg_ingr(58134810,8,2,sr_description);
%reaggreg_ingr(58134810,9,1,"cannelloni, cheese- and spinach-filled");
%reaggreg_ingr(58134810,10,1,"cannelloni, cheese- and spinach-filled");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58134810,2);


*FoodCode 58136120;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58136120,1,1,sr_description);
%reaggreg_ingr(58136120,2,2,sr_description);
%reaggreg_ingr(58136120,3,3,sr_description);
%reaggreg_ingr(58136120,4,4,sr_description);
%reaggreg_ingr(58136120,5,5,sr_description);
%reaggreg_ingr(58136120,6,6,"sauce");				
%reaggreg_ingr(58136120,7,7,sr_description);
%reaggreg_ingr(58136120,8,6,"sauce");
%reaggreg_ingr(58136120,9,8,sr_description);
%reaggreg_ingr(58136120,10,9,sr_description);
%reaggreg_ingr(58136120,11,10,sr_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58136120,10);


*FoodCode 58136130;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58136130,1,1,sr_description);
%reaggreg_ingr(58136130,2,2,sr_description);
%reaggreg_ingr(58136130,3,3,sr_description);
%reaggreg_ingr(58136130,4,4,sr_description);
%reaggreg_ingr(58136130,5,5,sr_description);
%reaggreg_ingr(58136130,6,6,sr_description);				
%reaggreg_ingr(58136130,7,7,"sauce");
%reaggreg_ingr(58136130,8,7,"sauce");
%reaggreg_ingr(58136130,9,7,"sauce");
%reaggreg_ingr(58136130,10,7,"sauce");
%reaggreg_ingr(58136130,11,7,"sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58136130,7);


*FoodCode 58136160;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58136160,1,1,sr_description);
%reaggreg_ingr(58136160,2,2,sr_description);
%reaggreg_ingr(58136160,3,3,sr_description);
%reaggreg_ingr(58136160,4,4,sr_description);
%reaggreg_ingr(58136160,5,5,sr_description);
%reaggreg_ingr(58136160,6,6,sr_description);				
%reaggreg_ingr(58136160,7,7,"sauce");
%reaggreg_ingr(58136160,8,8,sr_description);
%reaggreg_ingr(58136160,9,9,sr_description);
%reaggreg_ingr(58136160,10,10,sr_description);
%reaggreg_ingr(58136160,11,7,"sauce");
%reaggreg_ingr(58136160,12,11,sr_description);				
%reaggreg_ingr(58136160,13,7,"sauce");
%reaggreg_ingr(58136160,14,7,"sauce");
%reaggreg_ingr(58136160,15,7,"sauce");				
%reaggreg_ingr(58136160,16,7,"sauce");
%reaggreg_ingr(58136160,17,7,"sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58136160,11);


*FoodCode 58137220;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58137220,1,1,sr_description);
%reaggreg_ingr(58137220,2,2,sr_description);
%reaggreg_ingr(58137220,3,3,sr_description);
%reaggreg_ingr(58137220,4,4,sr_description);
%reaggreg_ingr(58137220,5,5,sr_description);
%reaggreg_ingr(58137220,6,6,sr_description);				
%reaggreg_ingr(58137220,7,7,"sauce");
%reaggreg_ingr(58137220,8,7,"sauce");
%reaggreg_ingr(58137220,9,7,"sauce");
%reaggreg_ingr(58137220,10,8,sr_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58137220,8);


*FoodCode 58137230;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58137230,1,1,sr_description);
%reaggreg_ingr(58137230,2,2,sr_description);
%reaggreg_ingr(58137230,3,3,sr_description);
%reaggreg_ingr(58137230,4,4,sr_description);
%reaggreg_ingr(58137230,5,5,sr_description);
%reaggreg_ingr(58137230,6,6,sr_description);				
%reaggreg_ingr(58137230,7,7,sr_description);
%reaggreg_ingr(58137230,8,8,"sauce");
%reaggreg_ingr(58137230,9,8,"sauce");
%reaggreg_ingr(58137230,10,8,"sauce");
%reaggreg_ingr(58137230,11,8,"sauce");
%reaggreg_ingr(58137230,12,8,"sauce");				
%reaggreg_ingr(58137230,13,8,"sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58137230,8);


*FoodCode 58137240;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58137240,1,1,sr_description);
%reaggreg_ingr(58137240,2,2,sr_description);
%reaggreg_ingr(58137240,3,3,sr_description);
%reaggreg_ingr(58137240,4,4,sr_description);
%reaggreg_ingr(58137240,5,5,sr_description);
%reaggreg_ingr(58137240,6,6,"sauce");				
%reaggreg_ingr(58137240,7,7,sr_description);
%reaggreg_ingr(58137240,8,8,sr_description);
%reaggreg_ingr(58137240,9,9,sr_description);
%reaggreg_ingr(58137240,10,10,sr_description);
%reaggreg_ingr(58137240,11,6,"sauce");
%reaggreg_ingr(58137240,12,6,"sauce");				
%reaggreg_ingr(58137240,13,11,sr_description);
%reaggreg_ingr(58137240,14,6,"sauce");
%reaggreg_ingr(58137240,15,6,"sauce");				
%reaggreg_ingr(58137240,16,6,"sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58137240,11);


*FoodCode 58145110;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58145110,1,1,food_description);
%reaggreg_ingr(58145110,2,1,food_description);
%reaggreg_ingr(58145110,3,1,food_description);
%reaggreg_ingr(58145110,4,1,food_description);
%reaggreg_ingr(58145110,5,1,food_description);
%reaggreg_ingr(58145110,6,1,food_description);				
%reaggreg_ingr(58145110,7,1,food_description);
%reaggreg_ingr(58145110,8,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58145110,1);


*FoodCode 58145112;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58145112,1,1,food_description);
%reaggreg_ingr(58145112,2,1,food_description);
%reaggreg_ingr(58145112,3,1,food_description);
%reaggreg_ingr(58145112,4,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58145112,1);


*FoodCode 58145114;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58145114,1,1,food_description);
%reaggreg_ingr(58145114,2,1,food_description);
%reaggreg_ingr(58145114,3,1,food_description);
%reaggreg_ingr(58145114,4,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58145114,1);


*FoodCode 58145115;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58145115,1,1,food_description);
%reaggreg_ingr(58145115,2,1,food_description);
%reaggreg_ingr(58145115,3,1,food_description);
%reaggreg_ingr(58145115,4,1,food_description);
%reaggreg_ingr(58145115,5,1,food_description);
%reaggreg_ingr(58145115,6,1,food_description);				
%reaggreg_ingr(58145115,7,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58145115,1);


*FoodCode 58145117;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58145117,1,1,food_description);
%reaggreg_ingr(58145117,2,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58145117,1);


*FoodCode 58145120;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58145120,1,1,"Macaroni or noodles with cheese");
%reaggreg_ingr(58145120,2,2,"mushroom sauce");
%reaggreg_ingr(58145120,3,3,sr_description);
%reaggreg_ingr(58145120,4,1,"Macaroni or noodles with cheese");
%reaggreg_ingr(58145120,5,1,"Macaroni or noodles with cheese");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58145120,3);


*FoodCode 58145130;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58145130,1,1,"gravy");
%reaggreg_ingr(58145130,2,2,"Macaroni or noodles with cheese");
%reaggreg_ingr(58145130,3,3,sr_description);
%reaggreg_ingr(58145130,4,2,"Macaroni or noodles with cheese");
%reaggreg_ingr(58145130,5,2,"Macaroni or noodles with cheese");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58145130,3);


*FoodCode 58145170;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58145170,1,1,"Macaroni and cheese");
%reaggreg_ingr(58145170,2,1,"Macaroni and cheese");
%reaggreg_ingr(58145170,3,1,"Macaroni and cheese");
%reaggreg_ingr(58145170,4,1,"Macaroni and cheese");
%reaggreg_ingr(58145170,5,2,sr_description);
%reaggreg_ingr(58145170,6,1,"Macaroni and cheese");				
%reaggreg_ingr(58145170,7,1,"Macaroni and cheese");
%reaggreg_ingr(58145170,8,1,"Macaroni and cheese");
%reaggreg_ingr(58145170,9,1,"Macaroni and cheese");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58145170,2);


*FoodCode 58146100;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58146100,1,1,"tomato sauce");
%reaggreg_ingr(58146100,2,2,sr_description);
%reaggreg_ingr(58146100,3,3,sr_description);
%reaggreg_ingr(58146100,4,4,sr_description);
%reaggreg_ingr(58146100,5,1,"tomato sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58146100,4);


*FoodCode 58146110;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58146110,1,1,sr_description);
%reaggreg_ingr(58146110,2,2,"tomato sauce");
%reaggreg_ingr(58146110,3,3,sr_description);
%reaggreg_ingr(58146110,4,4,sr_description);
%reaggreg_ingr(58146110,5,2,"tomato sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58146110,4);


*FoodCode 58146130;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58146130,1,1,sr_description);
%reaggreg_ingr(58146130,2,2,"carbonara sauce");
%reaggreg_ingr(58146130,3,3,sr_description);
%reaggreg_ingr(58146130,4,4,sr_description);
%reaggreg_ingr(58146130,5,5,sr_description);
%reaggreg_ingr(58146130,6,2,"carbonara sauce");				
%reaggreg_ingr(58146130,7,2,"carbonara sauce");
%reaggreg_ingr(58146130,8,2,"carbonara sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58146130,5);


*FoodCode 58146160;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58146160,1,1,"pasta, macaroni");
%reaggreg_ingr(58146160,2,2,sr_description);
%reaggreg_ingr(58146160,3,3,sr_description);
%reaggreg_ingr(58146160,4,4,sr_description);
%reaggreg_ingr(58146160,5,5,sr_description);
%reaggreg_ingr(58146160,6,1,"pasta, macaroni");				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58146160,5);


*FoodCode 58147100;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58147100,1,1,sr_description);
%reaggreg_ingr(58147100,2,2,"pesto sauce");
%reaggreg_ingr(58147100,3,2,"pesto sauce");
%reaggreg_ingr(58147100,4,3,sr_description);
%reaggreg_ingr(58147100,5,2,"pesto sauce");
%reaggreg_ingr(58147100,6,2,"pesto sauce");				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58147100,3);


*FoodCode 58147310;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58147310,1,1,food_description);
%reaggreg_ingr(58147310,2,1,food_description);
%reaggreg_ingr(58147310,3,1,food_description);
%reaggreg_ingr(58147310,4,1,food_description);
%reaggreg_ingr(58147310,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58147310,1);


*FoodCode 58147330;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58147330,1,1,food_description);
%reaggreg_ingr(58147330,2,1,food_description);
%reaggreg_ingr(58147330,3,1,food_description);
%reaggreg_ingr(58147330,4,1,food_description);
%reaggreg_ingr(58147330,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58147330,1);


*FoodCode 58148110;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58148110,1,1,food_description);
%reaggreg_ingr(58148110,2,1,food_description);
%reaggreg_ingr(58148110,3,1,food_description);
%reaggreg_ingr(58148110,4,1,food_description);
%reaggreg_ingr(58148110,5,1,food_description);
%reaggreg_ingr(58148110,6,1,food_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58148110,1);


*FoodCode 58148112;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58148112,1,1,food_description);
%reaggreg_ingr(58148112,2,1,food_description);
%reaggreg_ingr(58148112,3,1,food_description);
%reaggreg_ingr(58148112,4,1,food_description);
%reaggreg_ingr(58148112,5,1,food_description);
%reaggreg_ingr(58148112,6,1,food_description);				
%reaggreg_ingr(58148112,7,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58148112,1);


*FoodCode 58148114;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58148114,1,1,sr_description);
%reaggreg_ingr(58148114,2,2,sr_description);
%reaggreg_ingr(58148114,3,3,"salad dressing");
%reaggreg_ingr(58148114,4,4,sr_description);
%reaggreg_ingr(58148114,5,5,sr_description);
%reaggreg_ingr(58148114,6,6,sr_description);				
%reaggreg_ingr(58148114,7,3,"salad dressing");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58148114,6);


*FoodCode 58148180;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58148180,1,1,"Macaroni or pasta salad");
%reaggreg_ingr(58148180,2,1,"Macaroni or pasta salad");
%reaggreg_ingr(58148180,3,1,"Macaroni or pasta salad");
%reaggreg_ingr(58148180,4,2,sr_description);
%reaggreg_ingr(58148180,5,1,"Macaroni or pasta salad");
%reaggreg_ingr(58148180,6,1,"Macaroni or pasta salad");				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58148180,2);


*FoodCode 58148500;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58148500,1,1,sr_description);
%reaggreg_ingr(58148500,2,2,"salad dressing");
%reaggreg_ingr(58148500,3,3,sr_description);
%reaggreg_ingr(58148500,4,4,sr_description);
%reaggreg_ingr(58148500,5,5,sr_description);
%reaggreg_ingr(58148500,6,6,sr_description);				
%reaggreg_ingr(58148500,7,7,sr_description);
%reaggreg_ingr(58148500,8,8,sr_description);
%reaggreg_ingr(58148500,9,2,"salad dressing");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58148500,8);


*FoodCode 58150320;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58150320,1,1,sr_description);
%reaggreg_ingr(58150320,2,2,sr_description);
%reaggreg_ingr(58150320,3,3,sr_description);
%reaggreg_ingr(58150320,4,4,sr_description);
%reaggreg_ingr(58150320,5,5,sr_description);
%reaggreg_ingr(58150320,6,6,sr_description);				
%reaggreg_ingr(58150320,7,7,sr_description);
%reaggreg_ingr(58150320,8,8,"sauce");
%reaggreg_ingr(58150320,9,8,"sauce");
%reaggreg_ingr(58150320,10,8,"sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58150320,8);


*FoodCode 58150330;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58150330,1,1,sr_description);
%reaggreg_ingr(58150330,2,2,sr_description);
%reaggreg_ingr(58150330,3,3,sr_description);
%reaggreg_ingr(58150330,4,4,sr_description);
%reaggreg_ingr(58150330,5,5,sr_description);
%reaggreg_ingr(58150330,6,6,sr_description);				
%reaggreg_ingr(58150330,7,7,sr_description);
%reaggreg_ingr(58150330,8,8,"sauce");
%reaggreg_ingr(58150330,9,8,"sauce");
%reaggreg_ingr(58150330,10,8,"sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58150330,8);


*FoodCode 58150340;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58150340,1,1,sr_description);
%reaggreg_ingr(58150340,2,2,sr_description);
%reaggreg_ingr(58150340,3,3,sr_description);
%reaggreg_ingr(58150340,4,4,sr_description);
%reaggreg_ingr(58150340,5,5,sr_description);
%reaggreg_ingr(58150340,6,6,sr_description);				
%reaggreg_ingr(58150340,7,7,sr_description);
%reaggreg_ingr(58150340,8,8,"sauce");
%reaggreg_ingr(58150340,9,8,"sauce");
%reaggreg_ingr(58150340,10,8,"sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58150340,8);


*FoodCode 58151130;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58151130,1,1,sr_description);
%reaggreg_ingr(58151130,2,2,sr_description);
%reaggreg_ingr(58151130,3,3,"sauce");
%reaggreg_ingr(58151130,4,3,"sauce");
%reaggreg_ingr(58151130,5,4,sr_description);
%reaggreg_ingr(58151130,6,3,"sauce");				
%reaggreg_ingr(58151130,7,5,sr_description);
%reaggreg_ingr(58151130,8,6,sr_description);
%reaggreg_ingr(58151130,9,3,"sauce");
%reaggreg_ingr(58151130,10,3,"sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58151130,6);


*FoodCode 58151140;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58151140,1,1,sr_description);
%reaggreg_ingr(58151140,2,2,sr_description);
%reaggreg_ingr(58151140,3,3,"sauce");
%reaggreg_ingr(58151140,4,3,"sauce");
%reaggreg_ingr(58151140,5,4,sr_description);
%reaggreg_ingr(58151140,6,5,sr_description);				
%reaggreg_ingr(58151140,7,3,"sauce");
%reaggreg_ingr(58151140,8,6,sr_description);
%reaggreg_ingr(58151140,9,3,"sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58151140,6);


*FoodCode 58160000;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58160000,1,1,"seasoned rice");
%reaggreg_ingr(58160000,2,2,sr_description);
%reaggreg_ingr(58160000,3,3,sr_description);
%reaggreg_ingr(58160000,4,4,sr_description);
%reaggreg_ingr(58160000,5,5,sr_description);
%reaggreg_ingr(58160000,6,6,sr_description);				
%reaggreg_ingr(58160000,7,7,sr_description);
%reaggreg_ingr(58160000,8,8,sr_description);
%reaggreg_ingr(58160000,9,1,"seasoned rice");
%reaggreg_ingr(58160000,10,1,"seasoned rice");
%reaggreg_ingr(58160000,11,1,"seasoned rice");
%reaggreg_ingr(58160000,12,1,"seasoned rice");				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58160000,8);


*FoodCode 58160110;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58160110,1,1,"beans, white");
%reaggreg_ingr(58160110,2,2,sr_description);
%reaggreg_ingr(58160110,3,3,sr_description);
%reaggreg_ingr(58160110,4,1,"beans, white");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58160110,3);


*FoodCode 58160120;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58160120,1,1,"beans, white");
%reaggreg_ingr(58160120,2,2,sr_description);
%reaggreg_ingr(58160120,3,3,sr_description);
%reaggreg_ingr(58160120,4,4,sr_description);
%reaggreg_ingr(58160120,5,1,"beans, white");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58160120,4);


*FoodCode 58160130;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58160130,1,1,"sauce");
%reaggreg_ingr(58160130,2,2,sr_description);
%reaggreg_ingr(58160130,3,3,sr_description);
%reaggreg_ingr(58160130,4,4,sr_description);
%reaggreg_ingr(58160130,5,5,sr_description);
%reaggreg_ingr(58160130,6,1,"sauce");				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58160130,5);


*FoodCode 58160150;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58160150,1,1,sr_description);
%reaggreg_ingr(58160150,2,2,"rice");
%reaggreg_ingr(58160150,3,3,sr_description);
%reaggreg_ingr(58160150,4,4,sr_description);
%reaggreg_ingr(58160150,5,5,sr_description);				
%reaggreg_ingr(58160150,6,2,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58160150,5);


*FoodCode 58160200;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58160200,1,1,"rice");
%reaggreg_ingr(58160200,2,2,sr_description);
%reaggreg_ingr(58160200,3,3,sr_description);
%reaggreg_ingr(58160200,4,4,sr_description);
%reaggreg_ingr(58160200,5,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58160200,4);


*FoodCode 58160205;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58160205,1,1,"rice");
%reaggreg_ingr(58160205,2,2,sr_description);
%reaggreg_ingr(58160205,3,3,sr_description);
%reaggreg_ingr(58160205,4,4,sr_description);
%reaggreg_ingr(58160205,5,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58160205,4);


*FoodCode 58160220;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58160220,1,1,"rice");
%reaggreg_ingr(58160220,2,2,sr_description);
%reaggreg_ingr(58160220,3,3,sr_description);
%reaggreg_ingr(58160220,4,4,sr_description);
%reaggreg_ingr(58160220,5,5,sr_description);
%reaggreg_ingr(58160220,6,6,sr_description);				
%reaggreg_ingr(58160220,7,7,sr_description);
%reaggreg_ingr(58160220,8,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58160220,7);


*FoodCode 58160300;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58160300,1,1,"rice");
%reaggreg_ingr(58160300,2,2,sr_description);
%reaggreg_ingr(58160300,3,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58160300,2);


*FoodCode 58160450;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58160450,1,1,"rice");
%reaggreg_ingr(58160450,2,2,sr_description);
%reaggreg_ingr(58160450,3,3,sr_description);
%reaggreg_ingr(58160450,4,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58160450,3);


*FoodCode 58160520;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58160520,1,1,"rice");
%reaggreg_ingr(58160520,2,2,sr_description);
%reaggreg_ingr(58160520,3,3,sr_description);
%reaggreg_ingr(58160520,4,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58160520,3);


*FoodCode 58160530;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58160530,1,1,"rice");
%reaggreg_ingr(58160530,2,2,sr_description);
%reaggreg_ingr(58160530,3,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58160530,2);


*FoodCode 58160650;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58160650,1,1,"rice");
%reaggreg_ingr(58160650,2,2,sr_description);
%reaggreg_ingr(58160650,3,3,sr_description);
%reaggreg_ingr(58160650,4,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58160650,3);


*FoodCode 58161110;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58161110,1,1,food_description);
%reaggreg_ingr(58161110,2,1,food_description);
%reaggreg_ingr(58161110,3,1,food_description);
%reaggreg_ingr(58161110,4,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58161110,1);


*FoodCode 58161300;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58161300,1,1,"rice");
%reaggreg_ingr(58161300,2,2,sr_description);
%reaggreg_ingr(58161300,3,3,sr_description);
%reaggreg_ingr(58161300,4,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58161300,3);


*FoodCode 58161310;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58161310,1,1,"rice");
%reaggreg_ingr(58161310,2,2,sr_description);
%reaggreg_ingr(58161310,3,3,sr_description);
%reaggreg_ingr(58161310,4,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58161310,3);


*FoodCode 58161460;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58161460,1,1,"rice");
%reaggreg_ingr(58161460,2,2,sr_description);
%reaggreg_ingr(58161460,3,3,sr_description);
%reaggreg_ingr(58161460,4,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58161460,3);


*FoodCode 58161502;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58161502,1,1,"rice");
%reaggreg_ingr(58161502,2,2,sr_description);
%reaggreg_ingr(58161502,3,3,sr_description);
%reaggreg_ingr(58161502,4,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58161502,3);


*FoodCode 58161510;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58161510,1,1,food_description);
%reaggreg_ingr(58161510,2,1,food_description);
%reaggreg_ingr(58161510,3,1,food_description);
%reaggreg_ingr(58161510,4,1,food_description);
%reaggreg_ingr(58161510,5,1,food_description);
%reaggreg_ingr(58161510,6,1,food_description);				
%reaggreg_ingr(58161510,7,1,food_description);
%reaggreg_ingr(58161510,8,1,food_description);
%reaggreg_ingr(58161510,9,1,food_description);
%reaggreg_ingr(58161510,10,1,food_description);
%reaggreg_ingr(58161510,11,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58161510,1);


*FoodCode 58162090;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58162090,1,1,sr_description);
%reaggreg_ingr(58162090,2,2,"beef, ground");
%reaggreg_ingr(58162090,3,3,sr_description);
%reaggreg_ingr(58162090,4,4,sr_description);
%reaggreg_ingr(58162090,5,5,sr_description);
%reaggreg_ingr(58162090,6,2,"beef, ground");				
%reaggreg_ingr(58162090,7,2,"beef, ground");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58162090,5);


*FoodCode 58162110;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58162110,1,1,sr_description);
%reaggreg_ingr(58162110,2,2,"beef, ground");
%reaggreg_ingr(58162110,3,3,sr_description);
%reaggreg_ingr(58162110,4,4,sr_description);
%reaggreg_ingr(58162110,5,5,sr_description);
%reaggreg_ingr(58162110,6,6,sr_description);				
%reaggreg_ingr(58162110,7,2,"beef, ground");
%reaggreg_ingr(58162110,8,7,sr_description);
%reaggreg_ingr(58162110,9,8,sr_description);
%reaggreg_ingr(58162110,10,2,"beef, ground");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58162110,8);

/*
proc print data=infitems_mixed_ingr_corr1; 
	where foodcode in (58162310,581623101);
run;
*/

*FoodCode 58162310;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58162310,1,1,"rice");
%reaggreg_ingr(58162310,2,2,sr_description);
%reaggreg_ingr(58162310,3,3,sr_description);
%reaggreg_ingr(58162310,4,4,sr_description);
%reaggreg_ingr(58162310,5,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58162310,4);


*FoodCode 58163110;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58163110,1,1,"rice");
%reaggreg_ingr(58163110,2,2,sr_description);
%reaggreg_ingr(58163110,3,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58163110,2);

*FoodCode 58163380;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58163380,1,1,sr_description);
%reaggreg_ingr(58163380,2,2,sr_description);
%reaggreg_ingr(58163380,3,3,"milky sauce");
%reaggreg_ingr(58163380,4,3,"milky sauce");
%reaggreg_ingr(58163380,5,3,"milky sauce");
%reaggreg_ingr(58163380,6,3,"milky sauce");				
%reaggreg_ingr(58163380,7,3,"milky sauce");
%reaggreg_ingr(58163380,8,3,"milky sauce");
%reaggreg_ingr(58163380,9,3,"milky sauce");
%reaggreg_ingr(58163380,10,3,"milky sauce");
%reaggreg_ingr(58163380,11,3,"milky sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58163380,3);


*FoodCode 58163410;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58163410,1,1,sr_description);
%reaggreg_ingr(58163410,2,2,sr_description);
%reaggreg_ingr(58163410,3,3,sr_description);
%reaggreg_ingr(58163410,4,4,sr_description);
%reaggreg_ingr(58163410,5,5,sr_description);
%reaggreg_ingr(58163410,6,6,sr_description);				
%reaggreg_ingr(58163410,7,7,"sauce");
%reaggreg_ingr(58163410,8,7,"sauce");
%reaggreg_ingr(58163410,9,7,"sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58163410,7);


*FoodCode 58163420;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58163420,1,1,"sauce");
%reaggreg_ingr(58163420,2,2,sr_description);
%reaggreg_ingr(58163420,3,3,sr_description);
%reaggreg_ingr(58163420,4,4,sr_description);
%reaggreg_ingr(58163420,5,5,sr_description);
%reaggreg_ingr(58163420,6,6,sr_description);				
%reaggreg_ingr(58163420,7,1,"sauce");
%reaggreg_ingr(58163420,8,1,"sauce");
%reaggreg_ingr(58163420,9,1,"sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58163420,6);


*FoodCode 58164520;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58164520,1,1,"rice");
%reaggreg_ingr(58164520,2,2,sr_description);
%reaggreg_ingr(58164520,3,3,sr_description);
%reaggreg_ingr(58164520,4,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58164520,3);


*FoodCode 58165070;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58165070,1,1,sr_description);
%reaggreg_ingr(58165070,2,2,"gravy");
%reaggreg_ingr(58165070,3,3,sr_description);
%reaggreg_ingr(58165070,4,2,"gravy");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58165070,3);


*FoodCode 58165480;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58165480,1,1,"rice");
%reaggreg_ingr(58165480,2,2,sr_description);
%reaggreg_ingr(58165480,3,3,sr_description);
%reaggreg_ingr(58165480,4,4,sr_description);
%reaggreg_ingr(58165480,5,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58165480,4);


*FoodCode 58175110;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58175110,1,1,sr_description);
%reaggreg_ingr(58175110,2,2,sr_description);
%reaggreg_ingr(58175110,3,3,sr_description);
%reaggreg_ingr(58175110,4,4,"bulgur");
%reaggreg_ingr(58175110,5,5,sr_description);
%reaggreg_ingr(58175110,6,6,sr_description);				
%reaggreg_ingr(58175110,7,7,sr_description);
%reaggreg_ingr(58175110,8,4,"bulgur");
%reaggreg_ingr(58175110,9,4,"bulgur");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58175110,7);


*FoodCode 58200250;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58200250,1,1,food_description);
%reaggreg_ingr(58200250,2,1,food_description);
%reaggreg_ingr(58200250,3,1,food_description);
%reaggreg_ingr(58200250,4,1,food_description);
%reaggreg_ingr(58200250,5,1,food_description);
%reaggreg_ingr(58200250,6,1,food_description);				
%reaggreg_ingr(58200250,7,1,food_description);
%reaggreg_ingr(58200250,8,1,food_description);
%reaggreg_ingr(58200250,9,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58200250,1);


*FoodCode 58302000;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58302000,1,1,food_description);
%reaggreg_ingr(58302000,2,1,food_description);
%reaggreg_ingr(58302000,3,1,food_description);
%reaggreg_ingr(58302000,4,1,food_description);
%reaggreg_ingr(58302000,5,1,food_description);
%reaggreg_ingr(58302000,6,1,food_description);				
%reaggreg_ingr(58302000,7,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58302000,1);


*FoodCode 58304200;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58304200,1,1,"tomato sauce");
%reaggreg_ingr(58304200,2,2,"ravioli, cheese-filled");
%reaggreg_ingr(58304200,3,2,"ravioli, cheese-filled");
%reaggreg_ingr(58304200,4,2,"ravioli, cheese-filled");
%reaggreg_ingr(58304200,5,2,"ravioli, cheese-filled");
%reaggreg_ingr(58304200,6,2,"ravioli, cheese-filled");				
%reaggreg_ingr(58304200,7,2,"ravioli, cheese-filled");
%reaggreg_ingr(58304200,8,2,"ravioli, cheese-filled");
%reaggreg_ingr(58304200,9,1,"tomato sauce");
%reaggreg_ingr(58304200,10,2,"ravioli, cheese-filled");
%reaggreg_ingr(58304200,11,1,"tomato sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58304200,2);


*FoodCode 58305250;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58305250,1,1,sr_description);
%reaggreg_ingr(58305250,2,2,sr_description);
%reaggreg_ingr(58305250,3,3,"milky sauce");
%reaggreg_ingr(58305250,4,3,"milky sauce");
%reaggreg_ingr(58305250,5,4,sr_description);
%reaggreg_ingr(58305250,6,3,"milky sauce");				
%reaggreg_ingr(58305250,7,3,"milky sauce");
%reaggreg_ingr(58305250,8,5,sr_description);
%reaggreg_ingr(58305250,9,3,"milky sauce");
%reaggreg_ingr(58305250,10,3,"milky sauce");
%reaggreg_ingr(58305250,11,3,"milky sauce");
%reaggreg_ingr(58305250,12,6,sr_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58305250,6);


*FoodCode 58306100;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58306100,1,1,food_description);
%reaggreg_ingr(58306100,2,1,food_description);
%reaggreg_ingr(58306100,3,1,food_description);
%reaggreg_ingr(58306100,4,1,food_description);
%reaggreg_ingr(58306100,5,1,food_description);
%reaggreg_ingr(58306100,6,1,food_description);				
%reaggreg_ingr(58306100,7,1,food_description);
%reaggreg_ingr(58306100,8,1,food_description);
%reaggreg_ingr(58306100,9,1,food_description);
%reaggreg_ingr(58306100,10,1,food_description);
%reaggreg_ingr(58306100,11,1,food_description);
%reaggreg_ingr(58306100,12,1,food_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58306100,1);


*FoodCode 58310210;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(58310210,1,1,sr_description);
%reaggreg_ingr(58310210,2,2,"french toast");
%reaggreg_ingr(58310210,3,2,"french toast");
%reaggreg_ingr(58310210,4,2,"french toast");
%reaggreg_ingr(58310210,5,2,"french toast");
%reaggreg_ingr(58310210,6,2,"french toast");				
%reaggreg_ingr(58310210,7,2,"french toast");
%reaggreg_ingr(58310210,8,2,"french toast");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(58310210,2);


*FoodCode 74506000;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(74506000,1,1,sr_description);
%reaggreg_ingr(74506000,2,2,sr_description);
%reaggreg_ingr(74506000,3,3,"salad dressing");
%reaggreg_ingr(74506000,4,4,sr_description);
%reaggreg_ingr(74506000,5,3,"salad dressing");
%reaggreg_ingr(74506000,6,3,"salad dressing");				
%reaggreg_ingr(74506000,7,3,"salad dressing");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(74506000,4);


*FoodCode 271460501;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(271460501,1,1,sr_description);
%reaggreg_ingr(271460501,2,2,"hot pepper sauce");
%reaggreg_ingr(271460501,3,2,"hot pepper sauce");
%reaggreg_ingr(271460501,4,2,"hot pepper sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(271460501,2);


*FoodCode 272430001;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(272430001,1,1,sr_description);
%reaggreg_ingr(272430001,2,2,"chicken, broilers or fryers");
%reaggreg_ingr(272430001,3,3,sr_description);
%reaggreg_ingr(272430001,4,2,"chicken, broilers or fryers");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(272430001,3);


*FoodCode 272430002;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(272430002,1,1,sr_description);
%reaggreg_ingr(272430002,2,2,"chicken, broilers or fryers");
%reaggreg_ingr(272430002,3,3,sr_description);
%reaggreg_ingr(272430002,4,2,"chicken, broilers or fryers");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(272430002,3);


*FoodCode 272435001;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(272435001,1,1,"tomato sauce");
%reaggreg_ingr(272435001,2,2,sr_description);
%reaggreg_ingr(272435001,3,3,sr_description);
%reaggreg_ingr(272435001,4,4,sr_description);
%reaggreg_ingr(272435001,5,5,sr_description);
%reaggreg_ingr(272435001,6,1,"tomato sauce");				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(272435001,5);


*FoodCode 272461001;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(272461001,1,1,sr_description);
%reaggreg_ingr(272461001,2,2,"dumpling");
%reaggreg_ingr(272461001,3,2,"dumpling");
%reaggreg_ingr(272461001,4,2,"dumpling");
%reaggreg_ingr(272461001,5,2,"dumpling");
%reaggreg_ingr(272461001,6,2,"dumpling");				
%reaggreg_ingr(272461001,7,2,"dumpling");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(272461001,2);


*FoodCode 272500401;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(272500401,1,1,food_description);
%reaggreg_ingr(272500401,2,1,food_description);
%reaggreg_ingr(272500401,3,1,food_description);
%reaggreg_ingr(272500401,4,1,food_description);
%reaggreg_ingr(272500401,5,1,food_description);
%reaggreg_ingr(272500401,6,1,food_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(272500401,1);


*FoodCode 272500402;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(272500402,1,1,food_description);
%reaggreg_ingr(272500402,2,1,food_description);
%reaggreg_ingr(272500402,3,1,food_description);
%reaggreg_ingr(272500402,4,1,food_description);
%reaggreg_ingr(272500402,5,1,food_description);
%reaggreg_ingr(272500402,6,1,food_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(272500402,1);


*FoodCode 272500701;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(272500701,1,1,food_description);
%reaggreg_ingr(272500701,2,1,food_description);
%reaggreg_ingr(272500701,3,1,food_description);
%reaggreg_ingr(272500701,4,1,food_description);
%reaggreg_ingr(272500701,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(272500701,1);


*FoodCode 581003201;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581003201,1,1,food_description);
%reaggreg_ingr(581003201,2,1,food_description);
%reaggreg_ingr(581003201,3,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581003201,1);


*FoodCode 581321101;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581321101,1,1,sr_description);
%reaggreg_ingr(581321101,2,2,"tomato sauce");
%reaggreg_ingr(581321101,3,2,"tomato sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581321101,2);


*FoodCode 581323101;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581323101,1,1,sr_description);
%reaggreg_ingr(581323101,2,2,"tomato sauce");
%reaggreg_ingr(581323101,3,3,"meatballs, beef and pork");
%reaggreg_ingr(581323101,4,2,"tomato sauce");
%reaggreg_ingr(581323101,5,2,"tomato sauce");
%reaggreg_ingr(581323101,6,3,"meatballs, beef and pork");				
%reaggreg_ingr(581323101,7,3,"meatballs, beef and pork");
%reaggreg_ingr(581323101,8,3,"meatballs, beef and pork");
%reaggreg_ingr(581323101,9,3,"meatballs, beef and pork");
%reaggreg_ingr(581323101,10,4,sr_description);
%reaggreg_ingr(581323101,11,3,"meatballs, beef and pork");
%reaggreg_ingr(581323101,12,3,"meatballs, beef and pork");				
%reaggreg_ingr(581323101,13,2,"tomato sauce");
%reaggreg_ingr(581323101,14,2,"tomato sauce");
%reaggreg_ingr(581323101,15,3,"meatballs, beef and pork");				
%reaggreg_ingr(581323101,16,2,"tomato sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581323101,4);


*FoodCode 581323601;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581323601,1,1,sr_description);
%reaggreg_ingr(581323601,2,2,"tomato sauce");
%reaggreg_ingr(581323601,3,3,"meatballs, beef and pork");
%reaggreg_ingr(581323601,4,2,"tomato sauce");
%reaggreg_ingr(581323601,5,2,"tomato sauce");
%reaggreg_ingr(581323601,6,3,"meatballs, beef and pork");				
%reaggreg_ingr(581323601,7,3,"meatballs, beef and pork");
%reaggreg_ingr(581323601,8,3,"meatballs, beef and pork");
%reaggreg_ingr(581323601,9,3,"meatballs, beef and pork");
%reaggreg_ingr(581323601,10,4,sr_description);
%reaggreg_ingr(581323601,11,3,"meatballs, beef and pork");
%reaggreg_ingr(581323601,12,3,"meatballs, beef and pork");				
%reaggreg_ingr(581323601,13,2,"tomato sauce");
%reaggreg_ingr(581323601,14,2,"tomato sauce");
%reaggreg_ingr(581323601,15,3,"meatballs, beef and pork");				
%reaggreg_ingr(581323601,16,2,"tomato sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581323601,4);


*FoodCode 581329101;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581329101,1,1,sr_description);
%reaggreg_ingr(581329101,2,2,"tomato sauce");
%reaggreg_ingr(581329101,3,3,sr_description);
%reaggreg_ingr(581329101,4,4,sr_description);
%reaggreg_ingr(581329101,5,2,"tomato sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581329101,4);


*FoodCode 581451101;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581451101,1,1,food_description);
%reaggreg_ingr(581451101,2,1,food_description);
%reaggreg_ingr(581451101,3,1,food_description);
%reaggreg_ingr(581451101,4,1,food_description);
%reaggreg_ingr(581451101,5,1,food_description);
%reaggreg_ingr(581451101,6,1,food_description);				
%reaggreg_ingr(581451101,7,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581451101,1);


*FoodCode 581451102;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581451102,1,1,food_description);
%reaggreg_ingr(581451102,2,1,food_description);
%reaggreg_ingr(581451102,3,1,food_description);
%reaggreg_ingr(581451102,4,1,food_description);
%reaggreg_ingr(581451102,5,1,food_description);
%reaggreg_ingr(581451102,6,1,food_description);				
%reaggreg_ingr(581451102,7,1,food_description);				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581451102,1);


*FoodCode 581451141;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581451141,1,1,food_description);
%reaggreg_ingr(581451141,2,1,food_description);
%reaggreg_ingr(581451141,3,1,food_description);
%reaggreg_ingr(581451141,4,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581451141,1);


*FoodCode 581451142;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581451142,1,1,food_description);
%reaggreg_ingr(581451142,2,1,food_description);
%reaggreg_ingr(581451142,3,1,food_description);
%reaggreg_ingr(581451142,4,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581451142,1);


*FoodCode 581451701;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581451701,1,1,"Macaroni and cheese");
%reaggreg_ingr(581451701,2,1,"Macaroni and cheese");
%reaggreg_ingr(581451701,3,1,"Macaroni and cheese");
%reaggreg_ingr(581451701,4,1,"Macaroni and cheese");
%reaggreg_ingr(581451701,5,2,sr_description);
%reaggreg_ingr(581451701,6,1,"Macaroni and cheese");				
%reaggreg_ingr(581451701,7,1,"Macaroni and cheese");
%reaggreg_ingr(581451701,8,1,"Macaroni and cheese");				
%reaggreg_ingr(581451701,9,1,"Macaroni and cheese");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581451701,2);


*FoodCode 581473101;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581473101,1,1,food_description);
%reaggreg_ingr(581473101,2,1,food_description);
%reaggreg_ingr(581473101,3,1,food_description);
%reaggreg_ingr(581473101,4,1,food_description);
%reaggreg_ingr(581473101,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581473101,1);


*FoodCode 581473301;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581473301,1,1,food_description);
%reaggreg_ingr(581473301,2,1,food_description);
%reaggreg_ingr(581473301,3,1,food_description);
%reaggreg_ingr(581473301,4,1,food_description);
%reaggreg_ingr(581473301,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581473301,1);


*FoodCode 581473302;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581473302,1,1,food_description);
%reaggreg_ingr(581473302,2,1,food_description);
%reaggreg_ingr(581473302,3,1,food_description);
%reaggreg_ingr(581473302,4,1,food_description);
%reaggreg_ingr(581473302,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581473302,1);


*FoodCode 581473303;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581473303,1,1,food_description);
%reaggreg_ingr(581473303,2,1,food_description);
%reaggreg_ingr(581473303,3,1,food_description);
%reaggreg_ingr(581473303,4,1,food_description);
%reaggreg_ingr(581473303,5,1,food_description);
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581473303,1);


*FoodCode 581601101;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581601101,1,1,sr_description);
%reaggreg_ingr(581601101,2,2,"rice");
%reaggreg_ingr(581601101,3,3,sr_description);
%reaggreg_ingr(581601101,4,2,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581601101,3);


*FoodCode 581601102;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581601102,1,1,sr_description);
%reaggreg_ingr(581601102,2,2,"rice");
%reaggreg_ingr(581601102,3,2,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581601102,2);


*FoodCode 581601201;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581601201,1,1,sr_description);
%reaggreg_ingr(581601201,2,2,"rice");
%reaggreg_ingr(581601201,3,3,sr_description);
%reaggreg_ingr(581601201,4,2,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581601201,3);


*FoodCode 581601301;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581601301,1,1,sr_description);
%reaggreg_ingr(581601301,2,2,sr_description);
%reaggreg_ingr(581601301,3,3,sr_description);
%reaggreg_ingr(581601301,4,4,"sauce");
%reaggreg_ingr(581601301,5,5,sr_description);
%reaggreg_ingr(581601301,6,4,"sauce");				
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581601301,5);


*FoodCode 581601302;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581601302,1,1,sr_description);
%reaggreg_ingr(581601302,2,2,sr_description);
%reaggreg_ingr(581601302,3,3,sr_description);
%reaggreg_ingr(581601302,4,4,"sauce");
%reaggreg_ingr(581601302,5,4,"sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581601302,4);


*FoodCode 581623101;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581623101,1,1,"rice");
%reaggreg_ingr(581623101,2,2,sr_description);
%reaggreg_ingr(581623101,3,3,sr_description);
%reaggreg_ingr(581623101,4,1,"rice");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581623101,3);


*FoodCode 581633801;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581633801,1,1,sr_description);
%reaggreg_ingr(581633801,2,2,sr_description);
%reaggreg_ingr(581633801,3,3,"milky sauce");
%reaggreg_ingr(581633801,4,3,"milky sauce");
%reaggreg_ingr(581633801,5,3,"milky sauce");
%reaggreg_ingr(581633801,6,3,"milky sauce");				
%reaggreg_ingr(581633801,7,3,"milky sauce");
%reaggreg_ingr(581633801,8,3,"milky sauce");
%reaggreg_ingr(581633801,9,3,"milky sauce");
%reaggreg_ingr(581633801,10,3,"milky sauce");
%reaggreg_ingr(581633801,11,3,"milky sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581633801,3);

*FoodCode 581633802;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581633802,1,1,sr_description);
%reaggreg_ingr(581633802,2,2,sr_description);
%reaggreg_ingr(581633802,3,3,"milky sauce");
%reaggreg_ingr(581633802,4,3,"milky sauce");
%reaggreg_ingr(581633802,5,3,"milky sauce");
%reaggreg_ingr(581633802,6,3,"milky sauce");				
%reaggreg_ingr(581633802,7,3,"milky sauce");
%reaggreg_ingr(581633802,8,3,"milky sauce");
%reaggreg_ingr(581633802,9,3,"milky sauce");
%reaggreg_ingr(581633802,10,3,"milky sauce");
%reaggreg_ingr(581633802,11,3,"milky sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581633802,3);


*FoodCode 581634101;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581634101,1,1,sr_description);
%reaggreg_ingr(581634101,2,2,sr_description);
%reaggreg_ingr(581634101,3,3,sr_description);
%reaggreg_ingr(581634101,4,4,sr_description);
%reaggreg_ingr(581634101,5,5,sr_description);
%reaggreg_ingr(581634101,6,6,sr_description);				
%reaggreg_ingr(581634101,7,7,"sauce");
%reaggreg_ingr(581634101,8,7,"sauce");
%reaggreg_ingr(581634101,9,7,"sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581634101,7);


*FoodCode 581634102;
*%reaggreg_ingr(FoodCode,seq_num_before,seq_num_after,sr_description_after);
%reaggreg_ingr(581634102,1,1,sr_description);
%reaggreg_ingr(581634102,2,2,sr_description);
%reaggreg_ingr(581634102,3,3,sr_description);
%reaggreg_ingr(581634102,4,4,sr_description);
%reaggreg_ingr(581634102,5,5,sr_description);
%reaggreg_ingr(581634102,6,6,"sauce");
%reaggreg_ingr(581634102,7,6,"sauce");
%reaggreg_ingr(581634102,8,6,"sauce");
*new_num_ingr(FoodCode,num_ingr_new);
%new_num_ingr(581634102,6);



/*
%reaggreg_ingr(,1,1,sr_description);
%reaggreg_ingr(,2,2,sr_description);
%reaggreg_ingr(,3,3,sr_description);
%reaggreg_ingr(,4,4,sr_description);
%reaggreg_ingr(,5,5,sr_description);
%reaggreg_ingr(,6,6,sr_description);				
%reaggreg_ingr(,7,7,sr_description);
%reaggreg_ingr(,8,8,sr_description);
%reaggreg_ingr(,9,9,sr_description);
%reaggreg_ingr(,10,10,sr_description);
%reaggreg_ingr(,11,11,sr_description);
%reaggreg_ingr(,12,12,sr_description);				
%reaggreg_ingr(,13,13,sr_description);
%reaggreg_ingr(,14,14,sr_description);
%reaggreg_ingr(,15,15,sr_description);				
%reaggreg_ingr(,16,16,sr_description);
%reaggreg_ingr(,17,17,sr_description);
%reaggreg_ingr(,18,18,sr_description);
*/


/*
proc print data = by_ingredient_1;
	where foodcode = 58101350;
run;
*/


*condense reaggregated ingredients;
proc means data=by_ingredient_1 noprint;
	class foodcode food_description num_ingr seq_num sr_description sum_weight;
	ways 6;
	var weight;
	output out=by_ingredient_final sum=weight;
run;
data by_ingredient_final; set by_ingredient_final; 
	*where foodcode > 50000000;
	drop _TYPE_ _FREQ_;
run;
/*
*check;
proc print data= by_ingredient_2;
	where foodcode > 50000000;
run;
*/

/*
*check num_ingr adds up to _FREQ_;
proc means data=by_ingredient_final noprint;
	class foodcode food_description num_ingr;
	ways 3;
	var seq_num;
	output out=check mean=seq_num;
run;
proc freq data = check;						
	table num_ingr*_FREQ_ / nopercent norow nocol ;
run;

*/
