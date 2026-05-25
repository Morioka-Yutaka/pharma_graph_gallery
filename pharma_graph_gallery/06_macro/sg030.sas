/*** HELP START ***//*

Macro: SG030
Purpose: Lollipop plot of values by category.

*//*** HELP END ***/

%macro SG030;
title "SG030:Lollipop Plot";
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

ods graphics / 
               noborder
               noscale
               width=800 px
               height=600 px
               attrpriority=none
               imagefmt=png;
ods proclabel="SG030:Lollipop Plot";
;proc sgplot data=NullFreqs1  noautolegend;
  hbarparm category=y response=RowPercent /   barwidth=0.1 baselineattrs=(thickness=0);
  scatter y=y  x=RowPercent /  markerattrs=(symbol=circlefilled size=7)  dataskin=sheen;

  xaxis offsetmin=0.01 offsetmax=0.04 display=( noticks noline) values=(0 to 50 by 5) grid label='% Missing';
  yaxis display=( noticks noline novalues nolabel) fitpolicy=split grid;
  yaxistable varname/y=y nolabel position=left;
  format y best6.;
run;

ods proclabel="SG030:Lollipop Plot";
proc odstext;
p'data(*ESC*){unicode "00A0"x}missing_map_sampke;';
p'call(*ESC*){unicode "00A0"x}streaminit(123);';
p'';
p'length(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID(*ESC*){unicode "00A0"x}$12';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}SEX(*ESC*){unicode "00A0"x}$1';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRT(*ESC*){unicode "00A0"x}$8';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}STRATA(*ESC*){unicode "00A0"x}$5';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}FLAG(*ESC*){unicode "00A0"x}$1';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}C01-C05(*ESC*){unicode "00A0"x}$20';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}N01-N08(*ESC*){unicode "00A0"x}8.';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}C06(*ESC*){unicode "00A0"x}$20';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}N09-N13(*ESC*){unicode "00A0"x}8.';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}C07-C12(*ESC*){unicode "00A0"x}$20';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}N14-N20(*ESC*){unicode "00A0"x}8.';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}C13-C16(*ESC*){unicode "00A0"x}$20';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}N20-N25(*ESC*){unicode "00A0"x}8.';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}C17-C20(*ESC*){unicode "00A0"x}$20;';
p'';
p'array(*ESC*){unicode "00A0"x}nums(*ESC*){unicode "00A0"x}N01-N25;';
p'array(*ESC*){unicode "00A0"x}chars(*ESC*){unicode "00A0"x}C01-C20;';
p'';
p'do(*ESC*){unicode "00A0"x}i(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}300;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}cats("SUBJ",(*ESC*){unicode "00A0"x}put(i,(*ESC*){unicode "00A0"x}z4.));';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}SEX(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}ifc(rand("uniform")<0.5,"M","F");';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRT(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}scan("Placebo(*ESC*){unicode "00A0"x}DrugA(*ESC*){unicode "00A0"x}DrugB(*ESC*){unicode "00A0"x}DrugC",(*ESC*){unicode "00A0"x}ceil(rand("uniform")*4));';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}STRATA(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}scan("Low(*ESC*){unicode "00A0"x}Mid(*ESC*){unicode "00A0"x}High",(*ESC*){unicode "00A0"x}ceil(rand("uniform")*3));';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}FLAG(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}ifc(rand("uniform")<0.7,"Y","N");';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}j(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}dim(nums);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}rand("uniform")(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}0.15(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}nums[j](*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}.;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}nums[j](*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",(*ESC*){unicode "00A0"x}100,(*ESC*){unicode "00A0"x}15);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}k(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}dim(chars);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}rand("uniform")(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}0.20(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}chars[k](*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"";(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}chars[k](*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}scan("A(*ESC*){unicode "00A0"x}B(*ESC*){unicode "00A0"x}C(*ESC*){unicode "00A0"x}D(*ESC*){unicode "00A0"x}E",(*ESC*){unicode "00A0"x}ceil(rand("uniform")*5));';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'end;';
p'';
p'drop(*ESC*){unicode "00A0"x}i(*ESC*){unicode "00A0"x}j(*ESC*){unicode "00A0"x}k;';
p'run;';
p'';
p'data(*ESC*){unicode "00A0"x}nullmap;';
p'length(*ESC*){unicode "00A0"x}varname(*ESC*){unicode "00A0"x}$20.;';
p'set(*ESC*){unicode "00A0"x}missing_map_sampke;';
p'array(*ESC*){unicode "00A0"x}ar_num(*ESC*){unicode "00A0"x}_numeric_;';
p'do(*ESC*){unicode "00A0"x}over(*ESC*){unicode "00A0"x}ar_num;';
p'(*ESC*){unicode "00A0"x}varname=vname(ar_num);';
p'(*ESC*){unicode "00A0"x}varn=_i_;';
p'(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}missing(ar_num)(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}catn=0;';
p'(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}catn=1;';
p'(*ESC*){unicode "00A0"x}output;';
p'end;';
p'array(*ESC*){unicode "00A0"x}ar_character(*ESC*){unicode "00A0"x}_char_;';
p'do(*ESC*){unicode "00A0"x}over(*ESC*){unicode "00A0"x}ar_character;';
p'(*ESC*){unicode "00A0"x}varname=vname(ar_character);';
p'(*ESC*){unicode "00A0"x}varn=_i_;';
p'(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}missing(ar_character)(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}catn=0;';
p'(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}catn=2;';
p'(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}varname(*ESC*){unicode "00A0"x}ne(*ESC*){unicode "00A0"x}"varname"(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}output;';
p'end;';
p'keep(*ESC*){unicode "00A0"x}varname(*ESC*){unicode "00A0"x}catn;';
p'run;';
p'';
p'ods(*ESC*){unicode "00A0"x}output(*ESC*){unicode "00A0"x}CrossTabFreqs=NullFreqs(where=(catn=0));';
p'proc(*ESC*){unicode "00A0"x}freq(*ESC*){unicode "00A0"x}data=nullmap(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}order=FREQ;';
p'(*ESC*){unicode "00A0"x}table(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}varname*catn(*ESC*){unicode "00A0"x}/nopercent(*ESC*){unicode "00A0"x}nocol(*ESC*){unicode "00A0"x}nocum;';
p'run;';
p'';
p'proc(*ESC*){unicode "00A0"x}sort(*ESC*){unicode "00A0"x}data=NullFreqs;';
p'(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}descending(*ESC*){unicode "00A0"x}RowPercent;';
p'run;';
p'data(*ESC*){unicode "00A0"x}NullFreqs1;';
p'(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}NullFreqs;';
p'(*ESC*){unicode "00A0"x}where(*ESC*){unicode "00A0"x}^missing(RowPercent);';
p'(*ESC*){unicode "00A0"x}y=_N_;';
p'run;';
p'';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=800(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=600(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png;';
p';proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=NullFreqs1(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noautolegend;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}hbarparm(*ESC*){unicode "00A0"x}category=y(*ESC*){unicode "00A0"x}response=RowPercent(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}barwidth=0.1(*ESC*){unicode "00A0"x}baselineattrs=(thickness=0);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}scatter(*ESC*){unicode "00A0"x}y=y(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}x=RowPercent(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}markerattrs=(symbol=circlefilled(*ESC*){unicode "00A0"x}size=7)(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}dataskin=sheen;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxis(*ESC*){unicode "00A0"x}offsetmin=0.01(*ESC*){unicode "00A0"x}offsetmax=0.04(*ESC*){unicode "00A0"x}display=((*ESC*){unicode "00A0"x}noticks(*ESC*){unicode "00A0"x}noline)(*ESC*){unicode "00A0"x}values=(0(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}50(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}5)(*ESC*){unicode "00A0"x}grid(*ESC*){unicode "00A0"x}label="%(*ESC*){unicode "00A0"x}Missing";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxis(*ESC*){unicode "00A0"x}display=((*ESC*){unicode "00A0"x}noticks(*ESC*){unicode "00A0"x}noline(*ESC*){unicode "00A0"x}novalues(*ESC*){unicode "00A0"x}nolabel)(*ESC*){unicode "00A0"x}fitpolicy=split(*ESC*){unicode "00A0"x}grid;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxistable(*ESC*){unicode "00A0"x}varname/y=y(*ESC*){unicode "00A0"x}nolabel(*ESC*){unicode "00A0"x}position=left;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}format(*ESC*){unicode "00A0"x}y(*ESC*){unicode "00A0"x}best6.;';
p'run;';
run;
title;
%mend;

