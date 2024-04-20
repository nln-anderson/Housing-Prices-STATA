* Determining how many sales took place in each month
count if salemonth==1
count if salemonth==2
count if salemonth==3

* Determining how many dist	ZIP codes are in the dataset
sort zip
egen area_zip= group(zip)           
sum area_zip

sort zip
egen no_zip_month1= group(zip)  if salemonth==1         
sum no_zip_month1

sort zip
egen no_zip_month2= group(zip)  if salemonth==2         
sum no_zip_month2

sort zip
egen no_zip_month3= group(zip)  if salemonth==3         
sum no_zip_month3

* Dropping outliers
drop if soldprice<200000
drop if lotarea<600

* Create descriptive statistics table
sum soldprice beds pr_age salemonth saleyear livingarea baths lotarea yearbuilt
outreg2 using "C:\Users\nolio\OneDrive\Documents\ECON370\PS8\DescStats.doc", replace sum(log) keep(soldprice beds pr_age salemonth saleyear livingarea baths lotarea yearbuilt) label

* Comparing soldprice to normal distribution
kdensity soldprice, normal

* Creating new variable for the log of soldprice
gen lnsoldprice=ln(soldprice)
sum lnsoldprice
rename lnsoldprice lnpr

* Creating livingarea squared variable
gen livingarea2=(livingarea)^2
sum livingarea2

* Creating property age variable squared
gen pr_age2=(pr_age)^2
sum pr_age2

* First regression
reg lnpr livingarea livingarea2 pr_age pr_age2 beds baths lotarea, robust
r2_a

outreg2 using "C:\Users\nolio\OneDrive\Documents\ECON370\PS8\Regression1.doc", bracket bdec(3) sdec(3) label addstat(Adjusted R-Squared, e(r2_a), Root MSE, e(rmse)) replace adec(3) title (Problem Set 2)

* Time-fixed effects / dummy-variables
gen january=1 if salemonth==1
replace january=0 if january==.
gen february=1 if salemonth==2
replace february=0 if february==.
gen march=1 if salemonth==3
replace march=0 if march==.

* Regression with time fixed effects
reg lnpr livingarea livingarea2 pr_age pr_age2 beds baths lotarea january february march, robust
r2_a

reg lnpr livingarea livingarea2 pr_age pr_age2 beds baths lotarea i.zipcode, robust

* Final Regression
reg lnpr livingarea livingarea2 pr_age pr_age2 beds baths lotarea i.salemonth i.zipcode, robust

* Checking for multicollinearity
corr lnpr livingarea livingarea2 pr_age pr_age2 beds baths lotarea salemonth zipcode
vif

reg lnpr livingarea pr_age beds baths lotarea, robust
corr lnpr livingarea pr_age beds baths lotarea
vif

reg lnpr pr_age baths lotarea, robust
reg lnpr pr_age beds lotarea, robust
reg lnpr livingarea pr_age lotarea, robust

* Free of multicollinearity and heteroskadsticity <- definitely spelled that wrong
reg lnpr livingarea pr_age lotarea i.zipcode i.salemonth, robust

outreg2 using "C:\Users\nolio\OneDrive\Documents\ECON370\PS8\Regression.doc", bracket bdec(3) sdec(3) label addstat(Adjusted R-Squared, e(r2_a), Root MSE, e(rmse)) replace adec(3) title (Problem Set 2)

predict resid1, resid
predict yhat, xb

twoway(scatter resid1 yhat) (lfit resid1 yhat), yline(0) ///
title("Visual: Comparison of Residuals and Predicted Sales Price") ///
xtitle(Predicted Sales Price (ln)) ytitle(Residuals) legend(off)

kdensity lnpr, normal 
kdensity livingarea, normal 
kdensity pr_age, normal 
kdensity lotarea, normal 

