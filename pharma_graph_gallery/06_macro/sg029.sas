/*** HELP START ***//*

Macro: SG029
Purpose: Heatmap of missing data patterns.

*//*** HELP END ***/

%macro SG029;
title "SG029:Missing Data Heatmap";
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

ods output Position=Position;
proc contents data=missing_map_sampke varnum;
run;

proc format;
value catnf 
      0   = "Null"
      1   = "Numeric"
      2   = "Charcter";
run;
data nullmap;
length varname $20.;
set missing_map_sampke;
obs=_N_;
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
format catn catnf.;
keep varname obs catn;
run;

data nullmap2;
set nullmap;
if 0 then set position(keep=Variable Num);
if _N_ =1 then do;
  declare hash h1(dataset:"position");
  h1.definekey("Variable");
  h1.definedata("Num");
  h1.definedone();
end;
Variable=varname;
if h1.find() ne 0 then call missing(Num);
if ^missing(Num);
run;
proc sort data=nullmap2;
by num obs;
run;

data mapping;
length ID Show FillColor Value $20.;
ID='catn';
Show='AttrMap'; 
do Value ="Null","Numeric","Charcter";
 select(Value);
  when("Null") FillColor="gray";
  when("Numeric") FillColor="bibg";
  when("Charcter") FillColor="pink";
 end;
 output;
end;
run;

ods graphics / 
               noborder
               noscale
               width=1100 px
               height=700 px
               attrpriority=none
               imagefmt=png;
ods proclabel="SG029:Missing Data Heatmap";
proc sgplot data=nullmap2 dattrmap=mapping ; 
   format catn catnf.;
   heatmapparm x=varname  y=obs colorgroup=catn /  attrid=catn x2axis;
   x2axis;
   yaxis reverse label="Observation";
   keylegend / title="Type" location=outside position=right across=1;                          
run;

ods proclabel="SG029:Missing Data Heatmap";
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
p'ods(*ESC*){unicode "00A0"x}output(*ESC*){unicode "00A0"x}Position=Position;';
p'proc(*ESC*){unicode "00A0"x}contents(*ESC*){unicode "00A0"x}data=missing_map_sampke(*ESC*){unicode "00A0"x}varnum;';
p'run;';
p'';
p'proc(*ESC*){unicode "00A0"x}format;';
p'value(*ESC*){unicode "00A0"x}catnf(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Null"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Numeric"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Charcter";';
p'run;';
p'data(*ESC*){unicode "00A0"x}nullmap;';
p'length(*ESC*){unicode "00A0"x}varname(*ESC*){unicode "00A0"x}$20.;';
p'set(*ESC*){unicode "00A0"x}missing_map_sampke;';
p'obs=_N_;';
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
p'format(*ESC*){unicode "00A0"x}catn(*ESC*){unicode "00A0"x}catnf.;';
p'keep(*ESC*){unicode "00A0"x}varname(*ESC*){unicode "00A0"x}obs(*ESC*){unicode "00A0"x}catn;';
p'run;';
p'';
p'data(*ESC*){unicode "00A0"x}nullmap2;';
p'set(*ESC*){unicode "00A0"x}nullmap;';
p'if(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}position(keep=Variable(*ESC*){unicode "00A0"x}Num);';
p'if(*ESC*){unicode "00A0"x}_N_(*ESC*){unicode "00A0"x}=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}declare(*ESC*){unicode "00A0"x}hash(*ESC*){unicode "00A0"x}h1(dataset:"position");';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}h1.definekey("Variable");';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}h1.definedata("Num");';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}h1.definedone();';
p'end;';
p'Variable=varname;';
p'if(*ESC*){unicode "00A0"x}h1.find()(*ESC*){unicode "00A0"x}ne(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}missing(Num);';
p'if(*ESC*){unicode "00A0"x}^missing(Num);';
p'run;';
p'proc(*ESC*){unicode "00A0"x}sort(*ESC*){unicode "00A0"x}data=nullmap2;';
p'by(*ESC*){unicode "00A0"x}num(*ESC*){unicode "00A0"x}obs;';
p'run;';
p'';
p'data(*ESC*){unicode "00A0"x}mapping;';
p'length(*ESC*){unicode "00A0"x}ID(*ESC*){unicode "00A0"x}Show(*ESC*){unicode "00A0"x}FillColor(*ESC*){unicode "00A0"x}Value(*ESC*){unicode "00A0"x}$20.;';
p'ID="catn";';
p'Show="AttrMap";(*ESC*){unicode "00A0"x}';
p'do(*ESC*){unicode "00A0"x}Value(*ESC*){unicode "00A0"x}="Null","Numeric","Charcter";';
p'(*ESC*){unicode "00A0"x}select(Value);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}when("Null")(*ESC*){unicode "00A0"x}FillColor="gray";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}when("Numeric")(*ESC*){unicode "00A0"x}FillColor="bibg";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}when("Charcter")(*ESC*){unicode "00A0"x}FillColor="pink";';
p'(*ESC*){unicode "00A0"x}end;';
p'(*ESC*){unicode "00A0"x}output;';
p'end;';
p'run;';
p'';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=1100(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=700(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png;';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=nullmap2(*ESC*){unicode "00A0"x}dattrmap=mapping(*ESC*){unicode "00A0"x};(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}format(*ESC*){unicode "00A0"x}catn(*ESC*){unicode "00A0"x}catnf.;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}heatmapparm(*ESC*){unicode "00A0"x}x=varname(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}y=obs(*ESC*){unicode "00A0"x}colorgroup=catn(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrid=catn(*ESC*){unicode "00A0"x}x2axis;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}x2axis;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxis(*ESC*){unicode "00A0"x}reverse(*ESC*){unicode "00A0"x}label="Observation";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}keylegend(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}title="Type"(*ESC*){unicode "00A0"x}location=outside(*ESC*){unicode "00A0"x}position=right(*ESC*){unicode "00A0"x}across=1;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}';
p'run;';
run;
title;
%mend;
