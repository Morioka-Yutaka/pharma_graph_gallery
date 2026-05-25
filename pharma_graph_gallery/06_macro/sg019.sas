/*** HELP START ***//*

Macro: SG019
Purpose: Violin plot of distribution by group.

*//*** HELP END ***/

%macro SG019;
title "SG019:Violin Plot";;
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

ods graphics / 
               noborder
               noscale
               width=580 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
ods proclabel="SG019:Violin Plot";
proc sgplot data=sds noautolegend noborder;
band y=value upper=density lower=mirror /  fill outline group=TRT01PN transparency=0.6 lineattrs=(pattern=solid) name="band";
xaxis values=(-0.1 to 0.1 by 0.02 ) ;
keylegend "band"/title=""  location=inside position=topright across=1 noborder;
format TRT01PN TRT01PN.;
run;

ods proclabel="SG019:Violin Plot";
proc odstext;
p'data(*ESC*){unicode "00A0"x}wk1;';
p'do(*ESC*){unicode "00A0"x}TRT01PN(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}2;';
p'(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRT01PN(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}id=1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}200;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}SUBJID(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}cats(TRT01PN,"-",id);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=rand("normal",10,5)(*ESC*){unicode "00A0"x};';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}id=201(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}400;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}SUBJID(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}cats(TRT01PN,"-",id);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=rand("normal",23,6);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'(*ESC*){unicode "00A0"x}end;';
p'(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRT01PN(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}id=1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}300;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}SUBJID(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}cats(TRT01PN,"-",id);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=rand("normal",7,5)(*ESC*){unicode "00A0"x};';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}id=301(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}400;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}SUBJID(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}cats(TRT01PN,"-",id);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=rand("normal",18,6);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'(*ESC*){unicode "00A0"x}end;';
p'end;';
p'run;';
p'(*ESC*){unicode "00A0"x}';
p'proc(*ESC*){unicode "00A0"x}kde(*ESC*){unicode "00A0"x}data(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}wk1;';
p'univar(*ESC*){unicode "00A0"x}AVAL(*ESC*){unicode "00A0"x}/out=wk2(*ESC*){unicode "00A0"x};';
p'by(*ESC*){unicode "00A0"x}TRT01PN;';
p'run;';
p'(*ESC*){unicode "00A0"x}';
p'data(*ESC*){unicode "00A0"x}sds;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}wk2;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}mirror(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}-density;';
p'run;';
p'';
p'proc(*ESC*){unicode "00A0"x}format(*ESC*){unicode "00A0"x};';
p'value(*ESC*){unicode "00A0"x}TRT01PN(*ESC*){unicode "00A0"x}1="Active"(*ESC*){unicode "00A0"x}2="Placebo";';
p'run;';
p'';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=580(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=510(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=sds(*ESC*){unicode "00A0"x}noautolegend(*ESC*){unicode "00A0"x}noborder;';
p'band(*ESC*){unicode "00A0"x}y=value(*ESC*){unicode "00A0"x}upper=density(*ESC*){unicode "00A0"x}lower=mirror(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}fill(*ESC*){unicode "00A0"x}outline(*ESC*){unicode "00A0"x}group=TRT01PN(*ESC*){unicode "00A0"x}transparency=0.6(*ESC*){unicode "00A0"x}lineattrs=(pattern=solid)(*ESC*){unicode "00A0"x}name="band";';
p'xaxis(*ESC*){unicode "00A0"x}values=(-0.1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}0.1(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}0.02(*ESC*){unicode "00A0"x})(*ESC*){unicode "00A0"x};';
p'keylegend(*ESC*){unicode "00A0"x}"band"/title=""(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}location=inside(*ESC*){unicode "00A0"x}position=topright(*ESC*){unicode "00A0"x}across=1(*ESC*){unicode "00A0"x}noborder;';
p'format(*ESC*){unicode "00A0"x}TRT01PN(*ESC*){unicode "00A0"x}TRT01PN.;';
p'run;';
run;
title;
%mend;
