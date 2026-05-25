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

Macro: SG011
Purpose: Waterfall plot of subject-level change from baseline.

  
---
 
## `%sg012()` macro <a name="sg012-macro-13"></a> ######

Macro: SG012
Purpose: Scatter plot of individual values and overall mean plus-minus SD by visit.

  
---
 
## `%sg013()` macro <a name="sg013-macro-14"></a> ######

Macro: SG013
Purpose: Clustered bar chart of rates by type and treatment group.

  
---
 
## `%sg014()` macro <a name="sg014-macro-15"></a> ######

Macro: SG014
Purpose: Clustered bar chart of change from baseline with 95% confidence intervals over time by category.

  
---
 
## `%sg015()` macro <a name="sg015-macro-16"></a> ######

Macro: SG015
Purpose: Line plot of adjusted mean change from baseline with standard error over time by treatment group.

  
---
 
## `%sg016()` macro <a name="sg016-macro-17"></a> ######

Macro: SG016
Purpose: Reverse Kaplan-Meier plot of follow-up distribution over time.

  
---
 
## `%sg017()` macro <a name="sg017-macro-18"></a> ######

Macro: SG017
Purpose: Box plot of analysis values over visits by treatment group.

  
---
 
## `%sg018()` macro <a name="sg018-macro-19"></a> ######

Macro: SG018
Purpose: Box plot with overlaid beeswarm points.

  
---
 
## `%sg019()` macro <a name="sg019-macro-20"></a> ######

Macro: SG019
Purpose: Violin plot of distribution by group.

  
---
 
## `%sg020()` macro <a name="sg020-macro-21"></a> ######

Macro: SG020
Purpose: Raincloud plot showing distribution, box summary, and individual values.

  
---
 
## `%sg022()` macro <a name="sg022-macro-22"></a> ######

Macro: SG022
Purpose: Subject-level profile plot in a crossover study.

  
---
 
## `%sg023()` macro <a name="sg023-macro-23"></a> ######

Macro: SG023
Purpose: eDISH scatter plot of liver enzyme and bilirubin abnormalities.

  
---
 
## `%sg024()` macro <a name="sg024-macro-24"></a> ######

Macro: SG024
Purpose: Swimmer plot of subject-level treatment duration and events.

  
---
 
## `%sg025()` macro <a name="sg025-macro-25"></a> ######

Macro: SG025
Purpose: ROC curve of sensitivity versus false positive rate.

  
---
 
## `%sg026()` macro <a name="sg026-macro-26"></a> ######

Macro: SG026
Purpose: Power model plot of pharmacokinetic exposure versus dose.

  
---
 
## `%sg027()` macro <a name="sg027-macro-27"></a> ######

Macro: SG027
Purpose: Funnel plot of effect estimate versus standard error.

  
---
 
## `%sg028()` macro <a name="sg028-macro-28"></a> ######

Macro: SG028
Purpose: Funnel plot of effect estimate versus precision.

  
---
 
## `%sg029()` macro <a name="sg029-macro-29"></a> ######

Macro: SG029
Purpose: Heatmap of missing data patterns.

  
---
 
## `%sg030()` macro <a name="sg030-macro-30"></a> ######

Macro: SG030
Purpose: Lollipop plot of values by category.

  
---
 
## `%sg033()` macro <a name="sg033-macro-31"></a> ######

Macro: SG033
Purpose: Scatter plot with a broken X-axis.

  
---
 
## `%sg034()` macro <a name="sg034-macro-32"></a> ######

Macro: SG034
Purpose: Kaplan-Meier plot with confidence band and median survival droplines.

  
---
 
## `%sg035()` macro <a name="sg035-macro-33"></a> ######

Macro: SG035
Purpose: Pareto plot of counts and cumulative percentage.

  
---
 
## `%sg036()` macro <a name="sg036-macro-34"></a> ######

Macro: SG036
Purpose: Bland-Altman plot of measurement difference versus measurement mean.

  
---
 
## `%sg037()` macro <a name="sg037-macro-35"></a> ######

Macro: SG037
Purpose: Scatter plot with regression line within the data range.

  
---
 
## `%sg038()` macro <a name="sg038-macro-36"></a> ######

Macro: SG038
Purpose: Scatter plot with regression line extended over the axis range.

  
---
 
## `%sg039()` macro <a name="sg039-macro-37"></a> ######

Macro: SG039
Purpose: Volcano plot of fold change versus statistical significance.

  
---
 
## `%sg040()` macro <a name="sg040-macro-38"></a> ######

Macro: SG040
Purpose: Bubble plot of categorical change from baseline by visit and treatment group.

  
---
