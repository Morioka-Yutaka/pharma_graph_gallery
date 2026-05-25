/*** HELP START ***//*

Macro: SG035
Purpose: Pareto plot of counts and cumulative percentage.

*//*** HELP END ***/

%macro SG035;
title "SG035:Parato Plot";
data parato_raw;
  length reason $60;
  reason="Missing Visit Date"; count=42; output;
  reason="Incomplete Adverse Event Term"; count=35; output;
  reason="Lab Value Out of Range"; count=28; output;
  reason="Missing Concomitant Medication"; count=21; output;
  reason="Inconsistent AE Start Date"; count=16; output;
  reason="Unresolved Medical History Query"; count=12; output;
  reason="Missing Informed Consent Date"; count=9; output;
  reason="Other"; count=7; output;
run;
proc sort data=parato_raw out=parato_sort;
    by descending count;
run;
proc sql noprint;
    select sum(count) into :total_count
    from parato_sort;
quit;

data parato_data;
    set parato_sort;
    retain cum_count 0 order 0;
    qreason=quote(reason);
    order + 1;
    cum_count + count;
    cum_pct = cum_count / &total_count * 100;
run;

proc sql noprint;
select qreason into: _label_list separated by " " 
from parato_data;
quit;

ods graphics / 
               noborder
               noscale
               width=745 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
ods proclabel="SG035Parato Plot";
proc sgplot data=parato_data noautolegend;
    vbarparm category=order response=count /
        datalabel
        fillattrs=(color=cx5B9BD5)
        outlineattrs=(color=gray);

    series x=order y=cum_pct /
        y2axis
        markers
        lineattrs=(color=red thickness=2)
        markerattrs=(symbol=circlefilled color=red);

    refline 80 / axis=y2
        lineattrs=(pattern=shortdash color=gray);

    yaxis label="Number of Queries" grid;
    y2axis label="Cumulative Percentage (%)"
        values=(0 to 100 by 10)
        min=0 max=100;

    xaxis label="Query Reason"
        values=(1 to 8 by 1)
        valuesdisplay=(
            &_label_list.
        )
        fitpolicy=rotate;
format order best.;
run;

ods proclabel="SG035Parato Plot";
proc odstext;
p'data(*ESC*){unicode "00A0"x}parato_raw;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}length(*ESC*){unicode "00A0"x}reason(*ESC*){unicode "00A0"x}$60;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}reason="Missing(*ESC*){unicode "00A0"x}Visit(*ESC*){unicode "00A0"x}Date";(*ESC*){unicode "00A0"x}count=42;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}reason="Incomplete(*ESC*){unicode "00A0"x}Adverse(*ESC*){unicode "00A0"x}Event(*ESC*){unicode "00A0"x}Term";(*ESC*){unicode "00A0"x}count=35;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}reason="Lab(*ESC*){unicode "00A0"x}Value(*ESC*){unicode "00A0"x}Out(*ESC*){unicode "00A0"x}of(*ESC*){unicode "00A0"x}Range";(*ESC*){unicode "00A0"x}count=28;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}reason="Missing(*ESC*){unicode "00A0"x}Concomitant(*ESC*){unicode "00A0"x}Medication";(*ESC*){unicode "00A0"x}count=21;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}reason="Inconsistent(*ESC*){unicode "00A0"x}AE(*ESC*){unicode "00A0"x}Start(*ESC*){unicode "00A0"x}Date";(*ESC*){unicode "00A0"x}count=16;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}reason="Unresolved(*ESC*){unicode "00A0"x}Medical(*ESC*){unicode "00A0"x}History(*ESC*){unicode "00A0"x}Query";(*ESC*){unicode "00A0"x}count=12;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}reason="Missing(*ESC*){unicode "00A0"x}Informed(*ESC*){unicode "00A0"x}Consent(*ESC*){unicode "00A0"x}Date";(*ESC*){unicode "00A0"x}count=9;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}reason="Other";(*ESC*){unicode "00A0"x}count=7;(*ESC*){unicode "00A0"x}output;';
p'run;';
p'proc(*ESC*){unicode "00A0"x}sort(*ESC*){unicode "00A0"x}data=parato_raw(*ESC*){unicode "00A0"x}out=parato_sort;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}descending(*ESC*){unicode "00A0"x}count;';
p'run;';
p'proc(*ESC*){unicode "00A0"x}sql(*ESC*){unicode "00A0"x}noprint;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}select(*ESC*){unicode "00A0"x}sum(count)(*ESC*){unicode "00A0"x}into(*ESC*){unicode "00A0"x}:total_count';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}from(*ESC*){unicode "00A0"x}parato_sort;';
p'quit;';
p'';
p'data(*ESC*){unicode "00A0"x}parato_data;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}parato_sort;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}retain(*ESC*){unicode "00A0"x}cum_count(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}order(*ESC*){unicode "00A0"x}0;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}qreason=quote(reason);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}order(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}1;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}cum_count(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}count;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}cum_pct(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}cum_count(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}&total_count(*ESC*){unicode "00A0"x}*(*ESC*){unicode "00A0"x}100;';
p'run;';
p'';
p'proc(*ESC*){unicode "00A0"x}sql(*ESC*){unicode "00A0"x}noprint;';
p'select(*ESC*){unicode "00A0"x}qreason(*ESC*){unicode "00A0"x}into:(*ESC*){unicode "00A0"x}_label_list(*ESC*){unicode "00A0"x}separated(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}"(*ESC*){unicode "00A0"x}"(*ESC*){unicode "00A0"x}';
p'from(*ESC*){unicode "00A0"x}parato_data;';
p'quit;';
p'';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=745(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=510(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=parato_data(*ESC*){unicode "00A0"x}noautolegend;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}vbarparm(*ESC*){unicode "00A0"x}category=order(*ESC*){unicode "00A0"x}response=count(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}datalabel';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}fillattrs=(color=cx5B9BD5)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}outlineattrs=(color=gray);';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}series(*ESC*){unicode "00A0"x}x=order(*ESC*){unicode "00A0"x}y=cum_pct(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}y2axis';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}markers';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lineattrs=(color=red(*ESC*){unicode "00A0"x}thickness=2)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}markerattrs=(symbol=circlefilled(*ESC*){unicode "00A0"x}color=red);';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}refline(*ESC*){unicode "00A0"x}80(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}axis=y2';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lineattrs=(pattern=shortdash(*ESC*){unicode "00A0"x}color=gray);';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxis(*ESC*){unicode "00A0"x}label="Number(*ESC*){unicode "00A0"x}of(*ESC*){unicode "00A0"x}Queries"(*ESC*){unicode "00A0"x}grid;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}y2axis(*ESC*){unicode "00A0"x}label="Cumulative(*ESC*){unicode "00A0"x}Percentage(*ESC*){unicode "00A0"x}(%)"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}values=(0(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}100(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}10)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}min=0(*ESC*){unicode "00A0"x}max=100;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxis(*ESC*){unicode "00A0"x}label="Query(*ESC*){unicode "00A0"x}Reason"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}values=(1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}8(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}1)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}valuesdisplay=(';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}&_label_list.';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x})';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}fitpolicy=rotate;';
p'format(*ESC*){unicode "00A0"x}order(*ESC*){unicode "00A0"x}best.;';
p'run;';
run;
title;
%mend;
