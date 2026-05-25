/*** HELP START ***//*

Macro: Pharma_Graph_Gallery
Purpose: Execute existing SG001 to SG100 macros.

*//*** HELP END ***/

%macro Pharma_Graph_Gallery;

  %local i mac;

  %do i = 1 %to 100;
    %let mac = SG%sysfunc(putn(&i,z3.));

    %if %sysmacexist(&mac) %then %do;
      %&mac;
    %end;
  %end;

%mend Pharma_Graph_Gallery;
