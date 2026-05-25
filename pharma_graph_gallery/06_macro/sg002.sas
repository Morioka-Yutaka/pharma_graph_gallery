/*** HELP START ***//*

Macro: SG002
Purpose: Time-course plot of mean plus-minus SD by group.

*//*** HELP END ***/

%macro SG002;
title "SG002:Time-course plot of mean plus-minus SD by group";
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
run;

proc format ;
value TRTAN 1="Active" 2="Placebo";
run;
ods proclabel='SG002:Time-course plot of mean plus-minus SD by group';
proc sgplot data=sds noautolegend noborder;
    styleattrs datacontrastcolors=(blue red)
                  datacolors=(blue red)
                  datalinepatterns=(solid dash)
                  datasymbols=(circle circlefilled);   

    series x=AVISITN y=AVAL_Mean / group=TRTAN groupdisplay=cluster clusterwidth=0.1 markers markerattrs=( size=9) lineattrs=( thickness=1) name="series";
    scatter x=AVISITN y=AVAL_Mean /group=TRTAN  groupdisplay=cluster clusterwidth=0.1 yerrorupper=upper yerrorlower=lower markerattrs = (size=0);
    inset "Mean+-SD"/position=bottomright  ;

    keylegend "series"/title=""  location=inside position=topright across=1 noborder;

    xaxis offsetmin=0.05 offsetmax=0.05 values=(1 to 10 ) labelattrs=(size=10) label="Analisys Visit" type=discrete;
    yaxis  offsetmax=0.05 labelattrs=(size=10) values=(90 to 120 by 5) label ="Analysis Value";
format TRTAN TRTAN.;
run ;

ods proclabel='SG002:Time-course plot of mean plus-minus SD by group';
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
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} class TRTAN AVISITN;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} var AVAL;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} output out=wk2 mean= std=(*ESC*){unicode "00A0"x}/autoname;';
p 'run;';
p 'data sds;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} set wk2;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} if n(AVAL_Mean,AVAL_Stddev)(*ESC*){unicode "00A0"x}= 2 then upper = AVAL_Mean + AVAL_Stddev;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} if n(AVAL_Mean,AVAL_Stddev)(*ESC*){unicode "00A0"x}= 2 then lower = AVAL_Mean - AVAL_Stddev;';
p 'run;';
p '';
p 'proc format ;';
p 'value TRTAN 1="Active" 2="Placebo";';
p 'run;';
p '';
p 'proc sgplot data=sds noautolegend noborder;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} styleattrs datacontrastcolors=(blue red)';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} datacolors=(blue red)';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} datalinepatterns=(solid dash)';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} datasymbols=(circle circlefilled);(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}';
p '';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} series x=AVISITN y=AVAL_Mean / group=TRTAN groupdisplay=cluster clusterwidth=0.1 markers markerattrs=( size=9) lineattrs=( thickness=1) name="series";';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} scatter x=AVISITN y=AVAL_Mean /group=TRTAN  groupdisplay=cluster clusterwidth=0.1 yerrorupper=upper yerrorlower=lower markerattrs =(*ESC*){unicode "00A0"x}(size=0);';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} inset "Mean+-SD"/position=bottomright (*ESC*){unicode "00A0"x};';
p '';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} keylegend "series"/title=""(*ESC*){unicode "00A0"x} location=inside position=topright across=1 noborder;';
p '';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} xaxis offsetmin=0.05 offsetmax=0.05 values=(1 to 10 ) labelattrs=(size=10) label="Analisys Visit" type=discrete;';
p '(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x} yaxis  offsetmax=0.05 labelattrs=(size=10) values=(90 to 120 by 5) label ="Analysis Value";';
p 'format TRTAN TRTAN.;';
p 'run ;';

run;
title;
%mend;
