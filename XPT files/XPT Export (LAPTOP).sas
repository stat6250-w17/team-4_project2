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
dbms=xls
outfile='\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\DEMO_B.xls'
replace;

proc export data=DEMOC.demo_c
dbms=xls 
outfile='\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\DEMO_C.xls'
replace;

proc export data=PAQB.PAQ_B
dbms=xls
outfile='\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\PAQ_B.xls'
replace;

proc export data=PAQC.PAQ_C
dbms=xls 
outfile='\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\PAQ_C.xls'
replace;

proc export data=L20_B.L20_B
dbms=xls
outfile='\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\L20_B .xls'
replace;

proc export data=L20_C.L20_C
dbms=xls 
outfile='\\pamfrifs02\Home\gummidipundis\Documents\Github\team-4_project2\L20_C.xls'
replace;