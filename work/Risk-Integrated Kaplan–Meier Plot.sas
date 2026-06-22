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
TRTP = choosec(TRTPN,"XXXXX","YYYYY","ZZZZZ","Placebo");
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
ods output Quartiles=Quartiles;
proc lifetest data=dummy_adtte plots=survival(atrisk=0 to 15 by 1 cl);
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
if ^missing(Censored) then do;
  tick_marks_upper = Censored + 0.02;
  tick_marks_lower = Censored - 0.02;
end;
dumm_y1=-0.1*stratum;
run;
proc stdize data= SurvivalPlotData_1
    out = atrisk_volum
    method=range
    add = 0
    mult = 0.09
;
where ^missing(StratumNum);
by StratumNum;
var atrisk;
run;

data SurvivalPlotData_2;
set SurvivalPlotData_1 atrisk_volum(in=ina rename=(atrisk=atrisk_band));
if ina then do;
 atrisk_band=atrisk_band -0.1*StratumNum;
 dumm_y1=-0.1*StratumNum;
 time3=time;
 call missing(of time);
end;
else do;
  if ^missing(Censored) then time2=time;
  call missing(of atrisk_band);
end;

format atrisk_band best.;
run;

ods results;
ods select all;
proc sgplot data=SurvivalPlotData_2 noborder noautolegend ;
  styleattrs datacontrastcolors=(red blue )
  datacolors=(red blue )
  datalinepatterns=(solid solid) ;

 step x=time y=survival / group=stratum name='step' lineattrs=(thickness=2);
 scatter x=time y=censored /noerrorcaps yerrorupper=tick_marks_upper yerrorlower=tick_marks_lower errorbarattrs=(pattern=1 thickness=2) markerattrs=(size=0) GROUP=stratum;
 refline 0/axis=y;
 scatter x=time2 y=dumm_y1 /markerattrs=(size=5) GROUP=stratum jitter;
 band  x=time3 upper=atrisk_band lower=dumm_y1/ group=StratumNum transparency=0.8;

 inset "At Risk Fraction & Censor (shaded band = fraction at risk, open circles = censoring times)" / position=bottomright;
 xaxistable atrisk / x=tatrisk class=stratum location=outside valueattrs=(size=10 color=black)  ;
 keylegend 'step' / location=inside position=topright across=1 noborder valueattrs=(size=10) exclude=("") ;
 
 yaxis label="Probability" min=0 values=(0 0.2 0.4 0.5 0.6 0.8 1.0 )
 offsetmin=0.25
 offsetmax=0.03;
 xaxis label="Survival Time (Month)" values=(0 to 15 by 1) offsetmin=0.03 ;
format stratum $KM_GR. ;
run;
