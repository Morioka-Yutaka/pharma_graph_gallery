/*** HELP START ***//*

Macro: SG023
Purpose: eDISH scatter plot of liver enzyme and bilirubin abnormalities.

*//*** HELP END ***/

%macro SG023;
title "SG023:eDISH Plot";
data ADLB;
  LENGTH USUBJID $12 PARAMCD $6 TRTA $12 ABLFL $1 TRTEMFL $1;
  FORMAT ADT YYMMDD10.;

  USUBJID="SUBJ001"; PARAMCD="ALT";   AVAL=45;  ANRHI=40;  TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ001"; PARAMCD="ALT";   AVAL=120; ANRHI=40;  TRTA="Active"; ADT=input("2023-01-15", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
  USUBJID="SUBJ001"; PARAMCD="TBILI"; AVAL=1.0; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ001"; PARAMCD="TBILI"; AVAL=2.8; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-15", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;

  USUBJID="SUBJ003"; PARAMCD="ALT";   AVAL=30;  ANRHI=40;  TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ003"; PARAMCD="ALT";   AVAL=85;  ANRHI=40;  TRTA="Active"; ADT=input("2023-01-20", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
  USUBJID="SUBJ003"; PARAMCD="TBILI"; AVAL=0.7; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ003"; PARAMCD="TBILI"; AVAL=1.5; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-20", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;

  USUBJID="SUBJ002"; PARAMCD="ALT";   AVAL=35;  ANRHI=40;  TRTA="Placebo"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ002"; PARAMCD="ALT";   AVAL=55;  ANRHI=40;  TRTA="Placebo"; ADT=input("2023-01-10", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
  USUBJID="SUBJ002"; PARAMCD="TBILI"; AVAL=0.8; ANRHI=1.2; TRTA="Placebo"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ002"; PARAMCD="TBILI"; AVAL=1.0; ANRHI=1.2; TRTA="Placebo"; ADT=input("2023-01-10", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;

  USUBJID="SUBJ004"; PARAMCD="ALT";   AVAL=25;  ANRHI=40;  TRTA="Placebo"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ004"; PARAMCD="ALT";   AVAL=150; ANRHI=40;  TRTA="Placebo"; ADT=input("2023-01-18", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
  USUBJID="SUBJ004"; PARAMCD="TBILI"; AVAL=0.9; ANRHI=1.2; TRTA="Placebo"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ004"; PARAMCD="TBILI"; AVAL=3.5; ANRHI=1.2; TRTA="Placebo"; ADT=input("2023-01-18", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;

  USUBJID="SUBJ005"; PARAMCD="ALT";   AVAL=20;  ANRHI=40;  TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ005"; PARAMCD="ALT";   AVAL=60;  ANRHI=40;  TRTA="Active"; ADT=input("2023-01-12", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
  USUBJID="SUBJ005"; PARAMCD="TBILI"; AVAL=0.6; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ005"; PARAMCD="TBILI"; AVAL=0.9; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-12", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;

  USUBJID="SUBJ006"; PARAMCD="ALT";   AVAL=5;   ANRHI=40;  TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ006"; PARAMCD="ALT";   AVAL=10;  ANRHI=40;  TRTA="Active"; ADT=input("2023-01-12", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
  USUBJID="SUBJ006"; PARAMCD="TBILI"; AVAL=0.2; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ006"; PARAMCD="TBILI"; AVAL=0.1; ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-12", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;

  USUBJID="SUBJ006"; PARAMCD="ALT";   AVAL=1;   ANRHI=40;  TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ006"; PARAMCD="ALT";   AVAL=0.1; ANRHI=40;  TRTA="Active"; ADT=input("2023-01-12", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
  USUBJID="SUBJ006"; PARAMCD="TBILI"; AVAL=6;   ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-01", yymmdd10.); ABLFL="Y"; TRTEMFL="N"; output;
  USUBJID="SUBJ006"; PARAMCD="TBILI"; AVAL=8;   ANRHI=1.2; TRTA="Active"; ADT=input("2023-01-12", yymmdd10.); ABLFL="N"; TRTEMFL="Y"; output;
run;
data adlb_xuln;
  set adlb;
  if not missing(aval) and not missing(anrhi) and anrhi > 0;
  xuln = aval / anrhi;
  if paramcd in ("ALT", "TBILI");
run;
proc sql;
  create table edish_base as
  select
      usubjid,
      max(case when paramcd = "ALT"   then xuln else . end) as altxuln,
      max(case when paramcd = "TBILI" then xuln else . end) as bilixuln,
      max(trta) as trta length=12
  from adlb_xuln
  group by usubjid;
quit;

options orientation=landscape;
ods graphics / 
               noborder
               noscale
               width=680 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
ods proclabel="SG023:eDISH Plot";
proc sgplot data=edish_base noborder;
    styleattrs datacontrastcolors=(blue red)
                  datacolors=(blue red)
                  datasymbols=(circlefilled trianglefilled);   

  scatter x=altxuln y=bilixuln /
          group=trta
          markerattrs=( size=10) name="scatter";

  refline 1 / axis=x label="1 x ULN" labelattrs=(size=8) lineattrs=(pattern=shortdash color=black thickness=1);
  refline 3 / axis=x label="3 x ULN" labelattrs=(size=8) lineattrs=(pattern=solid color=black thickness=1);
  refline 1 / axis=y label="1 x ULN" labelattrs=(size=8) lineattrs=(pattern=shortdash color=black thickness=1);
  refline 2 / axis=y label="2 x ULN" labelattrs=(size=8) lineattrs=(pattern=solid color=black thickness=1);

  xaxis type=log logbase=10
        min=0.1 max=30
        label="Peak ALT (x ULN)"
        values=(0.01 0.1 0.3 1 3 10 100)
        grid;

  yaxis type=log logbase=10
        min=0.1 max=10
        label="Peak Total Bilirubin (x ULN)"
        values=(0.0625 0.125 0.25 0.5 1 2 4 8 16 32)
        grid;

  keylegend 'scatter' / title='' noborder valueattrs=(size=10) 
         location=inside position=topleft across=1 opaque;
run;

ods proclabel="SG023:eDISH Plot";
proc odstext;
p'data(*ESC*){unicode "00A0"x}ADLB;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}LENGTH(*ESC*){unicode "00A0"x}USUBJID(*ESC*){unicode "00A0"x}$12(*ESC*){unicode "00A0"x}PARAMCD(*ESC*){unicode "00A0"x}$6(*ESC*){unicode "00A0"x}TRTA(*ESC*){unicode "00A0"x}$12(*ESC*){unicode "00A0"x}ABLFL(*ESC*){unicode "00A0"x}$1(*ESC*){unicode "00A0"x}TRTEMFL(*ESC*){unicode "00A0"x}$1;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}FORMAT(*ESC*){unicode "00A0"x}ADT(*ESC*){unicode "00A0"x}YYMMDD10.;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ001";(*ESC*){unicode "00A0"x}PARAMCD="ALT";(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=45;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}ANRHI=40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-01",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="Y";(*ESC*){unicode "00A0"x}TRTEMFL="N";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ001";(*ESC*){unicode "00A0"x}PARAMCD="ALT";(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=120;(*ESC*){unicode "00A0"x}ANRHI=40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-15",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="N";(*ESC*){unicode "00A0"x}TRTEMFL="Y";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ001";(*ESC*){unicode "00A0"x}PARAMCD="TBILI";(*ESC*){unicode "00A0"x}AVAL=1.0;(*ESC*){unicode "00A0"x}ANRHI=1.2;(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-01",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="Y";(*ESC*){unicode "00A0"x}TRTEMFL="N";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ001";(*ESC*){unicode "00A0"x}PARAMCD="TBILI";(*ESC*){unicode "00A0"x}AVAL=2.8;(*ESC*){unicode "00A0"x}ANRHI=1.2;(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-15",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="N";(*ESC*){unicode "00A0"x}TRTEMFL="Y";(*ESC*){unicode "00A0"x}output;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ003";(*ESC*){unicode "00A0"x}PARAMCD="ALT";(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=30;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}ANRHI=40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-01",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="Y";(*ESC*){unicode "00A0"x}TRTEMFL="N";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ003";(*ESC*){unicode "00A0"x}PARAMCD="ALT";(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=85;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}ANRHI=40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-20",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="N";(*ESC*){unicode "00A0"x}TRTEMFL="Y";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ003";(*ESC*){unicode "00A0"x}PARAMCD="TBILI";(*ESC*){unicode "00A0"x}AVAL=0.7;(*ESC*){unicode "00A0"x}ANRHI=1.2;(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-01",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="Y";(*ESC*){unicode "00A0"x}TRTEMFL="N";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ003";(*ESC*){unicode "00A0"x}PARAMCD="TBILI";(*ESC*){unicode "00A0"x}AVAL=1.5;(*ESC*){unicode "00A0"x}ANRHI=1.2;(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-20",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="N";(*ESC*){unicode "00A0"x}TRTEMFL="Y";(*ESC*){unicode "00A0"x}output;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ002";(*ESC*){unicode "00A0"x}PARAMCD="ALT";(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=35;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}ANRHI=40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRTA="Placebo";(*ESC*){unicode "00A0"x}ADT=input("2023-01-01",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="Y";(*ESC*){unicode "00A0"x}TRTEMFL="N";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ002";(*ESC*){unicode "00A0"x}PARAMCD="ALT";(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=55;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}ANRHI=40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRTA="Placebo";(*ESC*){unicode "00A0"x}ADT=input("2023-01-10",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="N";(*ESC*){unicode "00A0"x}TRTEMFL="Y";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ002";(*ESC*){unicode "00A0"x}PARAMCD="TBILI";(*ESC*){unicode "00A0"x}AVAL=0.8;(*ESC*){unicode "00A0"x}ANRHI=1.2;(*ESC*){unicode "00A0"x}TRTA="Placebo";(*ESC*){unicode "00A0"x}ADT=input("2023-01-01",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="Y";(*ESC*){unicode "00A0"x}TRTEMFL="N";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ002";(*ESC*){unicode "00A0"x}PARAMCD="TBILI";(*ESC*){unicode "00A0"x}AVAL=1.0;(*ESC*){unicode "00A0"x}ANRHI=1.2;(*ESC*){unicode "00A0"x}TRTA="Placebo";(*ESC*){unicode "00A0"x}ADT=input("2023-01-10",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="N";(*ESC*){unicode "00A0"x}TRTEMFL="Y";(*ESC*){unicode "00A0"x}output;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ004";(*ESC*){unicode "00A0"x}PARAMCD="ALT";(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=25;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}ANRHI=40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRTA="Placebo";(*ESC*){unicode "00A0"x}ADT=input("2023-01-01",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="Y";(*ESC*){unicode "00A0"x}TRTEMFL="N";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ004";(*ESC*){unicode "00A0"x}PARAMCD="ALT";(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=150;(*ESC*){unicode "00A0"x}ANRHI=40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRTA="Placebo";(*ESC*){unicode "00A0"x}ADT=input("2023-01-18",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="N";(*ESC*){unicode "00A0"x}TRTEMFL="Y";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ004";(*ESC*){unicode "00A0"x}PARAMCD="TBILI";(*ESC*){unicode "00A0"x}AVAL=0.9;(*ESC*){unicode "00A0"x}ANRHI=1.2;(*ESC*){unicode "00A0"x}TRTA="Placebo";(*ESC*){unicode "00A0"x}ADT=input("2023-01-01",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="Y";(*ESC*){unicode "00A0"x}TRTEMFL="N";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ004";(*ESC*){unicode "00A0"x}PARAMCD="TBILI";(*ESC*){unicode "00A0"x}AVAL=3.5;(*ESC*){unicode "00A0"x}ANRHI=1.2;(*ESC*){unicode "00A0"x}TRTA="Placebo";(*ESC*){unicode "00A0"x}ADT=input("2023-01-18",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="N";(*ESC*){unicode "00A0"x}TRTEMFL="Y";(*ESC*){unicode "00A0"x}output;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ005";(*ESC*){unicode "00A0"x}PARAMCD="ALT";(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=20;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}ANRHI=40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-01",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="Y";(*ESC*){unicode "00A0"x}TRTEMFL="N";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ005";(*ESC*){unicode "00A0"x}PARAMCD="ALT";(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=60;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}ANRHI=40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-12",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="N";(*ESC*){unicode "00A0"x}TRTEMFL="Y";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ005";(*ESC*){unicode "00A0"x}PARAMCD="TBILI";(*ESC*){unicode "00A0"x}AVAL=0.6;(*ESC*){unicode "00A0"x}ANRHI=1.2;(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-01",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="Y";(*ESC*){unicode "00A0"x}TRTEMFL="N";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ005";(*ESC*){unicode "00A0"x}PARAMCD="TBILI";(*ESC*){unicode "00A0"x}AVAL=0.9;(*ESC*){unicode "00A0"x}ANRHI=1.2;(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-12",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="N";(*ESC*){unicode "00A0"x}TRTEMFL="Y";(*ESC*){unicode "00A0"x}output;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ006";(*ESC*){unicode "00A0"x}PARAMCD="ALT";(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=5;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}ANRHI=40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-01",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="Y";(*ESC*){unicode "00A0"x}TRTEMFL="N";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ006";(*ESC*){unicode "00A0"x}PARAMCD="ALT";(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=10;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}ANRHI=40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-12",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="N";(*ESC*){unicode "00A0"x}TRTEMFL="Y";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ006";(*ESC*){unicode "00A0"x}PARAMCD="TBILI";(*ESC*){unicode "00A0"x}AVAL=0.2;(*ESC*){unicode "00A0"x}ANRHI=1.2;(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-01",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="Y";(*ESC*){unicode "00A0"x}TRTEMFL="N";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ006";(*ESC*){unicode "00A0"x}PARAMCD="TBILI";(*ESC*){unicode "00A0"x}AVAL=0.1;(*ESC*){unicode "00A0"x}ANRHI=1.2;(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-12",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="N";(*ESC*){unicode "00A0"x}TRTEMFL="Y";(*ESC*){unicode "00A0"x}output;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ006";(*ESC*){unicode "00A0"x}PARAMCD="ALT";(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=1;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}ANRHI=40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-01",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="Y";(*ESC*){unicode "00A0"x}TRTEMFL="N";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ006";(*ESC*){unicode "00A0"x}PARAMCD="ALT";(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL=0.1;(*ESC*){unicode "00A0"x}ANRHI=40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-12",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="N";(*ESC*){unicode "00A0"x}TRTEMFL="Y";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ006";(*ESC*){unicode "00A0"x}PARAMCD="TBILI";(*ESC*){unicode "00A0"x}AVAL=6;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}ANRHI=1.2;(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-01",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="Y";(*ESC*){unicode "00A0"x}TRTEMFL="N";(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}USUBJID="SUBJ006";(*ESC*){unicode "00A0"x}PARAMCD="TBILI";(*ESC*){unicode "00A0"x}AVAL=8;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}ANRHI=1.2;(*ESC*){unicode "00A0"x}TRTA="Active";(*ESC*){unicode "00A0"x}ADT=input("2023-01-12",(*ESC*){unicode "00A0"x}yymmdd10.);(*ESC*){unicode "00A0"x}ABLFL="N";(*ESC*){unicode "00A0"x}TRTEMFL="Y";(*ESC*){unicode "00A0"x}output;';
p'run;';
p'data(*ESC*){unicode "00A0"x}adlb_xuln;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}adlb;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}not(*ESC*){unicode "00A0"x}missing(aval)(*ESC*){unicode "00A0"x}and(*ESC*){unicode "00A0"x}not(*ESC*){unicode "00A0"x}missing(anrhi)(*ESC*){unicode "00A0"x}and(*ESC*){unicode "00A0"x}anrhi(*ESC*){unicode "00A0"x}>(*ESC*){unicode "00A0"x}0;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xuln(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}aval(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}anrhi;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}paramcd(*ESC*){unicode "00A0"x}in(*ESC*){unicode "00A0"x}("ALT",(*ESC*){unicode "00A0"x}"TBILI");';
p'run;';
p'proc(*ESC*){unicode "00A0"x}sql;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}create(*ESC*){unicode "00A0"x}table(*ESC*){unicode "00A0"x}edish_base(*ESC*){unicode "00A0"x}as';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}select';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}usubjid,';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}max(case(*ESC*){unicode "00A0"x}when(*ESC*){unicode "00A0"x}paramcd(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"ALT"(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}xuln(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}.(*ESC*){unicode "00A0"x}end)(*ESC*){unicode "00A0"x}as(*ESC*){unicode "00A0"x}altxuln,';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}max(case(*ESC*){unicode "00A0"x}when(*ESC*){unicode "00A0"x}paramcd(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"TBILI"(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}xuln(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}.(*ESC*){unicode "00A0"x}end)(*ESC*){unicode "00A0"x}as(*ESC*){unicode "00A0"x}bilixuln,';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}max(trta)(*ESC*){unicode "00A0"x}as(*ESC*){unicode "00A0"x}trta(*ESC*){unicode "00A0"x}length=12';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}from(*ESC*){unicode "00A0"x}adlb_xuln';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}group(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}usubjid;';
p'quit;';
p'';
p'options(*ESC*){unicode "00A0"x}orientation=landscape;';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=680(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=510(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=edish_base(*ESC*){unicode "00A0"x}noborder;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}styleattrs(*ESC*){unicode "00A0"x}datacontrastcolors=(blue(*ESC*){unicode "00A0"x}red)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}datacolors=(blue(*ESC*){unicode "00A0"x}red)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}datasymbols=(circlefilled(*ESC*){unicode "00A0"x}trianglefilled);(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}scatter(*ESC*){unicode "00A0"x}x=altxuln(*ESC*){unicode "00A0"x}y=bilixuln(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}group=trta';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}markerattrs=((*ESC*){unicode "00A0"x}size=10)(*ESC*){unicode "00A0"x}name="scatter";';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}refline(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}axis=x(*ESC*){unicode "00A0"x}label="1(*ESC*){unicode "00A0"x}x(*ESC*){unicode "00A0"x}ULN"(*ESC*){unicode "00A0"x}labelattrs=(size=8)(*ESC*){unicode "00A0"x}lineattrs=(pattern=shortdash(*ESC*){unicode "00A0"x}color=black(*ESC*){unicode "00A0"x}thickness=1);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}refline(*ESC*){unicode "00A0"x}3(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}axis=x(*ESC*){unicode "00A0"x}label="3(*ESC*){unicode "00A0"x}x(*ESC*){unicode "00A0"x}ULN"(*ESC*){unicode "00A0"x}labelattrs=(size=8)(*ESC*){unicode "00A0"x}lineattrs=(pattern=solid(*ESC*){unicode "00A0"x}color=black(*ESC*){unicode "00A0"x}thickness=1);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}refline(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}axis=y(*ESC*){unicode "00A0"x}label="1(*ESC*){unicode "00A0"x}x(*ESC*){unicode "00A0"x}ULN"(*ESC*){unicode "00A0"x}labelattrs=(size=8)(*ESC*){unicode "00A0"x}lineattrs=(pattern=shortdash(*ESC*){unicode "00A0"x}color=black(*ESC*){unicode "00A0"x}thickness=1);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}refline(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}axis=y(*ESC*){unicode "00A0"x}label="2(*ESC*){unicode "00A0"x}x(*ESC*){unicode "00A0"x}ULN"(*ESC*){unicode "00A0"x}labelattrs=(size=8)(*ESC*){unicode "00A0"x}lineattrs=(pattern=solid(*ESC*){unicode "00A0"x}color=black(*ESC*){unicode "00A0"x}thickness=1);';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxis(*ESC*){unicode "00A0"x}type=log(*ESC*){unicode "00A0"x}logbase=10';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}min=0.1(*ESC*){unicode "00A0"x}max=30';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}label="Peak(*ESC*){unicode "00A0"x}ALT(*ESC*){unicode "00A0"x}(x(*ESC*){unicode "00A0"x}ULN)"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}values=(0.01(*ESC*){unicode "00A0"x}0.1(*ESC*){unicode "00A0"x}0.3(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}3(*ESC*){unicode "00A0"x}10(*ESC*){unicode "00A0"x}100)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}grid;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxis(*ESC*){unicode "00A0"x}type=log(*ESC*){unicode "00A0"x}logbase=10';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}min=0.1(*ESC*){unicode "00A0"x}max=10';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}label="Peak(*ESC*){unicode "00A0"x}Total(*ESC*){unicode "00A0"x}Bilirubin(*ESC*){unicode "00A0"x}(x(*ESC*){unicode "00A0"x}ULN)"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}values=(0.0625(*ESC*){unicode "00A0"x}0.125(*ESC*){unicode "00A0"x}0.25(*ESC*){unicode "00A0"x}0.5(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}4(*ESC*){unicode "00A0"x}8(*ESC*){unicode "00A0"x}16(*ESC*){unicode "00A0"x}32)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}grid;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}keylegend(*ESC*){unicode "00A0"x}"scatter"(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}title=""(*ESC*){unicode "00A0"x}noborder(*ESC*){unicode "00A0"x}valueattrs=(size=10)(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}location=inside(*ESC*){unicode "00A0"x}position=topleft(*ESC*){unicode "00A0"x}across=1(*ESC*){unicode "00A0"x}opaque;';
p'run;';
run;
title;
%mend;
