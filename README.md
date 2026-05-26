# pharma_graph_gallery
Pharma_Graph_Gallery is a SAS package that provides a gallery of reusable graph SAS-code for pharmaceutical and clinical trial data visualization.  
<img width="359" height="359" alt="pharma_graph_gallery_small" src="https://github.com/user-attachments/assets/adc1b56f-fa8d-4719-a715-73f4b41b961e" />

## `%pharma_graph_gallery` macro <a name="pharmagraphgallery-macro-1"></a> ######

Macro: Pharma_Graph_Gallery
Purpose: Show All Graphs and Codes.

~~~sas
%pharma_graph_gallery
~~~

  
---
 
## `%sg001` <a name="sg001-macro-2"></a> ######
### Time-course plot of mean plus-minus SD in a single group.

<img width="576" height="309" alt="image" src="https://github.com/user-attachments/assets/917af268-6d24-4151-92bf-40c0a47b6aa6" />

~~~sas
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 10;
        do i = 1 to 10;
            subjid=cats(trtan,"-",i);
            if trtan=1 then AVAL = rand("normal",110,3);
            else AVAL = rand("normal",100,2);
            output;
        end;
    end;
end;
run;
proc summary data=wk1 nway;
    class AVISITN;
    var AVAL;
    output out=wk2 mean= std= /autoname;
run;
data sds;
    set wk2;
    if n(AVAL_Mean,AVAL_Stddev) = 2 then upper = AVAL_Mean + AVAL_Stddev;
    if n(AVAL_Mean,AVAL_Stddev) = 2 then lower = AVAL_Mean - AVAL_Stddev;
run;
ods graphics / 
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=sds noautolegend noborder;
    series x=AVISITN y=AVAL_Mean / markers markerattrs=(symbol=circlefilled color=blue size=9) lineattrs=(pattern=solid color=blue thickness=1) ;
    scatter x=AVISITN y=AVAL_Mean / yerrorupper=upper yerrorlower=lower errorbarattrs=(color=blue )markerattrs = (size=0);
    inset "Mean+-SD"/position=bottomright  ;
 
    xaxis offsetmin=0.05 offsetmax=0.05 values=(1 to 10 ) labelattrs=(size=10) label="Analisys Visit" type=discrete;
    yaxis offsetmax=0.05 labelattrs=(size=10) values=(90 to 120 by 5) label ="Analysis Value";
 
run ;

~~~
  
---
 
## `%sg002` <a name="sg002-macro-3"></a> ######
### Time-course plot of mean plus-minus SD by group.
<img width="584" height="310" alt="image" src="https://github.com/user-attachments/assets/044978e1-ada0-446e-81fb-b6b3cc7e7f9c" />

~~~sas
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 10;
        do i = 1 to 10;
            subjid=cats(trtan,"-",i);
            if trtan=1 then AVAL = rand("normal",110,3);
            else AVAL = rand("normal",100,2);
            output;
        end;
    end;
end;
run;
proc summary data=wk1 nway;
    class TRTAN AVISITN;
    var AVAL;
    output out=wk2 mean= std= /autoname;
run;
data sds;
    set wk2;
    if n(AVAL_Mean,AVAL_Stddev) = 2 then upper = AVAL_Mean + AVAL_Stddev;
    if n(AVAL_Mean,AVAL_Stddev) = 2 then lower = AVAL_Mean - AVAL_Stddev;
run;
 
proc format ;
value TRTAN 1="Active" 2="Placebo";
run;
 
proc sgplot data=sds noautolegend noborder;
    styleattrs datacontrastcolors=(blue red)
                  datacolors=(blue red)
                  datalinepatterns=(solid dash)
                  datasymbols=(circle circlefilled);   
 
    series x=AVISITN y=AVAL_Mean / group=TRTAN groupdisplay=cluster clusterwidth=0.1 markers markerattrs=( size=9) lineattrs=( thickness=1) name="series";
    scatter x=AVISITN y=AVAL_Mean /group=TRTAN groupdisplay=cluster clusterwidth=0.1 yerrorupper=upper yerrorlower=lower markerattrs = (size=0);
    inset "Mean+-SD"/position=bottomright  ;
 
    keylegend "series"/title=""  location=inside position=topright across=1 noborder;
 
    xaxis offsetmin=0.05 offsetmax=0.05 values=(1 to 10 ) labelattrs=(size=10) label="Analisys Visit" type=discrete;
    yaxis offsetmax=0.05 labelattrs=(size=10) values=(90 to 120 by 5) label ="Analysis Value";
format TRTAN TRTAN.;
run ;
~~~
---
 
## `%sg003`  <a name="sg003-macro-4"></a> ######
### Spaghetti plot of individual time-course profiles in a single group.

<img width="608" height="325" alt="image" src="https://github.com/user-attachments/assets/bcaaf142-d6c1-445c-b84d-8b0a74b370d9" />

~~~sas
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 10;
        do i = 1 to 10;
            subjid=cats(trtan,"-",i);
            if trtan=1 then AVAL = rand("normal",110,3);
            else AVAL = rand("normal",110,2);
            output;
        end;
    end;
end;
run;
 
ods graphics / 
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=wk1 noautolegend noborder;
    series x=AVISITN y=AVAL /group=SUBJID markers markerattrs=(symbol=circlefilled color=blue size=5) lineattrs=(pattern=solid color=blue thickness=1) ;
 
    xaxis offsetmin=0.05 offsetmax=0.05 values=(1 to 10 ) labelattrs=(size=10) label="Analisys Visit" type=linear;
    yaxis offsetmax=0.05 labelattrs=(size=10) values=(90 to 120 by 5) label ="Analysis Value";
 
run ;
~~~
  
---
 
## `%sg004` <a name="sg004-macro-5"></a> ######
### Spaghetti plot of individual time-course profiles by group.

<img width="597" height="310" alt="image" src="https://github.com/user-attachments/assets/a7407cb4-52a1-44b0-982f-8ea92796bdd4" />

~~~sas
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 10;
        do i = 1 to 10;
            subjid=cats(trtan,"-",i);
            if trtan=1 then AVAL = rand("normal",110,3);
            else AVAL = rand("normal",110,2);
            output;
        end;
    end;
end;
run;
proc format ;
value TRTAN 1="Active" 2="Placebo";
run;
 
ods graphics / reset
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=wk1 noautolegend noborder;
    styleattrs datacontrastcolors=(blue red)
    datasymbols=(circlefilled squarefilled) ;
    series x=AVISITN y=AVAL /group=SUBJID grouplc=TRTAN groupmc=TRTAN markers markerattrs=(size=5) lineattrs=(pattern=solid  thickness=1) name="series";
 
    xaxis offsetmin=0.05 offsetmax=0.05 values=(1 to 10 ) labelattrs=(size=10) label="Analisys Visit" type=linear;
    yaxis  offsetmax=0.05 labelattrs=(size=10) values=(90 to 120 by 5) label ="Analysis Value";
       keylegend "series" / title="" noborder type=linecolor valueattrs=(size=10)
         location=inside position=bottomright across=1 opaque;
format TRTAN TRTAN.;
run ;

~~~
  
---
 
## `%sg005`  <a name="sg005-macro-6"></a> ######
### Spider plot of change from baseline by group.

<img width="583" height="311" alt="image" src="https://github.com/user-attachments/assets/4c8a08a5-ca78-4e1f-a487-902af439b471" />

~~~sas
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 10;
        do i = 1 to 10;
            subjid=cats(trtan,"-",i);
            if trtan=1 then AVAL = rand("normal",110,3);
            else AVAL = rand("normal",110,2);
            output;
        end;
    end;
end;
run;
data base;
set wk1;
where AVISITN = 1;
BASE=AVAL;
keep SUBJID BASE;
run;
data sds;
set wk1;
if 0 then set base;
if _N_ = 1 then do;
  declare hash h1(dataset:"base");
  h1.definekey("SUBJID");
  h1.definedata("BASE");
  h1.definedone();
end;
if h1.find() ne 0  then call missing(of BASE);
if n(AVAL,BASE)=2then CHG = AVAL - BASE;
run;
 
proc format ;
value TRTAN 1="Active" 2="Placebo";
run;
 
ods graphics / reset
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=sds noautolegend noborder;
    styleattrs datacontrastcolors=(blue red)
    datasymbols=(circlefilled squarefilled) ;
    series x=AVISITN y=CHG /group=SUBJID grouplc=TRTAN groupmc=TRTAN markers markerattrs=(size=5) lineattrs=(pattern=solid  thickness=1) name="series" ;
    refline 0 /axis=y lineattrs=(color=gray thickness=2 pattern=dash);
    xaxis offsetmin=0.05 offsetmax=0.05 values=(1 to 10 ) labelattrs=(size=10) label="Analisys Visit" type=linear;
    yaxis  offsetmax=0.05 labelattrs=(size=10)  values=(-20 to 20 by 5) label ="Change from Baseline";
       keylegend "series" / title="" noborder type=linecolor valueattrs=(size=10) 
         location=inside position=bottomright across=1 opaque;
format TRTAN TRTAN.;
run ;

~~~
  
---
 
## `%sg006`  <a name="sg006-macro-7"></a> ######
### Semi-logarithmic line plot of mean plus SD over time.

<img width="586" height="314" alt="image" src="https://github.com/user-attachments/assets/036d8c57-190e-4034-a239-219489ed5898" />

~~~sas
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 10;
        do i = 1 to 10;
            subjid=cats(trtan,"-",i);
            if trtan=1 then AVAL = rand("normal",110,50);
            else AVAL = rand("normal",100,50);
            AVAL=(AVAL*AVISITN)**2 *0.01;
            output;
        end;
    end;
end;
run;
proc summary data=wk1 nway;
    class AVISITN;
    var AVAL;
    output out=wk2 mean= std= /autoname;
run;
data sds;
    set wk2;
    if n(AVAL_Mean,AVAL_Stddev) = 2 then upper = AVAL_Mean + AVAL_Stddev;
    if n(AVAL_Mean,AVAL_Stddev) = 2 then lower = AVAL_Mean - AVAL_Stddev;
    if upper < 0 then call missing(upper);
    if lower < 0 then call missing(lower);
run;
 
ods graphics / reset
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=sds noautolegend noborder;
where AVAL_Mean >0;
    series x=AVISITN y=AVAL_Mean / markers markerattrs=(symbol=circlefilled color=blue size=9) lineattrs=(pattern=solid color=blue thickness=1) ;
    scatter x=AVISITN y=AVAL_Mean / yerrorupper=upper errorbarattrs=(color=blue )markerattrs = (size=0);
    inset "Mean+SD"/position=bottomright  ;
    inset "Semi-Logarithmic Scale" /position=topleft textattrs=(size=10);
 
    xaxis offsetmin=0.05 offsetmax=0.05 values=(1 to 10 ) labelattrs=(size=10) label="Analisys Visit" type=discrete;
   yaxis  offsetmax=0.07 labelattrs=(size=9) label=" Plasma Concentration (ng/mL)" Type=log logstyle=logexpand  logvtype=expanded
    values=(100 1000 10000 100000 ) ;
run ;


~~~
  
---
 
## `%sg007` <a name="sg007-macro-8"></a> ######
### Time-course plot of mean plus-minus SD by treatment group with discontinuation shown separately.

<img width="594" height="308" alt="image" src="https://github.com/user-attachments/assets/7281b510-e73d-4f7a-b894-edb88475dad5" />

~~~sas
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 10;
        do i = 1 to 10;
            subjid=cats(trtan,"-",i);
            if trtan=1 then AVAL = rand("normal",110,3);
            else AVAL = rand("normal",100,2);
            output;
        end;
    end;
end;
run;
proc summary data=wk1 nway;
    class TRTAN AVISITN;
    var AVAL;
    output out=wk2 mean= std= /autoname;
run;
data sds;
    set wk2;
    if n(AVAL_Mean,AVAL_Stddev) = 2 then upper = AVAL_Mean + AVAL_Stddev;
    if n(AVAL_Mean,AVAL_Stddev) = 2 then lower = AVAL_Mean - AVAL_Stddev;
 
    if  AVISITN = 10 then do;
      AVAL_Mean2 = AVAL_Mean;
      upper2 = upper;
      lower2 = lower;
      call missing(of AVAL_Mean upper lower);
    end;
run;
 
proc format ;
value TRTAN 1="Active" 2="Placebo";
run;
 
ods graphics / reset
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=sds noautolegend noborder;
    styleattrs datacontrastcolors=(blue red)
                  datacolors=(blue red)
                  datalinepatterns=(solid dash)
                  datasymbols=(circle circlefilled);   
 
    series x=AVISITN y=AVAL_Mean / group=TRTAN groupdisplay=cluster clusterwidth=0.1 markers markerattrs=( size=9) lineattrs=( thickness=1) name="series";
    scatter x=AVISITN y=AVAL_Mean /group=TRTAN  groupdisplay=cluster clusterwidth=0.1 yerrorupper=upper yerrorlower=lower markerattrs = (size=0);
    
    scatter x=AVISITN y=AVAL_Mean2 /group=TRTAN  groupdisplay=cluster clusterwidth=0.1 yerrorupper=upper2 yerrorlower=lower2 markerattrs = (size=9);
 
    inset "Mean+-SD"/position=bottomleft  ;
 
    keylegend "series"/title=""  location=inside position=topright across=1 noborder;
 
    xaxis offsetmin=0.05 offsetmax=0.05 values=(1 to 10 ) valuesdisplay=("Baseline" "V2" "V3" "V4" "V5" "V6" "V7" "V8" "V9" "discontinuation") labelattrs=(size=10) label="Analisys Visit" type=discrete;
    yaxis  offsetmax=0.05 labelattrs=(size=10) values=(90 to 120 by 5) label ="Analysis Value";
format TRTAN TRTAN.;
run ;

~~~
  
---
 
## `%sg008` <a name="sg008-macro-9"></a> ######
### Scatter plot of two parameters by sex with a reference line.

<img width="374" height="380" alt="image" src="https://github.com/user-attachments/assets/c00e9bb4-575b-4f0d-9ba9-c4b664658e8f" />

~~~sas
data wk1;
call streaminit(777);
do SEXN=1,2;
    do AVISITN= 1 to 10;
        do i = 1 to 10;
            SUBJID=cats(SEXN,"-",i);
            if SEXN = 1 then do;
              VALUE1 = rand("normal",100,10);
              VALUE2 = VALUE1 + rand("normal",20,10);
            end;
            if SEXN = 2 then do;
              VALUE1 = rand("normal",110,20);
              VALUE2 = VALUE1 + rand("normal",30,10);
            end;
            output;
        end;
    end;
end;
run;
proc format ;
value sexn 1="Male" 2="Female";
run;
ods graphics / reset
               noborder
               noscale
               width=500 px
               height=500 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=wk1 aspect=1;
  styleattrs
     datacontrastcolors=(blue red ) 
     datasymbols=(square circle)
;
scatter x=VALUE2 y=VALUE1/group=SEXN;
keylegend/title="Sex" location=inside position=topleft opaque;
lineparm x=0 y=0 slope=1 /lineattrs=(color=gray) transparency=0.1;
xaxis grid label="Parameter 1" ;
yaxis grid label="Parameter 2";
format SEXN sexn.;
run;

~~~
  
---
 
## `%sg009` <a name="sg009-macro-10"></a> ######
### Forest plot of point estimates and confidence intervals.

<img width="521" height="376" alt="image" src="https://github.com/user-attachments/assets/3009d0ae-a5fc-4c16-8989-d8889f15c5b2" />

~~~sas
data forest_subgroup;
  length Subgroup $25 _N $8 _PER $8 _HZ $8 _HZCLM $20;
  label _N="n" _PER="　" _HZ="HR" _HZCLM="95%CL";
  Id=1; Subgroup="Age"; Count=.; Percent=.; Mean=.; Low=.; High=.; ObsId=1; indentWt=0; call missing(_N, _PER, _HZ, _HZCLM); output;
  Id=2; Subgroup="  <= 65 Yr"; Count=1534; Percent=71; Mean=1.5; Low=1.05; High=1.9; ObsId=2; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=2; Subgroup="  > 65 Yr"; Count=632; Percent=29; Mean=0.8; Low=0.6; High=1.25; ObsId=3; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=1; Subgroup="Sex"; Count=.; Percent=.; Mean=.; Low=.; High=.; ObsId=4; indentWt=0; call missing(_N, _PER, _HZ, _HZCLM); output;
  Id=2; Subgroup="  Male"; Count=1690; Percent=78; Mean=1.5; Low=1.2; High=1.8; ObsId=5; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=2; Subgroup="  Female"; Count=476; Percent=22; Mean=0.8; Low=0.6; High=1; ObsId=6; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=1; Subgroup="Race or ethnic group"; Count=.; Percent=.; Mean=.; Low=.; High=.; ObsId=7; indentWt=0; call missing(_N, _PER, _HZ, _HZCLM); output;
  Id=2; Subgroup="  Nonwhite"; Count=428; Percent=20; Mean=1.05; Low=0.6; High=1.2; ObsId=8; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=2; Subgroup="  White"; Count=1738; Percent=80; Mean=1.2; Low=0.85; High=1.6; ObsId=9; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=1; Subgroup="From XX to Randomization"; Count=.; Percent=.; Mean=.; Low=.; High=.; ObsId=10; indentWt=0; call missing(_N, _PER, _HZ, _HZCLM); output;
  Id=2; Subgroup="  <= 7 days"; Count=963; Percent=44; Mean=1.2; Low=0.8; High=1.5; ObsId=11; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=2; Subgroup="  > 7 days"; Count=1203; Percent=56; Mean=1.15; Low=0.75; High=1.5; ObsId=12; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=1; Subgroup="COMPLICATION"; Count=.; Percent=.; Mean=.; Low=.; High=.; ObsId=13; indentWt=0; call missing(_N, _PER, _HZ, _HZCLM); output;
  Id=2; Subgroup="  Yes"; Count=446; Percent=21; Mean=1.4; Low=0.9; High=2.0; ObsId=14; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=2; Subgroup="  No"; Count=720; Percent=79; Mean=1.1; Low=0.8; High=1.5; ObsId=15; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
run;
 
data output;
set forest_subgroup;
gap="";
indentWt=10;
label gap="Subgroup";
run;
 
%SGANNO
data anno;
set output(keep=Subgroup ObsId);
%sgtext(label=Subgroup , y1space="DATAVALUE", x1space="GRAPHPERCENT",textcolor="black",width=1000,x1=0,y1=ObsId,justify="LEFT",textsize=8,ANCHOR="LEFT" ) ;
run;
 
ods graphics / reset
               noborder
               noscale
               width=800 px
               height=600 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=output nowall noborder nocycleattrs noautolegend sganno = anno;
  styleattrs axisextent=data ;
  highlow y=obsid low=low high=high /highcap=serif lowcap=serif ;
  scatter y=obsid x=mean / markerattrs=(symbol=squarefilled);
  refline 1 / axis=x;
 
  yaxistable gap  /  labeljustify=left location=inside position=left labelattrs=(size=9) indentweight=indentWt ;
  yaxistable _N / location=inside position=left labelattrs=(size=9) valueattrs=(size=8);
  yaxistable _PER / location=inside position=left labelattrs=(size=9) valueattrs=(size=8);
  yaxistable _HZ / location=inside position=left labelattrs=(size=9) valueattrs=(size=8);
  yaxistable _HZCLM / location=inside position=left labelattrs=(size=9) valueattrs=(size=8);
 
  yaxis reverse display=none  offsetmin=0.05 offsetmax=0.05;
  xaxis display=(nolabel) values=(0.0 0.5 1.0 1.5 2.0 2.5) valueattrs=(size=7);
run;

~~~
  
---
 
## `%sg010` <a name="sg010-macro-11"></a> ######
### Purpose: Kaplan-Meier plot of survival probability over time.

<img width="478" height="324" alt="image" src="https://github.com/user-attachments/assets/34d86007-8d94-4813-8dab-84130e04d0c6" />

~~~sas
data dummy_adtte;
attrib
USUBJID label="Unique Subject Identifier" length=$20.
TRTP  label="Planned Treatment" length=$20.
TRTPN label="Planned Treatment (N)" length=8.
PARAM  label="Parameter" length=$50.
PARAMCD label="Parameter Code" length=$20.
PARAMN  label="Parameter (N)" length=8.
AVAL  label="Analysis Value" length=8.
CNSR  label="Censor" length=8.
;
call streaminit(1982);
do TRTPN = 1 to 4;
do _USUBJID = 1 to 100;
do PARAMN = 1 to 1;
if TRTPN =1 then time =rand("WEIBULL", 1.5, 10);
else if TRTPN =2 then time =rand("WEIBULL", 1.5, 7);
else if TRTPN =3 then time =rand("WEIBULL", 1.5, 3);
else time =rand("WEIBULL", 1.5, 5);
USUBJID = cats(TRTPN,_USUBJID);
censor_limit = rand("UNIFORM") * 15;
CNSR = ^(time <= censor_limit);
AVAL = min(time, censor_limit);
TRTP = choosec(TRTPN,"XXXXX","YYYY","ZZZZZ","Placebo");
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
if ^missing(Censored) then do;
  tick_marks_upper = Censored + 0.02;
  tick_marks_lower = Censored - 0.02;
end;
run;
 
 
ods graphics / reset
               noborder
               noscale
               width=745 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
ods results;
ods select all;
proc sgplot data=SurvivalPlotData_1 noborder noautolegend ;
  styleattrs datacontrastcolors=(black red blue green)
  datalinepatterns=(solid dash longdash shortdash) ;
 
step x=time y=survival / group=stratum name="step" lineattrs=(thickness=2);
scatter x=time y=censored /noerrorcaps yerrorupper=tick_marks_upper yerrorlower=tick_marks_lower errorbarattrs=(pattern=1 thickness=2) markerattrs=(size=0) GROUP=stratum;
 
xaxistable atrisk / x=tatrisk class=stratum location=outside colorgroup=stratum valueattrs=(size=10 ) ;
keylegend "step" / location=inside position=topright across=1 noborder valueattrs=(size=10) exclude=("") ;
yaxis label="Probability" min=0 values=(0 0.2 0.4 0.5 0.6 0.8 1.0 ) offsetmax=0.03;
xaxis label="Survival Time (Month)" values=(0 to 15 by 1) offsetmin=0.04 ;
format stratum $KM_GR. ;
 
run;

~~~
  
---
 
## `%sg011` <a name="sg011-macro-12"></a> ######
### Waterfall plot of subject-level change from baseline.

<img width="549" height="258" alt="image" src="https://github.com/user-attachments/assets/182b31d1-9ced-4ae2-b3ef-78e7243318db" />

~~~sas
proc format;
value RECIST   1="PD"  2="SD" 3="PR" 4="CR";
run;
 
data wk1;
  length SUBJID $20.;
  format RECIST RECIST.;
 
  SUBJID="1001"; PCHG=-75; RECIST=2; output;
  SUBJID="1002"; PCHG=-73; RECIST=3; output;
  SUBJID="1003"; PCHG=-51; RECIST=2; output;
  SUBJID="1004"; PCHG=-09; RECIST=2; output;
  SUBJID="1005"; PCHG=-10; RECIST=2; output;
  SUBJID="1006"; PCHG=-17; RECIST=2; output;
  SUBJID="1007"; PCHG=-100; RECIST=3; output;
  SUBJID="1008"; PCHG=-83; RECIST=3; output;
  SUBJID="1009"; PCHG=-65; RECIST=2; output;
  SUBJID="1010"; PCHG=-53; RECIST=2; output;
  SUBJID="1011"; PCHG=-100; RECIST=4; output;
  SUBJID="1012"; PCHG=-48; RECIST=3; output;
  SUBJID="1013"; PCHG=-47; RECIST=3; output;
  SUBJID="1014"; PCHG=-85; RECIST=3; output;
  SUBJID="1015"; PCHG=-58; RECIST=3; output;
  SUBJID="1016"; PCHG=54; RECIST=1; output;
  SUBJID="1017"; PCHG=-100; RECIST=4; output;
  SUBJID="1018"; PCHG=-68; RECIST=3; output;
  SUBJID="1019"; PCHG=-25; RECIST=1; output;
  SUBJID="1020"; PCHG=21; RECIST=1; output;
  SUBJID="1021"; PCHG=-87; RECIST=3; output;
  SUBJID="1022"; PCHG=-21; RECIST=2; output;
  SUBJID="1023"; PCHG=-29; RECIST=2; output;
  SUBJID="1024"; PCHG=-20; RECIST=1; output;
  SUBJID="1025"; PCHG=-43; RECIST=3; output;
  SUBJID="1026"; PCHG=-50; RECIST=3; output;
  SUBJID="1027"; PCHG=-74; RECIST=3; output;
  SUBJID="1028"; PCHG=-100; RECIST=4; output;
  SUBJID="1029"; PCHG=-36; RECIST=3; output;
  SUBJID="1030"; PCHG=-44; RECIST=3; output;
  SUBJID="1031"; PCHG=22; RECIST=2; output;
  SUBJID="1032"; PCHG=-59; RECIST=3; output;
  SUBJID="1033"; PCHG=-26; RECIST=2; output;
  SUBJID="1034"; PCHG=-89; RECIST=3; output;
  SUBJID="1035"; PCHG=-57; RECIST=3; output;
  SUBJID="1036"; PCHG=-72; RECIST=2; output;
  SUBJID="1037"; PCHG=-76; RECIST=3; output;
  SUBJID="1038"; PCHG=-66; RECIST=3; output;
  SUBJID="1039"; PCHG=-44; RECIST=3; output;
  SUBJID="1040"; PCHG=-31; RECIST=3; output;
  SUBJID="1041"; PCHG=-40; RECIST=3; output;
  SUBJID="1042"; PCHG=-57; RECIST=3; output;
  SUBJID="1043"; PCHG=-74; RECIST=3; output;
  SUBJID="1044"; PCHG=-13; RECIST=2; output;
  SUBJID="1045"; PCHG=-07; RECIST=1; output;
  SUBJID="1046"; PCHG=-05; RECIST=2; output;
  SUBJID="1047"; PCHG=-29; RECIST=2; output;
  SUBJID="1048"; PCHG=-51; RECIST=3; output;
  SUBJID="1049"; PCHG=-70; RECIST=3; output;
  SUBJID="1050"; PCHG=-35; RECIST=3; output;
  SUBJID="1051"; PCHG=-43; RECIST=3; output;
  SUBJID="1052"; PCHG=-34; RECIST=2; output;
  SUBJID="1053"; PCHG=-87; RECIST=3; output;
  SUBJID="1054"; PCHG=-34; RECIST=3; output;
  SUBJID="1055"; PCHG=-59; RECIST=3; output;
  SUBJID="1056"; PCHG=-45; RECIST=3; output;
  SUBJID="1057"; PCHG=-26; RECIST=2; output;
  SUBJID="1058"; PCHG=-22; RECIST=2; output;
  SUBJID="1059"; PCHG=-100; RECIST=4; output;
  SUBJID="1060"; PCHG=-75; RECIST=3; output;
  SUBJID="1061"; PCHG=-83; RECIST=2; output;
  SUBJID="1062"; PCHG=-38; RECIST=3; output;
  SUBJID="1063"; PCHG=-70; RECIST=3; output;
  SUBJID="1064"; PCHG=-12; RECIST=2; output;
  SUBJID="1065"; PCHG=-32; RECIST=3; output;
  SUBJID="1066"; PCHG=-15; RECIST=2; output;
  SUBJID="1067"; PCHG=-49; RECIST=3; output;
  SUBJID="1068"; PCHG=-50; RECIST=3; output;
  SUBJID="1069"; PCHG=0; RECIST=1; output;
  SUBJID="1070"; PCHG=-41; RECIST=3; output;
  SUBJID="1071"; PCHG=-41; RECIST=3; output;
  SUBJID="1072"; PCHG=-50; RECIST=3; output;
  SUBJID="1073"; PCHG=-76; RECIST=2; output;
  SUBJID="1074"; PCHG=-78; RECIST=3; output;
  SUBJID="1075"; PCHG=-18; RECIST=2; output;
  SUBJID="1076"; PCHG=0; RECIST=1; output;
  SUBJID="1077"; PCHG=44; RECIST=1; output;
  SUBJID="1078"; PCHG=-23; RECIST=2; output;
  SUBJID="1079"; PCHG=-34; RECIST=3; output;
run;
 
proc sort data=wk1 out=wk2;
   by descending PCHG RECIST SUBJID;
run;
 
data sds;
   set wk2;
   rank + 1;
run;
 
data MYMAP;
length ID VALUE LineColor $30.;
ID ="myid";
VALUE="PD";LineColor="RED";output;
VALUE="SD";LineColor="ORANGE";output;
VALUE="PR";LineColor="GREEN";output;
VALUE="CR";LineColor="BLUE";output;
run;
 
ods graphics / reset
               noborder
               noscale
               width=700 px
               height=400 px
               attrpriority=none
               imagefmt=png
;
ods graphics / reset noborder noscale  width=850px height=400px imagefmt=png;
proc sgplot data=sds noborder dattrmap=MYMAP;
   refline -0.3 / axis=y lineattrs=(pattern=shortdash);
   needle x=rank y=PCHG / baseline=0 group=RECIST
          lineattrs=(thickness=7px pattern=solid) name="needle" attrid=myid;
   xaxis offsetmin=0.01 offsetmax=0.07 label="Cumulative number of participants" values=(1, 5 to 80 by 5) integer;
   yaxis label="Change from Baseline (%)" values=(-100 to 100 by 20) valueshint;
   keylegend / title="" location=inside down=2 noborder;
   format  RECIST RECIST.;
run;
~~~
  
---
 
## `%sg012` <a name="sg012-macro-13"></a> ######
### Scatter plot of individual values and overall mean plus-minus SD by visit.

<img width="501" height="267" alt="image" src="https://github.com/user-attachments/assets/b134fd3c-8d5e-4d8b-8160-e280860f8f75" />

~~~sas
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 3;
        do i = 1 to 10;
            subjid=cats(trtan,"-",i);
            if trtan=1 then AVAL = rand("normal",110,3);
            else AVAL = rand("normal",100,2);
            output;
        end;
    end;
end;
run;
proc summary data=wk1 nway;
    class  AVISITN;
    var AVAL;
    output out=wk2 mean= std= /autoname;
run;
data summary;
    set wk2;
    if n(AVAL_Mean,AVAL_Stddev) = 2 then upper = AVAL_Mean + AVAL_Stddev;
    if n(AVAL_Mean,AVAL_Stddev) = 2 then lower = AVAL_Mean - AVAL_Stddev;
    dummy_group=3;
run;
data dummy;
 do dummy_group = 1 to 2;
     do AVISITN= 1 to 3;
      output;
    end;
 end;
run;
data sds;
set wk1
      dummy
      summary;
run;
 
proc format ;
value TRTAN 1="Active" 2="Placebo";
run;
ods graphics / reset
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=sds noborder;
  scatter x = AVISITN y=AVAL/  group= TRTAN nomissinggroup groupdisplay=cluster clusterwidth=0.2 jitter markerattrs=(symbol=circlefilled) name="scatter";
  scatter x =AVISITN y=AVAL_Mean / group=dummy_group  groupdisplay=cluster clusterwidth=0.4 yerrorupper=upper yerrorlower=lower
                                 markerattrs=(color=black size=9 symbol=squarefilled) 
                                 errorbarattrs=(color=black);
  xaxis type=discrete offsetmax=0.1;
  yaxis values=(90 to 120 by 5 ); 
  keylegend "scatter" / title="Treatment"  valueattrs=(size=10) noborder
         location=inside position=topright across=1 opaque;
 format TRTAN TRTAN.;
run;

~~~
  
---
 
## `%sg013` <a name="sg013-macro-14"></a> ######
### Clustered bar chart of rates by type and treatment group.

<img width="559" height="386" alt="image" src="https://github.com/user-attachments/assets/cd2b1aa8-ffc7-450f-a51f-83ff5dc5f7b3" />

~~~sas
data wk1;
do TRTP="Active","Placebo";
 do TYPE= "Type 1","Type 2","Type 3","Type 4";
  RATE=50 + ranuni(777)*50;
  RATEC=cats(round(RATE,0.1),"%");
  N="999";
  output;
 end; 
end;
run;
 
ods graphics / reset
               noborder
               noscale
               width=880 px
               height=610 px
               attrpriority=none
               imagefmt=png
;
data attrmap;
length id value fillcolor linecolor $20.;
id="TRTP";value="Active";fillcolor="white";linecolor="black";fillpattern="L1";output;
id="TRTP";value="Placebo";fillcolor="black";linecolor="black";fillpattern="";output;
run;
 
proc sgplot data=wk1 dattrmap=attrmap noborder;
 
vbarparm  category=TYPE response=RATE / 
          group=TRTP
          groupdisplay=cluster
          clusterwidth=0.6
          barwidth=1
  attrid=TRTP
  name="P1"
  fillpattern
;
text x=TYPE y=RATE text=RATEC/ 
          group=TRTP
          groupdisplay=cluster
          clusterwidth=0.6
  position=top
  textattrs=(color=black size=13)
;
 
xaxis valueattrs=(size=13)
       type=discrete
       display=(noticks nolabel noline)
;
yaxis label="XXXX Rate (%)"
      labelattrs=(size=13)
  valueattrs=(size=13)
  min=0
  offsetmin=0
;
 
keylegend "P1" / 
   noborder
       location=inside
       position=topright
       across=1
       title=""    valueattrs=(size=13)
;
 
  xaxistable N / x=TYPE class=TRTP location=outside valueattrs=(size=13 color=black) labelattrs=(size=13);
run;

~~~
  
---
 
## `%sg014`  <a name="sg014-macro-15"></a> ######
### Clustered bar chart of change from baseline with 95% confidence intervals over time by category.

<img width="558" height="396" alt="image" src="https://github.com/user-attachments/assets/6e93f662-c995-4db4-b11f-4a9d5ab3b655" />

~~~sas
data wk1;
do ARELTIM=1,2,8,16,24;
 ATPTN=choosen(whichn(ARELTIM,1,2,8,16,24),1,2,3,4,5);
 do cate= "Category A","Category B","Category C","Category D","Category E";
  CHG=1 + ranuni(777)*whichc(cate,"Category A","Category B","Category C","Category D","Category E");
  if CHG>4 then CHG=3;
  if cate="E" then CHG=CHG-abs(CHG)*0.8;
  HCI=CHG+abs(CHG)*0.2;
  LCI=CHG-abs(CHG)*0.1;
  if HCI>4 then ast=cats("***");
  else if HCI>3.5 then ast=cats("**");
  else ast="";
  output;
 end; 
end;
run;
 
ods graphics / reset
               noborder
               noscale
               width=880 px
               height=610 px
               attrpriority=none
               imagefmt=png
;
data attrmap;
length id value fillcolor linecolor $20.;
id="mymap1";value="Category A";fillcolor="white";linecolor="black";output;
id="mymap1";value="Category B";fillcolor="lightgray";linecolor="black";output;
id="mymap1";value="Category C";fillcolor="mediumgray";linecolor="black";output;
id="mymap1";value="Category D";fillcolor="darkgray";linecolor="black";output;
id="mymap1";value="Category E";fillcolor="gray";linecolor="black";output;
 
run;
 
ods proclabel="Clustered bar chart of change from baseline with 95% CI over time by category";
proc sgplot data=wk1 dattrmap=attrmap;;
 
vbarparm  category=ATPTN response=CHG / 
          group=cate
          groupdisplay=cluster
          clusterwidth=0.8
          barwidth=1
          baseline=1
  limitlower=LCI
  limitupper=HCI
  limitattrs=(color=black)
          x2axis
  attrid=mymap1
  name="vbarparm"
 ;
text x=ATPTN y=HCI text=ast/ 
          group=cate
          groupdisplay=cluster
          clusterwidth=0.8
  position=top
  textattrs=(color=black size=13)
;
refline 1.5 2.5 3.5 4.5  / 
          axis=x2
          lineattrs=(pattern=dash thickness=2)
;
x2axis values=(1 1.5 2 2.5 3 3.5 4 4.5 5)
       type=linear display=(novalues noticks nolabel)
;
xaxis values=(1 2 3 4 5)
       valuesdisplay=("1h" "2h" "8h" "16h" "24h")
   valueattrs=(size=13)
       type=linear
       display=(noticks nolabel)
;
yaxis max=6 offsetmin=0 min=1
      label="Change from Baseline (95% CI)"
      labelattrs=(size=14)
;
keylegend "vbarparm" / 
       location=inside
       position=topright
       across=1
       title="";
 
format ATPTN 8.;
run;
~~~
  
---
 
## `%sg015` <a name="sg015-macro-16"></a> ######
### Line plot of adjusted mean change from baseline with standard error over time by treatment group.

<img width="514" height="286" alt="image" src="https://github.com/user-attachments/assets/61e0472c-dd10-4466-8587-6dacd07d3c38" />

~~~sas
data wk1;
do TRT01PN=1 to 2;
do AVISITN=1000,1030,1080,1150,1220,1290,1360,1430,1500,1570;
if AVISITN=1000 then estimate=0;
if AVISITN=1030 & TRT01PN=2 then do;estimate=-1.89; end;
if AVISITN=1030 & TRT01PN=1 then do;estimate=-2.91; end;
 
if AVISITN=1080 & TRT01PN=2 then do;estimate=-2.53; end;
if AVISITN=1080 & TRT01PN=1 then do;estimate=-6.18; end;
 
if AVISITN=1150 & TRT01PN=2 then do;estimate=-3.01; end;
if AVISITN=1150 & TRT01PN=1 then do;estimate=-8.79; end;
 
if AVISITN=1220 & TRT01PN=2 then do;estimate=-3.71; end;
if AVISITN=1220 & TRT01PN=1 then do;estimate=-9.78; end;
 
if AVISITN=1290 & TRT01PN=2 then do;estimate=-3.50; end;
if AVISITN=1290 & TRT01PN=1 then do;estimate=-10.78; end;
 
if AVISITN=1360 & TRT01PN=2 then do;estimate=-3.42; end;
if AVISITN=1360 & TRT01PN=1 then do;estimate=-11.92; end;
 
if AVISITN=1430 & TRT01PN=2 then do;estimate=-3.15; end;
if AVISITN=1430 & TRT01PN=1 then do;estimate=-11.83; end;
 
if AVISITN=1500 & TRT01PN=2 then do;estimate=-3.91; end;
if AVISITN=1500 & TRT01PN=1 then do;estimate=-12.14; end;
 
if AVISITN=1570 & TRT01PN=2 then do;estimate=-3.34; end;
if AVISITN=1570 & TRT01PN=1 then do;estimate=-12.56; end;
output;
end;
end;
run;
 
data wk2;
length out1-out3 $20.;
set wk1;
if TRT01PN=1  then do;
 upper=estimate+(estimate*0.2);
 lower=estimate-(estimate*0.2);
end;
if TRT01PN=2  then do;
 upper=estimate+(estimate*0.6);
 lower=estimate-(estimate*0.6);
end;
 
out1="XXX";
out2="XXX";
out3="XXX";
 
if AVISITN in (1150) then do;
out3="0.042 * ";
astarisk_y=round(Estimate +0.2,1e-10);
end;
if AVISITN in (1290,1360) then do;
out3="<.0001 *";
astarisk_y=round(Estimate +0.2,1e-10);
end;
 
astarisk="   *";
 
 
run;
 
proc format ;
value TRT01PN 1="Active" 2="Placebo";
run;
ods graphics / reset
               noborder
               noscale
               width=780 px
               height=450 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=wk2 noborder ;
styleattrs datacontrastcolors=(black black)
   datalinepatterns=( solid dash)
                   datasymbols=(  CircleFilled circle); 
 
series x=AVISITN y=estimate /group=trt01pn groupdisplay=cluster clusterwidth=0.2  markers markerattrs = (size=8) name="name1";
 
scatter x=AVISITN y=estimate/group=trt01pn  groupdisplay=cluster clusterwidth=0.2 yerrorupper=upper yerrorlower=lower 
                                  markerattrs = (size=0);
text x=AVISITN y=astarisk_y text=astarisk/group=trt01pn  groupdisplay=cluster clusterwidth=0.2 position=TOPRIGHT;
 
 
refline 0 / axis=y lineattrs=(pattern=shortdash);
 
keylegend "name1"/title=""  exclude=(".") location=inside position=topright across=1 noborder valueattrs=(size=10) sortorder=ascending;
 
xaxis offsetmin=0.02 offsetmax=0.1 values=(1000,1030,1080,1150,1220,1290,1360,1430,1500,1570) 
                                                        valuesdisplay=("Baseline" "3" "8" "15" "22" "29" "36" "43" "50" "57") type=discrete labelattrs=(size=12) label="Time point (Day)";
yaxis  offsetmax=0.05  labelattrs=(size=12)  values=(-20 to 2 by 2 ) valuesdisplay=("" "" "" "" "" "" "" "" "" "" "0") label="Adjusted Mean (SE) in Change from Baseline";
 
  xaxistable  out1/ x=AVISITN valueattrs=(size=9) location=outside label="Difference";
  xaxistable  out2/ x=AVISITN valueattrs=(size=9) location=outside label="[95％ CI]";
  xaxistable  out3/ x=AVISITN valueattrs=(size=9) location=outside label="p-value";
 
  format trt01pn trt01pn.;
run ;
~~~
  
---
 
## `%sg016` <a name="sg016-macro-17"></a> ######
### Reverse Kaplan-Meier plot of follow-up distribution over time.

<img width="486" height="325" alt="image" src="https://github.com/user-attachments/assets/8e008a01-8ffe-49af-bd23-f483e26ef658" />

~~~sas
data dummy_adtte;
attrib
USUBJID label="Unique Subject Identifier" length=$20.
TRTP  label="Planned Treatment" length=$20.
TRTPN label="Planned Treatment (N)" length=8.
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
if TRTPN =1 then time =rand("WEIBULL", 1.5, 10);
else if TRTPN =2 then time =rand("WEIBULL", 1.5, 7);
else if TRTPN =3 then time =rand("WEIBULL", 1.5, 3);
else time =rand("WEIBULL", 1.5, 5);
USUBJID = cats(TRTPN,_USUBJID);
censor_limit = rand("UNIFORM") * 15;
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
 
 
ods graphics / reset
               noborder
               noscale
               width=745 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
ods results;
ods select all;
proc sgplot data=SurvivalPlotData_1 noborder noautolegend ;
  styleattrs datacontrastcolors=(blue red )
  datalinepatterns=(solid solid) ;
 
step x=time y=r_survival / group=stratum name="step" lineattrs=(thickness=2);
scatter x=time y=r_censored /noerrorcaps yerrorupper=tick_marks_upper yerrorlower=tick_marks_lower errorbarattrs=(pattern=1 thickness=2) markerattrs=(size=0) GROUP=stratum;
 
xaxistable atrisk / x=tatrisk class=stratum location=outside colorgroup=stratum valueattrs=(size=10 ) ;
keylegend "step" / location=inside position=bottomright across=1 noborder valueattrs=(size=10) exclude=("") ;
yaxis label="Probability" min=0 values=(0 0.2 0.4 0.5 0.6 0.8 1.0 ) offsetmax=0.03;
xaxis label="Survival Time (Month)" values=(0 to 15 by 1) offsetmin=0.04 ;
format stratum $KM_GR. ;
run;

~~~
  
---
 
## `%sg017`  <a name="sg017-macro-18"></a> ######
### Box plot of analysis values over visits by treatment group.

<img width="498" height="268" alt="image" src="https://github.com/user-attachments/assets/ceea8028-de4e-485c-bce1-e6d01b6172c0" />

~~~sas
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 5;
        do i = 1 to 100;
            subjid=cats(trtan,"-",i);
            if trtan=1 then AVAL = rand("normal",110,3);
            else AVAL = rand("normal",100,2);
            if rand("UNIFORM") <0.01 then AVAL = rand("normal",120,30);
            output;
        end;
    end;
end;
run;
 
proc format ;
value TRTAN 1="Active" 2="Placebo";
run;
 
ods graphics / reset
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=wk1 noautolegend noborder;
    styleattrs datacontrastcolors=(black black)
                  datacolors=(white gray);
    vbox AVAL / category=AVISITN group=TRTAN name="vbox"
    meanattrs= (symbol = circle size=7)
    outlierattrs=(symbol = plus size=7)
;
 
    keylegend "vbox"/title=""  location=inside position=topright across=1 noborder;
 
    xaxis offsetmin=0.1 offsetmax=0.1 values=(1 to 5 ) labelattrs=(size=10) label="Analisys Visit" type=discrete;
    yaxis  offsetmax=0.05 labelattrs=(size=10) values=(80 to 130 by 10) label ="Analysis Value";
format TRTAN TRTAN.;
run ;
~~~
  
---
 
## `%sg018`  <a name="sg018-macro-19"></a> ######
### Box plot with overlaid beeswarm points.

<img width="491" height="259" alt="image" src="https://github.com/user-attachments/assets/f77141bc-5c2f-4263-bdc9-6996b4fc9b0b" />

~~~sas
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 3;
        do i = 1 to 100;
            subjid=cats(trtan,"-",i);
            if trtan=1 then AVAL = rand("normal",110,3);
            else AVAL = rand("normal",100,2);
            if rand("UNIFORM") <0.01 then AVAL = rand("normal",120,30);
            output;
        end;
    end;
end;
run;
 
proc format ;
value TRTAN 1="Active" 2="Placebo";
run;
 
ods graphics / reset
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=wk1 noautolegend noborder;
    styleattrs datacontrastcolors=(black black)
                  datacolors=(white gray);
    vbox AVAL / category=AVISITN group=TRTAN groupdisplay=cluster  clusterwidth=0.8 name="vbox" nooutliers
    meanattrs= (symbol = diamondFilled size=7)
;
  scatter x=AVISITN y=AVAL / group=TRTAN  groupdisplay=cluster  clusterwidth=0.8  name="sp1"
              transparency=0.5 jitter markerattrs=(symbol=circle size=5)
              ;
 
    keylegend "vbox"/title=""  location=inside position=topright across=1 noborder;
 
    xaxis offsetmin=0.2 offsetmax=0.2 values=(1 to 3 ) labelattrs=(size=10) label="Analisys Visit" type=discrete;
    yaxis  offsetmax=0.1 offsetmin=0.1  labelattrs=(size=10) values=(90 to 120 by 10) label ="Analysis Value";
format TRTAN TRTAN.;
run ;
~~~

---
 
## `%sg019`  <a name="sg019-macro-20"></a> ######
### Violin plot of distribution by group.

<img width="382" height="328" alt="image" src="https://github.com/user-attachments/assets/9707ae5a-c770-4a86-bd16-e6a375059db4" />

~~~sas
data wk1;
do TRT01PN = 1 to 2;
 if  TRT01PN = 1 then do;
  do id=1 to 200;
          SUBJID = cats(TRT01PN,"-",id);
          AVAL=rand("normal",10,5) ;
          output;
  end;
  do id=201 to 400;
          SUBJID = cats(TRT01PN,"-",id);
          AVAL=rand("normal",23,6);
          output;
  end;
 end;
 if  TRT01PN = 2 then do;
  do id=1 to 300;
          SUBJID = cats(TRT01PN,"-",id);
          AVAL=rand("normal",7,5) ;
          output;
  end;
  do id=301 to 400;
          SUBJID = cats(TRT01PN,"-",id);
          AVAL=rand("normal",18,6);
          output;
  end;
 end;
end;
run;
 
proc kde data = wk1;
univar AVAL /out=wk2 ;
by TRT01PN;
run;
 
data sds;
  set wk2;
    mirror = -density;
run;
 
proc format ;
value TRT01PN 1="Active" 2="Placebo";
run;
 
ods graphics / reset
               noborder
               noscale
               width=580 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=sds noautolegend noborder;
band y=value upper=density lower=mirror /  fill outline group=TRT01PN transparency=0.6 lineattrs=(pattern=solid) name="band";
xaxis values=(-0.1 to 0.1 by 0.02 ) ;
keylegend "band"/title=""  location=inside position=topright across=1 noborder;
format TRT01PN TRT01PN.;
run;

~~~
  
---
 
## `%sg020`  <a name="sg020-macro-21"></a> ######
### Raincloud plot showing distribution, box summary, and individual values.

<img width="507" height="292" alt="image" src="https://github.com/user-attachments/assets/484532b5-e21f-4604-bdf8-21e2d086e4ed" />

~~~sas
data wk1;
call streaminit(1080);
do id=1 to 200;
        SUBJID = cats(id);
        AVAL=rand("normal",10,5);
        output;
end;
do id=201 to 400;
        SUBJID = cats(id);
        AVAL=rand("normal",30,5);
        output;
end;
 
run;
proc kde data = wk1;
   univar AVAL / out = kde;
run;
data sds;
   set kde wk1;
run; 
 
options orientation=landscape;
ods graphics / reset
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
proc template;
   define statgraph RCP;
      begingraph;
         layout overlay
            / xaxisopts = (label      = " "
                           type       = linear
                           linearopts = (viewmin = -20
                                         viewmax = 60
                                         tickvaluesequence = (start = -20 end = 60 increment = 10)))
              yaxisopts = (label = " ")
              walldisplay=none
              ;
            bandplot x = value limitlower = 0 limitupper = density
               / display = (fill) ;
            boxplot y = aval x = eval(-0.02 + coalesce(0, aval))
               / orient   = horizontal
                 boxwidth = 0.3
                 ;
            scatterplot x = aval y = eval(-0.05 + 0.01*cdf("NORMAL", rannor(1234)) + coalesce(0, aval))
               / markerattrs = (symbol = circle size = 8 transparency = 0.4)
                 ;
         endlayout;
      endgraph;
   end;
run;
proc sgrender data = sds template = RCP ;
run;

~~~
  
---
 
## `%sg022` <a name="sg022-macro-22"></a> ######
### Subject-level profile plot in a crossover study.

<img width="378" height="327" alt="image" src="https://github.com/user-attachments/assets/aa0b9e0d-dc18-4a63-ad71-c7fbf6bb5ff6" />

~~~sas
data wk1;
length TRTAN 8.  SUBJID $20.  AVAL 8.;
call streaminit(777);
do TRTAN=1 to 2;
  do sub = 1 to 20;
    if sub <=10 then TRT01AN=1;
    else  TRT01AN=2;
    SUBJID=put(sub,z3.);
      if TRTAN=1 then AVAL = rand("normal", 20, 2);
      if TRTAN=2 then AVAL = rand("normal", 21, 3);
      output;
   end;
end;
keep TRTAN TRT01AN SUBJID AVAL;
run;
proc format ;
value TRT01AN 1= "Active to Placebo sequence (Active/Placebo)" 2="Placebo to Active sequence (Placebo/Active)";
run;
ods graphics / reset
               noborder
               noscale
               width=580 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=wk1 noborder noautolegend;
  series x=TRTAN y=AVAL /group=SUBJID grouplc=TRT01AN groupmc=TRT01AN markers lineattrs=(pattern=solid thickness=1) markerattrs = (size=7 symbol=circlefilled) name="series";
  xaxis offsetmin=0.2 offsetmax=0.2 labelattrs=(size=10) display=(nolabel) values=(1 2) valuesdisplay=("Active" "Placebo") type=discrete ;
  yaxis  offsetmax=0.07 labelattrs=(size=10)  values=(10 to  30 by 5) ;
  keylegend "series" / title="" noborder type=linecolor valueattrs=(size=10) 
         location=inside position=bottomright across=1 opaque;
  format TRT01AN TRT01AN.;
run ;

~~~
  
---
 
## `%sg023`  <a name="sg023-macro-23"></a> ######
### eDISH scatter plot of liver enzyme and bilirubin abnormalities.

<img width="438" height="324" alt="image" src="https://github.com/user-attachments/assets/af41a16a-d53c-4d5e-9c17-20918fd4c2d0" />

~~~sas
data ADLB;
  LENGTH USUBJID $12 PARAMCD $6 TRTA $12 ABLFL $1 TRTEMFL $1;
  FORMAT ADT YYMMDD10.;
 
  USUBJID="SUBJ001"; PARAMCD="ALT";   AVAL=45;  ANRHI=40;  TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ001"; PARAMCD="ALT";   AVAL=120; ANRHI=40;  TRTA="Active"; ADT=input("2023-01-15", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
  USUBJID="SUBJ001"; PARAMCD="TBILI"; AVAL=1.0; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ001"; PARAMCD="TBILI"; AVAL=2.8; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-15", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
 
  USUBJID="SUBJ003"; PARAMCD="ALT";   AVAL=30;  ANRHI=40;  TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ003"; PARAMCD="ALT";   AVAL=85;  ANRHI=40;  TRTA="Active"; ADT=input("2023-01-20", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
  USUBJID="SUBJ003"; PARAMCD="TBILI"; AVAL=0.7; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ003"; PARAMCD="TBILI"; AVAL=1.5; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-20", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
 
  USUBJID="SUBJ002"; PARAMCD="ALT";   AVAL=35;  ANRHI=40;  TRTA="Placebo"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ002"; PARAMCD="ALT";   AVAL=55;  ANRHI=40;  TRTA="Placebo"; ADT=input("2023-01-10", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
  USUBJID="SUBJ002"; PARAMCD="TBILI"; AVAL=0.8; ANRHI=1.2; TRTA="Placebo"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ002"; PARAMCD="TBILI"; AVAL=1.0; ANRHI=1.2; TRTA="Placebo"; ADT=input("2023-01-10", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
 
  USUBJID="SUBJ004"; PARAMCD="ALT";   AVAL=25;  ANRHI=40;  TRTA="Placebo"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ004"; PARAMCD="ALT";   AVAL=150; ANRHI=40;  TRTA="Placebo"; ADT=input("2023-01-18", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
  USUBJID="SUBJ004"; PARAMCD="TBILI"; AVAL=0.9; ANRHI=1.2; TRTA="Placebo"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ004"; PARAMCD="TBILI"; AVAL=3.5; ANRHI=1.2; TRTA="Placebo"; ADT=input("2023-01-18", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
 
  USUBJID="SUBJ005"; PARAMCD="ALT";   AVAL=20;  ANRHI=40;  TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ005"; PARAMCD="ALT";   AVAL=60;  ANRHI=40;  TRTA="Active"; ADT=input("2023-01-12", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
  USUBJID="SUBJ005"; PARAMCD="TBILI"; AVAL=0.6; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ005"; PARAMCD="TBILI"; AVAL=0.9; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-12", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
 
  USUBJID="SUBJ006"; PARAMCD="ALT";   AVAL=5;   ANRHI=40;  TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ006"; PARAMCD="ALT";   AVAL=10;  ANRHI=40;  TRTA="Active"; ADT=input("2023-01-12", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
  USUBJID="SUBJ006"; PARAMCD="TBILI"; AVAL=0.2; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ006"; PARAMCD="TBILI"; AVAL=0.1; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-12", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
 
  USUBJID="SUBJ006"; PARAMCD="ALT";   AVAL=1;   ANRHI=40;  TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ006"; PARAMCD="ALT";   AVAL=0.1; ANRHI=40;  TRTA="Active"; ADT=input("2023-01-12", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
  USUBJID="SUBJ006"; PARAMCD="TBILI"; AVAL=6;   ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ006"; PARAMCD="TBILI"; AVAL=8;   ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-12", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
run;
data adlb_xuln;
  set adlb;
  if not missing(aval) and not missing(anrhi) and anrhi > 0;
  xuln = aval / anrhi;
  if paramcd in ("ALT", "TBILI");
run;
proc sql;
  create table edish_base as
  select
      usubjid,
      max(case when paramcd = "ALT"   then xuln else . end) as altxuln,
      max(case when paramcd = "TBILI" then xuln else . end) as bilixuln,
      max(trta) as trta length=12
  from adlb_xuln
  group by usubjid;
quit;
 
options orientation=landscape;
ods graphics / reset
               noborder
               noscale
               width=680 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=edish_base noborder;
    styleattrs datacontrastcolors=(blue red)
                  datacolors=(blue red)
                  datasymbols=(circlefilled trianglefilled);   
 
  scatter x=altxuln y=bilixuln / 
          group=trta
          markerattrs=( size=10) name="scatter";
 
  refline 1 / axis=x label="1 x ULN" labelattrs=(size=8) lineattrs=(pattern=shortdash color=black thickness=1);
  refline 3 / axis=x label="3 x ULN" labelattrs=(size=8) lineattrs=(pattern=solid color=black thickness=1);
  refline 1 / axis=y label="1 x ULN" labelattrs=(size=8) lineattrs=(pattern=shortdash color=black thickness=1);
  refline 2 / axis=y label="2 x ULN" labelattrs=(size=8) lineattrs=(pattern=solid color=black thickness=1);
 
  xaxis type=log logbase=10
        min=0.1 max=30
        label="Peak ALT (x ULN)"
        values=(0.01 0.1 0.3 1 3 10 100)
        grid;
 
  yaxis type=log logbase=10
        min=0.1 max=10
        label="Peak Total Bilirubin (x ULN)"
        values=(0.0625 0.125 0.25 0.5 1 2 4 8 16 32)
        grid;
 
  keylegend "scatter" / title="" noborder valueattrs=(size=10) 
         location=inside position=topleft across=1 opaque;
run;

~~~

---
 
## `%sg024`  <a name="sg024-macro-24"></a> ######
### Purpose: Swimmer plot of subject-level treatment duration and events.

<img width="644" height="390" alt="image" src="https://github.com/user-attachments/assets/66d739f4-456f-4f46-b21e-6cd79ab3e421" />

~~~sas
data dummy_swimmer;
length USUBJID $8 PARAMCD $12 PARAM $40 AVALC ONGOING $2;
USUBJID="SUBJ001"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=210; AVALC=""; ONGOING="Y"; output;
USUBJID="SUBJ001"; PARAMCD="RESP"; PARAM="Overall response"; STDY=28; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ001"; PARAMCD="RESP"; PARAM="Overall response"; STDY=56; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ001"; PARAMCD="RESP"; PARAM="Overall response"; STDY=84; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ001"; PARAMCD="RESP"; PARAM="Overall response"; STDY=140; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ001"; PARAMCD="RESP"; PARAM="Overall response"; STDY=196; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ001"; PARAMCD="DUR"; PARAM="Response duration"; STDY=56; ENDY=196; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ002"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=168; AVALC=""; ONGOING="N"; output;
USUBJID="SUBJ002"; PARAMCD="RESP"; PARAM="Overall response"; STDY=21; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ002"; PARAMCD="RESP"; PARAM="Overall response"; STDY=42; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ002"; PARAMCD="RESP"; PARAM="Overall response"; STDY=63; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ002"; PARAMCD="RESP"; PARAM="Overall response"; STDY=105; ENDY=.; AVALC="PD"; ONGOING=""; output;
USUBJID="SUBJ002"; PARAMCD="DUR"; PARAM="Response duration"; STDY=63; ENDY=105; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ003"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=252; AVALC=""; ONGOING="N"; output;
USUBJID="SUBJ003"; PARAMCD="RESP"; PARAM="Overall response"; STDY=28; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ003"; PARAMCD="RESP"; PARAM="Overall response"; STDY=56; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ003"; PARAMCD="RESP"; PARAM="Overall response"; STDY=84; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ003"; PARAMCD="RESP"; PARAM="Overall response"; STDY=112; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ003"; PARAMCD="RESP"; PARAM="Overall response"; STDY=168; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ003"; PARAMCD="RESP"; PARAM="Overall response"; STDY=224; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ003"; PARAMCD="DUR"; PARAM="Response duration"; STDY=84; ENDY=224; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ004"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=98; AVALC=""; ONGOING="Y"; output;
USUBJID="SUBJ004"; PARAMCD="RESP"; PARAM="Overall response"; STDY=14; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ004"; PARAMCD="RESP"; PARAM="Overall response"; STDY=28; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ004"; PARAMCD="RESP"; PARAM="Overall response"; STDY=56; ENDY=.; AVALC="PD"; ONGOING=""; output;
USUBJID="SUBJ005"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=301; AVALC=""; ONGOING="Y"; output;
USUBJID="SUBJ005"; PARAMCD="RESP"; PARAM="Overall response"; STDY=30; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ005"; PARAMCD="RESP"; PARAM="Overall response"; STDY=60; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ005"; PARAMCD="RESP"; PARAM="Overall response"; STDY=90; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ005"; PARAMCD="RESP"; PARAM="Overall response"; STDY=150; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ005"; PARAMCD="RESP"; PARAM="Overall response"; STDY=210; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ005"; PARAMCD="RESP"; PARAM="Overall response"; STDY=270; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ005"; PARAMCD="DUR"; PARAM="Response duration"; STDY=60; ENDY=270; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ006"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=126; AVALC=""; ONGOING="N"; output;
USUBJID="SUBJ006"; PARAMCD="RESP"; PARAM="Overall response"; STDY=21; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ006"; PARAMCD="RESP"; PARAM="Overall response"; STDY=42; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ006"; PARAMCD="RESP"; PARAM="Overall response"; STDY=63; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ006"; PARAMCD="RESP"; PARAM="Overall response"; STDY=84; ENDY=.; AVALC="PD"; ONGOING=""; output;
USUBJID="SUBJ006"; PARAMCD="DUR"; PARAM="Response duration"; STDY=42; ENDY=63; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ007"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=224; AVALC=""; ONGOING="N"; output;
USUBJID="SUBJ007"; PARAMCD="RESP"; PARAM="Overall response"; STDY=28; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ007"; PARAMCD="RESP"; PARAM="Overall response"; STDY=56; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ007"; PARAMCD="RESP"; PARAM="Overall response"; STDY=112; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ007"; PARAMCD="RESP"; PARAM="Overall response"; STDY=168; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ007"; PARAMCD="RESP"; PARAM="Overall response"; STDY=210; ENDY=.; AVALC="PD"; ONGOING=""; output;
USUBJID="SUBJ007"; PARAMCD="DUR"; PARAM="Response duration"; STDY=56; ENDY=112; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ008"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=182; AVALC=""; ONGOING="Y"; output;
USUBJID="SUBJ008"; PARAMCD="RESP"; PARAM="Overall response"; STDY=26; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ008"; PARAMCD="RESP"; PARAM="Overall response"; STDY=52; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ008"; PARAMCD="RESP"; PARAM="Overall response"; STDY=78; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ008"; PARAMCD="RESP"; PARAM="Overall response"; STDY=130; ENDY=.; AVALC="PD"; ONGOING=""; output;
USUBJID="SUBJ009"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=336; AVALC=""; ONGOING="N"; output;
USUBJID="SUBJ009"; PARAMCD="RESP"; PARAM="Overall response"; STDY=28; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ009"; PARAMCD="RESP"; PARAM="Overall response"; STDY=56; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ009"; PARAMCD="RESP"; PARAM="Overall response"; STDY=84; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ009"; PARAMCD="RESP"; PARAM="Overall response"; STDY=140; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ009"; PARAMCD="RESP"; PARAM="Overall response"; STDY=196; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ009"; PARAMCD="RESP"; PARAM="Overall response"; STDY=280; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ009"; PARAMCD="DUR"; PARAM="Response duration"; STDY=28; ENDY=196; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ010"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=154; AVALC=""; ONGOING="Y"; output;
USUBJID="SUBJ010"; PARAMCD="RESP"; PARAM="Overall response"; STDY=22; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ010"; PARAMCD="RESP"; PARAM="Overall response"; STDY=44; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ010"; PARAMCD="RESP"; PARAM="Overall response"; STDY=88; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ010"; PARAMCD="RESP"; PARAM="Overall response"; STDY=132; ENDY=.; AVALC="PD"; ONGOING=""; output;
USUBJID="SUBJ010"; PARAMCD="DUR"; PARAM="Response duration"; STDY=44; ENDY=88; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ011"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=275; AVALC=""; ONGOING="N"; output;
USUBJID="SUBJ011"; PARAMCD="RESP"; PARAM="Overall response"; STDY=25; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ011"; PARAMCD="RESP"; PARAM="Overall response"; STDY=50; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ011"; PARAMCD="RESP"; PARAM="Overall response"; STDY=75; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ011"; PARAMCD="RESP"; PARAM="Overall response"; STDY=125; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ011"; PARAMCD="RESP"; PARAM="Overall response"; STDY=175; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ011"; PARAMCD="RESP"; PARAM="Overall response"; STDY=225; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ011"; PARAMCD="DUR"; PARAM="Response duration"; STDY=75; ENDY=225; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ012"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=119; AVALC=""; ONGOING="N"; output;
USUBJID="SUBJ012"; PARAMCD="RESP"; PARAM="Overall response"; STDY=17; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ012"; PARAMCD="RESP"; PARAM="Overall response"; STDY=34; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ012"; PARAMCD="RESP"; PARAM="Overall response"; STDY=68; ENDY=.; AVALC="PD"; ONGOING=""; output;
USUBJID="SUBJ013"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=245; AVALC=""; ONGOING="N"; output;
USUBJID="SUBJ013"; PARAMCD="RESP"; PARAM="Overall response"; STDY=35; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ013"; PARAMCD="RESP"; PARAM="Overall response"; STDY=70; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ013"; PARAMCD="RESP"; PARAM="Overall response"; STDY=105; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ013"; PARAMCD="RESP"; PARAM="Overall response"; STDY=140; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ013"; PARAMCD="RESP"; PARAM="Overall response"; STDY=210; ENDY=.; AVALC="PD"; ONGOING=""; output;
USUBJID="SUBJ013"; PARAMCD="DUR"; PARAM="Response duration"; STDY=70; ENDY=70; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ013"; PARAMCD="DUR"; PARAM="Response duration"; STDY=140; ENDY=140; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ014"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=196; AVALC=""; ONGOING="Y"; output;
USUBJID="SUBJ014"; PARAMCD="RESP"; PARAM="Overall response"; STDY=28; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ014"; PARAMCD="RESP"; PARAM="Overall response"; STDY=56; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ014"; PARAMCD="RESP"; PARAM="Overall response"; STDY=84; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ014"; PARAMCD="RESP"; PARAM="Overall response"; STDY=112; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ014"; PARAMCD="RESP"; PARAM="Overall response"; STDY=168; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ014"; PARAMCD="DUR"; PARAM="Response duration"; STDY=84; ENDY=112; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ015"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=322; AVALC=""; ONGOING="N"; output;
USUBJID="SUBJ015"; PARAMCD="RESP"; PARAM="Overall response"; STDY=46; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ015"; PARAMCD="RESP"; PARAM="Overall response"; STDY=92; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ015"; PARAMCD="RESP"; PARAM="Overall response"; STDY=138; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ015"; PARAMCD="RESP"; PARAM="Overall response"; STDY=184; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ015"; PARAMCD="RESP"; PARAM="Overall response"; STDY=230; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ015"; PARAMCD="RESP"; PARAM="Overall response"; STDY=276; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ015"; PARAMCD="DUR"; PARAM="Response duration"; STDY=92; ENDY=276; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ016"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=147; AVALC=""; ONGOING="N"; output;
USUBJID="SUBJ016"; PARAMCD="RESP"; PARAM="Overall response"; STDY=21; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ016"; PARAMCD="RESP"; PARAM="Overall response"; STDY=42; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ016"; PARAMCD="RESP"; PARAM="Overall response"; STDY=63; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ016"; PARAMCD="RESP"; PARAM="Overall response"; STDY=105; ENDY=.; AVALC="PD"; ONGOING=""; output;
USUBJID="SUBJ017"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=287; AVALC=""; ONGOING="N"; output;
USUBJID="SUBJ017"; PARAMCD="RESP"; PARAM="Overall response"; STDY=41; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ017"; PARAMCD="RESP"; PARAM="Overall response"; STDY=82; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ017"; PARAMCD="RESP"; PARAM="Overall response"; STDY=123; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ017"; PARAMCD="RESP"; PARAM="Overall response"; STDY=164; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ017"; PARAMCD="RESP"; PARAM="Overall response"; STDY=205; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ017"; PARAMCD="RESP"; PARAM="Overall response"; STDY=246; ENDY=.; AVALC="PD"; ONGOING=""; output;
USUBJID="SUBJ017"; PARAMCD="DUR"; PARAM="Response duration"; STDY=82; ENDY=205; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ018"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=203; AVALC=""; ONGOING="N"; output;
USUBJID="SUBJ018"; PARAMCD="RESP"; PARAM="Overall response"; STDY=29; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ018"; PARAMCD="RESP"; PARAM="Overall response"; STDY=58; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ018"; PARAMCD="RESP"; PARAM="Overall response"; STDY=87; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ018"; PARAMCD="RESP"; PARAM="Overall response"; STDY=145; ENDY=.; AVALC="PD"; ONGOING=""; output;
USUBJID="SUBJ018"; PARAMCD="DUR"; PARAM="Response duration"; STDY=58; ENDY=87; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ019"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=364; AVALC=""; ONGOING="Y"; output;
USUBJID="SUBJ019"; PARAMCD="RESP"; PARAM="Overall response"; STDY=28; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ019"; PARAMCD="RESP"; PARAM="Overall response"; STDY=56; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ019"; PARAMCD="RESP"; PARAM="Overall response"; STDY=84; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ019"; PARAMCD="RESP"; PARAM="Overall response"; STDY=112; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ019"; PARAMCD="RESP"; PARAM="Overall response"; STDY=168; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ019"; PARAMCD="RESP"; PARAM="Overall response"; STDY=224; ENDY=.; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ019"; PARAMCD="RESP"; PARAM="Overall response"; STDY=280; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ019"; PARAMCD="RESP"; PARAM="Overall response"; STDY=336; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ019"; PARAMCD="DUR"; PARAM="Response duration"; STDY=56; ENDY=280; AVALC="CR"; ONGOING=""; output;
USUBJID="SUBJ020"; PARAMCD="OBS"; PARAM="Observation period"; STDY=1; ENDY=175; AVALC=""; ONGOING="Y"; output;
USUBJID="SUBJ020"; PARAMCD="RESP"; PARAM="Overall response"; STDY=25; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ020"; PARAMCD="RESP"; PARAM="Overall response"; STDY=50; ENDY=.; AVALC="SD"; ONGOING=""; output;
USUBJID="SUBJ020"; PARAMCD="RESP"; PARAM="Overall response"; STDY=75; ENDY=.; AVALC="PR"; ONGOING=""; output;
USUBJID="SUBJ020"; PARAMCD="RESP"; PARAM="Overall response"; STDY=100; ENDY=.; AVALC="PD"; ONGOING=""; output;
USUBJID="SUBJ020"; PARAMCD="DUR"; PARAM="Response duration"; STDY=75; ENDY=75; AVALC="PR"; ONGOING=""; output;
run;
 
data dummy_swimmer1;
set dummy_swimmer;
select (AVALC);
  when ("CR") CRDY=STDY;
  when ("PR") PRDY=STDY;
  when ("SD") SDDY=STDY;
  when ("PD") PDDY=STDY;
  otherwise;
end;
if PARAMCD="DUR" then do;
  DURSTDY=STDY;
  DURENDY=ENDY;
end;
if PARAMCD="OBS" then do;
  OBSSTDY=STDY;
  OBSENDY=ENDY;
end;
if ONGOING="Y" then highcap ="FilledArrow";
retain yno;
if _N_=1 then yno=0;
L_USUBJID=lag(USUBJID);
if USUBJID ne L_USUBJID then yno +1;
 
drop L_USUBJID;
run;
 
ods graphics / reset
               noborder
               noscale
               width=980 px
               height=610 px
               attrpriority=none
               imagefmt=png
proc sgplot data= dummy_swimmer1 ;
  highlow y=yno low=OBSSTDY high=OBSENDY / highcap=highcap type=bar fill nooutline 
             dataskin=CRISP fillattrs=(color=silver ) lineattrs=(color=black) barwidth=1 ;
  
 highlow y=yno low=DURSTDY high=DURENDY / lineattrs=(thickness=2 color=black) name="status" legendlabel="Response Duration" ;
  scatter y=yno x=CRDY / markerattrs=(symbol=circlefilled size=8 color=black) name="CR" legendlabel="CR";
  scatter y=yno x=PRDY / markerattrs=(symbol=diamondfilled size=8 color=black) name="PR" legendlabel="PR";
  scatter y=yno x=SDDY / markerattrs=(symbol=squarefilled size=8 color=black) name="SD" legendlabel="SD";
  scatter y=yno x=PDDY / markerattrs=(symbol=X size=8 color=black) name="PD" legendlabel="PD";
  legenditem type=marker name="ongoing" /label="Ongoing" markerattrs=(symbol=trianglerightfilled color=silver size=10 ); 
  yaxistable USUBJID / title=" " label=" " location=inside position=left labelattrs=(size=9) valueattrs=(size=8);
  xaxis label="Day" values=(1 to 365 by 14 )  offsetmax=0.05;
  yaxis reverse display=(noticks novalues noline) label="Participants" min=1 max=20 offsetmin=0 ;
  keylegend "ongoing" "CR" "PR" "SD"  "PD"  "status"/  location=inside position=topright across=1;
run;

~~~
  
---
 
## `%sg025`  <a name="sg025-macro-25"></a> ######
### ROC curve of sensitivity versus false positive rate.

<img width="386" height="378" alt="image" src="https://github.com/user-attachments/assets/d2d953d9-9bf0-4f6e-9a0f-189a82c5abf6" />

~~~sas
data roc_sample;
  call streaminit(12345);
  do id = 1 to 500;
    age = rand("normal", 62, 10);
    bmi = rand("normal", 24, 3);
    latent = -8
             + 0.06 * age
             + 0.12 * bmi
             + rand("normal", 0, 1);
    p_disease = 1 / (1 + exp(-latent));
    outcome = rand("bernoulli", p_disease);
    if outcome = 1 then
      biomarker = rand("normal", 75, 12);
    else
      biomarker = rand("normal", 55, 12);
      biomarker = biomarker + 0.15 * (age - 60) + 0.4 * (bmi - 24);
    output;
  end;
run;
ods graphics on;
ods output ROCCurve = ROCCurve;
proc logistic data=roc_sample plots(only)=roc;
  model outcome(event="1") = biomarker age bmi
        / lackfit rsquare outroc=rocstats;
  output out=pred predicted=pred;
run;
 
data wk1;
  set rocstats;
  specificity = 1 - _1MSPEC_;
  youden_j = _SENSIT_ + specificity - 1;
  distance = sqrt((1 - _SENSIT_)**2 + (1 - specificity)**2);
run;
 
proc sql noprint;
  create table cutoff as
  select
      _PROB_   as cutoff_prob,
      _SENSIT_ as cutoff_sens,
      specificity as cutoff_spec,
      youden_j,
      distance
  from wk1
  having youden_j = max(youden_j);
quit;
 
data plot_roc;
  set wk1;
  if _n_ = 1 then set cutoff;
  if _PROB_ = cutoff_prob then do;
    star_x = _1MSPEC_;
    star_y = _SENSIT_;
  end;
run;
 
 
ods graphics / reset
               noborder
               noscale
               width=600 px
               height=600 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=plot_roc noautolegend aspect=1;
  step x=_1MSPEC_ y=_SENSIT_
    / lineattrs=(thickness=3 color=blue);
 
  scatter x=star_x y=star_y
    / markerattrs=(symbol=diamondfilled color=blue size=15) name="Youden" legendlabel="Cut off (max of Youden Index)";
 
  lineparm x=0 y=0 slope=1
    / transparency=0.3 lineattrs=(color=black pattern=shortdash thickness=2);
 
  xaxis grid values=(0 to 1 by 0.25)
    label="1 - Specificity"
    labelattrs=(size=11) offsetmin=0.01 offsetmax=0.01;
 
  yaxis grid values=(0 to 1 by 0.25)
    label="Sensitivity"
    labelattrs=(size=12 ) offsetmin=0.01 offsetmax=0.01;
 
  keylegend "Youden" /location=inside position=bottomright;
run;

~~~
---
 
## `%sg026`  <a name="sg026-macro-26"></a> ######
### Power model plot of pharmacokinetic exposure versus dose.

<img width="452" height="257" alt="image" src="https://github.com/user-attachments/assets/50c59387-4a7e-4afa-a4d8-460f86c69da1" />

~~~sas
data power_sample;
length SUBJID $20. DOSE 8. PPTEST $20.  AVAL 8.;
call streaminit(777);
k = 0.12;             
  do sub = 1 to 11;
    SUBJID=catx("-","SAMP",put(sub,z3.));
     do DOSE = 20,40,80,160;
      do PPTEST="CMAX";
        AVAL = k * dose**2*0.001 * exp(rand("normal", 0, 0.15));
        output;
     end;
  end;
end;
keep  SUBJID DOSE PPTEST AVAL;
run;
 
data power_sample_2;
set power_sample;
L_AVAL=log(AVAL);
L_DOSE=log(DOSE);
run;
 
ods output ParameterEstimates=ParameterEstimates;
proc reg data=power_sample_2;
model L_AVAL=L_DOSE/clb;
run;
quit;
 
 proc transpose data=ParameterEstimates out=ParameterEstimates_1;
 var Estimate;
 id Variable;
run;
 
data _null_;
set ParameterEstimates;
if Variable="Intercept" then call symputx("Intercept",round(Estimate,0.0001));
if Variable="L_DOSE" then do;
   if 0 <= Estimate then call symputx("beta",catx(" ","+",round(Estimate,0.0001)));
   if 0 > Estimate then call symputx("beta",catx(" ","-",round(abs(Estimate),0.0001)));
end;
run;
%put &=beta;
data ParameterEstimates_2;
set ParameterEstimates_1;
do x = 0 to 200 by 1;
  RF=exp(Intercept) * x ** L_DOSE ;
  output;
end;
run;
 
data power_sample_3;
 set power_sample_2 ParameterEstimates_2;
run;
 
ods graphics / reset
               noborder
               noscale
               width=700 px
               height=400 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=power_sample_3 noborder noautolegend;
inset "Power model : ln (Cmax) = &Intercept &beta. × ln (Dose) + Random error" / position=bottomright;
scatter x=DOSE y=AVAL /group=SUBJID   markerattrs=(color=black size=5 symbol=circlefilled) name="name1" ;
xaxis offsetmin=0.02 offsetmax=0.1labelattrs=(size=10) label="Dosage (mg)" values=(0 20 40 80 160);
yaxis  offsetmax=0.07  labelattrs=(size=10) label="Cmax (ng/mL)" values=(0 to 5 by 0.5) ;
series x=x y=RF /lineattrs=(color=black);
run ;

~~~
  
---
 
## `%sg027` <a name="sg027-macro-27"></a> ######
### Funnel plot of effect estimate versus standard error.

<img width="458" height="254" alt="image" src="https://github.com/user-attachments/assets/1236621f-272a-435d-b6f0-9a645224aacd" />

~~~sas
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
 
ods graphics / reset
               noborder
               noscale
               width=700 px
               height=400 px
               attrpriority=none
               imagefmt=png
;
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

~~~
  
---
 
## `%sg028`  <a name="sg028-macro-28"></a> ######
### Funnel plot of effect estimate versus precision.

<img width="453" height="258" alt="image" src="https://github.com/user-attachments/assets/d59a2bcb-fed2-4ac2-a499-0a7875a441b7" />

~~~sas
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
 
ods graphics / reset
               noborder
               noscale
               width=700 px
               height=400 px
               attrpriority=none
               imagefmt=png
;
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
~~~
  
---
 
## `%sg029`  <a name="sg029-macro-29"></a> ######
### Heatmap of missing data patterns.

<img width="676" height="424" alt="image" src="https://github.com/user-attachments/assets/01d97d80-c9a3-4a79-85db-98cc60b794b6" />

~~~sas
data missing_map_sampke;
call streaminit(123);
 
length 
    USUBJID $12
    SEX $1
    TRT $8
    STRATA $5
    FLAG $1
    C01-C05 $20
    N01-N08 8.
    C06 $20
    N09-N13 8.
    C07-C12 $20
    N14-N20 8.
    C13-C16 $20
    N20-N25 8.
    C17-C20 $20;
 
array nums N01-N25;
array chars C01-C20;
 
do i = 1 to 300;
    USUBJID = cats("SUBJ", put(i, z4.));
    
    SEX = ifc(rand("uniform")<0.5,"M","F");
    TRT = scan("Placebo DrugA DrugB DrugC", ceil(rand("uniform")*4));
    STRATA = scan("Low Mid High", ceil(rand("uniform")*3));
    FLAG = ifc(rand("uniform")<0.7,"Y","N");
 
    do j = 1 to dim(nums);
        if rand("uniform") < 0.15 then nums[j] = .;  
        else nums[j] = rand("normal", 100, 15);
    end;
 
    do k = 1 to dim(chars);
        if rand("uniform") < 0.20 then chars[k] = ""; 
        else chars[k] = scan("A B C D E", ceil(rand("uniform")*5));
    end;
 
    output;
end;
 
drop i j k;
run;
 
ods output Position=Position;
proc contents data=missing_map_sampke varnum;
run;
 
proc format;
value catnf 
      0   = "Null"
      1   = "Numeric"
      2   = "Charcter";
run;
data nullmap;
length varname $20.;
set missing_map_sampke;
obs=_N_;
array ar_num _numeric_;
do over ar_num;
 varname=vname(ar_num);
 varn=_i_;
 if missing(ar_num) then catn=0;
 else catn=1;
 output;
end;
array ar_character _char_;
do over ar_character;
 varname=vname(ar_character);
 varn=_i_;
 if missing(ar_character) then catn=0;
 else catn=2;
 if varname ne "varname" then output;
end;
format catn catnf.;
keep varname obs catn;
run;
 
data nullmap2;
set nullmap;
if 0 then set position(keep=Variable Num);
if _N_ =1 then do;
  declare hash h1(dataset:"position");
  h1.definekey("Variable");
  h1.definedata("Num");
  h1.definedone();
end;
Variable=varname;
if h1.find() ne 0 then call missing(Num);
if ^missing(Num);
run;
proc sort data=nullmap2;
by num obs;
run;
 
data mapping;
length ID Show FillColor Value $20.;
ID="catn";
Show="AttrMap"; 
do Value ="Null","Numeric","Charcter";
 select(Value);
  when("Null") FillColor="gray";
  when("Numeric") FillColor="bibg";
  when("Charcter") FillColor="pink";
 end;
 output;
end;
run;
 
ods graphics / reset
               noborder
               noscale
               width=1100 px
               height=700 px
               attrpriority=none
               imagefmt=png;
proc sgplot data=nullmap2 dattrmap=mapping ; 
   format catn catnf.;
   heatmapparm x=varname  y=obs colorgroup=catn /  attrid=catn x2axis;
   x2axis;
   yaxis reverse label="Observation";
   keylegend / title="Type" location=outside position=right across=1;                          
run;

~~~
---
 
## `%sg030`  <a name="sg030-macro-30"></a> ######
### Lollipop plot of values by category.

<img width="479" height="362" alt="image" src="https://github.com/user-attachments/assets/67b4aed1-e814-43ea-8bb6-c487084093b5" />

~~~sas
data missing_map_sampke;
call streaminit(123);
 
length 
    USUBJID $12
    SEX $1
    TRT $8
    STRATA $5
    FLAG $1
    C01-C05 $20
    N01-N08 8.
    C06 $20
    N09-N13 8.
    C07-C12 $20
    N14-N20 8.
    C13-C16 $20
    N20-N25 8.
    C17-C20 $20;
 
array nums N01-N25;
array chars C01-C20;
 
do i = 1 to 300;
    USUBJID = cats("SUBJ", put(i, z4.));
    
    SEX = ifc(rand("uniform")<0.5,"M","F");
    TRT = scan("Placebo DrugA DrugB DrugC", ceil(rand("uniform")*4));
    STRATA = scan("Low Mid High", ceil(rand("uniform")*3));
    FLAG = ifc(rand("uniform")<0.7,"Y","N");
 
    do j = 1 to dim(nums);
        if rand("uniform") < 0.15 then nums[j] = .;  
        else nums[j] = rand("normal", 100, 15);
    end;
 
    do k = 1 to dim(chars);
        if rand("uniform") < 0.20 then chars[k] = ""; 
        else chars[k] = scan("A B C D E", ceil(rand("uniform")*5));
    end;
 
    output;
end;
 
drop i j k;
run;
 
data nullmap;
length varname $20.;
set missing_map_sampke;
array ar_num _numeric_;
do over ar_num;
 varname=vname(ar_num);
 varn=_i_;
 if missing(ar_num) then catn=0;
 else catn=1;
 output;
end;
array ar_character _char_;
do over ar_character;
 varname=vname(ar_character);
 varn=_i_;
 if missing(ar_character) then catn=0;
 else catn=2;
 if varname ne "varname" then output;
end;
keep varname catn;
run;
 
ods output CrossTabFreqs=NullFreqs(where=(catn=0));
proc freq data=nullmap  order=FREQ;
 table  varname*catn /nopercent nocol nocum;
run;
 
proc sort data=NullFreqs;
 by  descending RowPercent;
run;
data NullFreqs1;
 set NullFreqs;
 where ^missing(RowPercent);
 y=_N_;
run;
 
ods graphics / reset
               noborder
               noscale
               width=800 px
               height=600 px
               attrpriority=none
               imagefmt=png;
;proc sgplot data=NullFreqs1  noautolegend;
  hbarparm category=y response=RowPercent /   barwidth=0.1 baselineattrs=(thickness=0);
  scatter y=y  x=RowPercent /  markerattrs=(symbol=circlefilled size=7)  dataskin=sheen;
 
  xaxis offsetmin=0.01 offsetmax=0.04 display=( noticks noline) values=(0 to 50 by 5) grid label="% Missing";
  yaxis display=( noticks noline novalues nolabel) fitpolicy=split grid;
  yaxistable varname/y=y nolabel position=left;
  format y best6.;
run;

~~~
  
---
 
## `%sg033`  <a name="sg033-macro-31"></a> ######
### Scatter plot with a broken X-axis.

<img width="305" height="305" alt="image" src="https://github.com/user-attachments/assets/56a82c52-5885-4cfa-848b-777ef5b8cb4e" />

~~~sas
data wk1;
call streaminit(777);
do SEXN=1,2;
    do AVISITN= 1 to 10;
        do i = 1 to 10;
            SUBJID=cats(SEXN,"-",i);
            if SEXN = 1 then do;
              VALUE1 = rand("normal",100,10);
              VALUE2 = VALUE1 + rand("normal",20,10);
            end;
            if SEXN = 2 then do;
              VALUE1 = rand("normal",110,20);
              VALUE2 = VALUE1 + rand("normal",30,10);
              if rand("UNIFORM") < 0.1 then  VALUE2 =1000  + rand("normal",30,10) ;
            end;
            output;
        end;
    end;
end;
run;
proc format ;
value sexn 1="Male" 2="Female";
run;
ods graphics / reset
               noborder
               noscale
               width=500 px
               height=500 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=wk1 ;
  styleattrs
     datacontrastcolors=(blue red ) 
     datasymbols=(square circle)
;
scatter x=VALUE2 y=VALUE1/group=SEXN;
keylegend/title="Sex" location=inside position=topleft opaque;
xaxis grid label="Parameter 1" ranges=(0-250 1000-1100) values=(0 to 1100 by 100) ;
yaxis grid label="Parameter 2";
format SEXN sexn.;
run;

~~~
---
 
## `%sg034`  <a name="sg034-macro-32"></a> ######
### Kaplan-Meier plot with confidence band and median survival droplines.

<img width="458" height="317" alt="image" src="https://github.com/user-attachments/assets/ee4e308b-5fa7-4456-af34-af946f7ea550" />

~~~sas
data dummy_adtte;
attrib
USUBJID label="Unique Subject Identifier" length=$20.
TRTP  label="Planned Treatment" length=$20.
TRTPN label="Planned Treatment (N)" length=8.
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
if TRTPN =1 then time =rand("WEIBULL", 1.5, 10);
else if TRTPN =2 then time =rand("WEIBULL", 1.5, 7);
else if TRTPN =3 then time =rand("WEIBULL", 1.5, 3);
else time =rand("WEIBULL", 1.5, 5);
USUBJID = cats(TRTPN,_USUBJID);
censor_limit = rand("UNIFORM") * 15;
CNSR = ^(time <= censor_limit);
AVAL = min(time, censor_limit);
TRTP = choosec(TRTPN,"XXXXX","YYYY","ZZZZZ","Placebo");
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
run;
 
proc sql noprint;
 select Estimate into:p50_1 from Quartiles
 where Percent=50 and stratum=1;
 
 select Estimate into:p50_2 from Quartiles
 where Percent=50 and stratum=2;
quit;
 
ods graphics / reset
               noborder
               noscale
               width=745 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
ods results;
ods select all;
proc sgplot data=SurvivalPlotData_1 noborder noautolegend ;
  styleattrs datacontrastcolors=(red blue )
  datacolors=(red blue )
  datalinepatterns=(solid solid) ;
 
 step x=time y=survival / group=stratum name="step" lineattrs=(thickness=2);
 scatter x=time y=censored /noerrorcaps yerrorupper=tick_marks_upper yerrorlower=tick_marks_lower errorbarattrs=(pattern=1 thickness=2) markerattrs=(size=0) GROUP=stratum;
 band  x=time upper=SDF_UCL lower=SDF_LCL/ group=stratum type=step transparency=0.8;
 dropline x=&p50_1.  y=0.5 /dropto=both lineattrs=(color=red  pattern=dot thickness=3);
 dropline x=&p50_2.  y=0.5 /dropto=both lineattrs=(color=blue  pattern=dot thickness=3);
 
 
 xaxistable atrisk / x=tatrisk class=stratum location=outside valueattrs=(size=10 color=black)  ;
 keylegend "step" / location=inside position=topright across=1 noborder valueattrs=(size=10) exclude=("") ;
 
 yaxis label="Probability" min=0 values=(0 0.2 0.4 0.5 0.6 0.8 1.0 ) offsetmax=0.03;
 xaxis label="Survival Time (Month)" values=(0 to 15 by 1) offsetmin=0.04 ;
format stratum $KM_GR. ;
run;

~~~
  
---
 
## `%sg035` <a name="sg035-macro-33"></a> ######
### Pareto plot of counts and cumulative percentage.

<img width="447" height="308" alt="image" src="https://github.com/user-attachments/assets/ed273db0-90b3-43e9-a32c-9469324f8fdc" />

~~~sas
data parato_raw;
  length reason $60;
  reason="Missing Visit Date"; count=42; output;
  reason="Incomplete Adverse Event Term"; count=35; output;
  reason="Lab Value Out of Range"; count=28; output;
  reason="Missing Concomitant Medication"; count=21; output;
  reason="Inconsistent AE Start Date"; count=16; output;
  reason="Unresolved Medical History Query"; count=12; output;
  reason="Missing Informed Consent Date"; count=9; output;
  reason="Other"; count=7; output;
run;
proc sort data=parato_raw out=parato_sort;
    by descending count;
run;
proc sql noprint;
    select sum(count) into :total_count
    from parato_sort;
quit;
 
data parato_data;
    set parato_sort;
    retain cum_count 0 order 0;
    qreason=quote(reason);
    order + 1;
    cum_count + count;
    cum_pct = cum_count / &total_count * 100;
run;
 
proc sql noprint;
select qreason into: _label_list separated by " " 
from parato_data;
quit;
 
ods graphics / reset
               noborder
               noscale
               width=745 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=parato_data noautolegend;
    vbarparm category=order response=count / 
        datalabel
        fillattrs=(color=cx5B9BD5)
        outlineattrs=(color=gray);
 
    series x=order y=cum_pct / 
        y2axis
        markers
        lineattrs=(color=red thickness=2)
        markerattrs=(symbol=circlefilled color=red);
 
    refline 80 / axis=y2
        lineattrs=(pattern=shortdash color=gray);
 
    yaxis label="Number of Queries" grid;
    y2axis label="Cumulative Percentage (%)"
        values=(0 to 100 by 10)
        min=0 max=100;
 
    xaxis label="Query Reason"
        values=(1 to 8 by 1)
        valuesdisplay=(
            &_label_list.
        )
        fitpolicy=rotate;
format order best.;
run;

~~~
  
---
 
## `%sg036`  <a name="sg036-macro-34"></a> ######
### Bland-Altman plot of measurement difference versus measurement mean.

<img width="450" height="308" alt="image" src="https://github.com/user-attachments/assets/59d13454-9005-4200-8f8f-93cf375e291c" />

~~~sas
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
 
ods graphics / reset
               noborder
               noscale
               width=745 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=plot3;
scatter x= mean y=diff;
refline 0 /axis=y;
refline lower/axis=y lineattrs=(pattern=dash);
refline upper/axis=y lineattrs=(pattern=dash);
xaxis label="Mean of two measurements";
yaxis label="Difference between the two measurements";
run;

~~~
  
---
 
## `%sg037`  <a name="sg037-macro-35"></a> ######
### Scatter plot with regression line within the data range.

<img width="465" height="304" alt="image" src="https://github.com/user-attachments/assets/863025f1-ef1e-43e8-894f-8aa985df8c50" />

~~~sas
ods output ParameterEstimates=ParameterEstimates;
proc reg data=sashelp.class ;
model height = age;
run;
quit;
data _null_;
set ParameterEstimates;
if Variable="Intercept" then call symputx("Intercept",round(Estimate,0.01));
else call symputx("Slope",round(Estimate,0.01));
run;
 
ods graphics / reset
               noborder
               noscale
               width=745 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=sashelp.class noborder;
    reg x=age y=height /clm = "95% Confidence Limits" cli="95% Prediction Limits" legendlabel="Regression";
    xaxis label="Age" values=(10 to 17);
    yaxis label="Height (inch)" values=(40 to 90 by 10);
    inset "Slope = &Slope." "Intercept = &Intercept.";
    keylegend /noborder location=inside position=bottomright across=1;
run;
~~~
  
---
 
## `%sg038`  <a name="sg038-macro-36"></a> ######
### Scatter plot with regression line extended over the axis range.

<img width="453" height="311" alt="image" src="https://github.com/user-attachments/assets/23d4cf9d-b697-46a7-be13-7d4a4b8120d7" />

~~~sas
data xgrid;
  do AGE = 9 to 18 by 1;
    height = .;
    output;
  end;
run;
data reg_input;
  set sashelp.class xgrid;
run;
ods output ParameterEstimates=ParameterEstimates;
proc reg data=reg_input ;
  model height = AGE;
  output out=reg_pred
    p     = pred
    lclm  = lclm
    uclm  = uclm
    lcl   = lcli
    ucl   = ucli;
run;
quit;
data _null_;
set ParameterEstimates;
if Variable="Intercept" then call symputx("Intercept",round(Estimate,0.01));
else call symputx("Slope",round(Estimate,0.01));
run;
data reg_pred_input;
set reg_pred;
if ^missing(height) then call missing(of pred lcli ucli lclm uclm);
run;
 
ods graphics / reset
               noborder
               noscale
               width=745 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=reg_pred_input noborder;
    scatter x=age y=height;
 
    lineparm x=0 y=&intercept slope=&slope
       / legendlabel="Regression" name="reg";
 
    band x=age lower=lclm upper=uclm
      / transparency=0.5
        legendlabel="95% Confidence Limits" name="clm";
 
      series x=age y=lcli
    / transparency=0.6
      lineattrs=(thickness=2 pattern=shortdash)
      legendlabel="95% Prediction Limits" name="cli";
 
      series x=age y=ucli
    / transparency=0.6
      lineattrs=(thickness=2 pattern=shortdash);
 
    xaxis label="Age" values=(10 to 17);
    yaxis label="Height (inch.)" values=(40 to 90 by 10);
    inset "Slope = &Slope." "Intercept = &Intercept.";
    keylegend "cli" "clm" "reg" /noborder location=inside position=bottomright across=1;
run;

~~~
  
---
 
## `%sg039`  <a name="sg039-macro-37"></a> ######
### Volcano plot of fold change versus statistical significance.

<img width="449" height="313" alt="image" src="https://github.com/user-attachments/assets/b850168a-6460-45bf-a50c-f9585c3b12ef" />

~~~sas
data volcano;
  length gene $10 sig_cat $20 label_gene $10;
 
  gene="GENE001"; log2fc=1.80;  p_value=0.0005; link calc; output;
  gene="GENE002"; log2fc=1.45;  p_value=0.0030; link calc; output;
  gene="GENE003"; log2fc=1.20;  p_value=0.0120; link calc; output;
  gene="GENE004"; log2fc=0.95;  p_value=0.0200; link calc; output;
  gene="GENE005"; log2fc=0.60;  p_value=0.0400; link calc; output;
  gene="GENE006"; log2fc=0.30;  p_value=0.1800; link calc; output;
  gene="GENE007"; log2fc=-0.20; p_value=0.6500; link calc; output;
  gene="GENE008"; log2fc=-0.55; p_value=0.0900; link calc; output;
  gene="GENE009"; log2fc=-1.10; p_value=0.0180; link calc; output;
  gene="GENE010"; log2fc=-1.45; p_value=0.0040; link calc; output;
  gene="GENE011"; log2fc=-1.90; p_value=0.0008; link calc; output;
  gene="GENE012"; log2fc=2.20;  p_value=0.0001; link calc; output;
  gene="GENE013"; log2fc=1.70;  p_value=0.0080; link calc; output;
  gene="GENE014"; log2fc=1.05;  p_value=0.0300; link calc; output;
  gene="GENE015"; log2fc=0.85;  p_value=0.0700; link calc; output;
  gene="GENE016"; log2fc=0.40;  p_value=0.3000; link calc; output;
  gene="GENE017"; log2fc=0.10;  p_value=0.8500; link calc; output;
  gene="GENE018"; log2fc=-0.35; p_value=0.4200; link calc; output;
  gene="GENE019"; log2fc=-0.90; p_value=0.0600; link calc; output;
  gene="GENE020"; log2fc=-1.25; p_value=0.0200; link calc; output;
  gene="GENE021"; log2fc=-1.60; p_value=0.0060; link calc; output;
  gene="GENE022"; log2fc=-2.10; p_value=0.0003; link calc; output;
  gene="GENE023"; log2fc=2.50;  p_value=0.0002; link calc; output;
  gene="GENE024"; log2fc=1.35;  p_value=0.0150; link calc; output;
  gene="GENE025"; log2fc=0.75;  p_value=0.1100; link calc; output;
  gene="GENE026"; log2fc=0.15;  p_value=0.7200; link calc; output;
  gene="GENE027"; log2fc=-0.15; p_value=0.7600; link calc; output;
  gene="GENE028"; log2fc=-0.70; p_value=0.1300; link calc; output;
  gene="GENE029"; log2fc=-1.05; p_value=0.0450; link calc; output;
  gene="GENE030"; log2fc=-1.80; p_value=0.0020; link calc; output;
  gene="GENE031"; log2fc=1.10;  p_value=0.0490; link calc; output;
  gene="GENE032"; log2fc=1.55;  p_value=0.0070; link calc; output;
  gene="GENE033"; log2fc=2.00;  p_value=0.0010; link calc; output;
  gene="GENE034"; log2fc=0.50;  p_value=0.2500; link calc; output;
  gene="GENE035"; log2fc=0.05;  p_value=0.9100; link calc; output;
  gene="GENE036"; log2fc=-0.45; p_value=0.3300; link calc; output;
  gene="GENE037"; log2fc=-1.15; p_value=0.0350; link calc; output;
  gene="GENE038"; log2fc=-1.55; p_value=0.0090; link calc; output;
  gene="GENE039"; log2fc=-2.30; p_value=0.0004; link calc; output;
  gene="GENE040"; log2fc=2.10;  p_value=0.0007; link calc; output;
  gene="GENE041"; log2fc=1.25;  p_value=0.0250; link calc; output;
  gene="GENE042"; log2fc=0.90;  p_value=0.0800; link calc; output;
  gene="GENE043"; log2fc=0.35;  p_value=0.5000; link calc; output;
  gene="GENE044"; log2fc=-0.05; p_value=0.9300; link calc; output;
  gene="GENE045"; log2fc=-0.50; p_value=0.2100; link calc; output;
  gene="GENE046"; log2fc=-0.95; p_value=0.0550; link calc; output;
  gene="GENE047"; log2fc=-1.30; p_value=0.0170; link calc; output;
  gene="GENE048"; log2fc=-1.75; p_value=0.0050; link calc; output;
  gene="GENE049"; log2fc=1.65;  p_value=0.0065; link calc; output;
  gene="GENE050"; log2fc=-2.00; p_value=0.0015; link calc; output;
 
  stop;
 
  calc:
    neglog10p = -log10(p_value);
 
    if p_value < 0.05 and log2fc >= 1 then sig_cat = "Up";
    else if p_value < 0.05 and log2fc <= -1 then sig_cat = "Down";
    else sig_cat = "Not significant";
 
    if p_value < 0.01 and abs(log2fc) >= 1.5 then label_gene = gene;
    else label_gene = "";
 
    return;
run;
 
 
ods graphics / reset
               noborder
               noscale
               width=745 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=volcano noborder;
  scatter x=log2fc y=neglog10p / 
    group=sig_cat
    markerattrs=(symbol=circlefilled size=8)
    transparency=0.2
    datalabel=label_gene;
 
  refline -1 1 / axis=x lineattrs=(pattern=shortdash);
  refline 1.30103 / axis=y lineattrs=(pattern=shortdash);
 
  xaxis label="log2 Fold Change";
 
  yaxis label="-log10(p-value)" ;
 
  keylegend / title="Category";
run;

~~~
  
---
 
## `%sg040()` macro <a name="sg040-macro-38"></a> ######
### Bubble plot of categorical change from baseline by visit and treatment group.

<img width="446" height="307" alt="image" src="https://github.com/user-attachments/assets/a7059665-f91e-4140-ac6f-7c59ef5a0cbf" />

~~~sas
data adlb_mock;
    call streaminit(123);
 
    length usubjid $12 trt01p $20 paramcd $8 avisit $20 chgcat $20;
 
    do subj = 1 to 180;
 
        usubjid = cats("SUBJ", put(subj, z3.));
 
        if rand("uniform") < 0.5 then trt01p = "Placebo";
        else trt01p = "Active Drug";
 
        paramcd = "ALT";
        base = rand("normal", 30, 8);
 
        do avisitn = 1 to 5;
 
            select (avisitn);
                when (1) avisit = "Week 2";
                when (2) avisit = "Week 4";
                when (3) avisit = "Week 8";
                when (4) avisit = "Week 12";
                when (5) avisit = "Week 24";
                otherwise avisit = "Other";
            end;
 
            if trt01p = "Placebo" then
                chg = rand("normal", 1, 12);
            else
                chg = rand("normal", -4, 12);
 
            if chg < -20 then chgcat = "< -20";
            else if chg < -10 then chgcat = "-20 to < -10";
            else if chg < 0 then chgcat = "-10 to < 0";
            else if chg < 10 then chgcat = "0 to < 10";
            else if chg < 20 then chgcat = "10 to < 20";
            else chgcat = ">= 20";
 
            output;
        end;
    end;
run;
 
data adlb_mock2;
    set adlb_mock;
 
    select (chgcat);
        when ("< -20")        chgcatn = 1;
        when ("-20 to < -10") chgcatn = 2;
        when ("-10 to < 0")   chgcatn = 3;
        when ("0 to < 10")    chgcatn = 4;
        when ("10 to < 20")   chgcatn = 5;
        when (">= 20")        chgcatn = 6;
        otherwise             chgcatn = .;
    end;
run;
 
proc summary data=adlb_mock2 nway;
    class avisitn avisit chgcatn chgcat trt01p;
    var chg;
    output out=bubble_sum(drop=_type_ _freq_)
        n = n_subject
        mean = mean_chg;
run;
 
data bubble_sum2;
    set bubble_sum;
 
    if trt01p = "Placebo" then avisitn_plot = avisitn - 0.15;
    else if trt01p = "Active Drug" then avisitn_plot = avisitn + 0.15;
    else avisitn_plot = avisitn;
 
    label
        avisitn_plot = "Visit"
        chgcatn      = "Change from Baseline Category"
        n_subject    = "Number of Subjects";
run;
 
proc sgplot data=bubble_sum2 noborder;
    bubble x=avisitn_plot
           y=chgcatn
           size=n_subject
           / group=trt01p
             transparency=0.25
             bradiusmin=2
             bradiusmax=18
             datalabel=n_subject
             datalabelpos=top
;
 
    xaxis label="Visit"
          values=(1 2 3 4 5)
          valuesdisplay=("Week 2" "Week 4" "Week 8" "Week 12" "Week 24")
          offsetmin=0.1 offsetmax=0.1
          integer;
 
    yaxis label="Change from Baseline Category"
          values=(1 2 3 4 5 6)
          valuesdisplay=("< -20"
                         "-20 to < -10"
                         "-10 to < 0"
                         "0 to < 10"
                         "10 to < 20"
                         ">= 20");
 
    keylegend / title="Treatment Group";
 
run;

~~~
  
---
---
# version history
0.1.0(26May2026): Initial version

## What is SAS Packages?

The package is built on top of **SAS Packages Framework(SPF)** developed by Bartosz Jablonski.

For more information about the framework, see [SAS Packages Framework](https://github.com/yabwon/SAS_PACKAGES).

You can also find more SAS Packages (SASPacs) in the [SAS Packages Archive(SASPAC)](https://github.com/SASPAC).

## How to use SAS Packages? (quick start)

### 1. Set-up SAS Packages Framework

First, create a directory for your packages and assign a `packages` fileref to it.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
filename packages "\path\to\your\packages";
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Secondly, enable the SAS Packages Framework.
(If you don't have SAS Packages Framework installed, follow the instruction in 
[SPF documentation](https://github.com/yabwon/SAS_PACKAGES/tree/main/SPF/Documentation) 
to install SAS Packages Framework.)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%include packages(SPFinit.sas)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### 2. Install SAS package

Install SAS package you want to use with the SPF's `%installPackage()` macro.

- For packages located in **SAS Packages Archive(SASPAC)** run:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  %installPackage(packageName)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- For packages located in **PharmaForest** run:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  %installPackage(packageName, mirror=PharmaForest)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- For packages located at some network location run:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  %installPackage(packageName, sourcePath=https://some/internet/location/for/packages)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  (e.g. `%installPackage(ABC, sourcePath=https://github.com/SomeRepo/ABC/raw/main/)`)


### 3. Load SAS package

Load SAS package you want to use with the SPF's `%loadPackage()` macro.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%loadPackage(packageName)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### Enjoy!

