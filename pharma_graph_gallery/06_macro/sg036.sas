/*** HELP START ***//*

Macro: SG036
Purpose: Bland-Altman plot of measurement difference versus measurement mean.

*//*** HELP END ***/

%macro SG036;
title "SG036:Bland-Altman Plott";
data dummy_normal;
  call streaminit(12345);
 
  do USUBJID = 1 to 80;
    true_value = rand("normal", 50, 10);
 
    TEST_A_AVAL = true_value + rand("normal", 0, 3);
    TEST_B_AVAL = true_value + rand("normal", 0, 3);
 
    output;
  end;
 
  drop true_value;
run;
 
data plot2;
set dummy_normal;
if  n(of TEST_A_AVAL  TEST_B_AVAL) =2 then do;
  mean = mean(of TEST_A_AVAL  TEST_B_AVAL);
  diff = TEST_A_AVAL-TEST_B_AVAL;
end;
run;
proc summary data=plot2 ;
var diff;
output out=diff_std mean= stddev= /autoname;
run;
 
data plot3;
set plot2;
if _N_=1 then set diff_std;
if n(of diff_mean diff_stddev) = 2 then do;
  lower = diff_mean - diff_stddev;
  upper = diff_mean + diff_stddev;
end;
run;

ods graphics / 
               noborder
               noscale
               width=745 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
ods proclabel="SG036:Bland-Altman Plot";
proc sgplot data=plot3;
scatter x= mean y=diff;
refline 0 /axis=y;
refline lower/axis=y lineattrs=(pattern=dash);
refline upper/axis=y lineattrs=(pattern=dash);
xaxis label="Mean of two measurements";
yaxis label="Difference between the two measurements";
run;

ods proclabel="SG036:Bland-Altman Plot";
proc odstext;
p'data(*ESC*){unicode "00A0"x}dummy_normal;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}streaminit(12345);';
p'(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}USUBJID(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}80;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}true_value(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",(*ESC*){unicode "00A0"x}50,(*ESC*){unicode "00A0"x}10);';
p'(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TEST_A_AVAL(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}true_value(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}rand("normal",(*ESC*){unicode "00A0"x}0,(*ESC*){unicode "00A0"x}3);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TEST_B_AVAL(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}true_value(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}rand("normal",(*ESC*){unicode "00A0"x}0,(*ESC*){unicode "00A0"x}3);';
p'(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}drop(*ESC*){unicode "00A0"x}true_value;';
p'run;';
p'(*ESC*){unicode "00A0"x}';
p'data(*ESC*){unicode "00A0"x}plot2;';
p'set(*ESC*){unicode "00A0"x}dummy_normal;';
p'if(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}n(of(*ESC*){unicode "00A0"x}TEST_A_AVAL(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TEST_B_AVAL)(*ESC*){unicode "00A0"x}=2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}mean(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}mean(of(*ESC*){unicode "00A0"x}TEST_A_AVAL(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TEST_B_AVAL);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}diff(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}TEST_A_AVAL-TEST_B_AVAL;';
p'end;';
p'run;';
p'proc(*ESC*){unicode "00A0"x}summary(*ESC*){unicode "00A0"x}data=plot2(*ESC*){unicode "00A0"x};';
p'var(*ESC*){unicode "00A0"x}diff;';
p'output(*ESC*){unicode "00A0"x}out=diff_std(*ESC*){unicode "00A0"x}mean=(*ESC*){unicode "00A0"x}stddev=(*ESC*){unicode "00A0"x}/autoname;';
p'run;';
p'(*ESC*){unicode "00A0"x}';
p'data(*ESC*){unicode "00A0"x}plot3;';
p'set(*ESC*){unicode "00A0"x}plot2;';
p'if(*ESC*){unicode "00A0"x}_N_=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}diff_std;';
p'if(*ESC*){unicode "00A0"x}n(of(*ESC*){unicode "00A0"x}diff_mean(*ESC*){unicode "00A0"x}diff_stddev)(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lower(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}diff_mean(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}diff_stddev;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}upper(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}diff_mean(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}diff_stddev;';
p'end;';
p'run;';
p'';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=745(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=510(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=plot3;';
p'scatter(*ESC*){unicode "00A0"x}x=(*ESC*){unicode "00A0"x}mean(*ESC*){unicode "00A0"x}y=diff;';
p'refline(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}/axis=y;';
p'refline(*ESC*){unicode "00A0"x}lower/axis=y(*ESC*){unicode "00A0"x}lineattrs=(pattern=dash);';
p'refline(*ESC*){unicode "00A0"x}upper/axis=y(*ESC*){unicode "00A0"x}lineattrs=(pattern=dash);';
p'xaxis(*ESC*){unicode "00A0"x}label="Mean(*ESC*){unicode "00A0"x}of(*ESC*){unicode "00A0"x}two(*ESC*){unicode "00A0"x}measurements";';
p'yaxis(*ESC*){unicode "00A0"x}label="Difference(*ESC*){unicode "00A0"x}between(*ESC*){unicode "00A0"x}the(*ESC*){unicode "00A0"x}two(*ESC*){unicode "00A0"x}measurements";';
p'run;';
run;
title;
%mend;

