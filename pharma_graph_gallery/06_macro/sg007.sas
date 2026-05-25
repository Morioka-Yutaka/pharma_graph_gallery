/*** HELP START ***//*

Macro: SG007
Purpose: Time-course plot of mean plus-minus SD by treatment group with discontinuation shown separately.

*//*** HELP END ***/

%macro SG007;
title "SG007:Mean +- SD over visits by treatment group, with discontinuation shown separately";
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 10;
        do i = 1 to 10;
            subjid=cats(trtan,'-',i);
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

ods graphics / 
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
ods proclabel="SG007:Mean +- SD over visits by treatment group, with discontinuation shown separately";
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

ods proclabel="SG007:Mean +- SD over visits by treatment group, with discontinuation shown separately";
proc odstext;
p'data(*ESC*){unicode "00A0"x}wk1;';
p'call(*ESC*){unicode "00A0"x}streaminit(777);';
p'do(*ESC*){unicode "00A0"x}TRTAN=1,2;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}AVISITN=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}10;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}i(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}10;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}subjid=cats(trtan,"-",i);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}trtan=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}AVAL(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",110,3);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}AVAL(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",100,2);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'end;';
p'run;';
p'proc(*ESC*){unicode "00A0"x}summary(*ESC*){unicode "00A0"x}data=wk1(*ESC*){unicode "00A0"x}nway;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}class(*ESC*){unicode "00A0"x}TRTAN(*ESC*){unicode "00A0"x}AVISITN;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}var(*ESC*){unicode "00A0"x}AVAL;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output(*ESC*){unicode "00A0"x}out=wk2(*ESC*){unicode "00A0"x}mean=(*ESC*){unicode "00A0"x}std=(*ESC*){unicode "00A0"x}/autoname;';
p'run;';
p'data(*ESC*){unicode "00A0"x}sds;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}wk2;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}n(AVAL_Mean,AVAL_Stddev)(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}upper(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}AVAL_Mean(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}AVAL_Stddev;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}n(AVAL_Mean,AVAL_Stddev)(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}lower(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}AVAL_Mean(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}AVAL_Stddev;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVISITN(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}10(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL_Mean2(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}AVAL_Mean;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}upper2(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}upper;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lower2(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}lower;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}missing(of(*ESC*){unicode "00A0"x}AVAL_Mean(*ESC*){unicode "00A0"x}upper(*ESC*){unicode "00A0"x}lower);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
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
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}datacolors=(blue(*ESC*){unicode "00A0"x}red)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}datalinepatterns=(solid(*ESC*){unicode "00A0"x}dash)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}datasymbols=(circle(*ESC*){unicode "00A0"x}circlefilled);(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}series(*ESC*){unicode "00A0"x}x=AVISITN(*ESC*){unicode "00A0"x}y=AVAL_Mean(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}group=TRTAN(*ESC*){unicode "00A0"x}groupdisplay=cluster(*ESC*){unicode "00A0"x}clusterwidth=0.1(*ESC*){unicode "00A0"x}markers(*ESC*){unicode "00A0"x}markerattrs=((*ESC*){unicode "00A0"x}size=9)(*ESC*){unicode "00A0"x}lineattrs=((*ESC*){unicode "00A0"x}thickness=1)(*ESC*){unicode "00A0"x}name="series";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}scatter(*ESC*){unicode "00A0"x}x=AVISITN(*ESC*){unicode "00A0"x}y=AVAL_Mean(*ESC*){unicode "00A0"x}/group=TRTAN(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}groupdisplay=cluster(*ESC*){unicode "00A0"x}clusterwidth=0.1(*ESC*){unicode "00A0"x}yerrorupper=upper(*ESC*){unicode "00A0"x}yerrorlower=lower(*ESC*){unicode "00A0"x}markerattrs(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}(size=0);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}scatter(*ESC*){unicode "00A0"x}x=AVISITN(*ESC*){unicode "00A0"x}y=AVAL_Mean2(*ESC*){unicode "00A0"x}/group=TRTAN(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}groupdisplay=cluster(*ESC*){unicode "00A0"x}clusterwidth=0.1(*ESC*){unicode "00A0"x}yerrorupper=upper2(*ESC*){unicode "00A0"x}yerrorlower=lower2(*ESC*){unicode "00A0"x}markerattrs(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}(size=9);';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}inset(*ESC*){unicode "00A0"x}"Mean+-SD"/position=bottomleft(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x};';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}keylegend(*ESC*){unicode "00A0"x}"series"/title=""(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}location=inside(*ESC*){unicode "00A0"x}position=topright(*ESC*){unicode "00A0"x}across=1(*ESC*){unicode "00A0"x}noborder;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxis(*ESC*){unicode "00A0"x}offsetmin=0.05(*ESC*){unicode "00A0"x}offsetmax=0.05(*ESC*){unicode "00A0"x}values=(1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}10(*ESC*){unicode "00A0"x})(*ESC*){unicode "00A0"x}valuesdisplay=("Baseline"(*ESC*){unicode "00A0"x}"V2"(*ESC*){unicode "00A0"x}"V3"(*ESC*){unicode "00A0"x}"V4"(*ESC*){unicode "00A0"x}"V5"(*ESC*){unicode "00A0"x}"V6"(*ESC*){unicode "00A0"x}"V7"(*ESC*){unicode "00A0"x}"V8"(*ESC*){unicode "00A0"x}"V9"(*ESC*){unicode "00A0"x}"discontinuation")(*ESC*){unicode "00A0"x}labelattrs=(size=10)(*ESC*){unicode "00A0"x}label="Analisys(*ESC*){unicode "00A0"x}Visit"(*ESC*){unicode "00A0"x}type=discrete;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxis(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}offsetmax=0.05(*ESC*){unicode "00A0"x}labelattrs=(size=10)(*ESC*){unicode "00A0"x}values=(90(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}120(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}5)(*ESC*){unicode "00A0"x}label(*ESC*){unicode "00A0"x}="Analysis(*ESC*){unicode "00A0"x}Value";';
p'format(*ESC*){unicode "00A0"x}TRTAN(*ESC*){unicode "00A0"x}TRTAN.;';
p'run(*ESC*){unicode "00A0"x};';
run;
title;
%mend;
