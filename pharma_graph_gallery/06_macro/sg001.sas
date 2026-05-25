/*** HELP START ***//*

Macro: SG001
Purpose: Time-course plot of mean plus-minus SD in a single group.

*//*** HELP END ***/

%macro SG001;
title "SG001:Time-course plot of mean plus-minus SD in a single group";
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
ods proclabel='SG001:Time-course plot of mean plus-minus SD in a single group';
proc sgplot data=sds noautolegend noborder;
    series x=AVISITN y=AVAL_Mean / markers markerattrs=(symbol=circlefilled color=blue size=9) lineattrs=(pattern=solid color=blue thickness=1) ;
    scatter x=AVISITN y=AVAL_Mean / yerrorupper=upper yerrorlower=lower errorbarattrs=(color=blue )markerattrs = (size=0);
    inset "Mean+-SD"/position=bottomright  ;

    xaxis offsetmin=0.05 offsetmax=0.05 values=(1 to 10 ) labelattrs=(size=10) label="Analisys Visit" type=discrete;
    yaxis  offsetmax=0.05 labelattrs=(size=10) values=(90 to 120 by 5) label ="Analysis Value";

run ;

ods proclabel='SG001:Time-course plot of mean plus-minus SD in a single group';
proc odstext;
p 'data wk1;';
p 'call streaminit(777);';
p 'do TRTAN=1,2;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} do AVISITN= 1 to 10;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} do i = 1 to 10;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} subjid=cats(trtan,"-",i);';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} if trtan=1 then AVAL = rand("normal",110,3);';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} else AVAL = rand("normal",100,2);';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} output;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} end;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} end;';
p 'end;';
p 'run;';
p 'proc summary data=wk1 nway;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} class AVISITN;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} var AVAL;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} output out=wk2 mean= std=(*ESC*){unicode "00A0"x}/autoname;';
p 'run;';
p 'data sds;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} set wk2;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} if n(AVAL_Mean,AVAL_Stddev)(*ESC*){unicode "00A0"x}= 2 then upper = AVAL_Mean + AVAL_Stddev;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} if n(AVAL_Mean,AVAL_Stddev)(*ESC*){unicode "00A0"x}= 2 then lower = AVAL_Mean - AVAL_Stddev;';
p 'run;';
p 'ods graphics / ';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} noborder';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} noscale';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} width=780 px';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} height=410 px';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} attrpriority=none';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} imagefmt=png';
p ';';
p 'proc sgplot data=sds noautolegend noborder;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} series x=AVISITN y=AVAL_Mean / markers markerattrs=(symbol=circlefilled color=blue size=9) lineattrs=(pattern=solid color=blue thickness=1)(*ESC*){unicode "00A0"x};';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} scatter x=AVISITN y=AVAL_Mean / yerrorupper=upper yerrorlower=lower errorbarattrs=(color=blue )markerattrs =(*ESC*){unicode "00A0"x}(size=0);';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} inset "Mean+-SD"/position=bottomright (*ESC*){unicode "00A0"x};';
p '';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} xaxis offsetmin=0.05 offsetmax=0.05 values=(1 to 10 ) labelattrs=(size=10) label="Analisys Visit" type=discrete;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} yaxis  offsetmax=0.05 labelattrs=(size=10) values=(90 to 120 by 5) label ="Analysis Value";';
p '';
p 'run ;';
run;
title;
%mend;

