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
*
Question: Does the average level of physical activity each day depend on age?

Rationale: This should help identify respondents age groups who are less likely 
to be involved in physical activities or tasks around the home/yard.

Note: This will combine the DEMO(Variable RIDAGEYR) and PAQ(Variable PAQ180) 
datasets to determine the average level of physical activity for different age 
groups.


Methodology:
Link the SEQN of the DEMO_C dataset to the PAQ_C dataset and determine the 
RIDAGEYR for each SEQN. 
Use PROC FORMAT to group Age and then use the PROC MEANS to determine the 
average physical activity of each age group
;


proc format;
    value Age_fmt
        low-20=“Age group1 - below 20”
        21-30=“Age group2 - 21 to 30”
        30-40="Age group3 - 31-40"
	40-50="Age group4 - 41-50"
	50-60="Age group5 - 51-60"
	60-70="Age group6 - 61-70"
	71-high="Age group8 - 71 and above"
     ;
run;

proc means data= demo_paq_analytic_file;
    class Age;
    var Avg_level_physical_activity;
    format 
        Age Age_fmt.
    ;
run;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: How does the average time spent on physical activity vary for 
different age groups between the year 2001-2002 and 2003-2004?

Rationale: This would help identify if there is change in the physical activity 
from the precious year. 

Note: This uses the variable PAD160 from PAQ_B and RIDAGEYR from DEMO_B and 
compares it with variables PAD160 from PAQ_C and RIDAGEYR from DEMO_C

Methodology:
;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: What is the average “number of times past 30 days” (variable that 
describes that activates for strength training) for each age group ?

Rationale: This would help to estimate the time different groups of people 
spend on walking and biking.

Note: This will identify the age group of the respondents who include strength 
training in their regular activity routine.

Methodology:
;
