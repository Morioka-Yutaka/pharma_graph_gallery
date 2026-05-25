/*** HELP START ***//*

Macro: SG005
Purpose: Spider plot of change from baseline by group.

*//*** HELP END ***/

%macro SG005;
title 'SG005:Spyder Plot by group';
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 10;
        do i = 1 to 10;
            subjid=cats(trtan,'-',i);
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

ods graphics / 
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
ods proclabel='SG005:Spyder Plot by group';
proc sgplot data=sds noautolegend noborder;
    styleattrs datacontrastcolors=(blue red)
    datasymbols=(circlefilled squarefilled) ;
    series x=AVISITN y=CHG /group=SUBJID grouplc=TRTAN groupmc=TRTAN markers markerattrs=(size=5) lineattrs=(pattern=solid  thickness=1) name="series" ;
    refline 0 /axis=y lineattrs=(color=gray thickness=2 pattern=dash);
    xaxis offsetmin=0.05 offsetmax=0.05 values=(1 to 10 ) labelattrs=(size=10) label="Analisys Visit" type=linear;
    yaxis  offsetmax=0.05 labelattrs=(size=10)  values=(-20 to 20 by 5) label ="Change from Baseline";
       keylegend 'series' / title='' noborder type=linecolor valueattrs=(size=10) 
         location=inside position=bottomright across=1 opaque;
format TRTAN TRTAN.;
run ;
ods proclabel='SG005:Spyder Plot by group';
proc odstext;
p'data(*ESC*){unicode "00A0"x}wk1;';
p'call(*ESC*){unicode "00A0"x}streaminit(777);';
p'do(*ESC*){unicode "00A0"x}TRTAN=1,2;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}AVISITN=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}10;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}i(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}10;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}subjid=cats(trtan,"-",i);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}trtan=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}AVAL(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",110,3);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}AVAL(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",110,2);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'end;';
p'run;';
p'data(*ESC*){unicode "00A0"x}base;';
p'set(*ESC*){unicode "00A0"x}wk1;';
p'where(*ESC*){unicode "00A0"x}AVISITN(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1;';
p'BASE=AVAL;';
p'keep(*ESC*){unicode "00A0"x}SUBJID(*ESC*){unicode "00A0"x}BASE;';
p'run;';
p'data(*ESC*){unicode "00A0"x}sds;';
p'set(*ESC*){unicode "00A0"x}wk1;';
p'if(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}base;';
p'if(*ESC*){unicode "00A0"x}_N_(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}declare(*ESC*){unicode "00A0"x}hash(*ESC*){unicode "00A0"x}h1(dataset:"base");';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}h1.definekey("SUBJID");';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}h1.definedata("BASE");';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}h1.definedone();';
p'end;';
p'if(*ESC*){unicode "00A0"x}h1.find()(*ESC*){unicode "00A0"x}ne(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}missing(of(*ESC*){unicode "00A0"x}BASE);';
p'if(*ESC*){unicode "00A0"x}n(AVAL,BASE)=2then(*ESC*){unicode "00A0"x}CHG(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}AVAL(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}BASE;';
p'run;';
p'';
p'proc(*ESC*){unicode "00A0"x}format(*ESC*){unicode "00A0"x};';
p'value(*ESC*){unicode "00A0"x}TRTAN(*ESC*){unicode "00A0"x}1="Active"(*ESC*){unicode "00A0"x}2="Placebo";';
p'run;';
p'';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=780(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=410(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=sds(*ESC*){unicode "00A0"x}noautolegend(*ESC*){unicode "00A0"x}noborder;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}styleattrs(*ESC*){unicode "00A0"x}datacontrastcolors=(blue(*ESC*){unicode "00A0"x}red)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}datasymbols=(circlefilled(*ESC*){unicode "00A0"x}squarefilled)(*ESC*){unicode "00A0"x};';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}series(*ESC*){unicode "00A0"x}x=AVISITN(*ESC*){unicode "00A0"x}y=CHG(*ESC*){unicode "00A0"x}/group=SUBJID(*ESC*){unicode "00A0"x}grouplc=TRTAN(*ESC*){unicode "00A0"x}groupmc=TRTAN(*ESC*){unicode "00A0"x}markers(*ESC*){unicode "00A0"x}markerattrs=(size=5)(*ESC*){unicode "00A0"x}lineattrs=(pattern=solid(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}thickness=1)(*ESC*){unicode "00A0"x}name="series"(*ESC*){unicode "00A0"x};';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}refline(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}/axis=y(*ESC*){unicode "00A0"x}lineattrs=(color=gray(*ESC*){unicode "00A0"x}thickness=2(*ESC*){unicode "00A0"x}pattern=dash);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxis(*ESC*){unicode "00A0"x}offsetmin=0.05(*ESC*){unicode "00A0"x}offsetmax=0.05(*ESC*){unicode "00A0"x}values=(1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}10(*ESC*){unicode "00A0"x})(*ESC*){unicode "00A0"x}labelattrs=(size=10)(*ESC*){unicode "00A0"x}label="Analisys(*ESC*){unicode "00A0"x}Visit"(*ESC*){unicode "00A0"x}type=linear;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxis(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}offsetmax=0.05(*ESC*){unicode "00A0"x}labelattrs=(size=10)(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}values=(-20(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}20(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}5)(*ESC*){unicode "00A0"x}label(*ESC*){unicode "00A0"x}="Change(*ESC*){unicode "00A0"x}from(*ESC*){unicode "00A0"x}Baseline";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}keylegend(*ESC*){unicode "00A0"x}"series"(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}title=""(*ESC*){unicode "00A0"x}noborder(*ESC*){unicode "00A0"x}type=linecolor(*ESC*){unicode "00A0"x}valueattrs=(size=10)(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}location=inside(*ESC*){unicode "00A0"x}position=bottomright(*ESC*){unicode "00A0"x}across=1(*ESC*){unicode "00A0"x}opaque;';
p'format(*ESC*){unicode "00A0"x}TRTAN(*ESC*){unicode "00A0"x}TRTAN.;';
p'run ;';
run;
title;
%mend;
