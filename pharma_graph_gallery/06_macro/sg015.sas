/*** HELP START ***//*

Macro: SG015
Purpose: Line plot of adjusted mean change from baseline with standard error over time by treatment group.

*//*** HELP END ***/

%macro SG015;
title "SG015:Line plot of adjusted mean change from baseline with SE over time by treatment group";
data wk1;
do TRT01PN=1 to 2;
	do AVISITN=1000,1030,1080,1150,1220,1290,1360,1430,1500,1570;
		if AVISITN=1000 then estimate=0;
		
		if AVISITN=1030 & TRT01PN=2 then do;estimate=-1.89; end;
		if AVISITN=1030 & TRT01PN=1 then do;estimate=-2.91; end;

		if AVISITN=1080 & TRT01PN=2 then do;estimate=-2.53; end;
		if AVISITN=1080 & TRT01PN=1 then do;estimate=-6.18; end;

		if AVISITN=1150 & TRT01PN=2 then do;estimate=-3.01; end;
		if AVISITN=1150 & TRT01PN=1 then do;estimate=-8.79; end;

		if AVISITN=1220 & TRT01PN=2 then do;estimate=-3.71; end;
		if AVISITN=1220 & TRT01PN=1 then do;estimate=-9.78; end;

		if AVISITN=1290 & TRT01PN=2 then do;estimate=-3.50; end;
		if AVISITN=1290 & TRT01PN=1 then do;estimate=-10.78; end;

		if AVISITN=1360 & TRT01PN=2 then do;estimate=-3.42; end;
		if AVISITN=1360 & TRT01PN=1 then do;estimate=-11.92; end;

		if AVISITN=1430 & TRT01PN=2 then do;estimate=-3.15; end;
		if AVISITN=1430 & TRT01PN=1 then do;estimate=-11.83; end;

		if AVISITN=1500 & TRT01PN=2 then do;estimate=-3.91; end;
		if AVISITN=1500 & TRT01PN=1 then do;estimate=-12.14; end;

		if AVISITN=1570 & TRT01PN=2 then do;estimate=-3.34; end;
		if AVISITN=1570 & TRT01PN=1 then do;estimate=-12.56; end;
		output;
	end;
end;
run;

data wk2;
length out1-out3 $20.;
set wk1;
if TRT01PN=1  then do;
 upper=estimate+(estimate*0.2);
 lower=estimate-(estimate*0.2);
end;
if TRT01PN=2  then do;
 upper=estimate+(estimate*0.6);
 lower=estimate-(estimate*0.6);
end;

out1="XXX";
out2="XXX";
out3="XXX";

if AVISITN in (1150) then do;
	out3="0.042 * ";
	astarisk_y=round(Estimate +0.2,1e-10);
end;
if AVISITN in (1290,1360) then do;
	out3="<.0001 *";
	astarisk_y=round(Estimate +0.2,1e-10);
end;

	astarisk="   *";


run;

proc format ;
value TRT01PN 1="Active" 2="Placebo";
run;
ods graphics / 
               noborder
               noscale
               width=780 px
               height=450 px
               attrpriority=none
               imagefmt=png
;
ods proclabel="SG015:Line plot of adjusted mean change from baseline with SE over time by treatment group";
proc sgplot data=wk2 noborder ;
	styleattrs datacontrastcolors=(black black)
				   datalinepatterns=( solid dash)
                   datasymbols=(  CircleFilled circle); 

	series x=AVISITN y=estimate /group=trt01pn groupdisplay=cluster clusterwidth=0.2  markers markerattrs = (size=8) name="name1";

	scatter x=AVISITN y=estimate/group=trt01pn  groupdisplay=cluster clusterwidth=0.2 yerrorupper=upper yerrorlower=lower 
                                  markerattrs = (size=0);
	text x=AVISITN y=astarisk_y text=astarisk/group=trt01pn  groupdisplay=cluster clusterwidth=0.2 position=TOPRIGHT;


	refline 0 / axis=y lineattrs=(pattern=shortdash);

	keylegend "name1"/title=""  exclude=(".") location=inside position=topright across=1 noborder valueattrs=(size=10) sortorder=ascending;

	xaxis offsetmin=0.02 offsetmax=0.1 values=(1000,1030,1080,1150,1220,1290,1360,1430,1500,1570) 
                                                        valuesdisplay=("Baseline" "3" "8" "15" "22" "29" "36" "43" "50" "57") type=discrete labelattrs=(size=12) label="Time point (Day)";
	yaxis  offsetmax=0.05  labelattrs=(size=12)  values=(-20 to 2 by 2 ) valuesdisplay=("" "" "" "" "" "" "" "" "" "" "0") label="Adjusted Mean (SE) in Change from Baseline";

  xaxistable  out1/ x=AVISITN valueattrs=(size=9) location=outside label="Difference";
  xaxistable  out2/ x=AVISITN valueattrs=(size=9) location=outside label='[95％ CI]';
  xaxistable  out3/ x=AVISITN valueattrs=(size=9) location=outside label="p-value";

  format trt01pn trt01pn.;
run ;

ods proclabel="SG015:Line plot of adjusted mean change from baseline with SE over time by treatment group";
proc odstext;
p'data(*ESC*){unicode "00A0"x}wk1;';
p'do(*ESC*){unicode "00A0"x}TRT01PN=1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}2;';
p'	do(*ESC*){unicode "00A0"x}AVISITN=1000,1030,1080,1150,1220,1290,1360,1430,1500,1570;';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1000(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}estimate=0;';
p'		';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1030(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-1.89;(*ESC*){unicode "00A0"x}end;';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1030(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-2.91;(*ESC*){unicode "00A0"x}end;';
p'';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1080(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-2.53;(*ESC*){unicode "00A0"x}end;';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1080(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-6.18;(*ESC*){unicode "00A0"x}end;';
p'';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1150(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-3.01;(*ESC*){unicode "00A0"x}end;';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1150(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-8.79;(*ESC*){unicode "00A0"x}end;';
p'';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1220(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-3.71;(*ESC*){unicode "00A0"x}end;';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1220(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-9.78;(*ESC*){unicode "00A0"x}end;';
p'';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1290(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-3.50;(*ESC*){unicode "00A0"x}end;';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1290(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-10.78;(*ESC*){unicode "00A0"x}end;';
p'';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1360(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-3.42;(*ESC*){unicode "00A0"x}end;';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1360(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-11.92;(*ESC*){unicode "00A0"x}end;';
p'';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1430(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-3.15;(*ESC*){unicode "00A0"x}end;';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1430(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-11.83;(*ESC*){unicode "00A0"x}end;';
p'';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1500(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-3.91;(*ESC*){unicode "00A0"x}end;';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1500(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-12.14;(*ESC*){unicode "00A0"x}end;';
p'';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1570(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=2(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-3.34;(*ESC*){unicode "00A0"x}end;';
p'		if(*ESC*){unicode "00A0"x}AVISITN=1570(*ESC*){unicode "00A0"x}&(*ESC*){unicode "00A0"x}TRT01PN=1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;estimate=-12.56;(*ESC*){unicode "00A0"x}end;';
p'		output;';
p'	end;';
p'end;';
p'run;';
p'';
p'data(*ESC*){unicode "00A0"x}wk2;';
p'length(*ESC*){unicode "00A0"x}out1-out3(*ESC*){unicode "00A0"x}$20.;';
p'set(*ESC*){unicode "00A0"x}wk1;';
p'if(*ESC*){unicode "00A0"x}TRT01PN=1(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;';
p'(*ESC*){unicode "00A0"x}upper=estimate+(estimate*0.2);';
p'(*ESC*){unicode "00A0"x}lower=estimate-(estimate*0.2);';
p'end;';
p'if(*ESC*){unicode "00A0"x}TRT01PN=2(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;';
p'(*ESC*){unicode "00A0"x}upper=estimate+(estimate*0.6);';
p'(*ESC*){unicode "00A0"x}lower=estimate-(estimate*0.6);';
p'end;';
p'';
p'out1="XXX";';
p'out2="XXX";';
p'out3="XXX";';
p'';
p'if(*ESC*){unicode "00A0"x}AVISITN(*ESC*){unicode "00A0"x}in(*ESC*){unicode "00A0"x}(1150)(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;';
p'	out3="0.042(*ESC*){unicode "00A0"x}*(*ESC*){unicode "00A0"x}";';
p'	astarisk_y=round(Estimate(*ESC*){unicode "00A0"x}+0.2,1e-10);';
p'end;';
p'if(*ESC*){unicode "00A0"x}AVISITN(*ESC*){unicode "00A0"x}in(*ESC*){unicode "00A0"x}(1290,1360)(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}do;';
p'	out3="<.0001(*ESC*){unicode "00A0"x}*";';
p'	astarisk_y=round(Estimate(*ESC*){unicode "00A0"x}+0.2,1e-10);';
p'end;';
p'';
p'	astarisk="(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}*";';
p'';
p'';
p'run;';
p'';
p'proc(*ESC*){unicode "00A0"x}format(*ESC*){unicode "00A0"x};';
p'value(*ESC*){unicode "00A0"x}TRT01PN(*ESC*){unicode "00A0"x}1="Active"(*ESC*){unicode "00A0"x}2="Placebo";';
p'run;';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=780(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=450(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=wk2(*ESC*){unicode "00A0"x}noborder(*ESC*){unicode "00A0"x};';
p'	styleattrs(*ESC*){unicode "00A0"x}datacontrastcolors=(black(*ESC*){unicode "00A0"x}black)';
p'				(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}datalinepatterns=((*ESC*){unicode "00A0"x}solid(*ESC*){unicode "00A0"x}dash)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}datasymbols=((*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}CircleFilled(*ESC*){unicode "00A0"x}circle);(*ESC*){unicode "00A0"x}';
p'';
p'	series(*ESC*){unicode "00A0"x}x=AVISITN(*ESC*){unicode "00A0"x}y=estimate(*ESC*){unicode "00A0"x}/group=trt01pn(*ESC*){unicode "00A0"x}groupdisplay=cluster(*ESC*){unicode "00A0"x}clusterwidth=0.2(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}markers(*ESC*){unicode "00A0"x}markerattrs(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}(size=8)(*ESC*){unicode "00A0"x}name="name1";';
p'';
p'	scatter(*ESC*){unicode "00A0"x}x=AVISITN(*ESC*){unicode "00A0"x}y=estimate/group=trt01pn(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}groupdisplay=cluster(*ESC*){unicode "00A0"x}clusterwidth=0.2(*ESC*){unicode "00A0"x}yerrorupper=upper(*ESC*){unicode "00A0"x}yerrorlower=lower(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}markerattrs(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}(size=0);';
p'	text(*ESC*){unicode "00A0"x}x=AVISITN(*ESC*){unicode "00A0"x}y=astarisk_y(*ESC*){unicode "00A0"x}text=astarisk/group=trt01pn(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}groupdisplay=cluster(*ESC*){unicode "00A0"x}clusterwidth=0.2(*ESC*){unicode "00A0"x}position=TOPRIGHT;';
p'';
p'';
p'	refline(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}axis=y(*ESC*){unicode "00A0"x}lineattrs=(pattern=shortdash);';
p'';
p'	keylegend(*ESC*){unicode "00A0"x}"name1"/title=""(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}exclude=(".")(*ESC*){unicode "00A0"x}location=inside(*ESC*){unicode "00A0"x}position=topright(*ESC*){unicode "00A0"x}across=1(*ESC*){unicode "00A0"x}noborder(*ESC*){unicode "00A0"x}valueattrs=(size=10)(*ESC*){unicode "00A0"x}sortorder=ascending;';
p'';
p'	xaxis(*ESC*){unicode "00A0"x}offsetmin=0.02(*ESC*){unicode "00A0"x}offsetmax=0.1(*ESC*){unicode "00A0"x}values=(1000,1030,1080,1150,1220,1290,1360,1430,1500,1570)(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}valuesdisplay=("Baseline"(*ESC*){unicode "00A0"x}"3"(*ESC*){unicode "00A0"x}"8"(*ESC*){unicode "00A0"x}"15"(*ESC*){unicode "00A0"x}"22"(*ESC*){unicode "00A0"x}"29"(*ESC*){unicode "00A0"x}"36"(*ESC*){unicode "00A0"x}"43"(*ESC*){unicode "00A0"x}"50"(*ESC*){unicode "00A0"x}"57")(*ESC*){unicode "00A0"x}type=discrete(*ESC*){unicode "00A0"x}labelattrs=(size=12)(*ESC*){unicode "00A0"x}label="Time(*ESC*){unicode "00A0"x}point(*ESC*){unicode "00A0"x}(Day)";';
p'	yaxis(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}offsetmax=0.05(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}labelattrs=(size=12)(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}values=(-20(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x})(*ESC*){unicode "00A0"x}valuesdisplay=(""(*ESC*){unicode "00A0"x}""(*ESC*){unicode "00A0"x}""(*ESC*){unicode "00A0"x}""(*ESC*){unicode "00A0"x}""(*ESC*){unicode "00A0"x}""(*ESC*){unicode "00A0"x}""(*ESC*){unicode "00A0"x}""(*ESC*){unicode "00A0"x}""(*ESC*){unicode "00A0"x}""(*ESC*){unicode "00A0"x}"0")(*ESC*){unicode "00A0"x}label="Adjusted(*ESC*){unicode "00A0"x}Mean(*ESC*){unicode "00A0"x}(SE)(*ESC*){unicode "00A0"x}in(*ESC*){unicode "00A0"x}Change(*ESC*){unicode "00A0"x}from(*ESC*){unicode "00A0"x}Baseline";';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxistable(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}out1/(*ESC*){unicode "00A0"x}x=AVISITN(*ESC*){unicode "00A0"x}valueattrs=(size=9)(*ESC*){unicode "00A0"x}location=outside(*ESC*){unicode "00A0"x}label="Difference";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxistable(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}out2/(*ESC*){unicode "00A0"x}x=AVISITN(*ESC*){unicode "00A0"x}valueattrs=(size=9)(*ESC*){unicode "00A0"x}location=outside(*ESC*){unicode "00A0"x}label="[95％(*ESC*){unicode "00A0"x}CI]";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxistable(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}out3/(*ESC*){unicode "00A0"x}x=AVISITN(*ESC*){unicode "00A0"x}valueattrs=(size=9)(*ESC*){unicode "00A0"x}location=outside(*ESC*){unicode "00A0"x}label="p-value";';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}format(*ESC*){unicode "00A0"x}trt01pn(*ESC*){unicode "00A0"x}trt01pn.;';
p'run(*ESC*){unicode "00A0"x};';
run;
title;
%mend;
