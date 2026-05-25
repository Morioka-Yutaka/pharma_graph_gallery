/*** HELP START ***//*

Macro: SG040
Purpose: Bubble plot of categorical change from baseline by visit and treatment group.

*//*** HELP END ***/

%macro SG040;
title "SG040:Bubble Plot";
data adlb_mock;
    call streaminit(123);

    length usubjid $12 trt01p $20 paramcd $8 avisit $20 chgcat $20;

    do subj = 1 to 180;

        usubjid = cats("SUBJ", put(subj, z3.));

        if rand("uniform") < 0.5 then trt01p = "Placebo";
        else trt01p = "Active Drug";

        paramcd = "ALT";
        base = rand("normal", 30, 8);

        do avisitn = 1 to 5;

            select (avisitn);
                when (1) avisit = "Week 2";
                when (2) avisit = "Week 4";
                when (3) avisit = "Week 8";
                when (4) avisit = "Week 12";
                when (5) avisit = "Week 24";
                otherwise avisit = "Other";
            end;

            if trt01p = "Placebo" then
                chg = rand("normal", 1, 12);
            else
                chg = rand("normal", -4, 12);

            if chg < -20 then chgcat = "< -20";
            else if chg < -10 then chgcat = "-20 to < -10";
            else if chg < 0 then chgcat = "-10 to < 0";
            else if chg < 10 then chgcat = "0 to < 10";
            else if chg < 20 then chgcat = "10 to < 20";
            else chgcat = ">= 20";

            output;
        end;
    end;
run;

data adlb_mock2;
    set adlb_mock;

    select (chgcat);
        when ("< -20")        chgcatn = 1;
        when ("-20 to < -10") chgcatn = 2;
        when ("-10 to < 0")   chgcatn = 3;
        when ("0 to < 10")    chgcatn = 4;
        when ("10 to < 20")   chgcatn = 5;
        when (">= 20")        chgcatn = 6;
        otherwise             chgcatn = .;
    end;
run;

proc summary data=adlb_mock2 nway;
    class avisitn avisit chgcatn chgcat trt01p;
    var chg;
    output out=bubble_sum(drop=_type_ _freq_)
        n = n_subject
        mean = mean_chg;
run;

data bubble_sum2;
    set bubble_sum;

    if trt01p = "Placebo" then avisitn_plot = avisitn - 0.15;
    else if trt01p = "Active Drug" then avisitn_plot = avisitn + 0.15;
    else avisitn_plot = avisitn;

    label
        avisitn_plot = "Visit"
        chgcatn      = "Change from Baseline Category"
        n_subject    = "Number of Subjects";
run;

ods proclabel="SG040:Bubble Plot";
proc sgplot data=bubble_sum2 noborder;
    bubble x=avisitn_plot
           y=chgcatn
           size=n_subject
           / group=trt01p
             transparency=0.25
             bradiusmin=2
             bradiusmax=18
             datalabel=n_subject
             datalabelpos=top
;

    xaxis label="Visit"
          values=(1 2 3 4 5)
          valuesdisplay=("Week 2" "Week 4" "Week 8" "Week 12" "Week 24")
          offsetmin=0.1 offsetmax=0.1
          integer;

    yaxis label="Change from Baseline Category"
          values=(1 2 3 4 5 6)
          valuesdisplay=("< -20"
                         "-20 to < -10"
                         "-10 to < 0"
                         "0 to < 10"
                         "10 to < 20"
                         ">= 20");

    keylegend / title="Treatment Group";

run;

ods proclabel="SG040:Bubble Plot";
proc odstext;
p'data(*ESC*){unicode "00A0"x}adlb_mock;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}call(*ESC*){unicode "00A0"x}streaminit(123);';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}length(*ESC*){unicode "00A0"x}usubjid(*ESC*){unicode "00A0"x}$12(*ESC*){unicode "00A0"x}trt01p(*ESC*){unicode "00A0"x}$20(*ESC*){unicode "00A0"x}paramcd(*ESC*){unicode "00A0"x}$8(*ESC*){unicode "00A0"x}avisit(*ESC*){unicode "00A0"x}$20(*ESC*){unicode "00A0"x}chgcat(*ESC*){unicode "00A0"x}$20;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}subj(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}180;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}usubjid(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}cats("SUBJ",(*ESC*){unicode "00A0"x}put(subj,(*ESC*){unicode "00A0"x}z3.));';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}rand("uniform")(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}0.5(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}trt01p(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Placebo";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}trt01p(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Active(*ESC*){unicode "00A0"x}Drug";';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}paramcd(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"ALT";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}base(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",(*ESC*){unicode "00A0"x}30,(*ESC*){unicode "00A0"x}8);';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}do(*ESC*){unicode "00A0"x}avisitn(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}5;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}select(*ESC*){unicode "00A0"x}(avisitn);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}when(*ESC*){unicode "00A0"x}(1)(*ESC*){unicode "00A0"x}avisit(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Week(*ESC*){unicode "00A0"x}2";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}when(*ESC*){unicode "00A0"x}(2)(*ESC*){unicode "00A0"x}avisit(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Week(*ESC*){unicode "00A0"x}4";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}when(*ESC*){unicode "00A0"x}(3)(*ESC*){unicode "00A0"x}avisit(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Week(*ESC*){unicode "00A0"x}8";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}when(*ESC*){unicode "00A0"x}(4)(*ESC*){unicode "00A0"x}avisit(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Week(*ESC*){unicode "00A0"x}12";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}when(*ESC*){unicode "00A0"x}(5)(*ESC*){unicode "00A0"x}avisit(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Week(*ESC*){unicode "00A0"x}24";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}otherwise(*ESC*){unicode "00A0"x}avisit(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Other";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}trt01p(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Placebo"(*ESC*){unicode "00A0"x}then';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}chg(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",(*ESC*){unicode "00A0"x}1,(*ESC*){unicode "00A0"x}12);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}chg(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}rand("normal",(*ESC*){unicode "00A0"x}-4,(*ESC*){unicode "00A0"x}12);';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}chg(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}-20(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}chgcat(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"<(*ESC*){unicode "00A0"x}-20";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}chg(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}-10(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}chgcat(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"-20(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}-10";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}chg(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}0(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}chgcat(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"-10(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}0";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}chg(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}10(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}chgcat(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"0(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}10";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}chg(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}20(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}chgcat(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"10(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}20";';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}chgcat(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}">=(*ESC*){unicode "00A0"x}20";';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'run;';
p'';
p'data(*ESC*){unicode "00A0"x}adlb_mock2;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}adlb_mock;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}select(*ESC*){unicode "00A0"x}(chgcat);';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}when(*ESC*){unicode "00A0"x}("<(*ESC*){unicode "00A0"x}-20")(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}chgcatn(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}1;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}when(*ESC*){unicode "00A0"x}("-20(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}-10")(*ESC*){unicode "00A0"x}chgcatn(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}2;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}when(*ESC*){unicode "00A0"x}("-10(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}0")(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}chgcatn(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}3;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}when(*ESC*){unicode "00A0"x}("0(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}10")(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}chgcatn(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}4;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}when(*ESC*){unicode "00A0"x}("10(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}20")(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}chgcatn(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}5;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}when(*ESC*){unicode "00A0"x}(">=(*ESC*){unicode "00A0"x}20")(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}chgcatn(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}6;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}otherwise(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}chgcatn(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}.;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}end;';
p'run;';
p'';
p'proc(*ESC*){unicode "00A0"x}summary(*ESC*){unicode "00A0"x}data=adlb_mock2(*ESC*){unicode "00A0"x}nway;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}class(*ESC*){unicode "00A0"x}avisitn(*ESC*){unicode "00A0"x}avisit(*ESC*){unicode "00A0"x}chgcatn(*ESC*){unicode "00A0"x}chgcat(*ESC*){unicode "00A0"x}trt01p;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}var(*ESC*){unicode "00A0"x}chg;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}output(*ESC*){unicode "00A0"x}out=bubble_sum(drop=_type_(*ESC*){unicode "00A0"x}_freq_)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}n(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}n_subject';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}mean(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}mean_chg;';
p'run;';
p'';
p'data(*ESC*){unicode "00A0"x}bubble_sum2;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}set(*ESC*){unicode "00A0"x}bubble_sum;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}trt01p(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Placebo"(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}avisitn_plot(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}avisitn(*ESC*){unicode "00A0"x}-(*ESC*){unicode "00A0"x}0.15;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}if(*ESC*){unicode "00A0"x}trt01p(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Active(*ESC*){unicode "00A0"x}Drug"(*ESC*){unicode "00A0"x}then(*ESC*){unicode "00A0"x}avisitn_plot(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}avisitn(*ESC*){unicode "00A0"x}+(*ESC*){unicode "00A0"x}0.15;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}else(*ESC*){unicode "00A0"x}avisitn_plot(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}avisitn;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}label';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}avisitn_plot(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Visit"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}chgcatn(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Change(*ESC*){unicode "00A0"x}from(*ESC*){unicode "00A0"x}Baseline(*ESC*){unicode "00A0"x}Category"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}n_subject(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}=(*ESC*){unicode "00A0"x}"Number(*ESC*){unicode "00A0"x}of(*ESC*){unicode "00A0"x}Subjects";';
p'run;';
p'';
p'proc(*ESC*){unicode "00A0"x}sgplot(*ESC*){unicode "00A0"x}data=bubble_sum2(*ESC*){unicode "00A0"x}noborder;';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}bubble(*ESC*){unicode "00A0"x}x=avisitn_plot';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}y=chgcatn';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}size=n_subject';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}group=trt01p';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}transparency=0.25';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}bradiusmin=2';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}bradiusmax=18';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}datalabel=n_subject';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}datalabelpos=top';
p';';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}xaxis(*ESC*){unicode "00A0"x}label="Visit"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}values=(1(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}3(*ESC*){unicode "00A0"x}4(*ESC*){unicode "00A0"x}5)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}valuesdisplay=("Week(*ESC*){unicode "00A0"x}2"(*ESC*){unicode "00A0"x}"Week(*ESC*){unicode "00A0"x}4"(*ESC*){unicode "00A0"x}"Week(*ESC*){unicode "00A0"x}8"(*ESC*){unicode "00A0"x}"Week(*ESC*){unicode "00A0"x}12"(*ESC*){unicode "00A0"x}"Week(*ESC*){unicode "00A0"x}24")';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}offsetmin=0.1(*ESC*){unicode "00A0"x}offsetmax=0.1';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}integer;';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}yaxis(*ESC*){unicode "00A0"x}label="Change(*ESC*){unicode "00A0"x}from(*ESC*){unicode "00A0"x}Baseline(*ESC*){unicode "00A0"x}Category"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}values=(1(*ESC*){unicode "00A0"x}2(*ESC*){unicode "00A0"x}3(*ESC*){unicode "00A0"x}4(*ESC*){unicode "00A0"x}5(*ESC*){unicode "00A0"x}6)';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}valuesdisplay=("<(*ESC*){unicode "00A0"x}-20"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}"-20(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}-10"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}"-10(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}0"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}"0(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}10"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}"10(*ESC*){unicode "00A0"x}to(*ESC*){unicode "00A0"x}<(*ESC*){unicode "00A0"x}20"';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}">=(*ESC*){unicode "00A0"x}20");';
p'';
p'(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}(*ESC*){unicode "00A0"x}keylegend(*ESC*){unicode "00A0"x}/(*ESC*){unicode "00A0"x}title="Treatment(*ESC*){unicode "00A0"x}Group";';
p'';
p'run;';

run;
title;
%mend;
