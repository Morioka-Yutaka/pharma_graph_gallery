/*** HELP START ***//*

Macro: SG037
Purpose: Scatter plot with regression line within the data range.

*//*** HELP END ***/

%macro SG037;
title "SG037:Regression line within the data range";
ods output ParameterEstimates=ParameterEstimates;
proc reg data=sashelp.class ;
model height = age;
run;
quit;
data _null_;
set ParameterEstimates;
if Variable="Intercept" then call symputx("Intercept",round(Estimate,0.01));
else call symputx("Slope",round(Estimate,0.01));
run;

ods graphics / 
               noborder
               noscale
               width=745 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
ods proclabel="SG037:Regression line within the data range";
proc sgplot data=sashelp.class noborder;
    reg x=age y=height /clm = "95% Confidence Limits" cli="95% Prediction Limits" legendlabel="Regression";
    xaxis label="Age" values=(10 to 17);
    yaxis label="Height (inch)" values=(40 to 90 by 10);
    inset "Slope = &Slope." "Intercept = &Intercept.";
    keylegend /noborder location=inside position=bottomright across=1;
run;

ods proclabel="SG037:Regression line within the data range";
proc odstext;
p'ods(*ESC*){unicode "00A0"x}output(*ESC*){unicode "00A0"x}ParameterEstimates=ParameterEstimates;';
p'proc(*ESC*){unicode "00A0"x}reg(*ESC*){unicode "00A0"x}data=sashelp.class(*ESC*){unicode "00A0"x};';
p'model(*ESC*){unicode "00A0"x}height(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}age;';
p'run;';
p'quit;';
p'data(*ESC*){unicode "00A0"x}_null_;';
p'set(*ESC*){unicode "00A0"x}ParameterEstimates;';
p'if(*ESC*){unicode "00A0"x}Variable="Intercept"(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}symputx("Intercept",round(Estimate,0.01));';
p'else(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}symputx("Slope",round(Estimate,0.01));';
p'run;';
p'';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=745(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=510(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=sashelp.class(*ESC*){unicode "00A0"x}noborder;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}reg(*ESC*){unicode "00A0"x}x=age(*ESC*){unicode "00A0"x}y=height(*ESC*){unicode "00A0"x}/clm(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"95%(*ESC*){unicode "00A0"x}Confidence(*ESC*){unicode "00A0"x}Limits"(*ESC*){unicode "00A0"x}cli="95%(*ESC*){unicode "00A0"x}Prediction(*ESC*){unicode "00A0"x}Limits"(*ESC*){unicode "00A0"x}legendlabel="Regression";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxis(*ESC*){unicode "00A0"x}label="Age"(*ESC*){unicode "00A0"x}values=(10(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}17);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxis(*ESC*){unicode "00A0"x}label="Height(*ESC*){unicode "00A0"x}(inch)"(*ESC*){unicode "00A0"x}values=(40(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}90(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}10);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}inset(*ESC*){unicode "00A0"x}"Slope(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}&Slope."(*ESC*){unicode "00A0"x}"Intercept(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}&Intercept.";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}keylegend(*ESC*){unicode "00A0"x}/noborder(*ESC*){unicode "00A0"x}location=inside(*ESC*){unicode "00A0"x}position=bottomright(*ESC*){unicode "00A0"x}across=1;';
p'run;';
run;
title;
%mend;
