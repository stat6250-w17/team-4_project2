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
%include '.\STAT6250-01_w17_team-4_project2_data_preparation.sas';

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: What is the lead exposure per race, per year for children. As a 
follow-up, what is the lead exposure change from the earlier dataset to later?
Rationale: This will help us determine if certain racial groups have a higher 
propensity to lead exposure, and also whether the exposure has improved or not over the years.
Note: 
Methodology:
;
