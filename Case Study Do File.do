//Childhood Asthma Case Study

**# Cleanup
//Missing responses were not assigned values for most questions in this dataset, so the cleanup should be easy
//The only variable that needs to be cleaned for missing values is b74abwt since it has the value 3 representing missing responses
tab b74abwt
mvdecode b74abwt, mv (3)
tab b74abwt
//e46dog has an error in one of the data points entered so that needs to be removed
tab e46dog
mvdecode e46dog, mv (22)
tab e46dog

//Creating a variable asthma to not get confused with the varible case and cases/controls outputted in tables
tab case
gen asthma = 0 if case == 0
replace asthma = 1 if case == 1
label variable asthma "Child diagnosed with asthma"
label define yn12 0 "0. No" 1 "1. Yes"
label values asthma yn12
tab asthma

//Need to change the values for weight from 1 and 2 into 0 and 1 for later when running OR
tab b74abwt
gen weight = 0 if b74abwt == 1
replace weight = 1 if b74abwt == 2
label variable weight "Child weight"
label define wt 0 "0. Average" 1 "1. Small/Very Small"
label values weight wt
tab weight

//Create a new age variable with only 2 categories to run ORs
tab p02age
gen age = 0 if p02age <7
replace age = 1 if p02age >= 7
label variable age "Child age 2 categories"
label define age01 0 "0. 2-6.5 years old" 1 "1. 7-14 years old"
label values age age01
tab age

//Assigning each varible that is binary and has unlabeled values No and Yes for greater ease
label values fasthay yn12
label values e52mold yn12
label values b68cough yn12
label values b68wheez yn12
label values b68bp yn12
label values e46cat yn12
label values e46dog yn12
label values e46goat yn12
label values e48cockroach yn12
label values e48rats yn12

**# Creating the table for part 1a
//Use --, chi2 column cell-- to get chi2 values, total percentages for each case/control exposure, and totoal percentages for each individual outcome and exposure
//To get exposure variable on the left and case variable on the top do --tab (exposure) (case)--
tab p03sex case, chi2 column cell
tab age asthma, chi2 column cell
tab fasthay asthma, chi2 column cell
tab e52mold asthma, chi2 column cell
tab weight asthma, chi2 column cell
tab b68cough asthma, chi2 column cell
tab b68wheez asthma, chi2 column cell
tab b68bp asthma, chi2 column cell
tab e46cat asthma, chi2 column cell
tab e46dog asthma, chi2 column cell
tab e46goat asthma, chi2 column cell
tab e48cockroach asthma, chi2 column cell
tab e48rats asthma, chi2 column cell

**# Creating the table for part 2a
//Odds ratio (case-control study)
//Stata flips tables for MOAs so to get exposure variable on the left and disease variable on the top you need to do --cc (case) (exposure)--
cc asthma p03sex
cc asthma age
cc asthma fasthay
cc asthma e52mold
cc asthma weight
cc asthma b68cough
cc asthma b68wheez
cc asthma b68bp
cc asthma e46cat
cc asthma e46dog
cc asthma e46goat
cc asthma e48cockroach
cc asthma e48rats

**# Creating the table for part 3a
//Do --, by(e52mold)-- to stratify by mold
//inlcude pool at the end to get pooled M-H
cc asthma p03sex, by(e52mold) pool
cc asthma age, by(e52mold) pool
cc asthma fasthay, by(e52mold) pool
cc asthma weight, by(e52mold) pool
cc asthma b68cough, by(e52mold) pool
cc asthma b68wheez, by(e52mold) pool
cc asthma b68bp, by(e52mold) pool
cc asthma e46cat, by(e52mold) pool
cc asthma e46dog, by(e52mold) pool
cc asthma e46goat, by(e52mold) pool
cc asthma e48cockroach, by(e52mold) pool
cc asthma e48rats, by(e52mold) pool