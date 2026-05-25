/*** HELP START ***//*

Macro: SG012
Purpose: Scatter plot of individual values and overall mean plus-minus SD by visit.

*//*** HELP END ***/

%macro SG012;
title 'SG012:Individual values and overall mean +- SD by visit';
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 3;
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
ods graphics / 
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
ods proclabel='SG012:Individual values and overall mean +- SD by visit';
proc sgplot data=sds noborder;
  scatter x = AVISITN y=AVAL/  group= TRTAN nomissinggroup groupdisplay=cluster clusterwidth=0.2 jitter markerattrs=(symbol=circlefilled) name="scatter";
  scatter x =AVISITN y=AVAL_Mean / group=dummy_group  groupdisplay=cluster clusterwidth=0.4 yerrorupper=upper yerrorlower=lower
                                 markerattrs=(color=black size=9 symbol=squarefilled) 
                                 errorbarattrs=(color=black);
  xaxis type=discrete offsetmax=0.1;
  yaxis values=(90 to 120 by 5 ); 
  keylegend 'scatter' / title='Treatment'  valueattrs=(size=10) noborder
         location=inside position=topright across=1 opaque;
 format TRTAN TRTAN.;
run;

ods proclabel='SG012:Individual values and overall mean +- SD by visit';
proc odstext;
p'data(*ESC*){unicode "00A0"x}wk1;';
p'call(*ESC*){unicode "00A0"x}streaminit(777);';
p'do(*ESC*){unicode "00A0"x}TRTAN=1,2;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}AVISITN=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}3;';
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
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}class(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVISITN;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}var(*ESC*){unicode "00A0"x}AVAL;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output(*ESC*){unicode "00A0"x}out=wk2(*ESC*){unicode "00A0"x}mean=(*ESC*){unicode "00A0"x}std=(*ESC*){unicode "00A0"x}/autoname;';
p'run;';
p'data(*ESC*){unicode "00A0"x}summary;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}wk2;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}n(AVAL_Mean,AVAL_Stddev)(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}upper(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}AVAL_Mean(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}AVAL_Stddev;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}n(AVAL_Mean,AVAL_Stddev)(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}lower(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}AVAL_Mean(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}AVAL_Stddev;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}dummy_group=3;';
p'run;';
p'data(*ESC*){unicode "00A0"x}dummy;';
p'(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}dummy_group(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}2;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}AVISITN=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}3;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'(*ESC*){unicode "00A0"x}end;';
p'run;';
p'data(*ESC*){unicode "00A0"x}sds;';
p'set(*ESC*){unicode "00A0"x}wk1';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}dummy';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}summary;';
p'run;';
p'';
p'proc(*ESC*){unicode "00A0"x}format(*ESC*){unicode "00A0"x};';
p'value(*ESC*){unicode "00A0"x}TRTAN(*ESC*){unicode "00A0"x}1="Active"(*ESC*){unicode "00A0"x}2="Placebo";';
p'run;';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=780(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=410(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=sds(*ESC*){unicode "00A0"x}noborder;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}scatter(*ESC*){unicode "00A0"x}x(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}AVISITN(*ESC*){unicode "00A0"x}y=AVAL/(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}group=(*ESC*){unicode "00A0"x}TRTAN(*ESC*){unicode "00A0"x}nomissinggroup(*ESC*){unicode "00A0"x}groupdisplay=cluster(*ESC*){unicode "00A0"x}clusterwidth=0.2(*ESC*){unicode "00A0"x}jitter(*ESC*){unicode "00A0"x}markerattrs=(symbol=circlefilled)(*ESC*){unicode "00A0"x}name="scatter";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}scatter(*ESC*){unicode "00A0"x}x(*ESC*){unicode "00A0"x}=AVISITN(*ESC*){unicode "00A0"x}y=AVAL_Mean(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}group=dummy_group(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}groupdisplay=cluster(*ESC*){unicode "00A0"x}clusterwidth=0.4(*ESC*){unicode "00A0"x}yerrorupper=upper(*ESC*){unicode "00A0"x}yerrorlower=lower';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}markerattrs=(color=black(*ESC*){unicode "00A0"x}size=9(*ESC*){unicode "00A0"x}symbol=squarefilled)(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}errorbarattrs=(color=black);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxis(*ESC*){unicode "00A0"x}type=discrete(*ESC*){unicode "00A0"x}offsetmax=0.1;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxis(*ESC*){unicode "00A0"x}values=(90(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}120(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}5(*ESC*){unicode "00A0"x});(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}keylegend(*ESC*){unicode "00A0"x}"scatter"(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}title="Treatment"(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}valueattrs=(size=10)(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}location=inside(*ESC*){unicode "00A0"x}position=topright(*ESC*){unicode "00A0"x}across=1(*ESC*){unicode "00A0"x}opaque;';
p'(*ESC*){unicode "00A0"x}format(*ESC*){unicode "00A0"x}TRTAN(*ESC*){unicode "00A0"x}TRTAN.;';
p'run;';

run;
title;
%mend;
