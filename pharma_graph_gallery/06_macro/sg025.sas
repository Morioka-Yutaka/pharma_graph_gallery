/*** HELP START ***//*

Macro: SG025
Purpose: ROC curve of sensitivity versus false positive rate.

*//*** HELP END ***/

%macro SG025;
title "SG025:ROC Curve";
data roc_sample;
  call streaminit(12345);
  do id = 1 to 500;
    age = rand("normal", 62, 10);
    bmi = rand("normal", 24, 3);
    latent = -8
             + 0.06 * age
             + 0.12 * bmi
             + rand("normal", 0, 1);
    p_disease = 1 / (1 + exp(-latent));
    outcome = rand("bernoulli", p_disease);
    if outcome = 1 then
      biomarker = rand("normal", 75, 12);
    else
      biomarker = rand("normal", 55, 12);
      biomarker = biomarker + 0.15 * (age - 60) + 0.4 * (bmi - 24);
    output;
  end;
run;
ods graphics on;
ods output ROCCurve = ROCCurve;
proc logistic data=roc_sample plots(only)=roc;
  model outcome(event='1') = biomarker age bmi
        / lackfit rsquare outroc=rocstats;
  output out=pred predicted=pred;
run;

data wk1;
  set rocstats;
  specificity = 1 - _1MSPEC_;
  youden_j = _SENSIT_ + specificity - 1;
  distance = sqrt((1 - _SENSIT_)**2 + (1 - specificity)**2);
run;

proc sql noprint;
  create table cutoff as
  select
      _PROB_   as cutoff_prob,
      _SENSIT_ as cutoff_sens,
      specificity as cutoff_spec,
      youden_j,
      distance
  from wk1
  having youden_j = max(youden_j);
quit;

data plot_roc;
  set wk1;
  if _n_ = 1 then set cutoff;
  if _PROB_ = cutoff_prob then do;
    star_x = _1MSPEC_;
    star_y = _SENSIT_;
  end;
run;


ods graphics / 
               noborder
               noscale
               width=600 px
               height=600 px
               attrpriority=none
               imagefmt=png
;
ods proclabel="SG025:ROC Curve";
proc sgplot data=plot_roc noautolegend aspect=1;
  step x=_1MSPEC_ y=_SENSIT_
    / lineattrs=(thickness=3 color=blue);

  scatter x=star_x y=star_y
    / markerattrs=(symbol=diamondfilled color=blue size=15) name="Youden" legendlabel="Cut off (max of Youden Index)";

  lineparm x=0 y=0 slope=1
    / transparency=0.3 lineattrs=(color=black pattern=shortdash thickness=2);

  xaxis grid values=(0 to 1 by 0.25)
    label="1 - Specificity"
    labelattrs=(size=11) offsetmin=0.01 offsetmax=0.01;

  yaxis grid values=(0 to 1 by 0.25)
    label="Sensitivity"
    labelattrs=(size=12 ) offsetmin=0.01 offsetmax=0.01;

  keylegend "Youden" /location=inside position=bottomright;
run;
ods proclabel="SG025:ROC Curve";
proc odstext;
p'data(*ESC*){unicode "00A0"x}roc_sample;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}streaminit(12345);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}id(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}500;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}age(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",(*ESC*){unicode "00A0"x}62,(*ESC*){unicode "00A0"x}10);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}bmi(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",(*ESC*){unicode "00A0"x}24,(*ESC*){unicode "00A0"x}3);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}latent(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}-8';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}0.06(*ESC*){unicode "00A0"x}*(*ESC*){unicode "00A0"x}age';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}0.12(*ESC*){unicode "00A0"x}*(*ESC*){unicode "00A0"x}bmi';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}rand("normal",(*ESC*){unicode "00A0"x}0,(*ESC*){unicode "00A0"x}1);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_disease(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}(1(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}exp(-latent));';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}outcome(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("bernoulli",(*ESC*){unicode "00A0"x}p_disease);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}outcome(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}then';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}biomarker(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",(*ESC*){unicode "00A0"x}75,(*ESC*){unicode "00A0"x}12);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}biomarker(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",(*ESC*){unicode "00A0"x}55,(*ESC*){unicode "00A0"x}12);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}biomarker(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}biomarker(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}0.15(*ESC*){unicode "00A0"x}*(*ESC*){unicode "00A0"x}(age(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}60)(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}0.4(*ESC*){unicode "00A0"x}*(*ESC*){unicode "00A0"x}(bmi(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}24);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'run;';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}on;';
p'ods(*ESC*){unicode "00A0"x}output(*ESC*){unicode "00A0"x}ROCCurve(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}ROCCurve;';
p'proc(*ESC*){unicode "00A0"x}logistic(*ESC*){unicode "00A0"x}data=roc_sample(*ESC*){unicode "00A0"x}plots(only)=roc;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}model(*ESC*){unicode "00A0"x}outcome(event="1")(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}biomarker(*ESC*){unicode "00A0"x}age(*ESC*){unicode "00A0"x}bmi';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}lackfit(*ESC*){unicode "00A0"x}rsquare(*ESC*){unicode "00A0"x}outroc=rocstats;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output(*ESC*){unicode "00A0"x}out=pred(*ESC*){unicode "00A0"x}predicted=pred;';
p'run;';
p'';
p'data(*ESC*){unicode "00A0"x}wk1;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}rocstats;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}specificity(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}_1MSPEC_;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}youden_j(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}_SENSIT_(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}specificity(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}1;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}distance(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}sqrt((1(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}_SENSIT_)**2(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}(1(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}specificity)**2);';
p'run;';
p'';
p'proc(*ESC*){unicode "00A0"x}sql(*ESC*){unicode "00A0"x}noprint;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}create(*ESC*){unicode "00A0"x}table(*ESC*){unicode "00A0"x}cutoff(*ESC*){unicode "00A0"x}as';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}select';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}_PROB_(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}as(*ESC*){unicode "00A0"x}cutoff_prob,';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}_SENSIT_(*ESC*){unicode "00A0"x}as(*ESC*){unicode "00A0"x}cutoff_sens,';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}specificity(*ESC*){unicode "00A0"x}as(*ESC*){unicode "00A0"x}cutoff_spec,';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}youden_j,';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}distance';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}from(*ESC*){unicode "00A0"x}wk1';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}having(*ESC*){unicode "00A0"x}youden_j(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}max(youden_j);';
p'quit;';
p'';
p'data(*ESC*){unicode "00A0"x}plot_roc;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}wk1;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}_n_(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}cutoff;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}_PROB_(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}cutoff_prob(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}star_x(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}_1MSPEC_;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}star_y(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}_SENSIT_;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'run;';
p'';
p'';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=600(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=600(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=plot_roc(*ESC*){unicode "00A0"x}noautolegend(*ESC*){unicode "00A0"x}aspect=1;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}step(*ESC*){unicode "00A0"x}x=_1MSPEC_(*ESC*){unicode "00A0"x}y=_SENSIT_';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}lineattrs=(thickness=3(*ESC*){unicode "00A0"x}color=blue);';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}scatter(*ESC*){unicode "00A0"x}x=star_x(*ESC*){unicode "00A0"x}y=star_y';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}markerattrs=(symbol=diamondfilled(*ESC*){unicode "00A0"x}color=blue(*ESC*){unicode "00A0"x}size=15)(*ESC*){unicode "00A0"x}name="Youden"(*ESC*){unicode "00A0"x}legendlabel="Cut(*ESC*){unicode "00A0"x}off(*ESC*){unicode "00A0"x}(max(*ESC*){unicode "00A0"x}of(*ESC*){unicode "00A0"x}Youden(*ESC*){unicode "00A0"x}Index)";';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lineparm(*ESC*){unicode "00A0"x}x=0(*ESC*){unicode "00A0"x}y=0(*ESC*){unicode "00A0"x}slope=1';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}transparency=0.3(*ESC*){unicode "00A0"x}lineattrs=(color=black(*ESC*){unicode "00A0"x}pattern=shortdash(*ESC*){unicode "00A0"x}thickness=2);';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxis(*ESC*){unicode "00A0"x}grid(*ESC*){unicode "00A0"x}values=(0(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}0.25)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}label="1(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}Specificity"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}labelattrs=(size=11)(*ESC*){unicode "00A0"x}offsetmin=0.01(*ESC*){unicode "00A0"x}offsetmax=0.01;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxis(*ESC*){unicode "00A0"x}grid(*ESC*){unicode "00A0"x}values=(0(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}0.25)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}label="Sensitivity"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}labelattrs=(size=12(*ESC*){unicode "00A0"x})(*ESC*){unicode "00A0"x}offsetmin=0.01(*ESC*){unicode "00A0"x}offsetmax=0.01;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}keylegend(*ESC*){unicode "00A0"x}"Youden"(*ESC*){unicode "00A0"x}/location=inside(*ESC*){unicode "00A0"x}position=bottomright;';
p'run;';
run;
title;
%mend;
