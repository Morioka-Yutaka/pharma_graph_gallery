/*** HELP START ***//*

Macro: SG009
Purpose: Forest plot of point estimates and confidence intervals.

*//*** HELP END ***/

%macro SG009;
title "SG009:Forest Plot";
data forest_subgroup;
  length Subgroup $25 _N $8 _PER $8 _HZ $8 _HZCLM $20;
  label _N='n' _PER="　" _HZ="HR" _HZCLM='95%CL';
  Id=1; Subgroup="Age"; Count=.; Percent=.; Mean=.; Low=.; High=.; ObsId=1; indentWt=0; call missing(_N, _PER, _HZ, _HZCLM); output;
  Id=2; Subgroup="  <= 65 Yr"; Count=1534; Percent=71; Mean=1.5; Low=1.05; High=1.9; ObsId=2; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=2; Subgroup="  > 65 Yr"; Count=632; Percent=29; Mean=0.8; Low=0.6; High=1.25; ObsId=3; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=1; Subgroup="Sex"; Count=.; Percent=.; Mean=.; Low=.; High=.; ObsId=4; indentWt=0; call missing(_N, _PER, _HZ, _HZCLM); output;
  Id=2; Subgroup="  Male"; Count=1690; Percent=78; Mean=1.5; Low=1.2; High=1.8; ObsId=5; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=2; Subgroup="  Female"; Count=476; Percent=22; Mean=0.8; Low=0.6; High=1; ObsId=6; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=1; Subgroup="Race or ethnic group"; Count=.; Percent=.; Mean=.; Low=.; High=.; ObsId=7; indentWt=0; call missing(_N, _PER, _HZ, _HZCLM); output;
  Id=2; Subgroup="  Nonwhite"; Count=428; Percent=20; Mean=1.05; Low=0.6; High=1.2; ObsId=8; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=2; Subgroup="  White"; Count=1738; Percent=80; Mean=1.2; Low=0.85; High=1.6; ObsId=9; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=1; Subgroup="From XX to Randomization"; Count=.; Percent=.; Mean=.; Low=.; High=.; ObsId=10; indentWt=0; call missing(_N, _PER, _HZ, _HZCLM); output;
  Id=2; Subgroup="  <= 7 days"; Count=963; Percent=44; Mean=1.2; Low=0.8; High=1.5; ObsId=11; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=2; Subgroup="  > 7 days"; Count=1203; Percent=56; Mean=1.15; Low=0.75; High=1.5; ObsId=12; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=1; Subgroup="COMPLICATION"; Count=.; Percent=.; Mean=.; Low=.; High=.; ObsId=13; indentWt=0; call missing(_N, _PER, _HZ, _HZCLM); output;
  Id=2; Subgroup="  Yes"; Count=446; Percent=21; Mean=1.4; Low=0.9; High=2.0; ObsId=14; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
  Id=2; Subgroup="  No"; Count=720; Percent=79; Mean=1.1; Low=0.8; High=1.5; ObsId=15; indentWt=1; _N="99"; _PER="(99.9)"; _HZ="99.99"; _HZCLM="[99.99-99.99]"; output;
run;

data output;
set forest_subgroup;
gap="";
indentWt=10;
label gap="Subgroup";
run;

%SGANNO
data anno;
set output(keep=Subgroup ObsId);
%sgtext(label=Subgroup , y1space="DATAVALUE", x1space="GRAPHPERCENT",textcolor="black",width=1000,x1=0,y1=ObsId,justify="LEFT",textsize=8,ANCHOR="LEFT" ) ;
run;

ods graphics / 
               noborder
               noscale
               width=800 px
               height=600 px
               attrpriority=none
               imagefmt=png
;
ods proclabel='SG009:Forest Plot';
proc sgplot data=output nowall noborder nocycleattrs noautolegend sganno = anno;
  styleattrs axisextent=data ;
  highlow y=obsid low=low high=high /highcap=serif lowcap=serif ;
  scatter y=obsid x=mean / markerattrs=(symbol=squarefilled);
  refline 1 / axis=x;
 
  yaxistable gap  /  labeljustify=left location=inside position=left labelattrs=(size=9) indentweight=indentWt ;
  yaxistable _N / location=inside position=left labelattrs=(size=9) valueattrs=(size=8);
  yaxistable _PER / location=inside position=left labelattrs=(size=9) valueattrs=(size=8);
  yaxistable _HZ / location=inside position=left labelattrs=(size=9) valueattrs=(size=8);
  yaxistable _HZCLM / location=inside position=left labelattrs=(size=9) valueattrs=(size=8);
 
  yaxis reverse display=none  offsetmin=0.05 offsetmax=0.05;
  xaxis display=(nolabel) values=(0.0 0.5 1.0 1.5 2.0 2.5) valueattrs=(size=7);
run;

ods proclabel='SG009:Forest Plot';
proc odstext;
p'data(*ESC*){unicode "00A0"x}forest_subgroup;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}length(*ESC*){unicode "00A0"x}Subgroup(*ESC*){unicode "00A0"x}$25(*ESC*){unicode "00A0"x}_N(*ESC*){unicode "00A0"x}$8(*ESC*){unicode "00A0"x}_PER(*ESC*){unicode "00A0"x}$8(*ESC*){unicode "00A0"x}_HZ(*ESC*){unicode "00A0"x}$8(*ESC*){unicode "00A0"x}_HZCLM(*ESC*){unicode "00A0"x}$20;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}label(*ESC*){unicode "00A0"x}_N="n"(*ESC*){unicode "00A0"x}_PER="　"(*ESC*){unicode "00A0"x}_HZ="HR"(*ESC*){unicode "00A0"x}_HZCLM="95%CL";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Id=1;(*ESC*){unicode "00A0"x}Subgroup="Age";(*ESC*){unicode "00A0"x}Count=.;(*ESC*){unicode "00A0"x}Percent=.;(*ESC*){unicode "00A0"x}Mean=.;(*ESC*){unicode "00A0"x}Low=.;(*ESC*){unicode "00A0"x}High=.;(*ESC*){unicode "00A0"x}ObsId=1;(*ESC*){unicode "00A0"x}indentWt=0;(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}missing(_N,(*ESC*){unicode "00A0"x}_PER,(*ESC*){unicode "00A0"x}_HZ,(*ESC*){unicode "00A0"x}_HZCLM);(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Id=2;(*ESC*){unicode "00A0"x}Subgroup="(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}<=(*ESC*){unicode "00A0"x}65(*ESC*){unicode "00A0"x}Yr";(*ESC*){unicode "00A0"x}Count=1534;(*ESC*){unicode "00A0"x}Percent=71;(*ESC*){unicode "00A0"x}Mean=1.5;(*ESC*){unicode "00A0"x}Low=1.05;(*ESC*){unicode "00A0"x}High=1.9;(*ESC*){unicode "00A0"x}ObsId=2;(*ESC*){unicode "00A0"x}indentWt=1;(*ESC*){unicode "00A0"x}_N="99";(*ESC*){unicode "00A0"x}_PER="(99.9)";(*ESC*){unicode "00A0"x}_HZ="99.99";(*ESC*){unicode "00A0"x}_HZCLM="[99.99-99.99]";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Id=2;(*ESC*){unicode "00A0"x}Subgroup="(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}>(*ESC*){unicode "00A0"x}65(*ESC*){unicode "00A0"x}Yr";(*ESC*){unicode "00A0"x}Count=632;(*ESC*){unicode "00A0"x}Percent=29;(*ESC*){unicode "00A0"x}Mean=0.8;(*ESC*){unicode "00A0"x}Low=0.6;(*ESC*){unicode "00A0"x}High=1.25;(*ESC*){unicode "00A0"x}ObsId=3;(*ESC*){unicode "00A0"x}indentWt=1;(*ESC*){unicode "00A0"x}_N="99";(*ESC*){unicode "00A0"x}_PER="(99.9)";(*ESC*){unicode "00A0"x}_HZ="99.99";(*ESC*){unicode "00A0"x}_HZCLM="[99.99-99.99]";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Id=1;(*ESC*){unicode "00A0"x}Subgroup="Sex";(*ESC*){unicode "00A0"x}Count=.;(*ESC*){unicode "00A0"x}Percent=.;(*ESC*){unicode "00A0"x}Mean=.;(*ESC*){unicode "00A0"x}Low=.;(*ESC*){unicode "00A0"x}High=.;(*ESC*){unicode "00A0"x}ObsId=4;(*ESC*){unicode "00A0"x}indentWt=0;(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}missing(_N,(*ESC*){unicode "00A0"x}_PER,(*ESC*){unicode "00A0"x}_HZ,(*ESC*){unicode "00A0"x}_HZCLM);(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Id=2;(*ESC*){unicode "00A0"x}Subgroup="(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Male";(*ESC*){unicode "00A0"x}Count=1690;(*ESC*){unicode "00A0"x}Percent=78;(*ESC*){unicode "00A0"x}Mean=1.5;(*ESC*){unicode "00A0"x}Low=1.2;(*ESC*){unicode "00A0"x}High=1.8;(*ESC*){unicode "00A0"x}ObsId=5;(*ESC*){unicode "00A0"x}indentWt=1;(*ESC*){unicode "00A0"x}_N="99";(*ESC*){unicode "00A0"x}_PER="(99.9)";(*ESC*){unicode "00A0"x}_HZ="99.99";(*ESC*){unicode "00A0"x}_HZCLM="[99.99-99.99]";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Id=2;(*ESC*){unicode "00A0"x}Subgroup="(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Female";(*ESC*){unicode "00A0"x}Count=476;(*ESC*){unicode "00A0"x}Percent=22;(*ESC*){unicode "00A0"x}Mean=0.8;(*ESC*){unicode "00A0"x}Low=0.6;(*ESC*){unicode "00A0"x}High=1;(*ESC*){unicode "00A0"x}ObsId=6;(*ESC*){unicode "00A0"x}indentWt=1;(*ESC*){unicode "00A0"x}_N="99";(*ESC*){unicode "00A0"x}_PER="(99.9)";(*ESC*){unicode "00A0"x}_HZ="99.99";(*ESC*){unicode "00A0"x}_HZCLM="[99.99-99.99]";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Id=1;(*ESC*){unicode "00A0"x}Subgroup="Race(*ESC*){unicode "00A0"x}or(*ESC*){unicode "00A0"x}ethnic(*ESC*){unicode "00A0"x}group";(*ESC*){unicode "00A0"x}Count=.;(*ESC*){unicode "00A0"x}Percent=.;(*ESC*){unicode "00A0"x}Mean=.;(*ESC*){unicode "00A0"x}Low=.;(*ESC*){unicode "00A0"x}High=.;(*ESC*){unicode "00A0"x}ObsId=7;(*ESC*){unicode "00A0"x}indentWt=0;(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}missing(_N,(*ESC*){unicode "00A0"x}_PER,(*ESC*){unicode "00A0"x}_HZ,(*ESC*){unicode "00A0"x}_HZCLM);(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Id=2;(*ESC*){unicode "00A0"x}Subgroup="(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Nonwhite";(*ESC*){unicode "00A0"x}Count=428;(*ESC*){unicode "00A0"x}Percent=20;(*ESC*){unicode "00A0"x}Mean=1.05;(*ESC*){unicode "00A0"x}Low=0.6;(*ESC*){unicode "00A0"x}High=1.2;(*ESC*){unicode "00A0"x}ObsId=8;(*ESC*){unicode "00A0"x}indentWt=1;(*ESC*){unicode "00A0"x}_N="99";(*ESC*){unicode "00A0"x}_PER="(99.9)";(*ESC*){unicode "00A0"x}_HZ="99.99";(*ESC*){unicode "00A0"x}_HZCLM="[99.99-99.99]";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Id=2;(*ESC*){unicode "00A0"x}Subgroup="(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}White";(*ESC*){unicode "00A0"x}Count=1738;(*ESC*){unicode "00A0"x}Percent=80;(*ESC*){unicode "00A0"x}Mean=1.2;(*ESC*){unicode "00A0"x}Low=0.85;(*ESC*){unicode "00A0"x}High=1.6;(*ESC*){unicode "00A0"x}ObsId=9;(*ESC*){unicode "00A0"x}indentWt=1;(*ESC*){unicode "00A0"x}_N="99";(*ESC*){unicode "00A0"x}_PER="(99.9)";(*ESC*){unicode "00A0"x}_HZ="99.99";(*ESC*){unicode "00A0"x}_HZCLM="[99.99-99.99]";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Id=1;(*ESC*){unicode "00A0"x}Subgroup="From(*ESC*){unicode "00A0"x}XX(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}Randomization";(*ESC*){unicode "00A0"x}Count=.;(*ESC*){unicode "00A0"x}Percent=.;(*ESC*){unicode "00A0"x}Mean=.;(*ESC*){unicode "00A0"x}Low=.;(*ESC*){unicode "00A0"x}High=.;(*ESC*){unicode "00A0"x}ObsId=10;(*ESC*){unicode "00A0"x}indentWt=0;(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}missing(_N,(*ESC*){unicode "00A0"x}_PER,(*ESC*){unicode "00A0"x}_HZ,(*ESC*){unicode "00A0"x}_HZCLM);(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Id=2;(*ESC*){unicode "00A0"x}Subgroup="(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}<=(*ESC*){unicode "00A0"x}7(*ESC*){unicode "00A0"x}days";(*ESC*){unicode "00A0"x}Count=963;(*ESC*){unicode "00A0"x}Percent=44;(*ESC*){unicode "00A0"x}Mean=1.2;(*ESC*){unicode "00A0"x}Low=0.8;(*ESC*){unicode "00A0"x}High=1.5;(*ESC*){unicode "00A0"x}ObsId=11;(*ESC*){unicode "00A0"x}indentWt=1;(*ESC*){unicode "00A0"x}_N="99";(*ESC*){unicode "00A0"x}_PER="(99.9)";(*ESC*){unicode "00A0"x}_HZ="99.99";(*ESC*){unicode "00A0"x}_HZCLM="[99.99-99.99]";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Id=2;(*ESC*){unicode "00A0"x}Subgroup="(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}>(*ESC*){unicode "00A0"x}7(*ESC*){unicode "00A0"x}days";(*ESC*){unicode "00A0"x}Count=1203;(*ESC*){unicode "00A0"x}Percent=56;(*ESC*){unicode "00A0"x}Mean=1.15;(*ESC*){unicode "00A0"x}Low=0.75;(*ESC*){unicode "00A0"x}High=1.5;(*ESC*){unicode "00A0"x}ObsId=12;(*ESC*){unicode "00A0"x}indentWt=1;(*ESC*){unicode "00A0"x}_N="99";(*ESC*){unicode "00A0"x}_PER="(99.9)";(*ESC*){unicode "00A0"x}_HZ="99.99";(*ESC*){unicode "00A0"x}_HZCLM="[99.99-99.99]";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Id=1;(*ESC*){unicode "00A0"x}Subgroup="COMPLICATION";(*ESC*){unicode "00A0"x}Count=.;(*ESC*){unicode "00A0"x}Percent=.;(*ESC*){unicode "00A0"x}Mean=.;(*ESC*){unicode "00A0"x}Low=.;(*ESC*){unicode "00A0"x}High=.;(*ESC*){unicode "00A0"x}ObsId=13;(*ESC*){unicode "00A0"x}indentWt=0;(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}missing(_N,(*ESC*){unicode "00A0"x}_PER,(*ESC*){unicode "00A0"x}_HZ,(*ESC*){unicode "00A0"x}_HZCLM);(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Id=2;(*ESC*){unicode "00A0"x}Subgroup="(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Yes";(*ESC*){unicode "00A0"x}Count=446;(*ESC*){unicode "00A0"x}Percent=21;(*ESC*){unicode "00A0"x}Mean=1.4;(*ESC*){unicode "00A0"x}Low=0.9;(*ESC*){unicode "00A0"x}High=2.0;(*ESC*){unicode "00A0"x}ObsId=14;(*ESC*){unicode "00A0"x}indentWt=1;(*ESC*){unicode "00A0"x}_N="99";(*ESC*){unicode "00A0"x}_PER="(99.9)";(*ESC*){unicode "00A0"x}_HZ="99.99";(*ESC*){unicode "00A0"x}_HZCLM="[99.99-99.99]";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}Id=2;(*ESC*){unicode "00A0"x}Subgroup="(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}No";(*ESC*){unicode "00A0"x}Count=720;(*ESC*){unicode "00A0"x}Percent=79;(*ESC*){unicode "00A0"x}Mean=1.1;(*ESC*){unicode "00A0"x}Low=0.8;(*ESC*){unicode "00A0"x}High=1.5;(*ESC*){unicode "00A0"x}ObsId=15;(*ESC*){unicode "00A0"x}indentWt=1;(*ESC*){unicode "00A0"x}_N="99";(*ESC*){unicode "00A0"x}_PER="(99.9)";(*ESC*){unicode "00A0"x}_HZ="99.99";(*ESC*){unicode "00A0"x}_HZCLM="[99.99-99.99]";(*ESC*){unicode "00A0"x}output;';
p'run;';
p'';
p'data(*ESC*){unicode "00A0"x}output;';
p'set(*ESC*){unicode "00A0"x}forest_subgroup;';
p'gap="";';
p'indentWt=10;';
p'label(*ESC*){unicode "00A0"x}gap="Subgroup";';
p'run;';
p'';
p'%SGANNO';
p'data(*ESC*){unicode "00A0"x}anno;';
p'set(*ESC*){unicode "00A0"x}output(keep=Subgroup(*ESC*){unicode "00A0"x}ObsId);';
p'%sgtext(label=Subgroup(*ESC*){unicode "00A0"x},(*ESC*){unicode "00A0"x}y1space="DATAVALUE",(*ESC*){unicode "00A0"x}x1space="GRAPHPERCENT",textcolor="black",width=1000,x1=0,y1=ObsId,justify="LEFT",textsize=8,ANCHOR="LEFT"(*ESC*){unicode "00A0"x})(*ESC*){unicode "00A0"x};';
p'run;';
p'';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=800(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=600(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=output(*ESC*){unicode "00A0"x}nowall(*ESC*){unicode "00A0"x}noborder(*ESC*){unicode "00A0"x}nocycleattrs(*ESC*){unicode "00A0"x}noautolegend(*ESC*){unicode "00A0"x}sganno(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}anno;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}styleattrs(*ESC*){unicode "00A0"x}axisextent=data(*ESC*){unicode "00A0"x};';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}highlow(*ESC*){unicode "00A0"x}y=obsid(*ESC*){unicode "00A0"x}low=low(*ESC*){unicode "00A0"x}high=high(*ESC*){unicode "00A0"x}/highcap=serif(*ESC*){unicode "00A0"x}lowcap=serif(*ESC*){unicode "00A0"x};';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}scatter(*ESC*){unicode "00A0"x}y=obsid(*ESC*){unicode "00A0"x}x=mean(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}markerattrs=(symbol=squarefilled);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}refline(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}axis=x;';
p'(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxistable(*ESC*){unicode "00A0"x}gap(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}labeljustify=left(*ESC*){unicode "00A0"x}location=inside(*ESC*){unicode "00A0"x}position=left(*ESC*){unicode "00A0"x}labelattrs=(size=9)(*ESC*){unicode "00A0"x}indentweight=indentWt(*ESC*){unicode "00A0"x};';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxistable(*ESC*){unicode "00A0"x}_N(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}location=inside(*ESC*){unicode "00A0"x}position=left(*ESC*){unicode "00A0"x}labelattrs=(size=9)(*ESC*){unicode "00A0"x}valueattrs=(size=8);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxistable(*ESC*){unicode "00A0"x}_PER(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}location=inside(*ESC*){unicode "00A0"x}position=left(*ESC*){unicode "00A0"x}labelattrs=(size=9)(*ESC*){unicode "00A0"x}valueattrs=(size=8);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxistable(*ESC*){unicode "00A0"x}_HZ(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}location=inside(*ESC*){unicode "00A0"x}position=left(*ESC*){unicode "00A0"x}labelattrs=(size=9)(*ESC*){unicode "00A0"x}valueattrs=(size=8);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxistable(*ESC*){unicode "00A0"x}_HZCLM(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}location=inside(*ESC*){unicode "00A0"x}position=left(*ESC*){unicode "00A0"x}labelattrs=(size=9)(*ESC*){unicode "00A0"x}valueattrs=(size=8);';
p'(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxis(*ESC*){unicode "00A0"x}reverse(*ESC*){unicode "00A0"x}display=none(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}offsetmin=0.05(*ESC*){unicode "00A0"x}offsetmax=0.05;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxis(*ESC*){unicode "00A0"x}display=(nolabel)(*ESC*){unicode "00A0"x}values=(0.0(*ESC*){unicode "00A0"x}0.5(*ESC*){unicode "00A0"x}1.0(*ESC*){unicode "00A0"x}1.5(*ESC*){unicode "00A0"x}2.0(*ESC*){unicode "00A0"x}2.5)(*ESC*){unicode "00A0"x}valueattrs=(size=7);';
p'run;';
run;
title;
%mend;
