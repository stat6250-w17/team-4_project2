libname DEMOB xport '\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\XPT files\DEMO_B.xpt'
access=readonly;

libname DEMOC xport '\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\XPT files\DEMO_C.xpt'
access=readonly;

libname PAQB xport '\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\XPT files\PAQ_B.xpt'
access=readonly;

libname PAQC xport '\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\XPT files\PAQ_C.xpt'
access=readonly;

libname L20_B xport '\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\XPT files\L20_B.xpt'
access=readonly;

libname L20_C xport '\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\XPT files\L20_C.xpt'
access=readonly;


proc export data=DEMOB.demo_b
dbms=xlsx 
outfile='\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\DEMO_B.xlsx'
replace;

proc export data=DEMOC.demo_c
dbms=xlsx 
outfile='\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\DEMO_C.xlsx'
replace;

proc export data=PAQB.PAQ_B
dbms=xlsx 
outfile='\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\PAQ_B.xlsx'
replace;

proc export data=PAQC.PAQ_C
dbms=xlsx 
outfile='\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\PAQ_C.xlsx'
replace;

proc export data=L20_B.L20_B
dbms=xlsx 
outfile='\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\L20_B .xlsx'
replace;

proc export data=L20_C.L20_C
dbms=xlsx 
outfile='\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\L20_C.xlsx'
replace;