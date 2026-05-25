/*** HELP START ***//*

Macro: SG022
Purpose: Subject-level profile plot in a crossover study.

*//*** HELP END ***/

%macro SG022;
title "SG022:Subject-level profile plot in a crossover study";
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
ods graphics / 
               noborder
               noscale
               width=580 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
ods proclabel="SG022:Subject-level profile plot in a crossover study";
proc sgplot data=wk1 noborder noautolegend;
  series x=TRTAN y=AVAL /group=SUBJID grouplc=TRT01AN groupmc=TRT01AN markers lineattrs=(pattern=solid thickness=1) markerattrs = (size=7 symbol=circlefilled) name="series";
  xaxis offsetmin=0.2 offsetmax=0.2 labelattrs=(size=10) display=(nolabel) values=(1 2) valuesdisplay=("Active" "Placebo") type=discrete ;
  yaxis  offsetmax=0.07 labelattrs=(size=10)  values=(10 to  30 by 5) ;
  keylegend 'series' / title='' noborder type=linecolor valueattrs=(size=10) 
         location=inside position=bottomright across=1 opaque;
  format TRT01AN TRT01AN.;
run ;

ods proclabel="SG022:Subject-level profile plot in a crossover study";
proc odstext;
p'data(*ESC*){unicode "00A0"x}wk1;';
p'length(*ESC*){unicode "00A0"x}TRTAN(*ESC*){unicode "00A0"x}8.(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}SUBJID(*ESC*){unicode "00A0"x}$20.(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL(*ESC*){unicode "00A0"x}8.;';
p'call(*ESC*){unicode "00A0"x}streaminit(777);';
p'do(*ESC*){unicode "00A0"x}TRTAN=1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}2;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}sub(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}20;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}sub(*ESC*){unicode "00A0"x}<=10(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}TRT01AN=1;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRT01AN=2;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}SUBJID=put(sub,z3.);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}TRTAN=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}AVAL(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",(*ESC*){unicode "00A0"x}20,(*ESC*){unicode "00A0"x}2);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}TRTAN=2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}AVAL(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",(*ESC*){unicode "00A0"x}21,(*ESC*){unicode "00A0"x}3);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'end;';
p'keep(*ESC*){unicode "00A0"x}TRTAN(*ESC*){unicode "00A0"x}TRT01AN(*ESC*){unicode "00A0"x}SUBJID(*ESC*){unicode "00A0"x}AVAL;';
p'run;';
p'proc(*ESC*){unicode "00A0"x}format(*ESC*){unicode "00A0"x};';
p'value(*ESC*){unicode "00A0"x}TRT01AN(*ESC*){unicode "00A0"x}1=(*ESC*){unicode "00A0"x}"Active(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}Placebo(*ESC*){unicode "00A0"x}sequence(*ESC*){unicode "00A0"x}(Active/Placebo)"(*ESC*){unicode "00A0"x}2="Placebo(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}Active(*ESC*){unicode "00A0"x}sequence(*ESC*){unicode "00A0"x}(Placebo/Active)";';
p'run;';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=580(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=510(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=wk1(*ESC*){unicode "00A0"x}noborder(*ESC*){unicode "00A0"x}noautolegend;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}series(*ESC*){unicode "00A0"x}x=TRTAN(*ESC*){unicode "00A0"x}y=AVAL(*ESC*){unicode "00A0"x}/group=SUBJID(*ESC*){unicode "00A0"x}grouplc=TRT01AN(*ESC*){unicode "00A0"x}groupmc=TRT01AN(*ESC*){unicode "00A0"x}markers(*ESC*){unicode "00A0"x}lineattrs=(pattern=solid(*ESC*){unicode "00A0"x}thickness=1)(*ESC*){unicode "00A0"x}markerattrs(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}(size=7(*ESC*){unicode "00A0"x}symbol=circlefilled)(*ESC*){unicode "00A0"x}name="series";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxis(*ESC*){unicode "00A0"x}offsetmin=0.2(*ESC*){unicode "00A0"x}offsetmax=0.2(*ESC*){unicode "00A0"x}labelattrs=(size=10)(*ESC*){unicode "00A0"x}display=(nolabel)(*ESC*){unicode "00A0"x}values=(1(*ESC*){unicode "00A0"x}2)(*ESC*){unicode "00A0"x}valuesdisplay=("Active"(*ESC*){unicode "00A0"x}"Placebo")(*ESC*){unicode "00A0"x}type=discrete(*ESC*){unicode "00A0"x};';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxis(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}offsetmax=0.07(*ESC*){unicode "00A0"x}labelattrs=(size=10)(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}values=(10(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}30(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}5)(*ESC*){unicode "00A0"x};';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}keylegend(*ESC*){unicode "00A0"x}"series"(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}title=""(*ESC*){unicode "00A0"x}noborder(*ESC*){unicode "00A0"x}type=linecolor(*ESC*){unicode "00A0"x}valueattrs=(size=10)(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}location=inside(*ESC*){unicode "00A0"x}position=bottomright(*ESC*){unicode "00A0"x}across=1(*ESC*){unicode "00A0"x}opaque;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}format(*ESC*){unicode "00A0"x}TRT01AN(*ESC*){unicode "00A0"x}TRT01AN.;';
p'run(*ESC*){unicode "00A0"x};';
run;
title;
%mend;
