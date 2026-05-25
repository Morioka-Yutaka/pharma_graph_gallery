/*** HELP START ***//*

Macro: SG027
Purpose: Funnel plot of effect estimate versus standard error.

*//*** HELP END ***/

%macro SG027;
title "SG027:Funnel Plot";
data meta_dat;
  length study $20;
  study="Study01"; yi=0.12;  sei=0.08; output;
  study="Study02"; yi=0.05;  sei=0.10; output;
  study="Study03"; yi=0.18;  sei=0.12; output;
  study="Study04"; yi=-0.02; sei=0.09; output;
  study="Study05"; yi=0.30;  sei=0.15; output;
  study="Study06"; yi=0.22;  sei=0.11; output;
  study="Study07"; yi=-0.10; sei=0.14; output;
  study="Study08"; yi=0.08;  sei=0.07; output;
  study="Study09"; yi=0.40;  sei=0.20; output;
  study="Study10"; yi=0.15;  sei=0.09; output;
run; 
data meta_w;
set meta_dat;
w = 1/(sei*sei);
wy = w*yi;
run;
 
proc sql noprint;
select sum(wy)/sum(w), max(sei)
into :pooled, :maxse
from meta_w;
quit;
 
%put pooled=&pooled;
 
data funnel_line;
do sei=0 to &maxse by 0.001;
 
    lower95=&pooled-1.96*sei;
    upper95=&pooled+1.96*sei;
 
    pooled=&pooled;
 
    output;
end;
run;
 
data plotdata;
 
set meta_dat(in=a)
    funnel_line(in=b);
 
if a then type="POINT";
if b then type="LINE";
 
run;
 
ods graphics / 
               noborder
               noscale
               width=700 px
               height=400 px
               attrpriority=none
               imagefmt=png
;
ods proclabel="SG027:Funnel Plot";
proc sgplot data=plotdata noautolegend;
scatter x=yi y=sei /
    group=type
    markerattrs=(symbol=circlefilled size=9)
    datalabel=study;
 series x=lower95 y=sei / lineattrs=(thickness=2);
 series x=upper95 y=sei / lineattrs=(thickness=2);
refline &pooled / axis=x lineattrs=(pattern=dash thickness=2);
yaxis reverse label="Standard Error";
xaxis label="Effect Size";
run;

ods proclabel="SG027:Funnel Plot";
proc odstext;
p'data(*ESC*){unicode "00A0"x}meta_dat;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}length(*ESC*){unicode "00A0"x}study(*ESC*){unicode "00A0"x}$20;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}study="Study01";(*ESC*){unicode "00A0"x}yi=0.12;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}sei=0.08;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}study="Study02";(*ESC*){unicode "00A0"x}yi=0.05;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}sei=0.10;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}study="Study03";(*ESC*){unicode "00A0"x}yi=0.18;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}sei=0.12;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}study="Study04";(*ESC*){unicode "00A0"x}yi=-0.02;(*ESC*){unicode "00A0"x}sei=0.09;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}study="Study05";(*ESC*){unicode "00A0"x}yi=0.30;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}sei=0.15;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}study="Study06";(*ESC*){unicode "00A0"x}yi=0.22;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}sei=0.11;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}study="Study07";(*ESC*){unicode "00A0"x}yi=-0.10;(*ESC*){unicode "00A0"x}sei=0.14;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}study="Study08";(*ESC*){unicode "00A0"x}yi=0.08;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}sei=0.07;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}study="Study09";(*ESC*){unicode "00A0"x}yi=0.40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}sei=0.20;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}study="Study10";(*ESC*){unicode "00A0"x}yi=0.15;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}sei=0.09;(*ESC*){unicode "00A0"x}output;';
p'run;(*ESC*){unicode "00A0"x}';
p'data(*ESC*){unicode "00A0"x}meta_w;';
p'set(*ESC*){unicode "00A0"x}meta_dat;';
p'w(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1/(sei*sei);';
p'wy(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}w*yi;';
p'run;';
p'(*ESC*){unicode "00A0"x}';
p'proc(*ESC*){unicode "00A0"x}sql(*ESC*){unicode "00A0"x}noprint;';
p'select(*ESC*){unicode "00A0"x}sum(wy)/sum(w),(*ESC*){unicode "00A0"x}max(sei)';
p'into(*ESC*){unicode "00A0"x}:pooled,(*ESC*){unicode "00A0"x}:maxse';
p'from(*ESC*){unicode "00A0"x}meta_w;';
p'quit;';
p'(*ESC*){unicode "00A0"x}';
p'%put(*ESC*){unicode "00A0"x}pooled=&pooled;';
p'(*ESC*){unicode "00A0"x}';
p'data(*ESC*){unicode "00A0"x}funnel_line;';
p'do(*ESC*){unicode "00A0"x}sei=0(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}&maxse(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}0.001;';
p'(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lower95=&pooled-1.96*sei;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}upper95=&pooled+1.96*sei;';
p'(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}pooled=&pooled;';
p'(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'end;';
p'run;';
p'(*ESC*){unicode "00A0"x}';
p'data(*ESC*){unicode "00A0"x}plotdata;';
p'(*ESC*){unicode "00A0"x}';
p'set(*ESC*){unicode "00A0"x}meta_dat(in=a)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}funnel_line(in=b);';
p'(*ESC*){unicode "00A0"x}';
p'if(*ESC*){unicode "00A0"x}a(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}type="POINT";';
p'if(*ESC*){unicode "00A0"x}b(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}type="LINE";';
p'(*ESC*){unicode "00A0"x}';
p'run;';
p'(*ESC*){unicode "00A0"x}';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=700(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=400(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=plotdata(*ESC*){unicode "00A0"x}noautolegend;';
p'scatter(*ESC*){unicode "00A0"x}x=yi(*ESC*){unicode "00A0"x}y=sei(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}group=type';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}markerattrs=(symbol=circlefilled(*ESC*){unicode "00A0"x}size=9)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}datalabel=study;';
p'(*ESC*){unicode "00A0"x}series(*ESC*){unicode "00A0"x}x=lower95(*ESC*){unicode "00A0"x}y=sei(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}lineattrs=(thickness=2);';
p'(*ESC*){unicode "00A0"x}series(*ESC*){unicode "00A0"x}x=upper95(*ESC*){unicode "00A0"x}y=sei(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}lineattrs=(thickness=2);';
p'refline(*ESC*){unicode "00A0"x}&pooled(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}axis=x(*ESC*){unicode "00A0"x}lineattrs=(pattern=dash(*ESC*){unicode "00A0"x}thickness=2);';
p'yaxis(*ESC*){unicode "00A0"x}reverse(*ESC*){unicode "00A0"x}label="Standard(*ESC*){unicode "00A0"x}Error";';
p'xaxis(*ESC*){unicode "00A0"x}label="Effect(*ESC*){unicode "00A0"x}Size";';
p'run;';

run;
title;
%mend;
