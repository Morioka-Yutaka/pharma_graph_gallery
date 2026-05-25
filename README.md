# pharma_graph_gallery
Pharma_Graph_Gallery is a SAS package that provides a gallery of reusable graph SAS-code for pharmaceutical and clinical trial data visualization.  
<img width="359" height="359" alt="pharma_graph_gallery_small" src="https://github.com/user-attachments/assets/adc1b56f-fa8d-4719-a715-73f4b41b961e" />

## `%pharma_graph_gallery` macro <a name="pharmagraphgallery-macro-1"></a> ######

Macro: Pharma_Graph_Gallery
Purpose: Show All Graphs and Codes.

~~~sas
%pharma_graph_gallery
~~~

  
---
 
## `%sg001` <a name="sg001-macro-2"></a> ######
### Time-course plot of mean plus-minus SD in a single group.

<img width="576" height="309" alt="image" src="https://github.com/user-attachments/assets/917af268-6d24-4151-92bf-40c0a47b6aa6" />

~~~sas
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 10;
        do i = 1 to 10;
            subjid=cats(trtan,"-",i);
            if trtan=1 then AVAL = rand("normal",110,3);
            else AVAL = rand("normal",100,2);
            output;
        end;
    end;
end;
run;
proc summary data=wk1 nway;
    class AVISITN;
    var AVAL;
    output out=wk2 mean= std= /autoname;
run;
data sds;
    set wk2;
    if n(AVAL_Mean,AVAL_Stddev) = 2 then upper = AVAL_Mean + AVAL_Stddev;
    if n(AVAL_Mean,AVAL_Stddev) = 2 then lower = AVAL_Mean - AVAL_Stddev;
run;
ods graphics / 
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=sds noautolegend noborder;
    series x=AVISITN y=AVAL_Mean / markers markerattrs=(symbol=circlefilled color=blue size=9) lineattrs=(pattern=solid color=blue thickness=1) ;
    scatter x=AVISITN y=AVAL_Mean / yerrorupper=upper yerrorlower=lower errorbarattrs=(color=blue )markerattrs = (size=0);
    inset "Mean+-SD"/position=bottomright  ;
 
    xaxis offsetmin=0.05 offsetmax=0.05 values=(1 to 10 ) labelattrs=(size=10) label="Analisys Visit" type=discrete;
    yaxis offsetmax=0.05 labelattrs=(size=10) values=(90 to 120 by 5) label ="Analysis Value";
 
run ;

~~~
  
---
 
## `%sg002` <a name="sg002-macro-3"></a> ######
### Time-course plot of mean plus-minus SD by group.
<img width="584" height="310" alt="image" src="https://github.com/user-attachments/assets/044978e1-ada0-446e-81fb-b6b3cc7e7f9c" />

~~~sas
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 10;
        do i = 1 to 10;
            subjid=cats(trtan,"-",i);
            if trtan=1 then AVAL = rand("normal",110,3);
            else AVAL = rand("normal",100,2);
            output;
        end;
    end;
end;
run;
proc summary data=wk1 nway;
    class TRTAN AVISITN;
    var AVAL;
    output out=wk2 mean= std= /autoname;
run;
data sds;
    set wk2;
    if n(AVAL_Mean,AVAL_Stddev) = 2 then upper = AVAL_Mean + AVAL_Stddev;
    if n(AVAL_Mean,AVAL_Stddev) = 2 then lower = AVAL_Mean - AVAL_Stddev;
run;
 
proc format ;
value TRTAN 1="Active" 2="Placebo";
run;
 
proc sgplot data=sds noautolegend noborder;
    styleattrs datacontrastcolors=(blue red)
                  datacolors=(blue red)
                  datalinepatterns=(solid dash)
                  datasymbols=(circle circlefilled);   
 
    series x=AVISITN y=AVAL_Mean / group=TRTAN groupdisplay=cluster clusterwidth=0.1 markers markerattrs=( size=9) lineattrs=( thickness=1) name="series";
    scatter x=AVISITN y=AVAL_Mean /group=TRTAN groupdisplay=cluster clusterwidth=0.1 yerrorupper=upper yerrorlower=lower markerattrs = (size=0);
    inset "Mean+-SD"/position=bottomright  ;
 
    keylegend "series"/title=""  location=inside position=topright across=1 noborder;
 
    xaxis offsetmin=0.05 offsetmax=0.05 values=(1 to 10 ) labelattrs=(size=10) label="Analisys Visit" type=discrete;
    yaxis offsetmax=0.05 labelattrs=(size=10) values=(90 to 120 by 5) label ="Analysis Value";
format TRTAN TRTAN.;
run ;
~~~
---
 
## `%sg003` macro <a name="sg003-macro-4"></a> ######

Macro: SG003
Purpose: Spaghetti plot of individual time-course profiles in a single group.

<img width="608" height="325" alt="image" src="https://github.com/user-attachments/assets/bcaaf142-d6c1-445c-b84d-8b0a74b370d9" />

~~~sas
data wk1;
call streaminit(777);
do TRTAN=1,2;
    do AVISITN= 1 to 10;
        do i = 1 to 10;
            subjid=cats(trtan,"-",i);
            if trtan=1 then AVAL = rand("normal",110,3);
            else AVAL = rand("normal",110,2);
            output;
        end;
    end;
end;
run;
 
ods graphics / 
               noborder
               noscale
               width=780 px
               height=410 px
               attrpriority=none
               imagefmt=png
;
proc sgplot data=wk1 noautolegend noborder;
    series x=AVISITN y=AVAL /group=SUBJID markers markerattrs=(symbol=circlefilled color=blue size=5) lineattrs=(pattern=solid color=blue thickness=1) ;
 
    xaxis offsetmin=0.05 offsetmax=0.05 values=(1 to 10 ) labelattrs=(size=10) label="Analisys Visit" type=linear;
    yaxis offsetmax=0.05 labelattrs=(size=10) values=(90 to 120 by 5) label ="Analysis Value";
 
run ;
~~~
  
---
 
## `%sg004` <a name="sg004-macro-5"></a> ######
### Spaghetti plot of individual time-course profiles by group.

  
---
 
## `%sg005()` macro <a name="sg005-macro-6"></a> ######

Macro: SG005
Purpose: Spider plot of change from baseline by group.

  
---
 
## `%sg006()` macro <a name="sg006-macro-7"></a> ######

Macro: SG006
Purpose: Semi-logarithmic line plot of mean plus SD over time.

  
---
 
## `%sg007()` macro <a name="sg007-macro-8"></a> ######

Macro: SG007
Purpose: Time-course plot of mean plus-minus SD by treatment group with discontinuation shown separately.

  
---
 
## `%sg008()` macro <a name="sg008-macro-9"></a> ######

Macro: SG008
Purpose: Scatter plot of two parameters by sex with a reference line.

  
---
 
## `%sg009()` macro <a name="sg009-macro-10"></a> ######

Macro: SG009
Purpose: Forest plot of point estimates and confidence intervals.

  
---
 
## `%sg010()` macro <a name="sg010-macro-11"></a> ######

Macro: SG010
Purpose: Kaplan-Meier plot of survival probability over time.

  
---
 
## `%sg011()` macro <a name="sg011-macro-12"></a> ######

Macro: SG011
Purpose: Waterfall plot of subject-level change from baseline.

  
---
 
## `%sg012()` macro <a name="sg012-macro-13"></a> ######

Macro: SG012
Purpose: Scatter plot of individual values and overall mean plus-minus SD by visit.

  
---
 
## `%sg013()` macro <a name="sg013-macro-14"></a> ######

Macro: SG013
Purpose: Clustered bar chart of rates by type and treatment group.

  
---
 
## `%sg014()` macro <a name="sg014-macro-15"></a> ######

Macro: SG014
Purpose: Clustered bar chart of change from baseline with 95% confidence intervals over time by category.

  
---
 
## `%sg015()` macro <a name="sg015-macro-16"></a> ######

Macro: SG015
Purpose: Line plot of adjusted mean change from baseline with standard error over time by treatment group.

  
---
 
## `%sg016()` macro <a name="sg016-macro-17"></a> ######

Macro: SG016
Purpose: Reverse Kaplan-Meier plot of follow-up distribution over time.

  
---
 
## `%sg017()` macro <a name="sg017-macro-18"></a> ######

Macro: SG017
Purpose: Box plot of analysis values over visits by treatment group.

  
---
 
## `%sg018()` macro <a name="sg018-macro-19"></a> ######

Macro: SG018
Purpose: Box plot with overlaid beeswarm points.

  
---
 
## `%sg019()` macro <a name="sg019-macro-20"></a> ######

Macro: SG019
Purpose: Violin plot of distribution by group.

  
---
 
## `%sg020()` macro <a name="sg020-macro-21"></a> ######

Macro: SG020
Purpose: Raincloud plot showing distribution, box summary, and individual values.

  
---
 
## `%sg022()` macro <a name="sg022-macro-22"></a> ######

Macro: SG022
Purpose: Subject-level profile plot in a crossover study.

  
---
 
## `%sg023()` macro <a name="sg023-macro-23"></a> ######

Macro: SG023
Purpose: eDISH scatter plot of liver enzyme and bilirubin abnormalities.

  
---
 
## `%sg024()` macro <a name="sg024-macro-24"></a> ######

Macro: SG024
Purpose: Swimmer plot of subject-level treatment duration and events.

  
---
 
## `%sg025()` macro <a name="sg025-macro-25"></a> ######

Macro: SG025
Purpose: ROC curve of sensitivity versus false positive rate.

  
---
 
## `%sg026()` macro <a name="sg026-macro-26"></a> ######

Macro: SG026
Purpose: Power model plot of pharmacokinetic exposure versus dose.

  
---
 
## `%sg027()` macro <a name="sg027-macro-27"></a> ######

Macro: SG027
Purpose: Funnel plot of effect estimate versus standard error.

  
---
 
## `%sg028()` macro <a name="sg028-macro-28"></a> ######

Macro: SG028
Purpose: Funnel plot of effect estimate versus precision.

  
---
 
## `%sg029()` macro <a name="sg029-macro-29"></a> ######

Macro: SG029
Purpose: Heatmap of missing data patterns.

  
---
 
## `%sg030()` macro <a name="sg030-macro-30"></a> ######

Macro: SG030
Purpose: Lollipop plot of values by category.

  
---
 
## `%sg033()` macro <a name="sg033-macro-31"></a> ######

Macro: SG033
Purpose: Scatter plot with a broken X-axis.

  
---
 
## `%sg034()` macro <a name="sg034-macro-32"></a> ######

Macro: SG034
Purpose: Kaplan-Meier plot with confidence band and median survival droplines.

  
---
 
## `%sg035()` macro <a name="sg035-macro-33"></a> ######

Macro: SG035
Purpose: Pareto plot of counts and cumulative percentage.

  
---
 
## `%sg036()` macro <a name="sg036-macro-34"></a> ######

Macro: SG036
Purpose: Bland-Altman plot of measurement difference versus measurement mean.

  
---
 
## `%sg037()` macro <a name="sg037-macro-35"></a> ######

Macro: SG037
Purpose: Scatter plot with regression line within the data range.

  
---
 
## `%sg038()` macro <a name="sg038-macro-36"></a> ######

Macro: SG038
Purpose: Scatter plot with regression line extended over the axis range.

  
---
 
## `%sg039()` macro <a name="sg039-macro-37"></a> ######

Macro: SG039
Purpose: Volcano plot of fold change versus statistical significance.

  
---
 
## `%sg040()` macro <a name="sg040-macro-38"></a> ######

Macro: SG040
Purpose: Bubble plot of categorical change from baseline by visit and treatment group.

  
---
