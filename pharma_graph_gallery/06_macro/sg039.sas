/*** HELP START ***//*

Macro: SG039
Purpose: Volcano plot of fold change versus statistical significance.

*//*** HELP END ***/

%macro SG039;
title "SG039:Volcano Plot";

data volcano;
  length gene $10 sig_cat $20 label_gene $10;

  gene="GENE001"; log2fc=1.80;  p_value=0.0005; link calc; output;
  gene="GENE002"; log2fc=1.45;  p_value=0.0030; link calc; output;
  gene="GENE003"; log2fc=1.20;  p_value=0.0120; link calc; output;
  gene="GENE004"; log2fc=0.95;  p_value=0.0200; link calc; output;
  gene="GENE005"; log2fc=0.60;  p_value=0.0400; link calc; output;
  gene="GENE006"; log2fc=0.30;  p_value=0.1800; link calc; output;
  gene="GENE007"; log2fc=-0.20; p_value=0.6500; link calc; output;
  gene="GENE008"; log2fc=-0.55; p_value=0.0900; link calc; output;
  gene="GENE009"; log2fc=-1.10; p_value=0.0180; link calc; output;
  gene="GENE010"; log2fc=-1.45; p_value=0.0040; link calc; output;
  gene="GENE011"; log2fc=-1.90; p_value=0.0008; link calc; output;
  gene="GENE012"; log2fc=2.20;  p_value=0.0001; link calc; output;
  gene="GENE013"; log2fc=1.70;  p_value=0.0080; link calc; output;
  gene="GENE014"; log2fc=1.05;  p_value=0.0300; link calc; output;
  gene="GENE015"; log2fc=0.85;  p_value=0.0700; link calc; output;
  gene="GENE016"; log2fc=0.40;  p_value=0.3000; link calc; output;
  gene="GENE017"; log2fc=0.10;  p_value=0.8500; link calc; output;
  gene="GENE018"; log2fc=-0.35; p_value=0.4200; link calc; output;
  gene="GENE019"; log2fc=-0.90; p_value=0.0600; link calc; output;
  gene="GENE020"; log2fc=-1.25; p_value=0.0200; link calc; output;
  gene="GENE021"; log2fc=-1.60; p_value=0.0060; link calc; output;
  gene="GENE022"; log2fc=-2.10; p_value=0.0003; link calc; output;
  gene="GENE023"; log2fc=2.50;  p_value=0.0002; link calc; output;
  gene="GENE024"; log2fc=1.35;  p_value=0.0150; link calc; output;
  gene="GENE025"; log2fc=0.75;  p_value=0.1100; link calc; output;
  gene="GENE026"; log2fc=0.15;  p_value=0.7200; link calc; output;
  gene="GENE027"; log2fc=-0.15; p_value=0.7600; link calc; output;
  gene="GENE028"; log2fc=-0.70; p_value=0.1300; link calc; output;
  gene="GENE029"; log2fc=-1.05; p_value=0.0450; link calc; output;
  gene="GENE030"; log2fc=-1.80; p_value=0.0020; link calc; output;
  gene="GENE031"; log2fc=1.10;  p_value=0.0490; link calc; output;
  gene="GENE032"; log2fc=1.55;  p_value=0.0070; link calc; output;
  gene="GENE033"; log2fc=2.00;  p_value=0.0010; link calc; output;
  gene="GENE034"; log2fc=0.50;  p_value=0.2500; link calc; output;
  gene="GENE035"; log2fc=0.05;  p_value=0.9100; link calc; output;
  gene="GENE036"; log2fc=-0.45; p_value=0.3300; link calc; output;
  gene="GENE037"; log2fc=-1.15; p_value=0.0350; link calc; output;
  gene="GENE038"; log2fc=-1.55; p_value=0.0090; link calc; output;
  gene="GENE039"; log2fc=-2.30; p_value=0.0004; link calc; output;
  gene="GENE040"; log2fc=2.10;  p_value=0.0007; link calc; output;
  gene="GENE041"; log2fc=1.25;  p_value=0.0250; link calc; output;
  gene="GENE042"; log2fc=0.90;  p_value=0.0800; link calc; output;
  gene="GENE043"; log2fc=0.35;  p_value=0.5000; link calc; output;
  gene="GENE044"; log2fc=-0.05; p_value=0.9300; link calc; output;
  gene="GENE045"; log2fc=-0.50; p_value=0.2100; link calc; output;
  gene="GENE046"; log2fc=-0.95; p_value=0.0550; link calc; output;
  gene="GENE047"; log2fc=-1.30; p_value=0.0170; link calc; output;
  gene="GENE048"; log2fc=-1.75; p_value=0.0050; link calc; output;
  gene="GENE049"; log2fc=1.65;  p_value=0.0065; link calc; output;
  gene="GENE050"; log2fc=-2.00; p_value=0.0015; link calc; output;

  stop;

  calc:
    neglog10p = -log10(p_value);

    if p_value < 0.05 and log2fc >= 1 then sig_cat = "Up";
    else if p_value < 0.05 and log2fc <= -1 then sig_cat = "Down";
    else sig_cat = "Not significant";

    if p_value < 0.01 and abs(log2fc) >= 1.5 then label_gene = gene;
    else label_gene = "";

    return;
run;


ods graphics / 
               noborder
               noscale
               width=745 px
               height=510 px
               attrpriority=none
               imagefmt=png
;
ods proclabel="SG039:Volcano Plot";

proc sgplot data=volcano noborder;
  scatter x=log2fc y=neglog10p /
    group=sig_cat
    markerattrs=(symbol=circlefilled size=8)
    transparency=0.2
    datalabel=label_gene;

  refline -1 1 / axis=x lineattrs=(pattern=shortdash);
  refline 1.30103 / axis=y lineattrs=(pattern=shortdash);

  xaxis label="log2 Fold Change";

  yaxis label="-log10(p-value)" ;

  keylegend / title="Category";
run;

ods proclabel="SG039:Volcano Plot";
proc odstext;
p'data(*ESC*){unicode "00A0"x}volcano;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}length(*ESC*){unicode "00A0"x}gene(*ESC*){unicode "00A0"x}$10(*ESC*){unicode "00A0"x}sig_cat(*ESC*){unicode "00A0"x}$20(*ESC*){unicode "00A0"x}label_gene(*ESC*){unicode "00A0"x}$10;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE001";(*ESC*){unicode "00A0"x}log2fc=1.80;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0005;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE002";(*ESC*){unicode "00A0"x}log2fc=1.45;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0030;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE003";(*ESC*){unicode "00A0"x}log2fc=1.20;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0120;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE004";(*ESC*){unicode "00A0"x}log2fc=0.95;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0200;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE005";(*ESC*){unicode "00A0"x}log2fc=0.60;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0400;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE006";(*ESC*){unicode "00A0"x}log2fc=0.30;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.1800;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE007";(*ESC*){unicode "00A0"x}log2fc=-0.20;(*ESC*){unicode "00A0"x}p_value=0.6500;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE008";(*ESC*){unicode "00A0"x}log2fc=-0.55;(*ESC*){unicode "00A0"x}p_value=0.0900;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE009";(*ESC*){unicode "00A0"x}log2fc=-1.10;(*ESC*){unicode "00A0"x}p_value=0.0180;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE010";(*ESC*){unicode "00A0"x}log2fc=-1.45;(*ESC*){unicode "00A0"x}p_value=0.0040;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE011";(*ESC*){unicode "00A0"x}log2fc=-1.90;(*ESC*){unicode "00A0"x}p_value=0.0008;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE012";(*ESC*){unicode "00A0"x}log2fc=2.20;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0001;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE013";(*ESC*){unicode "00A0"x}log2fc=1.70;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0080;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE014";(*ESC*){unicode "00A0"x}log2fc=1.05;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0300;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE015";(*ESC*){unicode "00A0"x}log2fc=0.85;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0700;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE016";(*ESC*){unicode "00A0"x}log2fc=0.40;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.3000;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE017";(*ESC*){unicode "00A0"x}log2fc=0.10;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.8500;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE018";(*ESC*){unicode "00A0"x}log2fc=-0.35;(*ESC*){unicode "00A0"x}p_value=0.4200;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE019";(*ESC*){unicode "00A0"x}log2fc=-0.90;(*ESC*){unicode "00A0"x}p_value=0.0600;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE020";(*ESC*){unicode "00A0"x}log2fc=-1.25;(*ESC*){unicode "00A0"x}p_value=0.0200;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE021";(*ESC*){unicode "00A0"x}log2fc=-1.60;(*ESC*){unicode "00A0"x}p_value=0.0060;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE022";(*ESC*){unicode "00A0"x}log2fc=-2.10;(*ESC*){unicode "00A0"x}p_value=0.0003;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE023";(*ESC*){unicode "00A0"x}log2fc=2.50;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0002;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE024";(*ESC*){unicode "00A0"x}log2fc=1.35;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0150;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE025";(*ESC*){unicode "00A0"x}log2fc=0.75;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.1100;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE026";(*ESC*){unicode "00A0"x}log2fc=0.15;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.7200;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE027";(*ESC*){unicode "00A0"x}log2fc=-0.15;(*ESC*){unicode "00A0"x}p_value=0.7600;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE028";(*ESC*){unicode "00A0"x}log2fc=-0.70;(*ESC*){unicode "00A0"x}p_value=0.1300;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE029";(*ESC*){unicode "00A0"x}log2fc=-1.05;(*ESC*){unicode "00A0"x}p_value=0.0450;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE030";(*ESC*){unicode "00A0"x}log2fc=-1.80;(*ESC*){unicode "00A0"x}p_value=0.0020;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE031";(*ESC*){unicode "00A0"x}log2fc=1.10;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0490;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE032";(*ESC*){unicode "00A0"x}log2fc=1.55;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0070;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE033";(*ESC*){unicode "00A0"x}log2fc=2.00;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0010;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE034";(*ESC*){unicode "00A0"x}log2fc=0.50;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.2500;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE035";(*ESC*){unicode "00A0"x}log2fc=0.05;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.9100;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE036";(*ESC*){unicode "00A0"x}log2fc=-0.45;(*ESC*){unicode "00A0"x}p_value=0.3300;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE037";(*ESC*){unicode "00A0"x}log2fc=-1.15;(*ESC*){unicode "00A0"x}p_value=0.0350;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE038";(*ESC*){unicode "00A0"x}log2fc=-1.55;(*ESC*){unicode "00A0"x}p_value=0.0090;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE039";(*ESC*){unicode "00A0"x}log2fc=-2.30;(*ESC*){unicode "00A0"x}p_value=0.0004;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE040";(*ESC*){unicode "00A0"x}log2fc=2.10;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0007;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE041";(*ESC*){unicode "00A0"x}log2fc=1.25;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0250;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE042";(*ESC*){unicode "00A0"x}log2fc=0.90;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0800;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE043";(*ESC*){unicode "00A0"x}log2fc=0.35;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.5000;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE044";(*ESC*){unicode "00A0"x}log2fc=-0.05;(*ESC*){unicode "00A0"x}p_value=0.9300;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE045";(*ESC*){unicode "00A0"x}log2fc=-0.50;(*ESC*){unicode "00A0"x}p_value=0.2100;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE046";(*ESC*){unicode "00A0"x}log2fc=-0.95;(*ESC*){unicode "00A0"x}p_value=0.0550;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE047";(*ESC*){unicode "00A0"x}log2fc=-1.30;(*ESC*){unicode "00A0"x}p_value=0.0170;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE048";(*ESC*){unicode "00A0"x}log2fc=-1.75;(*ESC*){unicode "00A0"x}p_value=0.0050;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE049";(*ESC*){unicode "00A0"x}log2fc=1.65;(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}p_value=0.0065;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}gene="GENE050";(*ESC*){unicode "00A0"x}log2fc=-2.00;(*ESC*){unicode "00A0"x}p_value=0.0015;(*ESC*){unicode "00A0"x}link(*ESC*){unicode "00A0"x}calc;(*ESC*){unicode "00A0"x}output;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}stop;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}calc:';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}neglog10p(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}-log10(p_value);';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}p_value(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}0.05(*ESC*){unicode "00A0"x}and(*ESC*){unicode "00A0"x}log2fc(*ESC*){unicode "00A0"x}>=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}sig_cat(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Up";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}p_value(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}0.05(*ESC*){unicode "00A0"x}and(*ESC*){unicode "00A0"x}log2fc(*ESC*){unicode "00A0"x}<=(*ESC*){unicode "00A0"x}-1(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}sig_cat(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Down";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}sig_cat(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Not(*ESC*){unicode "00A0"x}significant";';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}p_value(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}0.01(*ESC*){unicode "00A0"x}and(*ESC*){unicode "00A0"x}abs(log2fc)(*ESC*){unicode "00A0"x}>=(*ESC*){unicode "00A0"x}1.5(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}label_gene(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}gene;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}label_gene(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"";';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}return;';
p'run;';
p'';
p'';
p'ods(*ESC*){unicode "00A0"x}graphics(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}reset';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noborder';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}noscale';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}width=745(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}height=510(*ESC*){unicode "00A0"x}px';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}attrpriority=none';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}imagefmt=png';
p';';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=volcano(*ESC*){unicode "00A0"x}noborder;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}scatter(*ESC*){unicode "00A0"x}x=log2fc(*ESC*){unicode "00A0"x}y=neglog10p(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}group=sig_cat';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}markerattrs=(symbol=circlefilled(*ESC*){unicode "00A0"x}size=8)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}transparency=0.2';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}datalabel=label_gene;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}refline(*ESC*){unicode "00A0"x}-1(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}axis=x(*ESC*){unicode "00A0"x}lineattrs=(pattern=shortdash);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}refline(*ESC*){unicode "00A0"x}1.30103(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}axis=y(*ESC*){unicode "00A0"x}lineattrs=(pattern=shortdash);';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxis(*ESC*){unicode "00A0"x}label="log2(*ESC*){unicode "00A0"x}Fold(*ESC*){unicode "00A0"x}Change";';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxis(*ESC*){unicode "00A0"x}label="-log10(p-value)"(*ESC*){unicode "00A0"x};';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}keylegend(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}title="Category";';
p'run;';
run;
title ;
%mend;
