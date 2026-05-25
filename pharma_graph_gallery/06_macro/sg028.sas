/*** HELP START ***//*

Macro: SG028
Purpose: Funnel plot of effect estimate versus precision.

*//*** HELP END ***/

%macro SG028;
title "SG028:Funnel Plot (Y = Precision (1/SE))";
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
precision = 1/sei;
run;

proc sql noprint;
select sum(wy)/sum(w)
     , max(precision)
     , min(yi)
     , max(yi)
into :pooled
   , :maxprec
   , :minyi
   , :maxyi
from meta_w;
quit;

%put pooled=&pooled;
%put maxprec=&maxprec;

data funnel_curve;
do precision = 0.05 to %sysevalf(&maxprec * 1.2) by 0.01;

    lower95 = &pooled - 1.96/precision;
    upper95 = &pooled + 1.96/precision;
    pooledx  = &pooled;

    output;
end;
run;

data plotdata;
length type $10 study $20;
set meta_w(in=a keep=study yi sei precision)
    funnel_curve(in=b);

if a then type = "POINT";
if b then type = "LINE";
run;

proc sql noprint;
select min(xval), max(xval)
into :xmin, :xmax
from
(
    select yi      as xval from meta_w
    outer union corr
    select lower95 as xval from funnel_curve
    outer union corr
    select upper95 as xval from funnel_curve
);
quit;

ods graphics / 
               noborder
               noscale
               width=700 px
               height=400 px
               attrpriority=none
               imagefmt=png
;
ods proclabel="SG028:Funnel Plot (Y = Precision (1/SE))";
proc sgplot data=plotdata noautolegend;
scatter x=yi y=precision /
    markerattrs=(symbol=circlefilled size=9 color=blue)
    datalabel=study;
series x=lower95 y=precision /
    lineattrs=(thickness=2);
series x=upper95 y=precision /
    lineattrs=(thickness=2);
refline &pooled / axis=x
    lineattrs=(pattern=dash thickness=2);
xaxis label="Effect Size" values=(-1 to 1);
yaxis label="Precision (1/SE)" values=(0 to 20);
run;

ods proclabel="SG028:Funnel Plot (Y = Precision (1/SE))";
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
p'';
p'data(*ESC*){unicode "00A0"x}meta_w;';
p'set(*ESC*){unicode "00A0"x}meta_dat;';
p'w(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1/(sei*sei);';
p'wy(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}w*yi;';
p'precision(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1/sei;';
p'run;';
p'';
p'proc(*ESC*){unicode "00A0"x}sql(*ESC*){unicode "00A0"x}noprint;';
p'select(*ESC*){unicode "00A0"x}sum(wy)/sum(w)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x},(*ESC*){unicode "00A0"x}max(precision)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x},(*ESC*){unicode "00A0"x}min(yi)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x},(*ESC*){unicode "00A0"x}max(yi)';
p'into(*ESC*){unicode "00A0"x}:pooled';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x},(*ESC*){unicode "00A0"x}:maxprec';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x},(*ESC*){unicode "00A0"x}:minyi';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x},(*ESC*){unicode "00A0"x}:maxyi';
p'from(*ESC*){unicode "00A0"x}meta_w;';
p'quit;';
p'';
p'%put(*ESC*){unicode "00A0"x}pooled=&pooled;';
p'%put(*ESC*){unicode "00A0"x}maxprec=&maxprec;';
p'';
p'data(*ESC*){unicode "00A0"x}funnel_curve;';
p'do(*ESC*){unicode "00A0"x}precision(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}0.05(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}%sysevalf(&maxprec(*ESC*){unicode "00A0"x}*(*ESC*){unicode "00A0"x}1.2)(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}0.01;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lower95(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}&pooled(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}1.96/precision;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}upper95(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}&pooled(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}1.96/precision;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}pooledx(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}&pooled;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'end;';
p'run;';
p'';
p'data(*ESC*){unicode "00A0"x}plotdata;';
p'length(*ESC*){unicode "00A0"x}type(*ESC*){unicode "00A0"x}$10(*ESC*){unicode "00A0"x}study(*ESC*){unicode "00A0"x}$20;';
p'set(*ESC*){unicode "00A0"x}meta_w(in=a(*ESC*){unicode "00A0"x}keep=study(*ESC*){unicode "00A0"x}yi(*ESC*){unicode "00A0"x}sei(*ESC*){unicode "00A0"x}precision)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}funnel_curve(in=b);';
p'';
p'if(*ESC*){unicode "00A0"x}a(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}type(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"POINT";';
p'if(*ESC*){unicode "00A0"x}b(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}type(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"LINE";';
p'run;';
p'';
p'proc(*ESC*){unicode "00A0"x}sql(*ESC*){unicode "00A0"x}noprint;';
p'select(*ESC*){unicode "00A0"x}min(xval),(*ESC*){unicode "00A0"x}max(xval)';
p'into(*ESC*){unicode "00A0"x}:xmin,(*ESC*){unicode "00A0"x}:xmax';
p'from';
p'(';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}select(*ESC*){unicode "00A0"x}yi(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}as(*ESC*){unicode "00A0"x}xval(*ESC*){unicode "00A0"x}from(*ESC*){unicode "00A0"x}meta_w';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}outer(*ESC*){unicode "00A0"x}union(*ESC*){unicode "00A0"x}corr';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}select(*ESC*){unicode "00A0"x}lower95(*ESC*){unicode "00A0"x}as(*ESC*){unicode "00A0"x}xval(*ESC*){unicode "00A0"x}from(*ESC*){unicode "00A0"x}funnel_curve';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}outer(*ESC*){unicode "00A0"x}union(*ESC*){unicode "00A0"x}corr';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}select(*ESC*){unicode "00A0"x}upper95(*ESC*){unicode "00A0"x}as(*ESC*){unicode "00A0"x}xval(*ESC*){unicode "00A0"x}from(*ESC*){unicode "00A0"x}funnel_curve';
p');';
p'quit;';
p'';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=700(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=400(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=plotdata(*ESC*){unicode "00A0"x}noautolegend;';
p'scatter(*ESC*){unicode "00A0"x}x=yi(*ESC*){unicode "00A0"x}y=precision(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}markerattrs=(symbol=circlefilled(*ESC*){unicode "00A0"x}size=9(*ESC*){unicode "00A0"x}color=blue)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}datalabel=study;';
p'series(*ESC*){unicode "00A0"x}x=lower95(*ESC*){unicode "00A0"x}y=precision(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lineattrs=(thickness=2);';
p'series(*ESC*){unicode "00A0"x}x=upper95(*ESC*){unicode "00A0"x}y=precision(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lineattrs=(thickness=2);';
p'refline(*ESC*){unicode "00A0"x}&pooled(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}axis=x';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lineattrs=(pattern=dash(*ESC*){unicode "00A0"x}thickness=2);';
p'xaxis(*ESC*){unicode "00A0"x}label="Effect(*ESC*){unicode "00A0"x}Size"(*ESC*){unicode "00A0"x}values=(-1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}1);';
p'yaxis(*ESC*){unicode "00A0"x}label="Precision(*ESC*){unicode "00A0"x}(1/SE)"(*ESC*){unicode "00A0"x}values=(0(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}20);';
p'run;';
run;
title;
%mend;

