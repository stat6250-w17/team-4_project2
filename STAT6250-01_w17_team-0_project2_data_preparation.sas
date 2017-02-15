*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
[Team Number] team-4

--

 [Dataset 1 Name] Demographic Variables and Sample Weights (DEMO_B)

[Dataset Description] The NHANES 2001-2002 Sample Person Demographics File provides the interview and MEC examination status variable, sample weights, and selected demographic variables such as gender, age, race/ethnicity, education, marital status, country of birth, pregnancy status, total family and household income, and ratio of income to poverty.

[Experimental Unit Description] Individual

[Number of Observations] 11,039

[Number of Features] 37

[Data Source] https://wwwn.cdc.gov/Nchs/Nhanes/2001-2002/DEMO_B.XPT

[Data Dictionary] https://wwwn.cdc.gov/Nchs/Nhanes/2001-2002/DEMO_B.htm

[Unique ID Schema] The column “SEQN” which corresponds to the respondent sequence number us the unique ID in this schema.

 

[Dataset 2 Name] Demographic Variables and Sample Weights (DEMO_C)

[Dataset Description] The NHANES 2003-2004 Sample Person Demographics File provides the interview and MEC examination status variable, sample weights, and selected demographic variables such as gender, age, race/ethnicity, education, marital status, country of birth, pregnancy status, total family and household income, and ratio of income to poverty.

[Experimental Unit Description] Individual

[Number of Observations] 10,122

[Number of Features] 44

[Data Source] https://wwwn.cdc.gov/Nchs/Nhanes/2003-2004/DEMO_C.XPT

[Data Dictionary] https://wwwn.cdc.gov/Nchs/Nhanes/2003-2004/DEMO_C.htm

[Unique ID Schema] The column “SEQN” which corresponds to the respondent sequence number us the unique ID in this schema.

 

[Dataset 3 Name] Physical Activity (PAQ_B)

[Dataset Description] The physical activity questionnaire (PAQ) section includes an extensive array of questions related to daily activities, leisure-time activities, and sedentary activities at home for the year 2001-2002

[Experimental Unit Description] Individual

[Number of Observations] 10,094

[Number of Features] 21

[Data Source] https://wwwn.cdc.gov/Nchs/Nhanes/2001-2002/PAQ_B.XPT

[Data Dictionary] https://wwwn.cdc.gov/Nchs/Nhanes/2001-2002/PAQ_B.htm

[Unique ID Schema] The column “SEQN” which corresponds to the respondent sequence number us the unique ID in this schema.

 

[Dataset 4 Name] Physical Activity (PAQ_C)

[Dataset Description] The physical activity questionnaire (PAQ) section includes an extensive array of questions related to daily activities, leisure-time activities, and sedentary activities at home for the year 2003-2004

[Experimental Unit Description] Individual

[Number of Observations] 9278

[Number of Features] 20

[Data Source] https://wwwn.cdc.gov/Nchs/Nhanes/2003-2004/PAQ_C.XPT

[Data Dictionary] https://wwwn.cdc.gov/Nchs/Nhanes/2003-2004/PAQ_C.htm

[Unique ID Schema] The column “SEQN” which corresponds to the respondent sequence number us the unique ID in this schema.

 

[Dataset 5 Name] Lead - Dust  L20_B

[Dataset Description] In 1999, NHANES began to collect dust samples from the homes of children 1–5 years of age to be tested for the presence of lead. Lead in dust is most often the result of old, peeling, or chipping lead-based paint. As part of the household visit, NHANES interviewers collected separate dust-wipe samples from the floor and window sill of one room in the home. Signing of a special informed consent was required prior to the collection.

[Experimental Unit Description] Individual

[Number of Observations] 1330

[Number of Features] 20

[Data Source] https://wwwn.cdc.gov/Nchs/Nhanes/2001-2002/L20_B.XPT

[Data Dictionary] https://wwwn.cdc.gov/Nchs/Nhanes/2001-2002/L20_B.htm

[Unique ID Schema] SEQN

 

[Dataset 6 Name] Lead - Dust  L20_C

[Dataset Description] In 1999, NHANES began to collect dust samples from the homes of children 1–5 years of age to be tested for the presence of lead. Lead in dust is most often the result of old, peeling, or chipping lead-based paint. As part of the household visit, NHANES interviewers collected separate dust-wipe samples from the floor and window sill of one room in the home. Signing of a special informed consent was required prior to the collection.

[Experimental Unit Description] Individual

[Number of Observations] 1267

[Number of Features] 20

[Data Source] https://wwwn.cdc.gov/Nchs/Nhanes/2003-2004/L20_C.XPT

[Data Dictionary] https://wwwn.cdc.gov/Nchs/Nhanes/2003-2004/L20_C.htm

[Unique ID Schema] SEQN

;


%let inputDataset1URL =
https://github.com/stat6250/team-4_project2/blob/master/DEMO_B.xlsx
;
%let inputDataset1Type = XLSX;
%let inputDataset1DSN = DEMO_B_raw;


%let inputDataset2URL =
https://github.com/stat6250/team-4_project2/blob/master/DEMO_C.xlsx
;
%let inputDataset2Type = XLSX;
%let inputDataset2DSN = DEMO_C_raw;


%let inputDataset3URL =
https://github.com/stat6250/team-4_project2/blob/master/PAQ_B.xlsx
;
%let inputDataset3Type = XLSX;
%let inputDataset3DSN = PAQ_B_raw;


%let inputDataset4URL =
https://github.com/stat6250/team-4_project2/blob/master/PAQ_C.xlsx
;
%let inputDataset4Type = XLSX;
%let inputDataset4DSN = PAQ_C_raw;


%let inputDataset5URL =
https://github.com/stat6250/team-4_project2/blob/master/L20_B.xlsx
;
%let inputDataset5Type = XLSX;
%let inputDataset5DSN = L20_B_raw;


%let inputDataset6URL =
https://github.com/stat6250/team-4_project2/blob/master/L20_C.xlsx
;
%let inputDataset6Type = XLSX;
%let inputDataset6DSN = L20_C_raw;


* load raw datasets over the wire, if they doesn't already exist;
%macro loadDataIfNotAlreadyAvailable(dsn,url,filetype);
    %put &=dsn;
    %put &=url;
    %put &=filetype;
    %if
        %sysfunc(exist(&dsn.)) = 0
    %then
        %do;
            %put Loading dataset &dsn. over the wire now...;
            filename tempfile TEMP;
            proc http
                method="get"
                url="&url."
                out=tempfile
                ;
            run;
            proc import
                file=tempfile
                out=&dsn.
                dbms=&filetype.;
            run;
            filename tempfile clear;
        %end;
    %else
        %do;
            %put Dataset &dsn. already exists. Please delete and try again.;
        %end;
%mend;
%loadDataIfNotAlreadyAvailable(
    &inputDataset1DSN.,
    &inputDataset1URL.,
    &inputDataset1Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset2DSN.,
    &inputDataset2URL.,
    &inputDataset2Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset3DSN.,
    &inputDataset3URL.,
    &inputDataset3Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset4DSN.,
    &inputDataset4URL.,
    &inputDataset4Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset5DSN.,
    &inputDataset5URL.,
    &inputDataset5Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset6DSN.,
    &inputDataset6URL.,
    &inputDataset6Type.
)