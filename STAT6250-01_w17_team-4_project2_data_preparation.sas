*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
[Dataset 1 Name] Demographic Variables and Sample Weights (DEMO_B)

[Dataset Description] The NHANES 2001-2002 Sample Person Demographics File 
provides the interview and MEC examination status variable, sample weights,
and selected demographic variables such as gender, age, race/ethnicity, 
education, marital status, country of birth, pregnancy status, total family and 
household income, and ratio of income to poverty.

[Experimental Unit Description] Individuals

[Number of Observations] 11,039

[Number of Features] 37

[Data Source] https://wwwn.cdc.gov/Nchs/Nhanes/2001-2002/DEMO_B.XPT

[Data Dictionary] https://wwwn.cdc.gov/Nchs/Nhanes/2001-2002/DEMO_B.htm

[Unique ID Schema] SEQN

 --

[Dataset 2 Name] Demographic Variables and Sample Weights (DEMO_C)

[Dataset Description] The NHANES 2003-2004 Sample Person Demographics 
File provides the interview and MEC examination status variable, 
sample weights, and selected demographic variables such as gender, age, 
race/ethnicity, education, marital status, country of birth, pregnancy
status, total family and household income, and ratio of income to 
poverty.

[Experimental Unit Description] Individuals

[Number of Observations] 10,122

[Number of Features] 44

[Data Source] https://wwwn.cdc.gov/Nchs/Nhanes/2003-2004/DEMO_C.XPT

[Data Dictionary] https://wwwn.cdc.gov/Nchs/Nhanes/2003-2004/DEMO_C.htm

[Unique ID Schema] SEQN
 
--

[Dataset 3 Name] Physical Activity (PAQ_B)

[Dataset Description] The physical activity questionnaire (PAQ) section
includes an extensive array of questions related to daily activities, 
leisure-time activities, and sedentary activities at home for the year
2001-2002.

[Experimental Unit Description] Individuals

[Number of Observations] 10,094

[Number of Features] 21

[Data Source] https://wwwn.cdc.gov/Nchs/Nhanes/2001-2002/PAQ_B.XPT

[Data Dictionary] https://wwwn.cdc.gov/Nchs/Nhanes/2001-2002/PAQ_B.htm

[Unique ID Schema] SEQN

 --

[Dataset 4 Name] Physical Activity (PAQ_C)

[Dataset Description] The physical activity questionnaire (PAQ) section 
includes an extensive array of questions related to daily activities, 
leisure-time activities, and sedentary activities at home for the year
2003-2004.

[Experimental Unit Description] Individuals

[Number of Observations] 9278

[Number of Features] 20

[Data Source] https://wwwn.cdc.gov/Nchs/Nhanes/2003-2004/PAQ_C.XPT

[Data Dictionary] https://wwwn.cdc.gov/Nchs/Nhanes/2003-2004/PAQ_C.htm

[Unique ID Schema] SEQN

--

[Dataset 5 Name] Lead - Dust  L20_B

[Dataset Description] In 1999, NHANES began to collect dust samples from the
homes of children 1–5 years of age to be tested for the presence of lead. 
Lead in dust is most often the result of old, peeling, or chipping lead-based
paint. As part of the household visit, NHANES interviewers collected separate 
dust-wipe samples from the floor and window sill of one room in the home. 
Signing of a special informed consent was required prior to the collection.

[Experimental Unit Description] Individuals

[Number of Observations] 1330

[Number of Features] 20

[Data Source] https://wwwn.cdc.gov/Nchs/Nhanes/2001-2002/L20_B.XPT

[Data Dictionary] https://wwwn.cdc.gov/Nchs/Nhanes/2001-2002/L20_B.htm

[Unique ID Schema] SEQN

-- 

[Dataset 6 Name] Lead - Dust  L20_C

[Dataset Description] In 1999, NHANES began to collect dust samples from the
homes of children 1–5 years of age to be tested for the presence of lead.
Lead in dust is most often the result of old, peeling, or chipping lead-based 
paint. As part of the household visit, NHANES interviewers collected separate
dust-wipe samples from the floor and window sill of one room in the home. 
Signing of a special informed consent was required prior to the collection.

[Experimental Unit Description] Individuals

[Number of Observations] 1267

[Number of Features] 20

[Data Source] https://wwwn.cdc.gov/Nchs/Nhanes/2003-2004/L20_C.XPT

[Data Dictionary] https://wwwn.cdc.gov/Nchs/Nhanes/2003-2004/L20_C.htm

[Unique ID Schema] SEQN

;


%let inputDataset1URL =
https://github.com/stat6250/team-4_project2/blob/master/data/DEMO_B.xls?raw=true
;
%let inputDataset1Type = XLS;
%let inputDataset1DSN = DEMO_B_raw;


%let inputDataset2URL =
https://github.com/stat6250/team-4_project2/blob/master/data/DEMO_C.xls?raw=true
;
%let inputDataset2Type = XLS;
%let inputDataset2DSN = DEMO_C_raw;


%let inputDataset3URL =
https://github.com/stat6250/team-4_project2/blob/master/data/PAQ_B.xls?raw=true
;
%let inputDataset3Type = XLS;
%let inputDataset3DSN = PAQ_B_raw;


%let inputDataset4URL =
https://github.com/stat6250/team-4_project2/blob/master/data/PAQ_C.xls?raw=true
;
%let inputDataset4Type = XLS;
%let inputDataset4DSN = PAQ_C_raw;


%let inputDataset5URL =
https://github.com/stat6250/team-4_project2/blob/master/data/L20_B%20.xls?raw=true
;
%let inputDataset5Type = XLS;
%let inputDataset5DSN = L20_B_raw;


%let inputDataset6URL =
https://github.com/stat6250/team-4_project2/blob/master/data/L20_C.xls?raw=true
;
%let inputDataset6Type = XLS;
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


* sort and check raw datasets for duplicates with respect to their unique ids,
  removing blank rows, if needed;
proc sort
        nodupkey
        data=DEMO_B_raw
        dupout=DEMO_B_raw_dups
        out=DEMO_B_raw_sorted(where=(not(missing(SEQN))))
    ;
    by
        SEQN
    ;
run;

proc sort
        nodupkey
        data=DEMO_C_raw
        dupout=DEMO_C_raw_dups
        out=DEMO_C_raw_sorted(where=(not(missing(SEQN))))
    ;
    by
        SEQN
    ;
run;

proc sort
        nodupkey
        data=PAQ_B_raw
        dupout=PAQ_B_raw_dups
        out=PAQ_B_raw_sorted(where=(not(missing(SEQN))))
    ;
    by
        SEQN
    ;
run;

proc sort
        nodupkey
        data=PAQ_C_raw
        dupout=PAQ_C_raw_dups
        out=PAQ_C_raw_sorted(where=(not(missing(SEQN))))
    ;
    by
        SEQN
    ;
run;

proc sort
        nodupkey
        data=L20_B_raw
        dupout=L20_B_raw_dups
        out=L20_B_raw_sorted(where=(not(missing(SEQN))))
    ;
    by
        SEQN
    ;
run;

proc sort
        nodupkey
        data=L20_C_raw
        dupout=L20_C_raw_dups
        out=L20_C_raw_sorted(where=(not(missing(SEQN))))
    ;
    by
        SEQN
    ;
run;

proc contents data=demo_b_raw varnum;
run;

proc contents data=demo_c_raw varnum;
run;

proc contents data=l20_b_raw varnum;
run;

proc contents data=l20_c_raw varnum;
run;

proc freq data=l20_c_raw;
run;


*Merge datasets;
data demo_lead_b;
	merge demo_b_raw (IN=A) L20_b_raw (IN=B);
	by SEQN;
	demo = A;
	L20 = B;
run;

data demo_lead_c;
	merge demo_c_raw (IN=A) L20_c_raw (IN=B);
	by SEQN;
	demo = A;
	L20 = B;
run;

proc format;
	value RIDRETH1 1 = 'Mexican American'
				   2 = 'Other Hispanic'
				   3 = 'Non-Hispanic White'
				   4 = 'Non-Hispanic Black'
				   5 = 'Other Race - Including Multi-Racial';
	value DCDSTAT 1 = 'Floor Only'
				  2 = 'Window Only'
				  3 = 'Floor and Window';
	value DCD030 2 = 'Living Room/Family Room/Den'
				 3 = 'Dining Room'
				 4 = 'Kitchen'
				 5 = 'Bedroom'
				 7 = 'Another room';
run;

data demo_lead_total;
	set demo_lead_b demo_lead_c;

	keep RIDRETH1 
		 DCDSTAT 
		 DCD030 
		 LBXDFSF 
		 LBDDWS
		 demo
		 L20;
	rename  RIDRETH1 = race
			DCDSTAT = dust_sample
			DCD030 = room_sample
			LBXDFSF = floor_ug
			LBDDWS = window_ug;
	label race = 'Reported Race';
	label dust_sample = 'Dust Sample Status';
	label room_sample = 'Room where samples taken';
	label floor_ug = 'Floor, FAAS';
	label window_ug = 'Window, FAAS';
	if demo and L20;

run;

data demo_paq_b;
    merge demo_b_raw_sorted (IN=A) paq_b_raw_sorted (IN=B);
    by SEQN;
    if A and B;
run;

data demo_paq_c;
    merge demo_c_raw_sorted (IN=A) paq_c_raw_sorted (IN=B);
    by SEQN;
    if A and B;
run;

data demo_paq_total;
    retain
        SEQN 
	PAD020
	PAQ050Q
	PAQ050U
	PAD080
	RIAGENDR
	RIDAGEYR
	INDFMINC
     ;
     keep
         SEQN 
	 PAD020
	 PAQ050Q
	 PAQ050U
	 PAD080
	 RIAGENDR
	 RIDAGEYR
	 INDFMINC
    ;
    set demo_paq_b demo_paq_c;
run;

data demo_paq_analytic_file;
    rename 
        PAD020= Walk_bike_Status
	PAQ050Q= Times_Walk_Bike
	PAQ050U= Unit_Measure
	PAD080= Minutes_Day
	RIAGENDR= Gender
	RIDAGEYR= Age
	INDFMINC= Annual_Family_Income
	
    ;
    
    
    set demo_paq_total;
run;

