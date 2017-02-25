*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding lead exposure

Dataset Name: demo_paq_analytic_file created in external file
STAT6250-01_w17-team-4_project2_data_preparation.sas, which is 
assumed to be in the same directory as this file.

See included file for dataset properties.
;

*Environmental Setup;

*Reset the relative file import path to the current working directory;
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,
%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

*Calls the data preparation file in the current working directory.
Brings in the data preparation file;
%include '.\STAT6250-01_w17-team-4_project2_data_preparation.sas';

*******************************************************************************;
* Research Question Analysis 1;
*******************************************************************************;

title1
"Question: What is the lead exposure per race, per year for children. As a 
follow-up, what is the lead exposure change from the earlier dataset to later?"
;

title2
"Rationale: This will help us determine if certain racial groups have a higher 
propensity to lead exposure, and also whether the exposure has improved or 
not over the years."
;

footnote1
"From the results it seems Non-Hispanic Black individuals live in the highest
amounts of lead dust.Next are those of multi-racial descent."
;

footnote2
"The mean lead exposure of all races decreased from year to year, except that of
Non-Hispanic Black"
;

*
Note: 
Methodology: By using proc means, we can see that there are changes in mean
lead exposure from year to year, and race to race
;

proc means data=work.demo_lead_analytic_file;
	class survey_year race;
	var mean_ug;
	format race race. survey_year survey_year.;
run;

title;
footnote;

*******************************************************************************;
* Research Question Analysis 2;
*******************************************************************************;

title1
"Question: What is the lead exposure per country of origin and citizenship status?"
;

title2
"Rationale: This will help us determine if certain countries of origin in 
conjunction with citizenship status have a higher propensity to lead exposure."
;

footnote1
"It seems by citizenship status and country of origin, those non-citizens born
elsewhere had the highest lead exposure among all others."
;

footnote2
"Those who are citizens by birth or via naturalization had the lowest lead exposure"
;

*
Note: 
Methodology:By using proc means, we can see that there are changes in mean
lead exposure from citizenship status and country of origin.
;

proc means data=work.demo_lead_analytic_file;
	where survey_year = 3;
	class country_birth citizen;
	var mean_ug;
	format country_birth country_birth. citizen citizen.;
run;

title;
footnote;

*******************************************************************************;
* Research Question Analysis 3;
*******************************************************************************;

title1
"Question: Was there a significant difference in lead exposure in different 
parts of a room?"
;

title2
"Rationale: This would help us determine whether a great amount of lead is on
a window sill versus that of a floor."
;

footnote1
"The window sill had a much higher concentration of lead dust than the carpet"
;

*
Note: 
Methodology:By using proc means, we can see that there are differences in 
lead build up between the floor and window sill.
;

proc means data=work.demo_lead_analytic_file;
	where survey_year = 3;
	var floor_ug  window_ug;
run;

title;
footnote;