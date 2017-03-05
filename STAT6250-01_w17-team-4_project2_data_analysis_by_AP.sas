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
"Research Question: Does the average level of physical activity each day depend on age?"
;
title2
"Rationale: This should help identify respondents age groups who are less likely to be involved in physical activities or tasks around the home/yard."
;

footnote1
"All age groups appear to have answered that they walk or stand a lot during the day but donot have to carry or lift very often "
;

footnote2
"Though there is not much difference in the level of physical activity depending on age, there are 3065 missing values from the total 9278 observations."
;

footnote3
"Further analysis may be required to find if these missing values have any impact or if they are coming from a particular age group"
;

/*
Note: This will combine the DEMO(Variable RIDAGEYR) and PAQ(Variable PAQ180) 
datasets to determine the average level of physical activity for different age 
groups.


Methodology:
Link the SEQN of the DEMO_C dataset to the PAQ_C dataset and determine the 
RIDAGEYR for each SEQN. 
Use PROC FORMAT to group Age and then use the PROC MEANS to determine the 
average physical activity of each age group
;
*/

proc means data= demo_paq_analytic_file mean; 
    class Age;
    var Avg_Physical_Activity;
    where Year_of_Recording=3;
    format 
        Age Age_fmt.
    ;
	label
        Age="Age Group"
		Avg_Physical_Activity="Average Physical Activity"
    ;
  
run;

title;
footnote;



*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
title1
"Research Question: How does the average time spent on physical activity vary for different age groups between the year 2001-2002 and 2003-2004?"
;
title2
"Rationale: This would help identify if there is change in the physical activity from the precious year."
;

footnote1
"There is an increase in the average time spent on physical activity in the age group 31-60 from year 2001 to 2003"
;

footnote2
"The other age group participants have approximately remained the same."
;

footnote3
"Again there are about 6612 missing values from a total of 10094 observation from 2001 and 5835 missing values from a total of  9278 for the year 2005"
;
footnote4
"Further analysis of the missing values is certainly required."
;



/*
Note: This uses the variable PAD160 from PAQ_B and RIDAGEYR from DEMO_B and 
compares it with variables PAD160 from PAQ_C and RIDAGEYR from DEMO_C

Methodology: Link the SEQN from the DEMO dataset to the SEQN of the PAQ
dataset to determine the RIDAGEYR for each SEQN and form age bins and use the 
PROC MEANS procedure to find out the average time spent strength training
activity was performed by the particular age group for different years
;
*/

proc means data= demo_paq_analytic_file mean;
    class Age;
    var Avg_Time_Activity_2001 Avg_Time_Activity_2003;
    format 
        Age Age_fmt.
    ;
	label
        Age="Age Group"
        Avg_Time_Activity_2001="Year 2001"
        Avg_Time_Activity_2003="Year 2003"
;
run;
title;
footnote;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
title1
"Research Question: What is the average number of times in the past 30 daysù has each age group included strength training in the exercise routine?"
;
title2
"Rationale: This will identify the age group of the respondents who include strength training in their regular activity routine."
;

footnote1
"The respondants in the age group 70 and above have a higher average number of times of strength training exercise while the age group 31-40 have the least."
;

footnote2
"Also the number of missing values is 2040 of the total 9278 observations for this category"
;


/*
Note: This uses the variable PAD460 from the PAQ dataset and the RIDAGEYR 
from the DEMO dataset.

Methodology: Link the SEQN from the DEMO_C dataset to the SEQN of the PAQ_C 
dataset to determine the RIDAGEYR for each SEQN and form age bins and use the 
PROC MEANS procedure to find out the average number of times strength training
activity was performed by the particular age group.
;
*/
proc means mean data= demo_paq_analytic_file;
    class Age;
    var Avg_No_Of_Times;
    where Year_of_Recording=3;
    format 
        Age Age_fmt.
    ;
	label
        Age="Age Group"
        Avg_No_Of_Times="Strenght traning exercise"
	;

run;

title;
footnote;




