/*** HELP START ***//*

Macro: SG014
Purpose: Clustered bar chart of change from baseline with 95% confidence intervals over time by category.

*//*** HELP END ***/

%macro SG014;
title 'SG014:Clustered bar chart of change from baseline with 95% CI over time by category';
data wk1;
do ARELTIM=1,2,8,16,24;
 ATPTN=choosen(whichn(ARELTIM,1,2,8,16,24),1,2,3,4,5);
 do cate= "Category A","Category B","Category C","Category D","Category E";
  CHG=1 + ranuni(777)*whichc(cate,"Category A","Category B","Category C","Category D","Category E");
  if CHG>4 then CHG=3;
  if cate="E" then CHG=CHG-abs(CHG)*0.8;
  HCI=CHG+abs(CHG)*0.2;
  LCI=CHG-abs(CHG)*0.1;
  if HCI>4 then ast=cats("***");
  else if HCI>3.5 then ast=cats("**");
  else ast="";
  output;
 end; 
end;
run;

ods graphics / 
               noborder
               noscale
               width=880 px
               height=610 px
               attrpriority=none
               imagefmt=png
;
data attrmap;
length id value fillcolor linecolor $20.;
id="mymap1";value="Category A";fillcolor="white";linecolor="black";output;
id="mymap1";value="Category B";fillcolor="lightgray";linecolor="black";output;
id="mymap1";value="Category C";fillcolor="mediumgray";linecolor="black";output;
id="mymap1";value="Category D";fillcolor="darkgray";linecolor="black";output;
id="mymap1";value="Category E";fillcolor="gray";linecolor="black";output;

run;

ods proclabel='SG014:Clustered bar chart of change from baseline with 95% CI over time by category';
proc sgplot data=wk1 dattrmap=attrmap;;

vbarparm  category=ATPTN response=CHG /
          group=cate
          groupdisplay=cluster
          clusterwidth=0.8
          barwidth=1
          baseline=1
		  limitlower=LCI
		  limitupper=HCI
		  limitattrs=(color=black)
          x2axis
		  attrid=mymap1
		  name="vbarparm"
 ;
text x=ATPTN y=HCI text=ast/
          group=cate
          groupdisplay=cluster
          clusterwidth=0.8
		  position=top
		  textattrs=(color=black size=13)
;
refline 1.5 2.5 3.5 4.5  /
          axis=x2
          lineattrs=(pattern=dash thickness=2)
;
x2axis values=(1 1.5 2 2.5 3 3.5 4 4.5 5)
       type=linear display=(novalues noticks nolabel)
;
xaxis values=(1 2 3 4 5)
       valuesdisplay=("1h" "2h" "8h" "16h" "24h")
	   valueattrs=(size=13)
       type=linear
       display=(noticks nolabel)
;
yaxis max=6 offsetmin=0 min=1
      label='Change from Baseline (95% CI)'
      labelattrs=(size=14)
;
keylegend "vbarparm" /
       location=inside
       position=topright
       across=1
       title='';

format ATPTN 8.;
run;

ods proclabel='SG014:Clustered bar chart of change from baseline with 95% CI over time by category';
proc odstext;
p'data(*ESC*){unicode "00A0"x}wk1;';
p'do(*ESC*){unicode "00A0"x}ARELTIM=1,2,8,16,24;';
p'(*ESC*){unicode "00A0"x}ATPTN=choosen(whichn(ARELTIM,1,2,8,16,24),1,2,3,4,5);';
p'(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}cate=(*ESC*){unicode "00A0"x}"Category(*ESC*){unicode "00A0"x}A","Category(*ESC*){unicode "00A0"x}B","Category(*ESC*){unicode "00A0"x}C","Category(*ESC*){unicode "00A0"x}D","Category(*ESC*){unicode "00A0"x}E";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}CHG=1(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}ranuni(777)*whichc(cate,"Category(*ESC*){unicode "00A0"x}A","Category(*ESC*){unicode "00A0"x}B","Category(*ESC*){unicode "00A0"x}C","Category(*ESC*){unicode "00A0"x}D","Category(*ESC*){unicode "00A0"x}E");';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}CHG>4(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}CHG=3;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}cate="E"(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}CHG=CHG-abs(CHG)*0.8;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}HCI=CHG+abs(CHG)*0.2;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}LCI=CHG-abs(CHG)*0.1;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}HCI>4(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}ast=cats("***");';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}HCI>3.5(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}ast=cats("**");';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}ast="";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}end;(*ESC*){unicode "00A0"x}';
p'end;';
p'run;';
p'';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=880(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=610(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'data(*ESC*){unicode "00A0"x}attrmap;';
p'length(*ESC*){unicode "00A0"x}id(*ESC*){unicode "00A0"x}value(*ESC*){unicode "00A0"x}fillcolor(*ESC*){unicode "00A0"x}linecolor(*ESC*){unicode "00A0"x}$20.;';
p'id="mymap1";value="Category(*ESC*){unicode "00A0"x}A";fillcolor="white";linecolor="black";output;';
p'id="mymap1";value="Category(*ESC*){unicode "00A0"x}B";fillcolor="lightgray";linecolor="black";output;';
p'id="mymap1";value="Category(*ESC*){unicode "00A0"x}C";fillcolor="mediumgray";linecolor="black";output;';
p'id="mymap1";value="Category(*ESC*){unicode "00A0"x}D";fillcolor="darkgray";linecolor="black";output;';
p'id="mymap1";value="Category(*ESC*){unicode "00A0"x}E";fillcolor="gray";linecolor="black";output;';
p'';
p'run;';
p'';
p'ods(*ESC*){unicode "00A0"x}proclabel="Clustered(*ESC*){unicode "00A0"x}bar(*ESC*){unicode "00A0"x}chart(*ESC*){unicode "00A0"x}of(*ESC*){unicode "00A0"x}change(*ESC*){unicode "00A0"x}from(*ESC*){unicode "00A0"x}baseline(*ESC*){unicode "00A0"x}with(*ESC*){unicode "00A0"x}95%(*ESC*){unicode "00A0"x}CI(*ESC*){unicode "00A0"x}over(*ESC*){unicode "00A0"x}time(*ESC*){unicode "00A0"x}by(*ESC*){unicode "00A0"x}category";';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=wk1(*ESC*){unicode "00A0"x}dattrmap=attrmap;;';
p'';
p'vbarparm(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}category=ATPTN(*ESC*){unicode "00A0"x}response=CHG(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}group=cate';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}groupdisplay=cluster';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}clusterwidth=0.8';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}barwidth=1';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}baseline=1';
p'		(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}limitlower=LCI';
p'		(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}limitupper=HCI';
p'		(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}limitattrs=(color=black)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}x2axis';
p'		(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrid=mymap1';
p'		(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}name="vbarparm"';
p'(*ESC*){unicode "00A0"x};';
p'text(*ESC*){unicode "00A0"x}x=ATPTN(*ESC*){unicode "00A0"x}y=HCI(*ESC*){unicode "00A0"x}text=ast/(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}group=cate';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}groupdisplay=cluster';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}clusterwidth=0.8';
p'		(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}position=top';
p'		(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}textattrs=(color=black(*ESC*){unicode "00A0"x}size=13)';
p';';
p'refline(*ESC*){unicode "00A0"x}1.5(*ESC*){unicode "00A0"x}2.5(*ESC*){unicode "00A0"x}3.5(*ESC*){unicode "00A0"x}4.5(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}axis=x2';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}lineattrs=(pattern=dash(*ESC*){unicode "00A0"x}thickness=2)';
p';';
p'x2axis(*ESC*){unicode "00A0"x}values=(1(*ESC*){unicode "00A0"x}1.5(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}2.5(*ESC*){unicode "00A0"x}3(*ESC*){unicode "00A0"x}3.5(*ESC*){unicode "00A0"x}4(*ESC*){unicode "00A0"x}4.5(*ESC*){unicode "00A0"x}5)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}type=linear(*ESC*){unicode "00A0"x}display=(novalues(*ESC*){unicode "00A0"x}noticks(*ESC*){unicode "00A0"x}nolabel)';
p';';
p'xaxis(*ESC*){unicode "00A0"x}values=(1(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}3(*ESC*){unicode "00A0"x}4(*ESC*){unicode "00A0"x}5)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}valuesdisplay=("1h"(*ESC*){unicode "00A0"x}"2h"(*ESC*){unicode "00A0"x}"8h"(*ESC*){unicode "00A0"x}"16h"(*ESC*){unicode "00A0"x}"24h")';
p'	(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}valueattrs=(size=13)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}type=linear';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}display=(noticks(*ESC*){unicode "00A0"x}nolabel)';
p';';
p'yaxis(*ESC*){unicode "00A0"x}max=6(*ESC*){unicode "00A0"x}offsetmin=0(*ESC*){unicode "00A0"x}min=1';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}label="Change(*ESC*){unicode "00A0"x}from(*ESC*){unicode "00A0"x}Baseline(*ESC*){unicode "00A0"x}(95%(*ESC*){unicode "00A0"x}CI)"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}labelattrs=(size=14)';
p';';
p'keylegend(*ESC*){unicode "00A0"x}"vbarparm"(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}location=inside';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}position=topright';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}across=1';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}title="";';
p'';
p'format(*ESC*){unicode "00A0"x}ATPTN(*ESC*){unicode "00A0"x}8.;';
p'run;';

run;
title;
%mend;

