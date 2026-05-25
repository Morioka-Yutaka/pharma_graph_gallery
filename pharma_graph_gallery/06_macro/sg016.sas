/*** HELP START ***//*

Macro: SG016
Purpose: Reverse Kaplan-Meier plot of follow-up distribution over time.

*//*** HELP END ***/

%macro SG016;
title "SG016:Reverse Kaplan-Meier plot";
data dummy_adtte;
attrib
USUBJID label="Unique Subject Identifier" length=$20.
TRTP  label="Planned Treatment" length=$20.
TRTPN	label="Planned Treatment (N)" length=8.
PARAM  label="Parameter" length=$50.
PARAMCD label="Parameter Code" length=$20.
PARAMN  label="Parameter (N)" length=8.
AVAL  label="Analysis Value" length=8.
CNSR  label="Censor" length=8.
;
call streaminit(1982);
do TRTPN = 1 to 2;
do _USUBJID = 1 to 100;
do PARAMN = 1 to 1;
if TRTPN =1 then time =rand('WEIBULL', 1.5, 10);
else if TRTPN =2 then time =rand('WEIBULL', 1.5, 7);
else if TRTPN =3 then time =rand('WEIBULL', 1.5, 3);
else time =rand('WEIBULL', 1.5, 5);
USUBJID = cats(TRTPN,_USUBJID);
censor_limit = rand('UNIFORM') * 15;
CNSR = ^(time <= censor_limit);
AVAL = min(time, censor_limit);
TRTP = choosec(TRTPN,"Active","Placebo","ZZZZZ","Placebo");
PARAMCD = choosec(PARAMN,"PFS");
PARAM = choosec(PARAMN,"Progression Free Survival (Months)");
output;
end;
end;
end;
keep USUBJID -- CNSR;
run;
proc sort data=dummy_adtte(keep=TRTP TRTPN) out=group_fmt nodupkey;
by TRTP TRTPN;
run;
data group_fmt;
set group_fmt;
FMTNAME = "$KM_GR";
START = cats(TRTPN);
LABEL = TRTP;
run;
proc format cntlin=group_fmt;
run;
ods graphics on;
ods noresults;
ods select none;
ods output Survivalplot=SurvivalPlotData;
proc lifetest data=dummy_adtte plots=survival(atrisk=0 to 15 by 1);
time AVAL * CNSR(1);
strata TRTPN ;
run;
proc sort data=SurvivalPlotData(keep = Stratum) out=Stratum nodupkey;
by Stratum;
run;
proc sort data=SurvivalPlotData(keep = tAtRisk) out=tAtRisk nodupkey;
where ^missing(tAtRisk);
by tAtRisk;
run;
data atrisk;
set Stratum;
if _N_=1 then do;
  declare hash h1(dataset:"SurvivalPlotData(keep=Stratum tAtRisk)");
  h1.definekey("Stratum","tAtRisk");
  h1.definedone();
end;
do i=1 to obs;
  set tAtRisk nobs=obs point=i;
  AtRisk=0;
  if h1.check() ne 0 then output;
end;
run;
data SurvivalPlotData_1;
set SurvivalPlotData atrisk;
if ^missing(survival) then r_survival = 1 - survival;
 
if ^missing(Censored) then do;
  r_Censored = 1- Censored; 
  tick_marks_upper = r_Censored + 0.02;
  tick_marks_lower = r_Censored - 0.02;
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
ods results;
ods select all;
ods proclabel="SG016:Reverse Kaplan-Meier plot";
proc sgplot data=SurvivalPlotData_1 noborder noautolegend ;
  styleattrs datacontrastcolors=(blue red )
  datalinepatterns=(solid solid) ;
 
step x=time y=r_survival / group=stratum name='step' lineattrs=(thickness=2);
scatter x=time y=r_censored /noerrorcaps yerrorupper=tick_marks_upper yerrorlower=tick_marks_lower errorbarattrs=(pattern=1 thickness=2) markerattrs=(size=0) GROUP=stratum;
 
xaxistable atrisk / x=tatrisk class=stratum location=outside colorgroup=stratum valueattrs=(size=10 ) ;
keylegend 'step' / location=inside position=bottomright across=1 noborder valueattrs=(size=10) exclude=("") ;
yaxis label="Probability" min=0 values=(0 0.2 0.4 0.5 0.6 0.8 1.0 ) offsetmax=0.03;
xaxis label="Survival Time (Month)" values=(0 to 15 by 1) offsetmin=0.04 ;
format stratum $KM_GR. ;
run;

ods proclabel="SG016:Reverse Kaplan-Meier plot";
proc odstext;
p'data(*ESC*){unicode "00A0"x}dummy_adtte;';
p'attrib';
p'USUBJID(*ESC*){unicode "00A0"x}label="Unique(*ESC*){unicode "00A0"x}Subject(*ESC*){unicode "00A0"x}Identifier"(*ESC*){unicode "00A0"x}length=$20.';
p'TRTP(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}label="Planned(*ESC*){unicode "00A0"x}Treatment"(*ESC*){unicode "00A0"x}length=$20.';
p'TRTPN	label="Planned(*ESC*){unicode "00A0"x}Treatment(*ESC*){unicode "00A0"x}(N)"(*ESC*){unicode "00A0"x}length=8.';
p'PARAM(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}label="Parameter"(*ESC*){unicode "00A0"x}length=$50.';
p'PARAMCD(*ESC*){unicode "00A0"x}label="Parameter(*ESC*){unicode "00A0"x}Code"(*ESC*){unicode "00A0"x}length=$20.';
p'PARAMN(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}label="Parameter(*ESC*){unicode "00A0"x}(N)"(*ESC*){unicode "00A0"x}length=8.';
p'AVAL(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}label="Analysis(*ESC*){unicode "00A0"x}Value"(*ESC*){unicode "00A0"x}length=8.';
p'CNSR(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}label="Censor"(*ESC*){unicode "00A0"x}length=8.';
p';';
p'call(*ESC*){unicode "00A0"x}streaminit(1982);';
p'do(*ESC*){unicode "00A0"x}TRTPN(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}2;';
p'do(*ESC*){unicode "00A0"x}_USUBJID(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}100;';
p'do(*ESC*){unicode "00A0"x}PARAMN(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}1;';
p'if(*ESC*){unicode "00A0"x}TRTPN(*ESC*){unicode "00A0"x}=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}time(*ESC*){unicode "00A0"x}=rand("WEIBULL",(*ESC*){unicode "00A0"x}1.5,(*ESC*){unicode "00A0"x}10);';
p'else(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}TRTPN(*ESC*){unicode "00A0"x}=2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}time(*ESC*){unicode "00A0"x}=rand("WEIBULL",(*ESC*){unicode "00A0"x}1.5,(*ESC*){unicode "00A0"x}7);';
p'else(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}TRTPN(*ESC*){unicode "00A0"x}=3(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}time(*ESC*){unicode "00A0"x}=rand("WEIBULL",(*ESC*){unicode "00A0"x}1.5,(*ESC*){unicode "00A0"x}3);';
p'else(*ESC*){unicode "00A0"x}time(*ESC*){unicode "00A0"x}=rand("WEIBULL",(*ESC*){unicode "00A0"x}1.5,(*ESC*){unicode "00A0"x}5);';
p'USUBJID(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}cats(TRTPN,_USUBJID);';
p'censor_limit(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("UNIFORM")(*ESC*){unicode "00A0"x}*(*ESC*){unicode "00A0"x}15;';
p'CNSR(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}^(time(*ESC*){unicode "00A0"x}<=(*ESC*){unicode "00A0"x}censor_limit);';
p'AVAL(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}min(time,(*ESC*){unicode "00A0"x}censor_limit);';
p'TRTP(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}choosec(TRTPN,"Active","Placebo","ZZZZZ","Placebo");';
p'PARAMCD(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}choosec(PARAMN,"PFS");';
p'PARAM(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}choosec(PARAMN,"Progression(*ESC*){unicode "00A0"x}Free(*ESC*){unicode "00A0"x}Survival(*ESC*){unicode "00A0"x}(Months)");';
p'output;';
p'end;';
p'end;';
p'end;';
p'keep(*ESC*){unicode "00A0"x}USUBJID(*ESC*){unicode "00A0"x}--(*ESC*){unicode "00A0"x}CNSR;';
p'run;';
p'proc(*ESC*){unicode "00A0"x}sort(*ESC*){unicode "00A0"x}data=dummy_adtte(keep=TRTP(*ESC*){unicode "00A0"x}TRTPN)(*ESC*){unicode "00A0"x}out=group_fmt(*ESC*){unicode "00A0"x}nodupkey;';
p'by(*ESC*){unicode "00A0"x}TRTP(*ESC*){unicode "00A0"x}TRTPN;';
p'run;';
p'data(*ESC*){unicode "00A0"x}group_fmt;';
p'set(*ESC*){unicode "00A0"x}group_fmt;';
p'FMTNAME(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"$KM_GR";';
p'START(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}cats(TRTPN);';
p'LABEL(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}TRTP;';
p'run;';
p'proc(*ESC*){unicode "00A0"x}format(*ESC*){unicode "00A0"x}cntlin=group_fmt;';
p'run;';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}on;';
p'ods(*ESC*){unicode "00A0"x}noresults;';
p'ods(*ESC*){unicode "00A0"x}select(*ESC*){unicode "00A0"x}none;';
p'ods(*ESC*){unicode "00A0"x}output(*ESC*){unicode "00A0"x}Survivalplot=SurvivalPlotData;';
p'proc(*ESC*){unicode "00A0"x}lifetest(*ESC*){unicode "00A0"x}data=dummy_adtte(*ESC*){unicode "00A0"x}plots=survival(atrisk=0(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}15(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}1);';
p'time(*ESC*){unicode "00A0"x}AVAL(*ESC*){unicode "00A0"x}*(*ESC*){unicode "00A0"x}CNSR(1);';
p'strata(*ESC*){unicode "00A0"x}TRTPN(*ESC*){unicode "00A0"x};';
p'run;';
p'proc(*ESC*){unicode "00A0"x}sort(*ESC*){unicode "00A0"x}data=SurvivalPlotData(keep(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}Stratum)(*ESC*){unicode "00A0"x}out=Stratum(*ESC*){unicode "00A0"x}nodupkey;';
p'by(*ESC*){unicode "00A0"x}Stratum;';
p'run;';
p'proc(*ESC*){unicode "00A0"x}sort(*ESC*){unicode "00A0"x}data=SurvivalPlotData(keep(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}tAtRisk)(*ESC*){unicode "00A0"x}out=tAtRisk(*ESC*){unicode "00A0"x}nodupkey;';
p'where(*ESC*){unicode "00A0"x}^missing(tAtRisk);';
p'by(*ESC*){unicode "00A0"x}tAtRisk;';
p'run;';
p'data(*ESC*){unicode "00A0"x}atrisk;';
p'set(*ESC*){unicode "00A0"x}Stratum;';
p'if(*ESC*){unicode "00A0"x}_N_=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}declare(*ESC*){unicode "00A0"x}hash(*ESC*){unicode "00A0"x}h1(dataset:"SurvivalPlotData(keep=Stratum(*ESC*){unicode "00A0"x}tAtRisk)");';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}h1.definekey("Stratum","tAtRisk");';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}h1.definedone();';
p'end;';
p'do(*ESC*){unicode "00A0"x}i=1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}obs;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}tAtRisk(*ESC*){unicode "00A0"x}nobs=obs(*ESC*){unicode "00A0"x}point=i;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AtRisk=0;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}h1.check()(*ESC*){unicode "00A0"x}ne(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}output;';
p'end;';
p'run;';
p'data(*ESC*){unicode "00A0"x}SurvivalPlotData_1;';
p'set(*ESC*){unicode "00A0"x}SurvivalPlotData(*ESC*){unicode "00A0"x}atrisk;';
p'if(*ESC*){unicode "00A0"x}^missing(survival)(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}r_survival(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}survival;';
p'(*ESC*){unicode "00A0"x}';
p'if(*ESC*){unicode "00A0"x}^missing(Censored)(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}r_Censored(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1-(*ESC*){unicode "00A0"x}Censored;(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}tick_marks_upper(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}r_Censored(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}0.02;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}tick_marks_lower(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}r_Censored(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}0.02;';
p'end;';
p'run;';
p'(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=745(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=510(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'ods(*ESC*){unicode "00A0"x}results;';
p'ods(*ESC*){unicode "00A0"x}select(*ESC*){unicode "00A0"x}all;';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=SurvivalPlotData_1(*ESC*){unicode "00A0"x}noborder(*ESC*){unicode "00A0"x}noautolegend(*ESC*){unicode "00A0"x};';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}styleattrs(*ESC*){unicode "00A0"x}datacontrastcolors=(blue(*ESC*){unicode "00A0"x}red(*ESC*){unicode "00A0"x})';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}datalinepatterns=(solid(*ESC*){unicode "00A0"x}solid)(*ESC*){unicode "00A0"x};';
p'(*ESC*){unicode "00A0"x}';
p'step(*ESC*){unicode "00A0"x}x=time(*ESC*){unicode "00A0"x}y=r_survival(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}group=stratum(*ESC*){unicode "00A0"x}name="step"(*ESC*){unicode "00A0"x}lineattrs=(thickness=2);';
p'scatter(*ESC*){unicode "00A0"x}x=time(*ESC*){unicode "00A0"x}y=r_censored(*ESC*){unicode "00A0"x}/noerrorcaps(*ESC*){unicode "00A0"x}yerrorupper=tick_marks_upper(*ESC*){unicode "00A0"x}yerrorlower=tick_marks_lower(*ESC*){unicode "00A0"x}errorbarattrs=(pattern=1(*ESC*){unicode "00A0"x}thickness=2)(*ESC*){unicode "00A0"x}markerattrs=(size=0)(*ESC*){unicode "00A0"x}GROUP=stratum;';
p'(*ESC*){unicode "00A0"x}';
p'xaxistable(*ESC*){unicode "00A0"x}atrisk(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}x=tatrisk(*ESC*){unicode "00A0"x}class=stratum(*ESC*){unicode "00A0"x}location=outside(*ESC*){unicode "00A0"x}colorgroup=stratum(*ESC*){unicode "00A0"x}valueattrs=(size=10(*ESC*){unicode "00A0"x})(*ESC*){unicode "00A0"x};';
p'keylegend(*ESC*){unicode "00A0"x}"step"(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}location=inside(*ESC*){unicode "00A0"x}position=bottomright(*ESC*){unicode "00A0"x}across=1(*ESC*){unicode "00A0"x}noborder(*ESC*){unicode "00A0"x}valueattrs=(size=10)(*ESC*){unicode "00A0"x}exclude=("")(*ESC*){unicode "00A0"x};';
p'yaxis(*ESC*){unicode "00A0"x}label="Probability"(*ESC*){unicode "00A0"x}min=0(*ESC*){unicode "00A0"x}values=(0(*ESC*){unicode "00A0"x}0.2(*ESC*){unicode "00A0"x}0.4(*ESC*){unicode "00A0"x}0.5(*ESC*){unicode "00A0"x}0.6(*ESC*){unicode "00A0"x}0.8(*ESC*){unicode "00A0"x}1.0(*ESC*){unicode "00A0"x})(*ESC*){unicode "00A0"x}offsetmax=0.03;';
p'xaxis(*ESC*){unicode "00A0"x}label="Survival(*ESC*){unicode "00A0"x}Time(*ESC*){unicode "00A0"x}(Month)"(*ESC*){unicode "00A0"x}values=(0(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}15(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}1)(*ESC*){unicode "00A0"x}offsetmin=0.04(*ESC*){unicode "00A0"x};';
p'format(*ESC*){unicode "00A0"x}stratum(*ESC*){unicode "00A0"x}$KM_GR.(*ESC*){unicode "00A0"x};';
p'run;';
run;
title;
%mend;
