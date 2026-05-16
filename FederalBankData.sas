libname mis "~/MIS445";
data mis.gdp_raw;
    infile "~/MIS445/MIS445FRED-realGDP.csv"
        dsd
        firstobs=11
        truncover;

    length observation_date $10;
    input observation_date :$10. gdp_growth;

    date = input(observation_date, yymmdd10.);
    format date yymmdd10.;

    drop observation_date;
run;
proc contents data=mis.gdp_raw;
run;
proc means data=mis.gdp_raw n mean median std min q1 q3 max;
    var gdp_growth;
run;
title "Real U.S. GDP Growth Rate (Quarterly)";
proc sgplot data=mis.gdp_raw;
    series x=date y=gdp_growth;
    refline 0 / axis=y;
    xaxis label="Date";
    yaxis label="Percent";
run;
title;
ods listing gpath="~/MIS445";
ods graphics / reset imagename="gdp_graph" imagefmt=png;

title "Real U.S. GDP Growth Rate (Quarterly)";
proc sgplot data=mis.gdp_raw;
    series x=date y=gdp_growth;
    refline 0 / axis=y;
run;
title;
