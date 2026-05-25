/*** HELP START ***//*

Macro: SG013
Purpose: Clustered bar chart of rates by type and treatment group.

*//*** HELP END ***/

%macro SG013;
title "SG013:Clustered bar chart of rates by type and treatment group";
data wk1;
do TRTP="Active","Placebo";
 do TYPE= "Type 1","Type 2","Type 3","Type 4";
  RATE=50 + ranuni(777)*50;
  RATEC=cats(round(RATE,0.1),'%');
  N="999";
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
id="TRTP";value="Active";fillcolor="white";linecolor="black";fillpattern="L1";output;
id="TRTP";value="Placebo";fillcolor="black";linecolor="black";fillpattern="";output;
run;

ods proclabel="SG013:Clustered bar chart of rates by type and treatment group";
proc sgplot data=wk1 dattrmap=attrmap noborder;

vbarparm  category=TYPE response=RATE /
          group=TRTP
          groupdisplay=cluster
          clusterwidth=0.6
          barwidth=1
		  attrid=TRTP
		  name="P1"
		  fillpattern
;
text x=TYPE y=RATE text=RATEC/
          group=TRTP
          groupdisplay=cluster
          clusterwidth=0.6
		  position=top
		  textattrs=(color=black size=13)
;

xaxis valueattrs=(size=13)
       type=discrete
       display=(noticks nolabel noline)
;
yaxis label='XXXX Rate (%)'
      labelattrs=(size=13)
	  valueattrs=(size=13)
	  min=0
	  offsetmin=0
;

keylegend "P1" /
	   noborder
       location=inside
       position=topright
       across=1
       title=''	   valueattrs=(size=13)
;

  xaxistable N / x=TYPE class=TRTP location=outside valueattrs=(size=13 color=black) labelattrs=(size=13);

run;

ods proclabel="SG013:Clustered bar chart of rates by type and treatment group";
proc odstext;
p'data(*ESC*){unicode "00A0"x}wk1;';
p'do(*ESC*){unicode "00A0"x}TRTP="Active","Placebo";';
p'(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}TYPE=(*ESC*){unicode "00A0"x}"Type(*ESC*){unicode "00A0"x}1","Type(*ESC*){unicode "00A0"x}2","Type(*ESC*){unicode "00A0"x}3","Type(*ESC*){unicode "00A0"x}4";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}RATE=50(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}ranuni(777)*50;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}RATEC=cats(round(RATE,0.1),"%");';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}N="999";';
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
p'id="TRTP";value="Active";fillcolor="white";linecolor="black";fillpattern="L1";output;';
p'id="TRTP";value="Placebo";fillcolor="black";linecolor="black";fillpattern="";output;';
p'run;';
p'';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=wk1(*ESC*){unicode "00A0"x}dattrmap=attrmap(*ESC*){unicode "00A0"x}noborder;';
p'';
p'vbarparm(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}category=TYPE(*ESC*){unicode "00A0"x}response=RATE(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}group=TRTP';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}groupdisplay=cluster';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}clusterwidth=0.6';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}barwidth=1';
p'		(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrid=TRTP';
p'		(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}name="P1"';
p'		(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}fillpattern';
p';';
p'text(*ESC*){unicode "00A0"x}x=TYPE(*ESC*){unicode "00A0"x}y=RATE(*ESC*){unicode "00A0"x}text=RATEC/(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}group=TRTP';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}groupdisplay=cluster';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}clusterwidth=0.6';
p'		(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}position=top';
p'		(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}textattrs=(color=black(*ESC*){unicode "00A0"x}size=13)';
p';';
p'';
p'xaxis(*ESC*){unicode "00A0"x}valueattrs=(size=13)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}type=discrete';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}display=(noticks(*ESC*){unicode "00A0"x}nolabel(*ESC*){unicode "00A0"x}noline)';
p';';
p'yaxis(*ESC*){unicode "00A0"x}label="XXXX(*ESC*){unicode "00A0"x}Rate(*ESC*){unicode "00A0"x}(%)"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}labelattrs=(size=13)';
p'	(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}valueattrs=(size=13)';
p'	(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}min=0';
p'	(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}offsetmin=0';
p';';
p'';
p'keylegend(*ESC*){unicode "00A0"x}"P1"(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}';
p'	(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}location=inside';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}position=topright';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}across=1';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}title=""	(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}valueattrs=(size=13)';
p';';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxistable(*ESC*){unicode "00A0"x}N(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}x=TYPE(*ESC*){unicode "00A0"x}class=TRTP(*ESC*){unicode "00A0"x}location=outside(*ESC*){unicode "00A0"x}valueattrs=(size=13(*ESC*){unicode "00A0"x}color=black)(*ESC*){unicode "00A0"x}labelattrs=(size=13);';
p'run;';
run;
title;
%mend;
