/*** HELP START ***//*

Macro: SG026
Purpose: Power model plot of pharmacokinetic exposure versus dose.

*//*** HELP END ***/

%macro SG026;
title "SG026:Power Model (PK)";
data power_sample;
length SUBJID $20. DOSE 8. PPTEST $20.  AVAL 8.;
call streaminit(777);
k = 0.12;             
  do sub = 1 to 11;
    SUBJID=catx("-","SAMP",put(sub,z3.));
     do DOSE = 20,40,80,160;
      do PPTEST="CMAX";
        AVAL = k * dose**2*0.001 * exp(rand("normal", 0, 0.15));
        output;
     end;
  end;
end;
keep  SUBJID DOSE PPTEST AVAL;
run;

data power_sample_2;
set power_sample;
L_AVAL=log(AVAL);
L_DOSE=log(DOSE);
run;

ods output ParameterEstimates=ParameterEstimates;
proc reg data=power_sample_2;
model L_AVAL=L_DOSE/clb;
run;
quit;

 proc transpose data=ParameterEstimates out=ParameterEstimates_1;
 var Estimate;
 id Variable;
run;

data _null_;
set ParameterEstimates;
if Variable="Intercept" then call symputx("Intercept",round(Estimate,0.0001));
if Variable="L_DOSE" then do;
   if 0 <= Estimate then call symputx("beta",catx(" ","+",round(Estimate,0.0001)));
   if 0 > Estimate then call symputx("beta",catx(" ","-",round(abs(Estimate),0.0001)));
end;
run;
%put &=beta;
data ParameterEstimates_2;
set ParameterEstimates_1;
do x = 0 to 200 by 1;
  RF=exp(Intercept) * x ** L_DOSE ;
  output;
end;
run;

data power_sample_3;
 set power_sample_2 ParameterEstimates_2;
run;

ods graphics / 
               noborder
               noscale
               width=700 px
               height=400 px
               attrpriority=none
               imagefmt=png
;
ods proclabel="SG026:Power Model (PK)";

proc sgplot data=power_sample_3 noborder noautolegend;
inset "Power model : ln (Cmax) = &Intercept &beta. × ln (Dose) + Random error" / position=bottomright;
scatter x=DOSE y=AVAL /group=SUBJID   markerattrs=(color=black size=5 symbol=circlefilled) name="name1" ;
xaxis offsetmin=0.02 offsetmax=0.1labelattrs=(size=10) label="Dosage (mg)" values=(0 20 40 80 160);
yaxis  offsetmax=0.07  labelattrs=(size=10) label="Cmax (ng/mL)" values=(0 to 5 by 0.5) ;
series x=x y=RF /lineattrs=(color=black);
run ;

ods proclabel="SG026:Power Model (PK)";
proc odstext;
p'data(*ESC*){unicode "00A0"x}power_sample;';
p'length(*ESC*){unicode "00A0"x}SUBJID(*ESC*){unicode "00A0"x}$20.(*ESC*){unicode "00A0"x}DOSE(*ESC*){unicode "00A0"x}8.(*ESC*){unicode "00A0"x}PPTEST(*ESC*){unicode "00A0"x}$20.(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL(*ESC*){unicode "00A0"x}8.;';
p'call(*ESC*){unicode "00A0"x}streaminit(777);';
p'k(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}0.12;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}sub(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}11;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}SUBJID=catx("-","SAMP",put(sub,z3.));';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}DOSE(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}20,40,80,160;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}PPTEST="CMAX";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}AVAL(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}k(*ESC*){unicode "00A0"x}*(*ESC*){unicode "00A0"x}dose**2*0.001(*ESC*){unicode "00A0"x}*(*ESC*){unicode "00A0"x}exp(rand("normal",(*ESC*){unicode "00A0"x}0,(*ESC*){unicode "00A0"x}0.15));';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'end;';
p'keep(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}SUBJID(*ESC*){unicode "00A0"x}DOSE(*ESC*){unicode "00A0"x}PPTEST(*ESC*){unicode "00A0"x}AVAL;';
p'run;';
p'';
p'data(*ESC*){unicode "00A0"x}power_sample_2;';
p'set(*ESC*){unicode "00A0"x}power_sample;';
p'L_AVAL=log(AVAL);';
p'L_DOSE=log(DOSE);';
p'run;';
p'';
p'ods(*ESC*){unicode "00A0"x}output(*ESC*){unicode "00A0"x}ParameterEstimates=ParameterEstimates;';
p'proc(*ESC*){unicode "00A0"x}reg(*ESC*){unicode "00A0"x}data=power_sample_2;';
p'model(*ESC*){unicode "00A0"x}L_AVAL=L_DOSE/clb;';
p'run;';
p'quit;';
p'';
p'(*ESC*){unicode "00A0"x}proc(*ESC*){unicode "00A0"x}transpose(*ESC*){unicode "00A0"x}data=ParameterEstimates(*ESC*){unicode "00A0"x}out=ParameterEstimates_1;';
p'(*ESC*){unicode "00A0"x}var(*ESC*){unicode "00A0"x}Estimate;';
p'(*ESC*){unicode "00A0"x}id(*ESC*){unicode "00A0"x}Variable;';
p'run;';
p'';
p'data(*ESC*){unicode "00A0"x}_null_;';
p'set(*ESC*){unicode "00A0"x}ParameterEstimates;';
p'if(*ESC*){unicode "00A0"x}Variable="Intercept"(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}symputx("Intercept",round(Estimate,0.0001));';
p'if(*ESC*){unicode "00A0"x}Variable="L_DOSE"(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}<=(*ESC*){unicode "00A0"x}Estimate(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}symputx("beta",catx("(*ESC*){unicode "00A0"x}","+",round(Estimate,0.0001)));';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}>(*ESC*){unicode "00A0"x}Estimate(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}symputx("beta",catx("(*ESC*){unicode "00A0"x}","-",round(abs(Estimate),0.0001)));';
p'end;';
p'run;';
p'%put(*ESC*){unicode "00A0"x}&=beta;';
p'data(*ESC*){unicode "00A0"x}ParameterEstimates_2;';
p'set(*ESC*){unicode "00A0"x}ParameterEstimates_1;';
p'do(*ESC*){unicode "00A0"x}x(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}200(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}1;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}RF=exp(Intercept)(*ESC*){unicode "00A0"x}*(*ESC*){unicode "00A0"x}x(*ESC*){unicode "00A0"x}**(*ESC*){unicode "00A0"x}L_DOSE(*ESC*){unicode "00A0"x};';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'end;';
p'run;';
p'';
p'data(*ESC*){unicode "00A0"x}power_sample_3;';
p'(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}power_sample_2(*ESC*){unicode "00A0"x}ParameterEstimates_2;';
p'run;';
p'';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=700(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=400(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=power_sample_3(*ESC*){unicode "00A0"x}noborder(*ESC*){unicode "00A0"x}noautolegend;';
p'inset(*ESC*){unicode "00A0"x}"Power(*ESC*){unicode "00A0"x}model(*ESC*){unicode "00A0"x}:(*ESC*){unicode "00A0"x}ln(*ESC*){unicode "00A0"x}(Cmax)(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}&Intercept(*ESC*){unicode "00A0"x}&beta.(*ESC*){unicode "00A0"x}×(*ESC*){unicode "00A0"x}ln(*ESC*){unicode "00A0"x}(Dose)(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}Random(*ESC*){unicode "00A0"x}error"(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}position=bottomright;';
p'scatter(*ESC*){unicode "00A0"x}x=DOSE(*ESC*){unicode "00A0"x}y=AVAL(*ESC*){unicode "00A0"x}/group=SUBJID(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}markerattrs=(color=black(*ESC*){unicode "00A0"x}size=5(*ESC*){unicode "00A0"x}symbol=circlefilled)(*ESC*){unicode "00A0"x}name="name1"(*ESC*){unicode "00A0"x};';
p'xaxis(*ESC*){unicode "00A0"x}offsetmin=0.02(*ESC*){unicode "00A0"x}offsetmax=0.1labelattrs=(size=10)(*ESC*){unicode "00A0"x}label="Dosage(*ESC*){unicode "00A0"x}(mg)"(*ESC*){unicode "00A0"x}values=(0(*ESC*){unicode "00A0"x}20(*ESC*){unicode "00A0"x}40(*ESC*){unicode "00A0"x}80(*ESC*){unicode "00A0"x}160);';
p'yaxis(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}offsetmax=0.07(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}labelattrs=(size=10)(*ESC*){unicode "00A0"x}label="Cmax(*ESC*){unicode "00A0"x}(ng/mL)"(*ESC*){unicode "00A0"x}values=(0(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}5(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}0.5)(*ESC*){unicode "00A0"x};';
p'series(*ESC*){unicode "00A0"x}x=x(*ESC*){unicode "00A0"x}y=RF(*ESC*){unicode "00A0"x}/lineattrs=(color=black);';
p'run(*ESC*){unicode "00A0"x};';
run;
title;
%mend;
