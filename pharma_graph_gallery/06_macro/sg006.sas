/*** HELP START ***//*

Macro: SG006
Purpose: Semi-logarithmic line plot of mean plus SD over time.

*//*** HELP END ***/

%macro SG006;
title "SG006:Semi-logarithmic line plot with mean + SD error bars.";
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 10;
        do i = 1 to 10;
            subjid=cats(trtan,'-',i);
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

ods graphics / 
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
ods proclabel="SG006:Semi-logarithmic line plot with mean + SD error bars.";
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

ods proclabel="SG006:Semi-logarithmic line plot with mean + SD error bars.";
proc odstext;
p'data(*ESC*){unicode "00A0"x}wk1;';
p'call(*ESC*){unicode "00A0"x}streaminit(777);';
p'do(*ESC*){unicode "00A0"x}TRTAN=1,2;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}AVISITN=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}10;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}i(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}10;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}subjid=cats(trtan,"-",i);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}trtan=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}AVAL(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",110,50);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}AVAL(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",100,50);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=(AVAL*AVISITN)**2(*ESC*){unicode "00A0"x}*0.01;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'end;';
p'run;';
p'proc(*ESC*){unicode "00A0"x}summary(*ESC*){unicode "00A0"x}data=wk1(*ESC*){unicode "00A0"x}nway;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}class(*ESC*){unicode "00A0"x}AVISITN;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}var(*ESC*){unicode "00A0"x}AVAL;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output(*ESC*){unicode "00A0"x}out=wk2(*ESC*){unicode "00A0"x}mean=(*ESC*){unicode "00A0"x}std=(*ESC*){unicode "00A0"x}/autoname;';
p'run;';
p'data(*ESC*){unicode "00A0"x}sds;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}wk2;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}n(AVAL_Mean,AVAL_Stddev)(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}upper(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}AVAL_Mean(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}AVAL_Stddev;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}n(AVAL_Mean,AVAL_Stddev)(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}lower(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}AVAL_Mean(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}AVAL_Stddev;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}upper(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}missing(upper);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}lower(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}missing(lower);';
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
p'where(*ESC*){unicode "00A0"x}AVAL_Mean(*ESC*){unicode "00A0"x}>0;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}series(*ESC*){unicode "00A0"x}x=AVISITN(*ESC*){unicode "00A0"x}y=AVAL_Mean(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}markers(*ESC*){unicode "00A0"x}markerattrs=(symbol=circlefilled(*ESC*){unicode "00A0"x}color=blue(*ESC*){unicode "00A0"x}size=9)(*ESC*){unicode "00A0"x}lineattrs=(pattern=solid(*ESC*){unicode "00A0"x}color=blue(*ESC*){unicode "00A0"x}thickness=1)(*ESC*){unicode "00A0"x};';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}scatter(*ESC*){unicode "00A0"x}x=AVISITN(*ESC*){unicode "00A0"x}y=AVAL_Mean(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}yerrorupper=upper(*ESC*){unicode "00A0"x}errorbarattrs=(color=blue(*ESC*){unicode "00A0"x})markerattrs(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}(size=0);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}inset(*ESC*){unicode "00A0"x}"Mean+SD"/position=bottomright(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x};';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}inset(*ESC*){unicode "00A0"x}"Semi-Logarithmic(*ESC*){unicode "00A0"x}Scale"(*ESC*){unicode "00A0"x}/position=topleft(*ESC*){unicode "00A0"x}textattrs=(size=10);';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxis(*ESC*){unicode "00A0"x}offsetmin=0.05(*ESC*){unicode "00A0"x}offsetmax=0.05(*ESC*){unicode "00A0"x}values=(1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}10(*ESC*){unicode "00A0"x})(*ESC*){unicode "00A0"x}labelattrs=(size=10)(*ESC*){unicode "00A0"x}label="Analisys(*ESC*){unicode "00A0"x}Visit"(*ESC*){unicode "00A0"x}type=discrete;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxis(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}offsetmax=0.07(*ESC*){unicode "00A0"x}labelattrs=(size=9)(*ESC*){unicode "00A0"x}label="(*ESC*){unicode "00A0"x}Plasma(*ESC*){unicode "00A0"x}Concentration(*ESC*){unicode "00A0"x}(ng/mL)"(*ESC*){unicode "00A0"x}Type=log(*ESC*){unicode "00A0"x}logstyle=logexpand(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}logvtype=expanded';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}values=(100(*ESC*){unicode "00A0"x}1000(*ESC*){unicode "00A0"x}10000(*ESC*){unicode "00A0"x}100000(*ESC*){unicode "00A0"x})(*ESC*){unicode "00A0"x};';
p'run(*ESC*){unicode "00A0"x};';

run;
title;
%mend;
