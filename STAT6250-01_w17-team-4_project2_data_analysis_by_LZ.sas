*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding physical activities people do.

Dataset Name: demo_paq_analytic_file                created in external file
STAT6250-01_w17-team-4_project2_data_preparation.sas, which is assumed to be
in the same directory as this file.

See included file for dataset properties.
;

* environmental setup;
%let dataPrepFileName = STAT6250-01_w17-team-4_project2_data_preparation.sas;
%let sasUEFilePrefix = team-4_project2;

* load external file that generates analytic dataset
demo_paq_analytic_file using a system path dependent on the host
operating system, after setting the relative file import path to the current
directory, if using Windows;
%macro setup;
    %if
        &SYSSCP. = WIN
    %then
        %do;
            X
            "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))"""
            ;           
            %include ".\&dataPrepFileName.";
        %end;
    %else
        %do;
            %include "~/&sasUEFilePrefix./&dataPrepFileName.";
        %end;
%mend;
%setup


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
"Question: How much time are the top 10 walking or biking lovers spend on walking or biking in 30 days?"
;

title2
"Rationale: This would help to estimate the time the true walking or biking lovers spend."
;

footnote1
"Based on the output,the top 10 walking or biking lovers spend 10800 to 16800 minutes in 30 days. That is at least six hours everyday, and the fist one spends 10 hours everyday!"
;

footnote2
"Given the magnitude of these numbers, further investigation should be performed to ensure no data errors are involved."
;

footnote3
"However, assuming there are no data issues underlying this analysis, since half of them are 18-19 years old, possible explanation for such large numbers include work needs and professional training."
;

*
Note: Total_Time_WalkBike, The total time spent on walking or biking in 30 days
is roughly estimated.

Methodology:  use proc print to display the first 10 rows of the dataset that
was sorted by Total_Time_WalkBike in descending order in the data-prep file.
;

proc print data=demo_paq_analytic_file_sorted(obs=10); 
     var 
	     SEQN 
         Times_WalkBike
	     Unit_Measure
	     Minutes_Day
	     Gender
	     Age
	     Annual_Family_Income
		 Total_Time_WalkBike
	 ;

run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
"Question: Who like walking or biking based on gender, age, and annual family income?"
;

title2
"Rationale:This would help to identify if gender, age, and annual family income play roles in determining people's physical activity choices."
;

footnote1
"Based on the outputs, gender and annual family income don't play roles in determining people's physical activity choices, but age really does. Men are slightly more likely to like walking or biking than women,32.34% male and 28.75 female like walking or biking.
All annual family income groups have almost same percentage,about 28%, of people like it. However, the older people are,the less likely they like walking or biking, 47.9% people younger than 21 like it, and 30.5% people who are between 21-30 years old like it,but only 16.88% people older than 70 do. "
;

footnote2
"These outputs show that whether men or women, whether the rich or the poor, all equally like walking or biking. However, walking or biking require time and energy, so age matters in choosing it."
;

*
Methodology: Use proc format to format gender and WalkBike_Status, and to group
age and annual_family_income to categorical variables first. Then use proc freq 
to create cross-table.
;

proc freq data=demo_paq_analytic_file;
     tables
	     WalkBike_Status*
	     (Gender Age Annual_Family_Income)
         / norow nofreq nopercent;
     format 
	     WalkBike_Status WalkBike_Status_fmt.
         Gender Gender_fmt.
	     Age Age_fmt.
	     Annual_Family_Income Annual_Family_Income_fmt.
     ;      
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
"Question: What is the average time they spend on walking or biking in 30 days by gender, age, and annual family income?"
;

title2
"Rationale: This would help to estimate the time different groups of people spend on walking and biking."
;

footnote1
"Based on the output, Men spend more time on walking or biking than women. The average time is 743 minutes for men and 611 minutes for women. To surprise, people older than 70 spend the most time, 719 minutes; people who are 61-70 or younger than 21 come second, 692 minutes; and people who are 21-30 spend the least time.
Consider annual family income, the richer people are, the less time they spend on walking or biking. The people whose annual family income less than $25,000 spend 773 minutes, but people whose annual family income greater than $75,000 spend 488 minutes."
;

footnote2
"The possible explanation would be that walking or biking are time and energy consuming. Men are stronger than women in walking or biking. Seniors and students, the poor have more time to spend."
;

*
Methodology: Use proc means to compute the average time they spend on walking and
biking in 30 days by gender, age, and annual family income.
;

proc means mean data=demo_paq_analytic_file;
     class Gender;
     var Total_Time_WalkBike;
     where WalkBike_Status=1;
	 format 
         Gender Gender_fmt. 
	 ;
run;
proc means mean data=demo_paq_analytic_file;
     class Age ;
     var Total_Time_WalkBike;
     where WalkBike_Status=1;
	 format
	     Age Age_fmt.
	 ;
run;
proc means mean data=demo_paq_analytic_file;
     class Annual_Family_Income;
     var Total_Time_WalkBike;
     where WalkBike_Status=1;
	 format
	     Annual_Family_Income Annual_Family_Income_fmt.
	 ;
run;

title;
footnote;

