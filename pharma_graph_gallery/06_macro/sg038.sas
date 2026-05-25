/*** HELP START ***//*

Macro: SG038
Purpose: Scatter plot with regression line extended over the axis range.

*//*** HELP END ***/

%macro SG038;
title "SG038:Regression line over the data range";
data xgrid;
  do AGE = 9 to 18 by 1;
    height = .;
    output;
  end;
run;
data reg_input;
  set sashelp.class xgrid;
run;
ods output ParameterEstimates=ParameterEstimates;
proc reg data=reg_input ;
  model height = AGE;
  output out=reg_pred
    p     = pred
    lclm  = lclm
    uclm  = uclm
    lcl   = lcli
    ucl   = ucli;
run;
quit;
data _null_;
set ParameterEstimates;
if Variable="Intercept" then call symputx("Intercept",round(Estimate,0.01));
else call symputx("Slope",round(Estimate,0.01));
run;
data reg_pred_input;
set reg_pred;
if ^missing(height) then call missing(of pred lcli ucli lclm uclm);
run;

ods graphics / 
               noborder
               noscale
               width=745 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
ods proclabel="SG038:Regression line over the data range";
proc sgplot data=reg_pred_input noborder;
    scatter x=age y=height;

    lineparm x=0 y=&intercept slope=&slope
       / legendlabel="Regression" name="reg";

    band x=age lower=lclm upper=uclm
      / transparency=0.5
        legendlabel="95% Confidence Limits" name="clm";

      series x=age y=lcli
    / transparency=0.6
      lineattrs=(thickness=2 pattern=shortdash)
      legendlabel="95% Prediction Limits" name="cli";

      series x=age y=ucli
    / transparency=0.6
      lineattrs=(thickness=2 pattern=shortdash);

    xaxis label="Age" values=(10 to 17);
    yaxis label="Height (inch.)" values=(40 to 90 by 10);
    inset "Slope = &Slope." "Intercept = &Intercept.";
    keylegend "cli" "clm" "reg" /noborder location=inside position=bottomright across=1;
run;

ods proclabel="SG038:Regression line over the data range";
proc odstext;
p'data(*ESC*){unicode "00A0"x}xgrid;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}AGE(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}9(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}18(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}1;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}.;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'run;';
p'data(*ESC*){unicode "00A0"x}reg_input;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}sashelp.class(*ESC*){unicode "00A0"x}xgrid;';
p'run;';
p'ods(*ESC*){unicode "00A0"x}output(*ESC*){unicode "00A0"x}ParameterEstimates=ParameterEstimates;';
p'proc(*ESC*){unicode "00A0"x}reg(*ESC*){unicode "00A0"x}data=reg_input(*ESC*){unicode "00A0"x};';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}model(*ESC*){unicode "00A0"x}height(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}AGE;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output(*ESC*){unicode "00A0"x}out=reg_pred';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}pred';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lclm(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}lclm';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}uclm(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}uclm';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lcl(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}lcli';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}ucl(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}ucli;';
p'run;';
p'quit;';
p'data(*ESC*){unicode "00A0"x}_null_;';
p'set(*ESC*){unicode "00A0"x}ParameterEstimates;';
p'if(*ESC*){unicode "00A0"x}Variable="Intercept"(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}symputx("Intercept",round(Estimate,0.01));';
p'else(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}symputx("Slope",round(Estimate,0.01));';
p'run;';
p'data(*ESC*){unicode "00A0"x}reg_pred_input;';
p'set(*ESC*){unicode "00A0"x}reg_pred;';
p'if(*ESC*){unicode "00A0"x}^missing(height)(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}missing(of(*ESC*){unicode "00A0"x}pred(*ESC*){unicode "00A0"x}lcli(*ESC*){unicode "00A0"x}ucli(*ESC*){unicode "00A0"x}lclm(*ESC*){unicode "00A0"x}uclm);';
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
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=reg_pred_input(*ESC*){unicode "00A0"x}noborder;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}scatter(*ESC*){unicode "00A0"x}x=age(*ESC*){unicode "00A0"x}y=height;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lineparm(*ESC*){unicode "00A0"x}x=0(*ESC*){unicode "00A0"x}y=&intercept(*ESC*){unicode "00A0"x}slope=&slope';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}legendlabel="Regression"(*ESC*){unicode "00A0"x}name="reg";';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}band(*ESC*){unicode "00A0"x}x=age(*ESC*){unicode "00A0"x}lower=lclm(*ESC*){unicode "00A0"x}upper=uclm';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}transparency=0.5';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}legendlabel="95%(*ESC*){unicode "00A0"x}Confidence(*ESC*){unicode "00A0"x}Limits"(*ESC*){unicode "00A0"x}name="clm";';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}series(*ESC*){unicode "00A0"x}x=age(*ESC*){unicode "00A0"x}y=lcli';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}transparency=0.6';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lineattrs=(thickness=2(*ESC*){unicode "00A0"x}pattern=shortdash)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}legendlabel="95%(*ESC*){unicode "00A0"x}Prediction(*ESC*){unicode "00A0"x}Limits"(*ESC*){unicode "00A0"x}name="cli";';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}series(*ESC*){unicode "00A0"x}x=age(*ESC*){unicode "00A0"x}y=ucli';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}transparency=0.6';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lineattrs=(thickness=2(*ESC*){unicode "00A0"x}pattern=shortdash);';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxis(*ESC*){unicode "00A0"x}label="Age"(*ESC*){unicode "00A0"x}values=(10(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}17);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxis(*ESC*){unicode "00A0"x}label="Height(*ESC*){unicode "00A0"x}(inch.)"(*ESC*){unicode "00A0"x}values=(40(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}90(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}10);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}inset(*ESC*){unicode "00A0"x}"Slope(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}&Slope."(*ESC*){unicode "00A0"x}"Intercept(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}&Intercept.";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}keylegend(*ESC*){unicode "00A0"x}"cli"(*ESC*){unicode "00A0"x}"clm"(*ESC*){unicode "00A0"x}"reg"(*ESC*){unicode "00A0"x}/noborder(*ESC*){unicode "00A0"x}location=inside(*ESC*){unicode "00A0"x}position=bottomright(*ESC*){unicode "00A0"x}across=1;';
p'run;';
run;

title;
%mend;

