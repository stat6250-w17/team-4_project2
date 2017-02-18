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
Question: How much time are the top 10 walking and biking lovers spend on 
walking and biking  in 30 days?
Rationale: This would help to estimate the time the true walking and biking 
lovers spend.
Note: 
Methodology:
;




*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: Who like walking and biking based on gender, age, and annual family 
income?
Rationale:This would help to identify  if  gender, age, and annual family income
play  roles in determining people's physical activity choices. 
Note: 
Methodology:
;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: What is the average time they spend on walking and biking in 30 days 
by gender, age, and annual family income?
Rationale: This would help to estimate the time different groups of people 
spend on walking and biking.
Note: 
Methodology:
;
