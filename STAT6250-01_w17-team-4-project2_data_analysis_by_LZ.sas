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
Methodology: First, create a new variable Total_Time_WalkBike, the total time
that an individual spends on walking or biking,and compute according to unit of
measure,which is the unit: day, week, and month(1="day",2="week", and 3="month"),
an individual often walks or bikes. Second, use proc sort to create a temporary
sorted table in descending by Total_Time_WalkBike' Third, use proc print to 
display the first 10 rows of the sorted dataset.
;

data walk_bike_time;
    length Total_Time_WalkBike 8 ;
    set demo_paq_analytic_file;
    if 
        Unit_Measure=1        
    then
        Total_Time_WalkBike=30*Minutes_Day;
    else if 
        Unit_Measure=2   
    then 
        Total_Time_WalkBike=4*Times_WalkBike*Minutes_Day;
    else if 
        Unit_Measure=3   
    then 
        Total_Time_WalkBike=Times_WalkBike*Minutes_Day;
    else
        Total_Time_WalkBike=0;
run;

proc sort 
        data=walk_bike_time 
        out=walk_bike_time_sorted
    ;
    by descending Total_Time_WalkBike;
run;

proc print data=walk_bike_time_sorted(obs=10);
run;



*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: Who like walking and biking based on gender, age, and annual family 
income?
Rationale:This would help to identify  if  gender, age, and annual family income
play  roles in determining people's physical activity choices. 
Note: 
Methodology: Use proc format to format gender and WalkBike_Status, and to group
age and annual_family_income to categorical variables first. Then use proc freq 
to create cross-table.
;

proc format;
     value WalkBike_Status_fmt
	 1="Yes"
	 OTHER="No"
    ;
    value Age_fmt
        low-20="<=20"
	21-30="21-30"
	31-40="31-40"
	41-50="41-50"
	51-60="51-60"
	61-70="61-70"
	71-high=">70"
     ;
     value Gender_fmt
	 1="Male"
	 2="Female"
     ;
     value Annual_Family_Income_fmt
	 low-5="<25k"
	 6-8="25-<55k"
	 9-10="55-<75k"
	 11=">75k"
	 OTHER="<25k"
     ;
run;

proc freq data=walk_bike_time;
    tables
	 WalkBike_Status*
	 (Gender Age Annual_Family_Income)
         / missing norow nofreq nopercent;
    format 
	WalkBike_Status WalkBike_Status_fmt.
        Gender Gender_fmt.
	Age Age_fmt.
	Annual_Family_Income Annual_Family_Income_fmt.
    ;      
run;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: What is the average time they spend on walking and biking in 30 days 
by gender, age, and annual family income?
Rationale: This would help to estimate the time different groups of people 
spend on walking and biking.
Note: 
Methodology: Use proc means to compute the average time they spend on walking and
biking in 30 days by gender, age, and annual family income.
;

proc means mean data=walk_bike_time;
    class Gender Age Annual_Family_Income;
    var Total_Time_WalkBike;
    where WalkBike_Status=1;
	format 
            Gender Gender_fmt.
	    Age Age_fmt.
	    Annual_Family_Income Annual_Family_Income_fmt.
	;
run;

