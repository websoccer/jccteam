* Encoding: UTF-8.
comment chapters syntax for Detroit 2018 study. 

weight wf.
frequencies variables = area subarea subarea clor cclor10a ownrent headage ccage1 sex1 jsex cfamily jhhc anydiv anywid inc ccinc50 cocr inter synmem jccmem member chabad cajed
	         ajed sleep yg hillel cgoisr famfed quafed emotion donate ccamtfed.

weight wf. 
frequencies sex1 cj1.
weight off.

weight wf.
mult response groups =
	      sage 'age distribution' (sage1 sage2 sage3 sage4 sage5 sage6 sage7 (1,20))
	      sex (sex1 sex2 sex3 sex4 sex5 sex6 sex7 (1,2))	
	      /tables = sage by sex (paired)

********************************************************************************************************************************************************************.
comment chapter 2.
********************************************************************************************************************************************************************.
Comment Table 2-1 Current Size of the Jewish Community.
weight wf.
frequencies variables = area subarea city.
print formats hhsiz (f8.6).
means tables = hhsiz by area subarea.
means hhsiz.

comment I added the part Jewish to the Jews when creating Table 2-1. 
mult response groups= cj (cj1 cj2 cj3 cj4 cj5 cj6 cj7 cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,3))
         	/variables = area city (101,901)
                  /frequencies = cj
        	/tables = cj by area city
                 /base=responses
        	/cells= column.

****************************************************************************************************************************************************************************************************************.
comment chapter 3.
********************************************************************************************************************************************************************************************************************.
comment Table 3-1 Zip Table.
weight wf.
frequencies variables = zip. 
frequencies variables = zip 
         /format=dfreq.
comment Table 4-1 Zip Table.
means tables=hhsiz by zip
	        /cells mean.

weight wf.
temporary.
select if Huntwoods eq 1.

temporary.
select if OakPark eq 1.
comment ***********************************************Place of Birth.
comment Table 3-3 Place of Birth.
temporary.
select if OakPark eq 1.
select if Huntwoods eq 1.
mult response groups =  born 'place of birth' (born1 born2 born3 born4 born5 born6 born7 (-1,998))
	         cborn 'place of birth in cats' (cborn1 cborn2 cborn3 cborn4 cborn5 cborn6 cborn7 (0,998))
	         ccborn 'place of birth in cats' (ccborn1 ccborn2 ccborn3 ccborn4 ccborn5 ccborn6 ccborn7 (201,202)) 
	         /frequencies = born cborn ccborn
	         /base= responses
	         /cells = column
	         /missing = include.

comment Table 3-5 and Table 3-6 Place of Birth by area subarea and Age.
mult response groups = cborn 'place of birth in cats' (cborn1 cborn2 cborn3 cborn4 cborn5 cborn6 cborn7 (0,998)) born 'place of birth' (born1 born2 born3 born4 born5 born6 born7 (0,998))
	          age1 'age distribution' (ccage1 ccage2 ccage3 ccage4 ccage5 ccage6 ccage7 (1,6)) 
	          age2 'age eld-non-eld' (cccage1 cccage2 cccage3 cccage4 cccage5 cccage6 cccage7 (102,102)) 
           ccborn 'place of birth in cats' (ccborn1 ccborn2 ccborn3 ccborn4 ccborn5 ccborn6 ccborn7 (201,202))
           /variables = area subarea (101,105) county (0,3)
           /tables = cborn ccborn by area subarea county
	         /tables = cborn ccborn by age1 (paired)
	         /tables = cborn ccborn by age2 (paired) 
	         /base= responses
	         /cells = column
	         /missing = include.

comment ********************************************************************************************** FSU, Citizenship, LGBTQ, Months.
comment Citizenship for text.
weight wf.
frequencies citizen citizen2.

comment Table 3-8.
frequencies fsu.
temporary.
select if (fsu eq 1).
descriptives hhsiz.

comment Table 3-9.
missing values lgbt (8 9).
frequencies lgbt.

comment Table 3-11.
frequencies months cmonths.

comment *********************************************************************************************************Geographic Locations.
comment Table 3-12. 
frequencies variables = lbefor clbefor cclbefor. 

comment *************************************************Length of Residence.
comment Table 3-14 Length of Residence at the Current Address.
temporary.
*select if OakPark eq 1.
select if Huntwoods eq 1.
crosstabs tables = area subarea by clorca 
	         /cells = row.

comment Table 3-15 Own Rent.
crosstabs tables = area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr synmem chabad jccmem  member by ownrent
	         /cells = row.

comment Table 3-17 Length of Residence in Local area.
crosstabs tables =  area subarea headage cheadage cfamily cinc ccinc50 cocr synmem chabad jccmem  member by clor 
     	   /cells = row.

comment Table 3-20 Profile of New Residents Part I.
*crosstabs tables = area subarea headage profilefamily cinc ccinc50 profileocr inter synmem chabad jccmem member donate camtfed by cclor5
	      /cells = column.

comment Table 3-20 Employment Status Section of New Resident Profile - Part II.
*mult response groups = emp 'employ' (cemp1 cemp2 cemp3 cemp4 cemp5 cemp6 cemp7 (101,108))
	        /variables = cclor5 (1,2)
	        /tables = emp by cclor5
        	/base=responses
        	/cells= column.

comment ************************************************************************Moving.
comment Table 3-20 Plans to Move.
crosstabs tables = area subarea cclor10a headage cheadage cfamily cinc ccinc50 by move
	      /cells = row.

comment Table 3-22 Plans to Move by area subarea.
weight wf.
crosstabs tables = wmove by area subarea ccage1
	      /cells = column.

comment Table 4-24 and text.
weight wf.
frequencies variables = defmove probmove.

comment ************************************************************************Local Adult Children.
comment Table 4-27 Local Adult Children for 50 and over table.
crosstabs tables = area subarea cclor10a cclor20 ccage1 cccage1 cfamily cinc ccinc50 by aclocal
	      /cells = row.

*weight off.
*crosstabs tables = area subarea cclor10a cclor20 ccage1 cccage1 cfamily cinc ccinc50 by aclocal
	         /cells = count.
weight wf.
comment Table 3-27. 
missing values wac2 (98).
frequencies ac wac2.


weight wf.
comment ____________________________________________________________________________attend college in Michigan.
comment Table 3-28 Attend College in Michigan.
frequencies mcol.
crosstabs tables = area subarea subarea cclor10a age1849 cccage1 sex1 cfamily cinc cocr inter by mcol
                     /cells = row.

frequencies wcol.
weight wf.
crosstabs tables = wcol by age1849
         /cells = column.

weight wf.
comment ____________________________________________________________________________Place of Work.
comment does work by zip code, too much detail so did not use.
crosstabs tables = zip by zipwork.
crosstabs tables = city by zipwork.

frequencies zipwork.

compute workWF = WF.
compute workwf = workwf *1.083574388.
weight workwf.
crosstabs tables = city2 by citywork
    /cells =count.
weight wf.
crosstabs tables = city2 by citywork
    /cells = column.
crosstabs tables = city2 by citywork
    /cells = row.
crosstabs tables = city2 by citywork
    /cells = count.


*******************************************************************************************************************************************************************************************************************.
comment chapter 4.
*******************************************************************************************************************************************************************************************************************.
weight wf.
comment Table 4-1 Age by Sex.

mult response groups =
	      age   'age distribution' (cage1 cage2 cage3 cage4 cage5 cage6 cage7 cagec1 cagec2 cagec3 cagec4 cagec5 cagec6 cagec7 cagec8 cagec9 (1,20))
	      sage 'age distribution' (sage1 sage2 sage3 sage4 sage5 sage6 sage7 sagec1 sagec2 sagec3 sagec4 sagec5 sagec6 sagec7 sagec8 sagec9 (1,20))
	      sex (sex1 sex2 sex3 sex4 sex5 sex6 sex7 sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))	
                        /frequencies age sage
                        /tables = age by sex (paired) 
	      /tables = sage by sex (paired)
	      /base = responses
	      /cells = total.

comment Table 4-12 Age by Jewish Status.
mult response groups =
 	       age 'age distribution' (cage1 cage2 cage3 cage4 cage5 cage6 cage7 cagec1 cagec2 cagec3 cagec4 cagec5 cagec6 cagec7 cagec8 cagec9 (1,20))
	       sage 'age distribution' (sage1 sage2 sage3 sage4 sage5 sage6 sage7 sagec1 sagec2 sagec3 sagec4 sagec5 sagec6 sagec7 sagec8 sagec9 (1,20)) 
        	       cj 'Currently Jewish' (cj1 cj2 cj3 cj4 cj5 cj6 cj7 newcjc1 newcjc2 newcjc3 newcjc4 newcjc5 newcjc6 newcjc7 newcjc8 newcjc9  (1,3))
                         cjpart 'Part Jewish Separate' (cj1 cj2 cj3 cj4 cj5 cj6 cj7 cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,3))     
        	/tables = age by cj (paired)
        	/tables = sage by cj  (paired)
        	/base = responses
        	/cells = column.

comment Table 4-12 Age by Jewish Status to separate out part Jewish children.
mult response groups = sage 'age distribution' (sage1 sage2 sage3 sage4 sage5 sage6 sage7 sagec1 sagec2 sagec3 sagec4 sagec5 sagec6 sagec7 sagec8 sagec9 (1,20)) 
        	cj  'Currently Jewish' (cj1 cj2 cj3 cj4 cj5 cj6 cj7 cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,3))  
                 age 'age distribution' (cage1 cage2 cage3 cage4 cage5 cage6 cage7 cagec1 cagec2 cagec3 cagec4 cagec5 cagec6 cagec7 cagec8 cagec9 (1,20))
        	/tables = age sage by cj (paired)
        	/base = responses
        	/cells = row.

comment for Table 4-17 take percentages from later tables.

comment Table 4-18 to 4-20 Age.
mult response groups =
	        age '  age distribution' (cage1 cage2 cage3 cage4 cage5 cage6 cage7 cagec1 cagec2 cagec3 cagec4 cagec5 cagec6 cagec7 cagec8 cagec9 (1,20))
	        sage 'age distribution' (sage1 sage2 sage3 sage4 sage5 sage6 sage7 sagec1 sagec2 sagec3 sagec4 sagec5 sagec6 sagec7 sagec8 sagec9 (1,20)) 
                          /variables = area subarea (101,999)
                         /tables = age by area subarea 
         /tables = sage by area subarea 
        	/base = responses
        	/cells = column.

comment Table 4-21 Age Groups 
recode subarea (sysmis = 999).
frequencies subarea.
missing values subarea ().
mult response groups = nage 'age distribution' (nage1 nage2 nage3 nage4 nage5 nage6 nage7 nagec1 nagec2 nagec3 nagec4 nagec5 nagec6 nagec7 nagec8 nagec9 (1,20))
	         mage 'age distribution' (mage1 mage2 mage3 mage4 mage5 mage6 mage7 magec1 magec2 magec3 magec4 magec5 magec6 magec7 magec8 magec9 (1,20))
	         /variables = area (101,102) subarea (101,999)
	         /tables = nage by area subarea
	         /tables = mage by area subarea
                    /base=responses
         	/cells= row.
missing values subarea (999).

comment Table 4-22 to 4-23 Age by Jewish Identification. 
mult response groups = 
	        age  'age distribution'  (ccage1 ccage2 ccage3 ccage4 ccage5 ccage6 ccage7 ccagec1 ccagec2 ccagec3 ccagec4 ccagec5 ccagec6 ccagec7 ccagec8 ccagec9 (1,20))
	        /variables = cocr (101,108)
	        /tables = age by cocr 
	        /base=responses
	        /cells= column.

comment Table 4-22 to 4-23 Age by Membership. 
mult response groups = 
	        age  'age distribution'  (ccage1 ccage2 ccage3 ccage4 ccage5 ccage6 ccage7 ccagec1 ccagec2 ccagec3 ccagec4 ccagec5 ccagec6 ccagec7 ccagec8 ccagec9 (1,20))
	        /variables = synmem (1,2) chabad (1,2) member (1,2) jccmem (1,2)
	        /tables = age by synmem 
	       	/tables = age by chabad
        	/tables = age by jccmem
	        /tables = age by member
	        /base=responses
	        /cells= column.

comment Age for PJ Library Age Groups. 
*mult response groups =
	pjage '  age distribution' (pjage1 pjage2 pjage3 pjage4 pjage5 pjage6 pjage7 pjagec1 pjagec2 pjagec3 pjagec4 pjagec5 pjagec6 pjagec7 pjagec8 pjagec9 (1,20))
            /variables = area subarea (101,900)
         /frequencies pjage
            /tables = pjage by area subarea 
        	/base = responses
        	/cells = column.

comment Table 4-24 Household Size by Number of Persons (1, 2, 3, etc).
weight wf.
crosstabs tables = area subarea cocr synmem chabad jccmem  member by chhsiz
	        /cells= row.

comment Table 4-24 Average Household Size.
print formats hhsiz (f8.2).
means tables = hhsiz by  area subarea cocr synmem chabad jccmem  member.

print formats hhsiz (f8.2).
comment to rerun 2005.
means tables = hhsiz by  city.

comment Table 4-25 Household Structure.
frequencies variables = family cfamily profilefamily.

comment Table 4-31  Household Structure by area subarea.
crosstabs tables = family profilefamily by area subarea 
        /cells= column.

comment Table 4-32 Geographic Distribution of Household Structure by Rows.
crosstabs tables = cfamily by area subarea 
        /cells= row.

comment Table 4-33 Household Structure by Jewish Identification.
crosstabs tables = profilefamily by cocr  
        /cells= column.

comment Table 4-34 Working Parents Kids. 
crosstabs tables = nchild12 by latch
      	/cells = count. 

comment Table 4-35 Kids in Single Parent Household.
temporary.
select if ANY(family,101,102,103,802).
crosstabs tables = nchild by family
         /cells = count.

comment Table 4-34 Kids in Divorced Household.
crosstabs tables = nchild by divor_hh
	        /cells = count.

comment *************************************************************** Marital Status Section.
comment Table 4-36 Marital Status by Jewish Status.
mult response groups = mar 'marital status' (mar1 mar2 mar3 mar4 mar5 mar6 mar7 (101,108))
        	cj 'Currently Jewish' (cj1 cj2 cj3 cj4 cj5 cj6 cj7 (1,2))
        /frequencies mar
	       /tables = mar by cj (paired)
        /base=responses
        /cells= column.

comment Table 4-38  Marital Status by area subarea.
mult response groups = mar 'marital status' (mar1 mar2 mar3 mar4 mar5 mar6 mar7 (101,108))
        	/variables= area subarea (101,900)
        	/tables = mar by area subarea 
        	/base=responses
        	/cells= column.

comment Table 4-39 Marital Status by Sex.
mult response groups = mar 'marital status' (mar1 mar2 mar3 mar4 mar5 mar6 mar7 (101,108 ))
	        sex (sex1 sex2 sex3 sex4 sex5 sex6 sex7 (1,2)) 
	        /tables = mar by sex (paired)
        	/base=responses
        	/cells= column.

comment Table 4-40 Marital Status by Age.
mult response groups = mar 'marital status' (mar1 mar2 mar3 mar4 mar5 mar6 mar7 (101,108))
	         age 'age distribution' (ccage1 ccage2 ccage3 ccage4 ccage5 ccage6 ccage7 (1,120))  
	         age2 'age eld-non' (cccage1 cccage2 cccage3 cccage4 cccage5 cccage6 cccage7 (102,102))
	         /tables = mar by age (paired)
	         /tables = mar by age2 (paired)
        	/base=responses
        	/cells= column.

comment Table 4-41 Marital Status for Males by Age.
mult response groups = mar 'marital status' (mar1 mar2 mar3 mar4 mar5 mar6 mar7 (101,108))
	      sex (sex1 sex2 sex3 sex4 sex5 sex6 sex7 (1,1)) 
	      age 'age distribution' (ccage1 ccage2 ccage3 ccage4 ccage5 ccage6 ccage7 (1,120))  
	      age2 'age eld-non' (cccage1 cccage2 cccage3 cccage4 cccage5 cccage6 cccage7 (102,102))
     	 /tables = mar by age by sex (paired)
     	 /tables = mar by age2 by sex (paired)
       /base=responses
       /cells= column.

comment Table 4-42 Marital Status for Females by Age.
mult response groups = mar 'marital status' (mar1 mar2 mar3 mar4 mar5 mar6 mar7 (101,108))
	        sex (sex1 sex2 sex3 sex4 sex5 sex6 sex7 (2,2)) 
	        age 'age distribution' (ccage1 ccage2 ccage3 ccage4 ccage5 ccage6 ccage7 (1,120))  
	        age2 'age eld-non' (cccage1 cccage2 cccage3 cccage4 cccage5 cccage6 cccage7 (102,102))
     	   /tables = mar by age by sex (paired)
     	   /tables = mar by age2 by sex (paired)
        	/base=responses
        	/cells= column.

comment ******************************************************************Singles Section. 
comment Table 4-43 
comment 	input just the 10 NUMBERS, not percentages by age and by sex  IRA TO DO.
weight wf.
mult response groups = 
	        cmar (ccmar1 ccmar2 ccmar3 ccmar4 ccmar5 ccmar6 ccmar7 (201,201))
	        sex (sex1 sex2 sex3 sex4 sex5 sex6 sex7 (1,2)) 
	        age (ccage1 ccage2 ccage3 ccage4 ccage5 ccage6 ccage7 (1,120))
	        cj   'Jewish' (cj1 cj2 cj3 cj4 cj5 cj6 cj7 (1,1))
     	   /tables = cmar by age by sex by cj (paired)
        	/base=responses
        	/cells= column.

comment *************************************************************** Secular Education Section.
comment Table 4-44 Degree by Jewish Status.
temporary.
*select if OakPark eq 1.
select if Huntwoods eq 1.
mult response groups = deg 'degree' (deg1 deg2 deg3 deg4 deg5 deg6 deg7 (1,17))
	        cedage 'Age distribution with 18-24 and 25+'  (cedage1 cedage2 cedage3 cedage4 cedage5 cedage6 cedage7 (2,2))
	        cj 'Currently Jewish' (cj1 cj2 cj3 cj4 cj5 cj6 cj7 (1,3))
         /tables = deg by cedage (paired)
	        /tables = deg by cj by cedage (paired)
         /base=responses
         /cells= column.

comment Table 4-46 Degree by area subarea.
weight wf.
mult response groups = deg 'degree' (deg1 deg2 deg3 deg4 deg5 deg6 deg7 (1,17)) cdeg 'degree' (cdeg1 cdeg2 cdeg3 cdeg4 cdeg5 cdeg6 cdeg7 (101,104))
		        cedage 'Age Distribution with 18-24 and 25+'  (cedage1 cedage2 cedage3 cedage4 cedage5 cedage6 cedage7 (2,2))
        	 /variables= area subarea (101,900)
        	 /tables = deg by area by cedage (paired)
        	 /tables = cdeg by subarea by cedage (paired)
        	 /base=responses
        	 /cells= column.

comment Table 4-47 Degree by Sex.
mult response groups = deg 'degree' (deg1 deg2 deg3 deg4 deg5 deg6 deg7 (1,17))
	         cedage 'Age distribution with 18-24 and 25+'  (cedage1 cedage2 cedage3 cedage4 cedage5 cedage6 cedage7 (2,2))
	         sex (sex1 sex2 sex3 sex4 sex5 sex6 sex7 (1,2)) 
	         /tables = deg by sex by cedage (paired)
        	/base=responses
        	/cells= column.

comment Table 4-48 Degree by Age.
weight wf.
mult response groups = deg 'degree' (deg1 deg2 deg3 deg4 deg5 deg6 deg7 (1,17))
	         edage 'Age distribution with 18-24 separate'  (edage1 edage2 edage3 edage4 edage5 edage6 edage7 (1,6))
	         age2 'age eld-non' (cccage1 cccage2 cccage3 cccage4 cccage5 cccage6 cccage7 (102,102))
	         /tables = deg by edage (paired)
	         /tables = deg by age2 (paired)
          /base=responses
        	/cells= column.

comment Table 4-49 Degree for Males by Age.
mult response groups = deg 'degree' (deg1 deg2 deg3 deg4 deg5 deg6 deg7 (1,17))
         sex (sex1 sex2 sex3 sex4 sex5 sex6 sex7 (1,1)) 
	        edage 'Age distribution with 18-24 separate'  (edage1 edage2 edage3 edage4 edage5 edage6 edage7 (1,6))
	        age2 'age eld-non' (cccage1 cccage2 cccage3 cccage4 cccage5 cccage6 cccage7 (102,102))
     	   /tables = deg by edage by sex (paired)
     	   /tables = deg by age2 by sex (paired)
        	/base=responses
        	/cells= column.

comment Table 4-50 Degrees for Females by Age.
mult response groups = deg 'degree' (deg1 deg2 deg3 deg4 deg5 deg6 deg7 (1,17))
	         sex (sex1 sex2 sex3 sex4 sex5 sex6 sex7 (2,2)) 
	         edage 'Age distribution with 18-24 separate'  (edage1 edage2 edage3 edage4 edage5 edage6 edage7 (1,6))
	         age2 'age eld-non' (cccage1 cccage2 cccage3 cccage4 cccage5 cccage6 cccage7 (102,102))
     	     /tables = deg by edage by sex (paired)
     	     /tables = deg by age2 by sex (paired)
        	  /base=responses
        	 /cells= column.

comment *************************************************************** Employment Status Section.
comment Table 4-51 Employment Status by Jewish Status.
mult response groups = emp 'employ' (cemp1 cemp2 cemp3 cemp4 cemp5 cemp6 cemp7 (101,108))
	         cj 'Currently Jewish' (cj1 cj2 cj3 cj4 cj5 cj6 cj7 (1,2))
          /frequencies emp
	         /tables = emp by cj (paired)
        	 /base=responses
        	 /cells= column.

comment Table 4-54 Employment Status by Geographic area subarea.
mult response groups = emp 'employ' (cemp1 cemp2 cemp3 cemp4 cemp5 cemp6 cemp7 (101,108))
        	/variables= area subarea(101,900)
        	/tables = emp by area subarea 
        	/base=responses
        	/cells= column.

comment Table 4-55 Employment Status by Sex.
mult response groups = emp 'employ' (cemp1 cemp2 cemp3 cemp4 cemp5 cemp6 cemp7 (101,108))
	         sex (sex1 sex2 sex3 sex4 sex5 sex6 sex7 (1,2)) 
         	/tables = emp by sex (paired)
        	/base=responses
        	/cells= column.

comment Table 4-56 Employment Status by Age.
mult response groups = emp 'employ' (cemp1 cemp2 cemp3 cemp4 cemp5 cemp6 cemp7 (101,108))
	         age 'age distribution' (ccage1 ccage2 ccage3 ccage4 ccage5 ccage6 ccage7 (1,120))  
	         age2 'age eld-non' (cccage1 cccage2 cccage3 cccage4 cccage5 cccage6 cccage7 (102,102))
	         /tables = emp by age (paired)
	         /tables = emp by age2 (paired)
        	/base=responses
        	/cells= column.

comment Table 4-57 Employment Status for Males by Age.
mult response groups = emp 'employ' (cemp1 cemp2 cemp3 cemp4 cemp5 cemp6 cemp7 (101,108))
         sex (sex1 sex2 sex3 sex4 sex5 sex6 sex7 (1,1)) 
	        age 'age distribution' (ccage1 ccage2 ccage3 ccage4 ccage5 ccage6 ccage7 (1,120))  
	        age2 'age eld-non' (cccage1 cccage2 cccage3 cccage4 cccage5 cccage6 cccage7 (102,102))
     	   /tables = emp by age by sex (paired)
     	   /tables = emp by age2 by sex (paired)
        	/base=responses
        	/cells= column.

comment Table 4-58 Employment Status for Females by Age.
mult response groups = emp 'employ' (cemp1 cemp2 cemp3 cemp4 cemp5 cemp6 cemp7 (101,108))
	         sex (sex1 sex2 sex3 sex4 sex5 sex6 sex7 (2,2)) 
	         age 'age distribution' (ccage1 ccage2 ccage3 ccage4 ccage5 ccage6 ccage7 (1,120))  
	         age2 'age eld-non' (cccage1 cccage2 cccage3 cccage4 cccage5 cccage6 cccage7 (102,102))
     	    /tables = emp by age by sex (paired)
     	    /tables = emp by age2 by sex (paired)
        	 /base=responses
        	 /cells= column.

comment *************************************************************** Income Section.
comment Table 4-59.
frequencies cinc inc100.

comment tables 4-60 to 4-70.

crosstabs tables = inc by area subarea cclor10a ownrent headage cheadage cfamily cocr synmem chabad jccmem  member 
         /cells = column.

comment Table 4-71 Poverty.
frequencies poverty.

comment Table 4-72. Elderly Poverty.
temporary.
select if (range(nelder65,1,7)).
frequencies poverty.
 
comment household financial situation Table 4-76.
crosstabs tables = area subarea cclor10a ownrent headage cheadage cfamily  cinc ccinc50 cocr synmem chabad jccmem  member by finsit 
         /cells = row.



***********************************comment for the text of Chapter 4 *****************************************************************.
weight wf.
frequencies jhhc.

comment for the income section text.
comment this is for the under and over $100,000 discussion on income.
weight wf.
missing values inc ().
recode inc (sysmis = 9).
weight wf.
temporary.
select if inc eq 9.
frequencies inc100.
missing values inc (9).
weight wf.

comment for profile of low income.
temporary.
select if cinc eq 101.
frequencies area city ownrent  headage cheadage profilefamily  profileocr inter synmem chabad jccmem  member cgoisr donate camtfed.


temporary.
select if poverty eq 1.
means hhsiz.

temporary. 
select if (range(nelder65,1,7)) and (poverty eq 1).
means hhsiz.

frequencies nelder2.

********************************************************************************************************************************************************************.
comment chapter 5.
********************************************************************************************************************************************************************.
comment for percentage of households see crosstabs tables = area subarea cclor10a ccage1 cfamily inter synmem chabad jccmem  member ccamtfed by cocr
	below and use the total from the area subarea table.

weight wf.
comment Table 5-1 Jewish Identification Household Size - Part I.

frequencies cocr profileocr.
print formats hhsiz (f8.4).
means tables = hhsiz by profileocr.

comment for Pew Comps.
frequencies proud.
weight wf.
temporary.
select if range(age1,18,29).
frequencies ocr impjew proud belong special. 

comment Table 5-1 Jewish Identification - Percentage Jewish -  Part II.
weight wf.
mult response groups= cj  (cj1 cj2 cj3 cj4 cj5 cj6 cj7 cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,3))  
         	/variables = cocr (101,105) profileocr  (101,900) 
          /tables = cj by cocr profileocr 
        	 /base=responses
        	 /cells= column.

comment Table 5-2: Jewish Identification.
weight wf.
crosstabs tables = area subarea cclor10a ccage1 cccage1 jsex cfamily cinc ccinc50 inter synmem chabad jccmem  member cajed ajed  sleep yg hillel cgoisr donate ccamtfed party2  by profileocr
            /cells = row.

comment Tables 5-3 Jewish Identification by Rows.
crosstabs tables = cocr by area 
          /cells = row.

comment Tables 5-4 Jewish Identification by age by Rows, first command is for the all row.
crosstabs tables = cocr by ccage1 
         /cells = row.

comment Table 5-10 Importance of Being Jewish.
crosstabs tables = area subarea ccage1  cccage1 sex1 cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr  donate ccamtfed  party2 by impjew
         /cells = row.

comment Table 5-12 Belong.
crosstabs tables = area subarea ccage1  cccage1 sex1 cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr  donate ccamtfed  party2 by belong
         /cells = row.

comment Table 5-12 Special.
crosstabs tables =  area subarea ccage1  cccage1 sex1 cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr  donate ccamtfed party2 by special
         /cells = row.

comment Table 5-13.
frequencies proud.

comment Table 5-14.
frequencies mezz seder hancan tree fcan oth_sab kosherin kout lights .

comment Table 5-15 Practice.
crosstabs tables = area subarea headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr  donate ccamtfed  by practice
          /cells = row.

weight wf.
comment Table 5-17 Mezuzah.
crosstabs tables = area subarea ownrent headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr  donate ccamtfed  by mezz
         /cells = row.

comment Table 5-19 Seder. 
crosstabs tables = area subarea headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed  by seder
	         /cells = row.

comment Table 5-21 Chanukah Candles. 
crosstabs tables = area subarea headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed  by hancan
	         /cells = row.

weight wf.
comment Table 5-23 Sabbath Candles. 
crosstabs tables = area subarea headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed  by fcan
         /cells = row.

weight wf.
comment Table 5-25 Special Sabbath Observance. 
crosstabs tables = area subarea headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed  by oth_sab
	        /cells = row.

comment Table 5-26 Kosher. 
crosstabs tables = area subarea headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed  by kosherin kout
	      /cells = row.

comment Table 5-28 Electricity.  NO CROSSTABS TABLE FOR THIS ONE until we see size of percentage.
crosstabs tables = area subarea headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed  by lights
	      /cells = row.

comment Table 5-30 Christmas Tree.
crosstabs  area subarea headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed  by tree
	      /cells = row.

comment Table 5-32 Synagogue Attendance.
crosstabs tables = area subarea cclor10a ccage1  cccage1 jsex cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed by cattend
	      /cells = row.

comment Table 5-35 Intermarriage by Age.
*Weight wf.
*crosstabs tables = inter by headage cheadage
         /cells = count.

WEIGHT wF.
comment Table 5-35 Intermarriage by Age.
crosstabs tables = inter by headage cheadage
	         /cells = column.

comment Table 5-36 Intermarriage.

crosstabs tables =  area subarea cclor10a  cfamily cinc ccinc50 ccinc100 cocr synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed by inter
         /cells = row.

comment use this to check sample sizes.
*weight off.
*crosstabs tables = headage cheadage  area subarea cclor10a cfamily cinc ccinc50 ccinc100 cocr synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed by inter
         /cells = count.
*weight wf.

weight wf.
comment Table 5-39 Children Raised.
mult response groups= bjc 'child born jewish'(bjc1 bjc2 bjc3 bjc4 bjc5 bjc6 bjc7 bjc8 bjc9  (1,9))
          cjc 'child currently jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,9))
          /variables = inter (1,3) 
          /tables = cjc by inter 
          /base=responses
          /cells= column.


weight wf.
comment Table 5-40 Children Raised.
comment use the percentages in the YES row.
mult response groups= cjc 'child currently jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,9))
          /variables = inter (1,3) 
    /tables = cjc by inter
     /base=responses
     /cells= row.

comment Table 5-41 take number of children from Table 4-16 and divide by number of all children in Table 4-1.

comment Table 5-42 take from Table 2-1.

comment Table 5-43 and Text Jews by Choice.
mult response groups= conv 'Person Converted' (conv1 conv2 conv3 conv4 conv5 conv6 conv7 convc1 convc2 convc3 convc4 convc5  convc6 convc7 convc8 convc9  (1,2))
	         age 'age distribution' (ccage1 ccage2 ccage3 ccage4 ccage5 ccage6 ccage7 ccagec1 ccagec2 ccagec3 ccagec4 ccagec5 ccagec6 ccagec7 ccagec8 ccagec9 (1,20))
	         sex 'sex distribution' (sex1 sex2 sex3 sex4 sex5 sex6 sex7 sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))
          /frequencies conv
	         /tables = conv by age (paired)
	         /tables = conv by sex (paired)
     	    /base=responses
     	    /cells= column.

******************************************comment the following are for the text of Chapter 5*****************************************************.
comment to get number of traditional, renewal.
weight wf.
frequencies ocr.

comment orthodox who are shomer shabbes.
crosstabs tables = lights by cocr 
      /cells = column count.

frequencies modorth.

means tables = hhsiz by modorth.

comment Number of Jewish childen from Table 4-16.
crosstabs tables = njchild by profileocr
   	/cell = count. 

comment for the box showing the percentage of respondents who are not Jewish.
frequencies cj1.

comment adds mezuzah into the practice variable for the practice section.
frequencies pracmezz.

comment to get number of persons keep kosher in and out of house.
means tables = hhsiz by kosherin kout.

***************************************************Christmas tree for the text.
weight wf.
comment for all born Jewish (check mark 1) and all currently Jewish (check mark 2).
crosstabs tables = tree by all_brnj
         /tree by all_jews
  	      /cells = column.

comment use first column for check mark 3.
crosstabs tables = hancan by tree
         /cells = column.

comment use first row for check mark 4.
crosstabs tables = hancan by tree
         /cells = row.

comment for check mark 5.
crosstabs tables = hancan by tree
         /cells = total.

*comment for sample sizes for intermarried and fsu.
*weight off.
*frequencies interhhk fsu.

comment intermarried households with children being raised Jewish - check mark 6.
weight wf.
temporary.
select if interhhk eq 1.
frequencies tree.

comment Christmas tree in FSU households -check mark 7.
crosstabs tree by fsu
	/cells = column.

comment for number of married couples under heading Intermarriage by Age.
frequencies variables = inter.

*****************************************comment this is for summary report**********************************************************.
weight wf.
temporary.
select if cfamily ne 201.
frequencies variables = mezz seder hancan fcan  kosherin kout Lights tree .

********************************************************************************************************************************************************************.
comment chapter 6    Membership.
********************************************************************************************************************************************************************.

comment Table 6-1 Synagogue Membership.
***************************************************************.
comment Table 6-1.


frequencies synmem synpart jccmem member.

weight wf.
crosstabs tables = area subarea cclor10a headage headage cheadage cfamily cinc ccinc50 cocr inter chabad  jccmem member cajed ajed  sleep yg hillel cgoisr donate ccamtfed 
         by synmem  /cells = rows.

crosstabs tables = area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad chabad  jccmem member cajed ajed sleep yg hillel cgoisr donate ccamtfed 
         by synpart  /cells = rows.

crosstabs tables = area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem jccmem member cajed ajed  sleep yg hillel cgoisr donate ccamtfed
	        by Chabad 	 /cells = rows.

crosstabs tables = area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad  member cajed ajed  sleep yg hillel cgoisr donate ccamtfed
	        by  jccmem  /cells = rows.

crosstabs tables = area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad  jccmem member cajed ajed  sleep yg hillel cgoisr donate ccamtfed
	        by partjcc   /cells = rows.

*temporary.
*select if JCCmem eq 2.
*crosstabs tables = area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem synpart chabad  jccmem member cajed ajed  sleep yg hillel cgoisr donate ccamtfed
	        by  othcc /cells = rows.

crosstabs tables = area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  cajed ajed  sleep yg hillel cgoisr donate ccamtfed
	        by member /cells = rows.

crosstabs tables = area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed  sleep yg hillel cgoisr donate ccamtfed
      	  by assoc   /cells = rows.

comment Table 6-20 Reasons for Not Joining the JCC.
*****************************************************************************************************************.
weight wf.
frequencies nojoin cnojoin.
temporary.
select if jccmem eq 2 and partjcc eq 1.
frequencies nojoin cnojoin.

comment Table 6-21 Reasons for Not Joining the JCC.
*****************************************************************************************************************.
comment TAKE Participated in a JCC Program row from Table 6-20.
weight wf.
crosstabs tables = area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad member famjcc donate ccamtfed by cnojoin
          /cells = row.

*weight off.
*crosstabs tables = area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad member famjcc donate ccamtfed by cnojoin
      /cells = count.

comment Table 6-29 Overlap Between Synagogue and JCC Membership.
***********************************************************************************.
weight wf.
crosstabs tables =  jccmem by synmem
      /cells = total.

comment Table 6-33 Jewish Organization Membership in Households Who Are Not Synagogue members.
**********************************************************************************************************************************.
weight wf.
temporary.
select if (synmem eq 2 and jccmem eq 2).
frequencies member.

comment Table 6-33 Profiles of Members of Synagogue, Chabad, JCC Members, Jewish Organizations.
************************************************************************************************************************************.
crosstabs tables = area city clor headage profilefamily cinc profileocr mezz cseder chancan cfcan kosherin kout lights ctree
          ccattend aded othered cultural inter partjcc partloc profileajed sleep yg hillel cgoisr emotion donate camtfed cjchar1 cnjchar1 by synmem chabad jccmem member
          /cells = columns.

crosstabs tables = synmem by chabad  jccmem member 
         /cells = columns.

crosstabs tables = chabad by synmem  jccmem member 
         /cells = columns.

crosstabs tables =  jccmem by synmem chabad member 
         /cells = columns.

crosstabs tables = member by synmem chabad jccmem  
         /cells = columns.

comment Table 6-34 Feel a Part of the Local Jewish Community.
**************************************************************************.
crosstabs tables = area subarea cclor10a ccage1  cccage1 jsex cfamily cinc ccinc50 cocr inter interhhk synmem chabad jccmem  member cajed ajed  sleep yg hillel cgoisr donate ccamtfed by partloc
         	/cells = row.

comment Table 6-36 Overall Involvement.
**************************************************************************.
crosstabs tables = area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed  sleep yg hillel cgoisr donate ccamtfed by alljew
         /cells = rows.

comment for the text of Chapter 6.
**************************************************************************.
comment for Participate in Chabad checkmarks.
temporary.
select if ((synmem eq 2) and (jccmem eq 2)).
frequencies chabad.
temporary.
select if (assoc eq 2).
frequencies chabad.

frequencies outreach partchabad partaish partwell.
weight wf.
temporary.
select if ((partaish eq 2) or (partchabad eq 2)).
mult response groups =
	      sage 'age distribution' (sage1 sage2 sage3 sage4 sage5 sage6 sage7 sagec1 sagec2 sagec3 sagec4 sagec5 sagec6 sagec7 sagec8 sagec9 (1,20))
                    age   'age distribution' (cage1 cage2 cage3 cage4 cage5 cage6 cage7 cagec1 cagec2 cagec3 cagec4 cagec5 cagec6 cagec7 cagec8 cagec9 (1,20))
                        /frequencies age sage
	      /base = responses
	      /cells = total.

weight wf.
temporary.
select if ((partaish eq 3) or (partchabad eq 3) or (partwell eq 3)).
mult response groups =
	      sage 'age distribution' (sage1 sage2 sage3 sage4 sage5 sage6 sage7 sagec1 sagec2 sagec3 sagec4 sagec5 sagec6 sagec7 sagec8 sagec9 (1,20))
                    age   'age distribution' (cage1 cage2 cage3 cage4 cage5 cage6 cage7 cagec1 cagec2 cagec3 cagec4 cagec5 cagec6 cagec7 cagec8 cagec9 (1,20))
                        /frequencies age sage
	      /base = responses
	      /cells = total.


comment 16,191 households are total for these variables since only asked of half the sample.
comment Chabad is given 2,110 as total participation
comment Aish participation is 571 + 291 or 862 divided by 16,191 is 5.3%.
comment The Well participation is 1084 divided by 16,191 is 6.7%

********************************************************************************************************************************************************************.
comment chapter 7    Adult Jewish Education.
********************************************************************************************************************************************************************.

COMMENT PRINT THIS CHAPTER OUTPUT IN LANDSCAPE.

*********************************************************************.
comment adult jewish education and day school as a child.
*********************************************************************.
weight wf.
comment Table 7-1 Adult Jewish Education.
***************************************************.
crosstabs tables = area subarea ccage1  cccage1 sex1 cocr inter synmem chabad jccmem member donate ccamtfed
	         by profileajed  /cells = rows.

weight wf.
crosstabs tables = ccage1  cccage1 by profileajed by sex1 
         /cells = row.

comment Table 7-4 Informal Jewish Education.
***************************************************.
crosstabs tables = area subarea ccage1 cccage1 sex1 cocr inter synmem chabad jccmem  member donate ccamtfed
	        by sleep yg hillel jcolcourse  /cells = rows.

crosstabs tables = ccage1  cccage1 by sleep yg hillel jcolcourse by sex1
         /cells = rows.

comment Table 7-8 Adult Jewish Education.
***************************************************.
crosstabs tables = area subarea ccage1 cccage1 sex1 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed
	         by aded othered cultural   /cells = rows.

crosstabs tables = ccage1 cccage1 by aded othered cultural by sex1
         /cells = rows.

********************************************************************************************************************************************************************.
comment chapter 8    Children Jewish Education.
********************************************************************************************************************************************************************.

***********************************************************************.
comment Table 8-4. children's preschool education. done for Jewish chidlren, not part Jewish
***********************************************************************.
weight wf.
mult response groups = pre 'attend preschool' (pre1 pre2 pre3 pre4 pre5 pre6 pre7 pre8 pre9 (101,103)) cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1))
                  /tables = pre by cjc (paired)
        	/base=responses
	/cells= column.

mult response groups = pre 'attend preschool' (pre1 pre2 pre3 pre4 pre5 pre6 pre7 pre8 pre9 (101,103)) sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))
         	cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1))
        	/variables= ccocr (101,201) area subarea (101,900) cinc (101,105) ccinc50 (101,105) ccinc100 (101,105) cocr (101,105) inter (1,9) synmem (1,2) chabad (1,2) jccmem (1,2) member (1,2) donate (1,3) camtfed (-1,9) 
        	/tables = ccocr area subarea by pre by cjc (paired)  /sex by pre by cjc (paired) /cinc ccinc50 ccinc100 by pre by cjc (paired) /cocr by pre by cjc (paired) /inter by pre by cjc (paired)    
         	/synmem by pre by cjc (paired) /chabad by pre by cjc (paired)  /jccmem by pre by cjc (paired)  /member by pre by cjc (paired) 	
                  /base=responses
                  /cells= row.
           
mult response groups = pre 'attend preschool' (pre1 pre2 pre3 pre4 pre5 pre6 pre7 pre8 pre9 (101,103)) sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2)) 	
         cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1))
         	/variables= area subarea (101,900)  cinc (101,105) ccinc50 (101,105), ccinc100 (101,105) cocr(101,105) inter (1,9) synmem (1,2) chabad (1,2) jccmem (1,2) member (1,2) 
        donate (1,3) ccamtfed (-1,9)  amt100 (-1,1)
         	/tables = donate by pre by cjc (paired)  /ccamtfed amt100 by pre by cjc (paired)
   	      /base=responses
	         /cells= row.

comment below is to determine sample sizes for Table 8-4.
*weight off.
*mult response groups = pre 'attend preschool' (pre1 pre2 pre3 pre4 pre5 pre6 pre7 pre8 pre9 (101,103)) sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2)) 	
         cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1))
        	/variables= area subarea (101,900) cinc (101,105) ccinc50 (101,105)  ccinc100 (101,102) cocr (101,105) inter (1,9) synmem (1,2) jccmem (1,2) chabad (1,2)  member (1,2) donate (1,3) ccamtfed (-1,9) 
         /tables = pre by cjc (paired)
        	/tables = area subarea by pre by cjc (paired)  /sex by pre by cjc (paired)  /cinc ccinc50 ccinc100 by pre by cjc (paired) /cocr by pre by cjc (paired) /inter by pre by cjc (paired)
	        /base=responses
	        /cells= count.

*weight off.
*mult response groups = pre 'attend preschool' (pre1 pre2 pre3 pre4 pre5 pre6 pre7 pre8 pre9 (101,103)) cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1))
         /variables= area subarea (101,900)  cinc (101,105) ccinc50 (101,105) cocr (101,105) inter (1,9) synmem (1,2) chabad (1,2) jccmem (1,2) member (1,2) donate (1,3) ccamtfed (-1,9) 
        	/tables = synmem by pre by cjc (paired) /chabad by pre by cjc (paired) / jccmem by pre by cjc (paired) /member by pre by cjc (paired) /donate by pre by cjc (paired) /ccamtfed amt100 by pre by cjc (paired)
	        /base=responses
	        /cells= count.

*************************************************************************************
comment Table 8-4.
comment rerun preschool for age 2-5.
weight wf.
mult response groups = pre 'attend preschool' (pre1 pre2 pre3 pre4 pre5 pre6 pre7 pre8 pre9 (101,103)) cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1)) 
         ECEAge 'Selects Age 2-5' (ECEAgec1 ECEAgec2 ECEAgec3 ECEAgec4 ECEAgec5 ECEAgec6 ECEAgec7 ECEAgec8 ECEAgec9 (2,2))
          /tables = pre by cjc by ECEAge (paired)
	        /base=responses
	        /cells= row.

comment for Table 8-4.
*weight off.
*mult response groups = pre 'attend preschool' (pre1 pre2 pre3 pre4 pre5 pre6 pre7 pre8 pre9 (101,103)) cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1)) 
         ECEAge 'Selects Age 2-5' (ECEAgec1 ECEAgec2 ECEAgec3 ECEAgec4 ECEAgec5 ECEAgec6 ECEAgec7 ECEAgec8 ECEAgec9 (2,2))
          /tables = pre by cjc by ECEAge (paired)
	        /base=responses
	        /cells= column.

*****************************************************************************************************************************.
comment Table 8-6 Have Received PJ Library.
*******************************************************************************************************************************.
weight wf.
temporary.
select if jhhc eq 1.
crosstabs tables =  ccocr by pjlibrary
          /cells = row.

comment for Age 0-8.
temporary.
select if range(njchild8,1,10).
frequencies pjlibrary.

comment for Age 9-11.
temporary.
select if range(njchild9,1,10).
frequencies pjlibrary.

temporary.
select if jhhc eq 1.
crosstabs tables =  ccocr area subarea headage cinc ccinc50 ccinc100 cocr inter synmem chabad  jccmem member cajed ajed  sleep yg hillel cgoisr donate ccamtfed by pjlibrary
          /cells = row.

*weight off.
*temporary.
*select if jhhc eq 1.
*crosstabs tables = area subarea headage cinc ccinc50 ccinc100 cocr inter synmem chabad  jccmem member cajed ajed  sleep yg hillel cgoisr donate ccamtfed by pjlibrary
          /cells = count.
*weight wf.

*****************************************************************************************************************************.
comment Table 8-7 children's jewish day school education done for Jewish children not part Jewish.
*******************************************************************************************************************************.
weight wf.
comment sagec1a variables include a small number of 5 year olds as 6-12 year olds.
mult response groups = school 'type of education' (school1 school2 school3 school4 school5 school6 school7 school8 school9 (101, 103)) 
          sagea 'school age groups' (sagec1a sagec2a sagec3a sagec4a sagec5a sagec6a sagec7a sagec8a sagec9a (101,102))  cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1))
          /tables = school by cjc (paired)
           /base=responses
          /cells= column.

mult response groups = school 'type of education' (school1 school2 school3 school4 school5 school6 school7 school8 school9 (101,103)) sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))
          sagea 'school age groups' (sagec1a sagec2a sagec3a sagec4a sagec5a sagec6a sagec7a sagec8a sagec9a (101,102))  cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1))
           /variables= area subarea (101,900)  cinc (101,105) ccinc50 (101,105) cocr (101,105) ccocr (101,201) inter (1,9) synmem (1,2) chabad (1,2)  jccmem (1,2) member (1,2) cgoisr (100,102) ajed (1,2) 
          sleep yg hillel (1,9) donate (1,3) ccamtfed (-1,9) cajed (101,108) ccinc100 (101,102) amt100 (-1,9)
          /tables = school by cjc (paired)
         /tables = ccocr area subarea sagea ccocr sex cinc ccinc50  ccinc100 cocr inter synmem chabad  jccmem member cajed ajed sleep yg hillel cgoisr donate amt100 ccamtfed by school by cjc (paired)        
          /base=responses
          /cells= row.

comment for non-Orthodox by 5-12 and 13-17.
mult response groups = school 'type of education' (school1 school2 school3 school4 school5 school6 school7 school8 school9 (101,103)) sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))
          sagea 'school age groups' (sagec1a sagec2a sagec3a sagec4a sagec5a sagec6a sagec7a sagec8a sagec9a (101,102))  cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1))
           /variables= area subarea (101,900)  cinc (101,105) ccinc50 (101,105) cocr (101,105) ccocr (101,201) inter (1,9) synmem (1,2) chabad (1,2)  jccmem (1,2) member (1,2) cgoisr (100,102) ajed (1,2) 
          sleep yg hillel (1,9) donate (1,3) ccamtfed (-1, 9) cajed (101,108) ccinc100 (101,102) amt100 (-1,9)
            /tables = school by sagea by ccocr by cjc (paired)
          /base=responses
          /cells= column.

*weight off.
comment to figure out which groups to use.
*mult response groups = school 'type of education' (school1 school2 school3 school4 school5 school6 school7 school8 school9 (101,103)) sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))
          sagea 'school age groups' (sagec1a sagec2a sagec3a sagec4a sagec5a sagec6a sagec7a sagec8a sagec9a (101,102))  cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1))
          /variables= area subarea (101,900)  cinc (101,105) cocr (101,105) ccocr (101,201) inter (1,9) synmem (1,2) chabad (1,2) jccmem (1,2) member (1,2) cgoisr (100,102) ajed (1,3) sleep yg hillel (1,9) 
          donate (1,3) ccamtfed (-1,9) cajed (101,108)  ccinc50 (101,105) ccinc100 (101,102) amt100 (-1,9)
          /tables = school by cjc (paired)
          /tables = ccocr area subarea sagea sex cinc ccinc50 ccinc100 cocr inter synmem chabad  member cajed ajed sleep yg hillel cgoisr donate amt100 ccamtfed by school by cjc (paired)
          /base=responses
          /cells= count.
*weight wf.

************************************************************************************************.
comment part of the Jewish day school market.
************************************************************************************************.
comment Table 8-11.
weight wf.
temporary.
select if range(njchild,1,9).
frequencies variables = consider consider2.

comment Table 8-12 Part of Jewish Day school market.
weight wf.
temporary.
select if range(njchild,1,9).
crosstabs tables = ccocr area subarea cinc ccinc50 ccinc100 cocr inter synmem chabad jccmem member cajed ajed sleep yg hillel cgoisr donate ccamtfed by consider2
         /cells = row.

*weight off.
*temporary.
*select if range(njchild,1,9).
*crosstabs tables = ccocr area subarea cinc ccinc50 ccinc100 cocr inter synmem chabad jccmem member cajed ajed sleep yg hillel cgoisr donate ccamtfed by consider2
	/cells = count.
*weight wf.

**********************************************************************.
comment Table 8-14  Reasons Not to Jewish Day School.
weight wf.
temporary.
select if jhhc eq 1.
mult response groups = noday 'Reason Not Send to Day School' (noday1 noday2 (1,100))
	/frequencies noday
        /base=responses
        /cells= column.

**********************************************************************.
comment Table 8-14  Reasons Not to Jewish Day School.
weight wf.
temporary.
select if jhhc eq 1.
mult response groups = noday 'Reason Not Send to Day School' (noday1 noday2 (1,100))
	/frequencies noday
        /base=responses
        /cells= column.

**********************************************************************.
comment Table 8-23. Cost an Issue in Jewish Day School.
weight wf.
temporary.
select if jhhc eq 1.
crosstabs tables =  ccocr area subarea headage headage1849 cinc ccinc50 ccinc100 cocr inter synmem chabad  jccmem member  donate ccamtfed by costday
          /cells = row.

*weight off.
*temporary.
*select if jhhc eq 1.
*crosstabs tables =  ccocr area subarea headage cinc ccinc50 ccinc100 cocr inter synmem chabad  jccmem member donate ccamtfed by costday
          /cells = count.

**********************************************************************.
comment Table 8-24. Perception of Public Schools.
weight wf.
temporary.
select if jhhc eq 1.
crosstabs tables =  ccocr area subarea ccage1 cccage1 age1849 sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem chabad jccmem  member donate ccamtfed by qpublic
      	/cells = row.
 
*weight off.
*temporary.
*select if jhhc eq 1.
*crosstabs tables =  ccocr area subarea ccage1  cccage1 sex1 cinc ccinc50 cocr inter synmem chabad jccmem  member donate ccamtfed by qpublic
          /cells = count.  


comment Table 8-25 *************************************************************************************************************Child Currently Attends Jewish Education.
comment sagec1a variables include a small number of 5 year olds as 6-12 year olds.

comment note that the column order in the output is different then the table.

weight wf.
mult response groups = cjed 'Child Currently Attends Jewish Education' (cjed1 cjed2 cjed3 cjed4 cjed5 cjed6 cjed7 cjed8 cjed9 (101,104))
     	sagea 'school age  groups' (sagec1a sagec2a sagec3a sagec4a sagec5a sagec6a sagec7a sagec8a sagec9a (101,102))
	sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))  cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1))
   	/variables= area subarea (101,900)  cinc (101,105) cocr (101,105) ccocr (101,201) inter (1,9) synmem (1,2)  jccmem (1,2) member (1,2) chabad (1,2) inc100 (1,2)
	cgoisr (100,102) ajed (1,2) cajed (101,108) sleep yg hillel (1,9)  donate (1,3) ccamtfed (-1,9) ccinc100 (101,102) ccinc50 (101,105) amt100 (-1,9)
                  /tables = ccocr by cjed by cjc (paired)  
	/tables = ccocr area subarea sagea sex cinc ccinc50 ccinc100 cocr inter synmem chabad  jccmem member cajed ajed sleep yg hillel cgoisr donate ccamtfed amt100 by cjed by cjc (paired)
       	/base=responses
                  /cells = row.

comment for non-Orthodox by 5-12 and 13-17.
mult response groups = school 'type of education' (school1 school2 school3 school4 school5 school6 school7 school8 school9 (101,103)) sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))
          sagea 'school age groups' (sagec1a sagec2a sagec3a sagec4a sagec5a sagec6a sagec7a sagec8a sagec9a (101,102))  cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1))
          cjed 'Child Currently Attends Jewish Education' (cjed1 cjed2 cjed3 cjed4 cjed5 cjed6 cjed7 cjed8 cjed9 (101,104))
          /variables= area subarea (101,900)  cinc (101,105) ccinc50 (101,105) cocr (101,105) ccocr (101,201) inter (1,9) synmem (1,2) chabad (1,2)  jccmem (1,2) member (1,2) cgoisr (100,102) ajed (1,2) 
          sleep yg hillel (1,9) donate (1,3) ccamtfed (-1, 9) cajed (101,108) ccinc100 (101,102) amt100 (-1,9)
          /tables = cjed by sagea by ccocr by cjc (paired)
          /base=responses
          /cells= column.

weight off.
mult response groups = cjed 'Child Currently Attends Jewish Education' (cjed1 cjed2 cjed3 cjed4 cjed5 cjed6 cjed7 cjed8 cjed9 (101,104))
     	    sagea 'school age  groups' (sagec1a sagec2a sagec3a sagec4a sagec5a sagec6a sagec7a sagec8a sagec9a (101,102))
	         sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2)) 	cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1))
   	      /variables= area subarea (101,900)  cinc (101,105) cocr (101,105) ccocr (101,201) inter (1,9) synmem (1,2)  jccmem (1,2) member (1,2) chabad (1,2)
	                cgoisr (100,102) ajed (1,2) cajed (101,108) sleep yg hillel (1,9)  donate (1,3) ccamtfed (-1,9) ccinc100 (101,102) ccinc50 (101,105) amt100 (-1,9)
	         /tables = ccocr area subarea sagea sex cinc ccinc50 ccinc100 cocr inter synmem chabad jccmem member cajed ajed sleep yg hillel cgoisr donate ccamtfed amt100 by cjed by cjc (paired)
       	  /base=responses
          /cells = count.

weight off.
frequencies school2 cjed2 everjed2.
weight wf.


comment Table 8-28 ************************************************************************************************************Child Ever Attended Jewish Education.
weight wf.
comment sagec1a variables include a small number of 5 year olds as 6-12 year olds.
 mult response groups = everjed 'Ever Attended Jewish Education' (everjed1 everjed2 everjed3 everjed4 everjed5 everjed6 everjed7 everjed8 everjed9 (101,104))
                  neweverjed 'Ever Attended Jewish Education' (neweverjed1 neweverjed2 neweverjed3 neweverjed4 neweverjed5 neweverjed6 neweverjed7 neweverjed8 neweverjed9 (101,104))
	sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))
      	sagea 'school age groups' (sagec1a sagec2a sagec3a sagec4a sagec5a sagec6a sagec7a sagec8a sagec9a (101,102)) 
	cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1))
                  /variables= area subarea (101,900)  cinc (101,105) cocr (101,105) ccocr (101,201) inter (1,9) synmem (1,2) jccmem (1,2) member (1,2) chabad (1,2)
	cgoisr (100,102) ajed (1,2) cajed (101,108) sleep yg hillel (1,9)  donate (1,3) ccamtfed (-1,9) ccinc100 (101,102) ccinc50 (101,105) amt100(-1,1)
	/tables = ccocr area subarea sagea sex cinc ccinc50 ccinc100 cocr inter synmem chabad jccmem member cajed ajed sleep yg hillel cgoisr donate ccamtfed amt100 by neweverjed by cjc (paired)
 	/base=responses
 	/cells= row.

comment for non-Orthodox by 5-12 and 13-17.
mult response groups = everjed 'Ever Attended Jewish Education' (everjed1 everjed2 everjed3 everjed4 everjed5 everjed6 everjed7 everjed8 everjed9 (101,104))
                  neweverjed 'Ever Attended Jewish Education' (neweverjed1 neweverjed2 neweverjed3 neweverjed4 neweverjed5 neweverjed6 neweverjed7 neweverjed8 neweverjed9 (101,104))
	sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))
      	sagea 'school age groups' (sagec1a sagec2a sagec3a sagec4a sagec5a sagec6a sagec7a sagec8a sagec9a (101,102)) 
	cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1))
                  /variables= area subarea (101,900)  cinc (101,105) cocr (101,105) ccocr (101,201) inter (1,9) synmem (1,2) jccmem (1,2) member (1,2) chabad (1,2)
	cgoisr (100,102) ajed (1,2) cajed (101,108) sleep yg hillel (1,9)  donate (1,3) ccamtfed (-1,9) ccinc100 (101,102) ccinc50 (101,105) amt100(-1,1)
            /tables = neweverjed by sagea by ccocr by cjc (paired)
          /base=responses
          /cells= column.

comment remove same population subgroups from table as current education in previous table.

***********************************************************************
comment Table 8-31 children's day camp.
***********************************************************************.
weight wf. 
mult response groups = dcamp 'Attended Day Camp' (dcamp1 dcamp2 dcamp3 dcamp4 dcamp5 dcamp6 dcamp7 dcamp8 dcamp9  (101,103))
	         sage 'school age groups' (sagec1 sagec2 sagec3 sagec4 sagec5 sagec6 sagec7 sagec8 sagec9 (1,3))
	         sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2)) 
	         cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1)) 
   	      /variables= area subarea (101,900)  cinc (101,105) cocr (101,105)  ccocr (101, 201) inter (1,9) synmem (1,2) jccmem (1,2) member (1,2) chabad (1,2)
	             cgoisr (100,102) ajed (1,2) cajed (101,108) sleep yg hillel (1,9) ccamtfed (-1,9) donate (1,3) ccinc100 (101,102)  ccinc50 (101,105) 
 	        /tables = ccocr area subarea sage sex cinc ccinc50 ccinc100 cocr inter synmem chabad  jccmem member cajed ajed sleep yg hillel cgoisr donate ccamtfed by dcamp by cjc (paired)
    	     /base=responses
    	    /cells = row.

*weight off.
comment for sample sizes for Day Camp Attendance.
*mult response groups = dcamp 'Attended Day Camp' (dcamp1 dcamp2 dcamp3 dcamp4 dcamp5 dcamp6 dcamp7 dcamp8 dcamp9  (101,103))
	         sage 'school age groups' (sagec1 sagec2 sagec3 sagec4 sagec5 sagec6 sagec7 sagec8 sagec9 (1,3))
	         sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2)) 
	         cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1)) newcjc 'Child is currently Jewish or part Jewish' (newcjc1 newcjc2 newcjc3 newcjc4 newcjc5 newcjc6 newcjc7 newcjc8 newcjc9  (1,1))
   	      /variables= area subarea (101,900)  cinc (101,105) cocr (101,105) ccocr (101, 201) inter (1,9) synmem (1,2)  jccmem (1,2) member (1,2) chabad (1,2)
	                cgoisr (100,102) ajed (1,2) cajed (101,108) sleep yg hillel (1,9) ccamtfed (-1,9) donate (1,3) ccinc100 (101,102)   ccinc50 (101,105) 
	         /tables = ccocr area subarea sage sex cinc ccinc50 ccinc100 cocr inter synmem chabad  jccmem member cajed ajed sleep yg hillel cgoisr donate ccamtfed by dcamp by cjc (paired)
    	     /base=responses
    	     /cells = row.

***********************************************************************
comment Table 8-33 overnight camp for children.
***********************************************************************.
weight wf.
mult response groups = scamp 'Attended Sleep Away Camp' (scamp1 scamp2 scamp3 scamp4 scamp5 scamp6 scamp7 scamp8 scamp9  (101,103)) sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))
     	    sageb 'school age groups' (sagec1b sagec2b sagec3b sagec4b sagec5b sagec6b sagec7b sagec8b sagec9b (101,101))  cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1))
          newcjc 'Child is currently Jewish or part Jewish' (newcjc1 newcjc2 newcjc3 newcjc4 newcjc5 newcjc6 newcjc7 newcjc8 newcjc9  (1,1))
     	    sage 'school age groups' (sagec1 sagec2 sagec3 sagec4 sagec5 sagec6 sagec7 sagec8 sagec9 (1,3)) 
   	      /variables= area subarea (101,900)  cinc (101,105) cocr (101,105) ccocr (101,201) inter (1,9) synmem (1,2)  jccmem (1,2) member (1,2) chabad (1,2)
	                cgoisr (100,102) ajed (1,2) cajed (101,108) sleep yg hillel (1,9) donate (1,3)  ccamtfed (-1,9) ccinc100 (101,102)  ccinc50 (101,105)   
	         /tables = ccocr area subarea sage sageb sex cinc ccinc50 ccinc100 cocr inter synmem chabad  jccmem member cajed ajed sleep yg hillel cgoisr donate ccamtfed by scamp by sageb by cjc (paired)
          /base=responses
	        /cells = row.

*weight off.
*mult response groups = scamp 'Attended Sleep Away Camp' (scamp1 scamp2 scamp3 scamp4 scamp5 scamp6 scamp7 scamp8 scamp9  (101,103)) sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))
     	sageb 'school age groups' (sagec1b sagec2b sagec3b sagec4b sagec5b sagec6b sagec7b sagec8b sagec9b (101,101))  cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1 ))
     	sage 'school age groups' (sagec1 sagec2 sagec3 sagec4 sagec5 sagec6 sagec7 sagec8 sagec9 (1,3)) newcjc 'Child is currently Jewish or part Jewish' (newcjc1 newcjc2 newcjc3 newcjc4 newcjc5 newcjc6 newcjc7 newcjc8 newcjc9  (1,1))
   	  /variables= area subarea (101,900)  cinc (101,105) cocr (101,105) ccocr (101,201)  inter (1,9) synmem (1,2) jccmem (1,2) member (1,2) chabad (1,2)
	    cgoisr (100,102) ajed (1,2) cajed (101,108) sleep yg hillel (1,9) donate (1,3)  ccamtfed (-1,9) ccinc100 (101,102)  ccinc50 (101,105) 
	    /tables = ccocr area subarea sage sageb sex cinc ccinc50 ccinc100 cocr inter synmem chabad  jccmem member cajed ajed sleep yg hillel cgoisr donate ccamtfed by scamp by sageb by cjc (paired)
     /base=responses
	    /cells = row.

***********************************************************************************.
comment Table 8-35 Cost of sleep away and day camp
***********************************************************************************.
weight wf.
temporary.
select if jhhc eq 1.
crosstabs tables = ccocr area subarea headage headage1849 cinc ccinc50 ccinc100 cocr inter synmem chabad jccmem member famfed donate ccamtfed amt100 by costcamp costcampday
        /cells = row.

comment to get number of households for the text.
temporary.
select if jhhc eq 1.
crosstabs tables = area by costcamp costcampday
        /cells = count.

*weight off.
*temporary.
*select if jhhc eq 1.
*crosstabs tables = ccocr area subarea headage cinc ccinc50 ccinc100 cocr inter synmem chabad jccmem member famfed donate ccamtfed amt100 by costcamp costcampday
           /cells = count.
*weight wf.

***********************************************************************************.
comment Table 8-37 Teenage Youth Group Particiption.
***********************************************************************************.
weight wf.
mult response groups = ygc 'Youth Group Attendance' (ygc1 ygc2 ygc3 ygc4 ygc5 ygc6 ygc7 ygc8 ygc9 (1,2)) 	sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))
	        sagec 'school age groups' (sagec1c sagec2c sagec3c sagec4c sagec5c sagec6c sagec7c sagec8c sagec9c (102,102)) 	cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1))
 	       /variables= area subarea (101,900)  cinc (101,105) cocr (101,105) ccocr (101,201) inter (1,9) synmem (1,2) jccmem (1,2) member (1,2) chabad (1,2)
	             cgoisr (100,102) ajed (1,2) cajed (101,108) sleep yg hillel (1,9) donate (1,3)  ccamtfed (-1,9) ccinc100 (101,102)   ccinc50 (101,105) amt100 (-1,9)
	        /tables = ccocr area subarea sagec sex cinc ccinc50 ccinc100 cocr inter synmem chabad  jccmem member donate ccamtfed  amt100 by ygc by sagec by cjc (paired)
 	       /base=responses
	        /cells = row.

*weight off.
comment sample size for youth group regular participation.
*mult response groups = ygc 'Youth Group Attendance' (ygc1 ygc2 ygc3 ygc4 ygc5 ygc6 ygc7 ygc8 ygc9 (1,2)) 	sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))
	        sagec 'school age groups' (sagec1c sagec2c sagec3c sagec4c sagec5c sagec6c sagec7c sagec8c sagec9c (102,102)) 	cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1))
         newcjc 'Child is currently Jewish or part Jewish' (newcjc1 newcjc2 newcjc3 newcjc4 newcjc5 newcjc6 newcjc7 newcjc8 newcjc9  (1,1))
 	       /variables= area subarea (101,900)  cinc (101,105) cocr (101,105) ccocr (101,201) inter (1,9) synmem (1,2)  jccmem (1,2) member (1,2) chabad (1,2)
	             cgoisr (100,102) ajed (1,2) cajed (101,108) sleep yg hillel (1,9) donate (1,3)  ccamtfed (-1,9) ccinc100 (101,102)  ccinc50 (101,105) amt100 (-1,9)
	        /tables = area subarea sagec sex cinc ccinc50 ccinc100 cocr inter synmem chabad jccmem member donate ccamtfed amt100 by ygc by sagec by cjc (paired)
 	       /base=responses
	        /cells = row.

***********************************************************************************.
comment Table 8-40 Any Type of Jewish Education Particiption.
***********************************************************************************.
weight wf.
mult response groups = anyjew 'Child is doing any type of Jewish Education' (anyjew1 anyjew2 anyjew3 anyjew4 anyjew5 anyjew6 anyjew7 anyjew8 anyjew9 (101,102)) 	sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))
	         sage 'school age groups' (sagec1 sagec2 sagec3 sagec4 sagec5 sagec6 sagec7 sagec8 sagec9 (1,3))
	         cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1)) 
	          /variables= area subarea (101,900)  cinc (101,105) cocr (101,105) ccocr (101,201) inter (1,9) synmem (1,2) jccmem (1,2) member (1,2) chabad (1,2)
	                cgoisr (100,102) ajed (1,2) cajed (101,108) sleep yg hillel (1,9) donate (1,3)  ccamtfed (-1,9) ccinc100 (101,102)  ccinc50 (101,105) amt100 (-1,9)
          /tables anyjew by cjc (paired)
	         /tables = ccocr area subarea sage sex cinc ccinc50 ccinc100 cocr inter synmem chabad  jccmem member cajed ajed cgoisr donate ccamtfed amt100 by anyjew by cjc (paired)
 	        /base=responses
	         /cells = row.

*weight off.
comment sample size for any type of Jewish education.
*mult response groups = anyjew 'Child is doing any type of Jewish Education' (anyjew1 anyjew2 anyjew3 anyjew4 anyjew5 anyjew6 anyjew7 anyjew8 anyjew9 (101,102)) 	sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))
         sage 'school age groups' (sagec1 sagec2 sagec3 sagec4 sagec5 sagec6 sagec7 sagec8 sagec9 (1,3))
	        cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1))  newcjc 'Child is currently Jewish or part Jewish' (newcjc1 newcjc2 newcjc3 newcjc4 newcjc5 newcjc6 newcjc7 newcjc8 newcjc9  (1,1))
	        /variables=  area subarea (101,900)  cinc (101,105) cocr (101,105) ccocr (101,201) inter (1,9) synmem (1,2)  jccmem (1,2) member (1,2) chabad (1,2)
	             cgoisr (100,102) ajed (1,2) cajed (101,108) sleep yg hillel (1,9) donate (1,3)  ccamtfed (-1,9) ccinc100 (101,102)  ccinc50 (101,105) amt100 (-1,9)
         /tables anyjew by cjc (paired)
         /tables = ccocr area subarea sage sex cinc ccinc50 ccinc100 cocr inter synmem chabad  jccmem member cajed ajed cgoisr donate ccamtfed amt100 by anyjew by cjc (paired)
 	       /base=responses
	        /cells = row.

***********************************************************************************.
comment Table 8-42 Preference for Jewish After School Care.
*****************************************************************************.

weight wf.
temporary.
select if jhhc eq 1.
crosstabs tables = ccocr area subarea ccage1 jsex cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed amt100 by pjafter
	         /cells = row.

comment for preference for Jewish afer school care sample size.
*weight off.
*temporary.
*select if jhhc eq 1.
*crosstabs tables = ccocr area subarea ccage1 jsex cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed amt100 by pjafter
	         /cells = count.

**
******************************************comment the following are for the text of Chapter 8*****************************************************.
comment for the PRESCHOOL section.
comment to get the number of children to transfer from 0-5 to 6-12 because some 5 year olds are in kindergarten.
comment In Detroit, we have 4,100 Jewish kids age 0-5, the output from the following syntax shows that 3,900 kids are 0-5 and not in kindergarten, so transfer 200 kids in chapter 8 from 0-5 to 6-12.
weight wf.
mult response groups = pre 'attend preschool' (pre1 pre2 pre3 pre4 pre5 pre6 pre7 pre8 pre9 (101,103)) cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1))
                  /tables = pre by cjc (paired)
        	/base=responses
	/cells= column.
comment same as above, except for Non-Orthodox.
weight wfhh.
temporary.
select if (ccocr eq 201).
mult response groups = pre 'attend preschool' (pre1 pre2 pre3 pre4 pre5 pre6 pre7 pre8 pre9 (101,103)) cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1))
                  /variables = ccocr (101,201)
                  /tables = pre by cjc (paired)
        	/base=responses
	/cells= column.

comment for sample size of preschool kids.
weight off.
mult response groups = pre 'attend preschool' (pre1 pre2 pre3 pre4 pre5 pre6 pre7 pre8 pre9 (101,103)) cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1))
        	        /tables = pre by cjc (paired)
        	        /base=responses
	        /cells= count.
weight off.
temporary.
select if ccocr eq 201.
mult response groups = pre 'attend preschool' (pre1 pre2 pre3 pre4 pre5 pre6 pre7 pre8 pre9 (101,103)) cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1))
        	        /tables = pre by cjc (paired)
        	        /base=responses
	        /cells= count.
weight wf.

comment for check mark in day school section.
temporary.
select if jhhc eq 1.
frequencies schoolchoice.

comment for sample size of children for day school section.
weight off.
mult response groups = school 'type of education' (school1 school2 school3 school4 school5 school6 school7 school8 school9 (101, 103)) 
          sagea 'school age groups' (sagec1a sagec2a sagec3a sagec4a sagec5a sagec6a sagec7a sagec8a sagec9a (101,102))  cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1))
          /tables = school by cjc (paired)
           /base=responses
          /cells= column.

weight off.
mult response groups = school 'type of education' (school1 school2 school3 school4 school5 school6 school7 school8 school9 (101, 103)) 
          sagea 'school age groups' (sagec1a sagec2a sagec3a sagec4a sagec5a sagec6a sagec7a sagec8a sagec9a (101,102))  cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1))
          /tables = sagea by school by cjc (paired)
           /base=responses
          /cells= column.

comment this is for the check mark.
weight wf.
mult response groups =
         sage 'age distribution' (sagec1 sagec2 sagec3 sagec4 sagec5 sagec6 sagec7 sagec8 sagec9 (1,20)) 
        	cj 'Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,3))
        	/tables = sage by cj (paired)
        	/base = responses
        	/cells = column.
 

********************************************************************************************************************************************************************.
comment chapter 9.
*********************************************************************************************************************************************************************.
comment to determine agency order:.
frequencies famfed famjcc famapt famalf famjfs famjcrc famjvs famcamp famyad famhosp famfriend famkadima famjarc famloan fambbyo.
frequencies quafed quajcc quaapt quaalf quajfs quajcrc quajvs quacamp quayad quahosp quafriend quakadima quajarc qualoan quabbyo.

temporary.
select if jhhc eq 1.
frequencies famday1 famday2 famday3 famday4 famday5 famday6 quaday1 quaday2 quaday3 quaday4 quaday5 quaday6.

*******************************************************************************************************************************************************************************************************JCC.
comment Table 9-4 Familiarity with the JCC.
**********************************************************************.
weight wf.
crosstabs tables =  area subarea cclor10a cclor20 ccage1 cccage1 sex1 cfamily  cinc ccinc50 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famjcc
       	/cells = row.

*weight off.
*crosstabs tables =  area subarea cclor10a ccage1 cccage1 sex1 cfamily  cinc ccinc50 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famjcc
	/cells = count.

comment Table 9-6 Perception of  the JCC.
*********************************************************************.
weight wf.
crosstabs tables =  famjcc area subarea ccage1 cccage1 age1849 sex1 cfamily  cinc ccinc50 cocr inter synmem jccmem  member donate ccamtfed by quajcc
      	/cells = row.
 
*weight off.
*crosstabs tables =  famjcc area subarea ccage1  cccage1 sex1 cfamily  cinc ccinc50 cocr inter synmem jccmem  member donate ccamtfed by quajcc
          /cells = count.

***************************************************************************************************************************************************************************************************** Fresh Air Society.
comment Table 9-8 Familiarity with Camp.
***********************************************************************.
weight wf.
crosstabs tables = area subarea cclor10a ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famcamp
          /cells = row.

comment for row for households with JEWISH children.
Temporary.
select if jhhc eq 1.
frequencies famcamp.

*weight off.
*crosstabs tables = area subarea cclor10a ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famcamp
          /cells = count.

comment Table 9-10 Perception of  Camp.
**********************************************************.
weight wf.
crosstabs tables =  famcamp area subarea ccage1 age1849 cccage1 sex1 cfamily cinc ccinc50 ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quacamp
	         /cells = row.

comment for row for households with JEWISH children.
Temporary.
select if jhhc eq 1.
frequencies quacamp.

*weight off.
*crosstabs tables =  famcamp area subarea ccage1  age1849 cccage1 sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quacamp
          /cells = count.

*******************************************************************************************************************************************************************************************************Federation.
comment Table 9-12 Familiarity with the Federation.
******************************************************************.
weight wf.
crosstabs tables =  area subarea cclor10a ccage1  cccage1  sex1 cfamily  cinc ccinc50 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famfed 	
          /cells = row.

*weight off.
*crosstabs tables =  area subarea cclor10a ccage1  cccage1  sex1 cfamily  cinc ccinc50 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famfed 	
          /cells = count.

comment Table 9-14 Perception of  the Federation.
*************************************************************.
weight wf.
crosstabs tables =  famfed area subarea ccage1  cccage1 age1849 sex1 cfamily cinc ccinc50 cocr inter synmem jccmem member donate ccamtfed by quafed 
          /cells = row.

*weight off.
*crosstabs tables =  famfed area subarea ccage1  cccage1 sex1 cfamily  cinc ccinc50 cocr inter synmem jccmem  member donate ccamtfed by quafed
          /cells = count.

******************************************************************************************************************************************************************************************************YAD Ezra.
comment Table 9-16 Familiarity with YAD Ezra.
***********************************************************************.
weight wf.
crosstabs tables = area subarea cclor10a cclor20 ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famyad
          /cells = row.

*weight off.
*crosstabs tables = area subarea cclor10a ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famyad
          /cells = count.

comment Table 9-17 Perception of  Yad Ezra.
**********************************************************.
weight wf.
crosstabs tables =  famyad area subarea ccage1 age1849  cccage1 sex1 cfamily   cinc ccinc50 ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quayad
	         /cells = row.

*weight off.
*crosstabs tables =  famyad area subarea ccage1 age1849  cccage1 sex1 cfamily  cinc ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quayad
          /cells = count.

******************************************************************************************************************************************************************************************************BBYO.
comment Table 9-18 Familiarity with BBYO.
***********************************************************************.
weight wf.
crosstabs tables = area subarea cclor10a cclor20 ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famBBYO
          /cells = row.

*weight off.
*crosstabs tables = area subarea cclor10a ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famBBYO
          /cells = count.

comment Table 9-19 Perception of  BBYO.
**********************************************************.
weight wf.
crosstabs tables =  famBBYO area subarea ccage1 age1849  cccage1 sex1 cfamily   cinc ccinc50 ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quaBBYO
	         /cells = row.

*weight off.
*crosstabs tables =  famBBYO area subarea ccage1 age1849  cccage1 sex1 cfamily  cinc ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quaBBYO
          /cells = count.

************************************************************************************************************************************************************************************Jewish Apartments.
comment Table 9-20 Familiarity with Jewish Apartments such as Prentis, Meer.
*********************************************************************************************.
weight wf.
crosstabs tables = area subarea cclor10a cclor20 ccage1  cccage1  sex1 cfamily  cinc ccinc50 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famapt
          /cells = row.

*weight off.
*crosstabs tables = area subarea cclor10a ccage1  cccage1  sex1 cfamily  cinc ccinc50 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famapt
          /cells = count.

comment Table 9-22 Perception of  Jewish Apartments.
*******************************************************************.
weight wf.
crosstabs tables =  famapt area subarea ccage1  cccage1 age1849  sex1 cfamily  cinc ccinc50 cocr inter synmem jccmem  member donate ccamtfed amt100 by quaapt
         /cells = row.

*weight off.
*crosstabs tables =  famapt area subarea clor ccage1  cccage1 sex1 cfamily  cinc ccinc50 cocr inter synmem jccmem  member donate ccamtfed amt100 by quaapt
          /cells = count.

*******************************************************************************************************************************************************************************************************ALF.
comment Table 9-24 Familiarity with the Assisted Living Facility Fleischman.
*****************************************************************************.
weight wf.
crosstabs tables =  area subarea cclor10a cclor20 ccage1  cccage1  sex1 cfamily  cinc ccinc50 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famalf 	
          /cells = row.

*weight off.
*crosstabs tables =  area subarea cclor10a ccage1  cccage1  sex1 cfamily  cinc ccinc50 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famalf 	
          /cells = count.

comment Table 9-25 Perception of  the Assisted Living Facility Fleischman.
********************************************************************************.
weight wf.
crosstabs tables =  famalf area subarea ccage1  cccage1  age1849 sex1 cfamily cinc ccinc50 cocr inter synmem jccmem member donate ccamtfed by quaalf 
          /cells = row.

*weight off.
*crosstabs tables =  famalf area subarea ccage1  cccage1 sex1 cfamily  cinc ccinc50 cocr inter synmem jccmem  member donate ccamtfed by quaalf
          /cells = count.

*******************************************************************************************************************************************************************************************************Friendship Circle.
comment Table 9-26 Familiarity with Friendship Circle.
***********************************************************************.
weight wf.
crosstabs tables = area subarea cclor10a cclor20 ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famfriend
          /cells = row.

*weight off.
*crosstabs tables = area subarea cclor10a ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famfriend
          /cells = count.

comment Table 9-27 Perception of  Friendship Circle.
**********************************************************.
weight wf.
crosstabs tables =  famfriend area subarea ccage1 age1849  cccage1 sex1 cfamily   cinc ccinc50 ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quafriend
	         /cells = row.

*weight off.
*crosstabs tables =  famfriend area subarea ccage1 age1849  cccage1 sex1 cfamily  cinc ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quafriend
          /cells = count.

***************************************************************************************************************************************************************************************************JFS.
comment Table 9-28 Familiarity with JFS.
************************************************************.
missing values cmar1 (108).
weight wf.
crosstabs tables = area subarea cclor10a cclor20 ccage1  cccage1  sex1 cfamily  cmar1 cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famjfs
          /cells = row.

*weight off.
*crosstabs tables = area subarea cclor10a ccage1  cccage1  sex1 cfamily  cmar1 cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famjfs
          /cells = count.

comment Table 9-30 Perception of JFS.
***********************************************************.
weight wf.
missing values cmar1 (108).
crosstabs tables =  famjfs area subarea ccage1 age1849 cccage1 sex1 cfamily  cmar1 cinc ccinc50 ccinc100 cocr inter synmem jccmem  member donate ccamtfed by quajfs
	         /cells = row.

*weight off.
*crosstabs tables =  famjfs area subarea ccage1  age1849 cccage1 sex1 cfamily  cmar1 cinc ccinc50 cocr inter synmem jccmem  member donate ccamtfed by quajfs
          /cells = count.

******************************************************************************************************************************************************************************************************Hebrew Free Loan.
comment Table 9-32 Familiarity with Loan.
***********************************************************************.
weight wf.
crosstabs tables = area subarea cclor10a cclor20 ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famloan
          /cells = row.

*weight off.
*crosstabs tables = area subarea cclor10a ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famloan
          /cells = count.

comment Table 9-33 Perception of  Loan.
**********************************************************.
weight wf.
crosstabs tables =  famloan area subarea ccage1 age1849  cccage1 sex1 cfamily   cinc ccinc50 ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by qualoan
	         /cells = row.

*weight off.
*crosstabs tables =  famloan area subarea ccage1 age1849  cccage1 sex1 cfamily  cinc ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by qualoan
          /cells = count.

******************************************************************************************************************************************************************************************************JVS.
comment Table 9-34 Familiarity with JVS.
***********************************************************************.
weight wf.
crosstabs tables = area subarea cclor10a cclor20 ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famjvs
          /cells = row.

*weight off.
*crosstabs tables = area subarea cclor10a ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famjvs
          /cells = count.

comment Table 9-35 Perception of  JVS.
**********************************************************.
weight wf.
crosstabs tables =  famjvs area subarea ccage1 age1849  cccage1 sex1 cfamily   cinc ccinc50 ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quajvs
	         /cells = row.

*weight off.
*crosstabs tables =  famjvs area subarea ccage1 age1849  cccage1 sex1 cfamily  cinc ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quajvs
          /cells = count.

******************************************************************************************************************************************************************************************************Hospice.
comment Table 9-36 Familiarity with Hospice.
***********************************************************************.
weight wf.
crosstabs tables = area subarea cclor10a cclor20 ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famhosp
          /cells = row.

*weight off.
*crosstabs tables = area subarea cclor10a ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famhosp
          /cells = count.

comment Table 9-37 Perception of  Hospice.
**********************************************************.
weight wf.
crosstabs tables =  famhosp area subarea ccage1 age1849  cccage1 sex1 cfamily   cinc ccinc50 ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quahosp
	         /cells = row.

*weight off.
*crosstabs tables =  famhosp area subarea ccage1 age1849  cccage1 sex1 cfamily  cinc ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quahosp
          /cells = count.

*******************************************************************************************************************************************************************************************************JARC.
comment Table 9-38 Familiarity with JARC.
***********************************************************************.
weight wf.
crosstabs tables = area subarea cclor10a cclor20 ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famjarc
          /cells = row.

*weight off.
*crosstabs tables = area subarea cclor10a ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famjarc
          /cells = count.

comment Table 9-39 Perception of  JARC.
**********************************************************.
weight wf.
crosstabs tables =  famjarc area subarea ccage1 age1849  cccage1 sex1 cfamily cinc ccinc50 ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quajarc
	         /cells = row.

*weight off.
*crosstabs tables =  famjarc area subarea ccage1 age1849  cccage1 sex1 cfamily cinc ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quajarc
          /cells = count.


*******************************************************************************************************************************************************************************************************Kadima.
comment Table 9-40 Familiarity with Kadima.
***********************************************************************.
weight wf.
crosstabs tables = area subarea cclor10a cclor20 ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famkadima
          /cells = row.

*weight off.
*crosstabs tables = area subarea cclor10a ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famkadima
          /cells = count.

comment Table 9-41 Perception of  Kadima.
**********************************************************.
weight wf.
crosstabs tables =  famkadima area subarea ccage1 age1849  cccage1 sex1 cfamily   cinc ccinc50 ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quakadima
	         /cells = row.

*weight off.
*crosstabs tables =  famkadima area subarea ccage1 age1849  cccage1 sex1 cfamily  cinc ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quakadima
          /cells = count.

*******************************************************************************************************************************************************************************************************JCRC.
comment Table 9-42 Familiarity with JCRC.
***********************************************************************.
weight wf.
crosstabs tables = area subarea cclor10a cclor20 ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famjcrc
          /cells = row.

*weight off.
*crosstabs tables = area subarea cclor10a ccage1  cccage1  sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cgoisr donate ccamtfed by famjcrc
          /cells = count.

comment Table 9-44 Perception of  JCRC.
**********************************************************.
weight wf.
crosstabs tables =  famjcrc area subarea ccage1 age1849  cccage1 sex1 cfamily   cinc ccinc50 ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quajcrc
	         /cells = row.

*weight off.
*crosstabs tables =  famjcrc area subarea ccage1 age1849  cccage1 sex1 cfamily  cinc ccinc50 ccinc100 cocr inter synmem jccmem  member donate ccamtfed amt100 by quajcrc
          /cells = count.

******************************************************************************************************************************************************.
comment for sample sizes for familiarity with all day schools.
*weight off.
*temporary.
*select if range(njchild,1,9).
*frequencies area subarea clor ccage1 cccage1 sex1 cfamily cinc cocr inter synmem jccmem member cgoisr donate ccamtfed.
*******************************************************************************************************************************************************************.

comment *****Day School 2***************************************************************************************************Hillel   School2.  
comment Table 9-46  Familiarity with Hillel percentages.
weight wf.
temporary.
select if range(njchild,1,9).
crosstabs tables = area subarea cclor20 ccage1 sex1 ccinc50 ccinc100 cocr inter synmem jccmem member cgoisr donate ccamtfed amt100 by famday2
	/cells = row.

******************************************************************************.

comment Table 9-48 perception of  Hillel perecentages.
weight wf.
temporary.
select if range(njchild,1,9).
crosstabs tables = famday2  area subarea age1849 cccage1 sex1 ccinc50 ccinc100 cocr inter synmem  jccmem member donate ccamtfed amt100 by quaday2
	/cells = row.

comment for Table 9-48 sample sizes for perception of Hillel.
*weight off.
*temporary.
*select if (any(famday2,1,2)) and (quaday2 ne 9) and range(njchild,1,9). 
*frequencies famday2 area subarea ccage1 sex1 cinc cocr inter synmem  jccmem member donate ccamtfed.


comment *****School 3***************************************************************************************************Frankel Jewish Academy School 3.
comment Table 9-50  Familiarity with Frankel Jewish Academy percentages.
weight wf.
temporary.
select if range(njchild,1,9).
crosstabs tables = area subarea cclor20 ccage1 sex1 ccinc50 ccinc100 cocr inter synmem jccmem member cgoisr donate ccamtfed amt100  by famday3
	/cells = row.

******************************************************************************.
comment Table 9-51 perception of  Frankel Jewish Academy perecentages.
weight wf.
temporary.
select if range(njchild,1,9).
crosstabs tables = famday3 area subarea  age1849 cccage1 sex1 ccinc50 ccinc100 inter cocr synmem jccmem member donate ccamtfed amt100 by quaday3
	/cells = row.

comment for Table 9-51 sample sizes for perception of Frankel Jewish Academy.
*weight off.
*temporary.
*select if (any(famday3,1,2)) and (quaday3 ne 9) and range(njchild,1,9). 
*frequencies famday3 area subarea ccage1 sex1 cinc cocr inter synmem  jccmem member donate ccamtfed.
*weight wf.

comment *****School 1***************************************************************************************************Farber/Akiva School 1.
comment Table 9-52  Familiarity with Akiva percentages.
weight wf.
temporary.
select if range(njchild,1,9).
crosstabs tables = area subarea cclor20 ccage1 sex1 ccinc50 ccinc100  cocr inter synmem jccmem member cgoisr donate ccamtfed amt100  by famday1
	/cells = row.

******************************************************************************.
comment Table 9-53 perception of  Farber/Akiva perecentages.
weight wf.
temporary.
select if range(njchild,1,9).
crosstabs tables = famday1  area subarea ccage1 age1849 cccage1 sex1 ccinc50 ccinc100 cocr inter synmem jccmem member donate ccamtfed amt100 by quaday1
	/cells = row.

comment for Table 9-52 sample sizes for perception of Farber/Akiva.
*weight off.
*temporary.
*select if (any(famday1,1,2)) and (quaday1 ne 9) and range(njchild,1,9). 
*frequencies famday1 area subarea ccage1 sex1 cinc cocr inter synmem  jccmem member donate ccamtfed.

comment *****Day School 4***************************************************************************************************Yeshiva Beth Yahudah School4.
comment Table 9-54  Familiarity with Yeshiva Beth Yahudah percentages.
weight wf.
temporary.
select if range(njchild,1,9).
crosstabs tables = area subarea cclor20 ccage1 sex1 ccinc50 ccinc100 cocr inter synmem jccmem member cgoisr donate ccamtfed amt100 by famday4
	/cells = row.

******************************************************************************.
comment Table 9-55 perception of  Beth Yahudah perecentages.
weight wf.
temporary.
select if range(njchild,1,9).
crosstabs tables = famday4  area subarea ccage1 age1849 cccage1 sex1 ccinc50 ccinc100  cocr inter synmem jccmem member donate ccamtfed amt100 by quaday4
	/cells = row.

comment for Table 9-55 sample sizes for perception of Beth Yahudah.
*weight off.
*temporary.
*select if (any(famday4,1,2)) and (quaday4 ne 9) and range(njchild,1,9). 
*frequencies famday4 area subarea ccage1 sex1 cinc cocr inter synmem  jccmem member donate ccamtfed amt100.

comment *****School 6***************************************************************************************************Yeshiva Gedolah School 6.
comment Table 9-56  Familiarity with Gedolah percentages.
weight wf.
temporary.
select if range(njchild,1,9).
crosstabs tables = area subarea cclor20 ccage1 sex1 ccinc50 ccinc100  cocr inter synmem jccmem member cgoisr donate ccamtfed amt100 by famday6
	/cells = row.

******************************************************************************.
comment Table 9-57 perception of Gedolah perecentages.
weight wf.
temporary.
select if range(njchild,1,9).
crosstabs tables = famday6  area subarea ccage1 age1849 cccage1 sex1 ccinc50 ccinc100 cocr inter  synmem jccmem member donate ccamtfed amt100 by quaday6
	/cells = row.

comment for Table 9-57 sample sizes for perception of Gedolah.
*weight off.
*temporary.
*select if (any(famday6,1,2)) and (quaday6 ne 9) and range(njchild,1,9). 
*frequencies famday6 area subarea ccage1 sex1 cinc cocr inter synmem  jccmem member donate ccamtfed.


comment *****School 5***************************************************************************************************Yeshivas Darchei Torah School 5 .
comment Table 9-58  Familiarity with Darchei percentages.
weight wf.
temporary.
select if range(njchild,1,9).
crosstabs tables = area subarea cclor20 ccage1 sex1 ccinc50 ccinc100  cocr inter synmem jccmem member cgoisr donate ccamtfed by famday5
	/cells = row.

******************************************************************************.
comment Table 9-59 perception of Darchei perecentages.
weight wf.
temporary.
select if range(njchild,1,9).
crosstabs tables = famday5  area subarea ccage1 age1849 cccage1 sex1 ccinc50 ccinc100 cocr inter synmem jccmem member donate ccamtfed amt100 by quaday5
	/cells = row.

comment for Table 9-59 sample sizes for perception of Darchei.
*weight off.
*temporary.
*select if (any(famday5,1,2)) and (quaday5 ne 9) and range(njchild,1,9). 
*frequencies famday5 area subarea ccage1 sex1 cinc cocr inter synmem  jccmem member donate ccamtfed.

********************************************************************************************************************************************************************.
comment chapter 10 Social Service Needs.
********************************************************************************************************************************************************************.

comment Table 10-1: Households in Which a Member is Health Limited.
**************************************************************************************.
weight wf.
crosstabs tables = area subarea cfamily cinc ccinc50 by disability
          /cells = row.

comment Table 10-5 Need for Selected Social Services.
********************************************************************.
frequencies variables = coor coory coun fin job. 

temporary.
select if jhhc eq 1.
frequencies ldis cment.

temporary.
select if nelder75 ge 1.
frequencies variables = hh supserv handy  tran nurs sday alf meal needss.

comment Table 10-10 top get results for 18-64, not 18-75.
weight wf.
temporary.
select if (nadults1864 ge 1).
frequencies job.

temporary.
select if nelder75 eq 0.
frequencies variables = hh supserv handy  tran nurs sday alf meal needss.
weight wf.

comment Table 10-17 Need for Coordinating Services for elderly.
******************************************************************************. 
weight wf.
crosstabs tables = area subarea cfamily cinc ccinc50 by ccoor
	         /cells = row.

*weight off.
*crosstabs tables = area subarea cfamily  anydiv anywid cinc ccinc50 inter by ccoor
	         /cells = count.

comment Table 10-17 Need for Coordinating Services for non-elderly.
************************************************************************************.
crosstabs tables = area subarea cfamily cinc ccinc50 by ccoory
	         /cells = row.

comment Table 10-17 Need for Counseling.
*****************************************************.   
crosstabs tables = area subarea cfamily anydiv anywid cinc ccinc50 inter by ccoun
	         /cells = row.

comment Table 10-17 Need for Financial Assistance.
*************************************************************.
crosstabs tables = area subarea cfamily anydiv anywid cinc ccinc50 by cfin
	         /cells = row.

comment Table 10-17  Need for Job Counseling.
***********************************************************.
crosstabs tables = area subarea cfamily cinc ccinc50 by cjob
	         /cells = row.

*weight off.
*temporary.
*crosstabs tables = area subarea cfamily cinc ccinc50 by cjob
	           /cells = count.
*weight wf.

comment Table 10-18 Need for Learning Disabled Programs.
**************************************************************************.
temporary.
select if jhhc eq 1.
crosstabs tables = area subarea cinc ccinc50 ccinc100 by cldis
	         /cells = row.

comment for sample sizes.
*weight off.
*crosstabs tables = area subarea cinc ccinc50 ccinc100 by cldis
	         /cells = count.
*weight wf.

comment Table 10-18 Need for Mental Health Services for Children.
**************************************************************************.
temporary.
select if jhhc eq 1.
crosstabs tables = area subarea cinc ccinc50 ccinc100 by ccment
	         /cells = row.

*comment for sample sizes.
*weight off.
*crosstabs tables = area subarea cinc ccinc50 ccinc100 by ccment
	         /cells = count.
*weight wf.

comment Table 10-19a Need for Home Health Care.
*************************************************************.
temporary.
select if nelder75 ge 1.
crosstabs tables = area subarea cfamily cinc ccinc50 ccinc100 by chh 
	         /cells = row.

*weight off.
comment for sample sizes.
*temporary.
*select if nelder75 ge 1.
*crosstabs tables = area subarea cfamily cinc ccinc50 ccinc100 by chh 
	         /cells = count.
*weight wf.

comment Table 10-19a Need for In-Home support services.
*************************************************************.
temporary.
select if nelder75 ge 1.
crosstabs tables = area subarea cfamily cinc ccinc50 ccinc100 by csupserv 
	         /cells = row.

comment Table 10-19a Need for Handyman services.
*************************************************************.
temporary.
select if nelder75 ge 1.
crosstabs tables = area subarea cfamily cinc ccinc50 ccinc100 by chandy
	         /cells = row.

comment Table 10-19a Need for Home Delivered Meals.
*******************************************************************.
temporary.
select if nelder75 ge 1.
crosstabs tables = area subarea family cfamily cinc ccinc50 ccinc100 by cmeal
	         /cells = row.

comment Table 10-19b Need for ALF.
********************************************.
temporary.
select if nelder75 ge 1.
crosstabs tables = area subarea cfamily cinc ccinc50 ccinc100 by calf
	         /cells = row.

comment Table 10-19b Need for Nursing Home Care.
***************************************************************.
temporary.
select if nelder75 ge 1.
crosstabs tables = area subarea cfamily cinc ccinc50 ccinc100 by cnurs
	         /cells = row.

comment Table 10-19b Need for Adult Day Care.
***************************************************************.
temporary.
select if nelder75 ge 1.
crosstabs tables = area subarea cfamily cinc ccinc50 ccinc100 by csday
	         /cells = row.

comment Table 10-19b Need for Transportation.
********************************************************.
temporary.
select if nelder75 ge 1.
crosstabs tables = area subarea cfamily cinc ccinc50 ccinc100 by ctran
	         /cells = row.
 
comment Table 10-20 Preference for Jewish-Sponsored Adult Care Facilities.
 ********************************************************************************************.
weight wf.
crosstabs tables = area subarea ccage1  cccage1 jsex cfamily cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed amt100 by pjalf
	         /cells = row.

comment for preference for Jewish sample size.
*weight off.
*crosstabs tables = area subarea ccage1  cccage1 jsex cfamily cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed amt100 by pjalf
	         /cells = count.

comment Table 10-22 Preference for Kosher Food at Jewish-Sponsored Kosher Food at Jeiwsh Sponsored adult care facilities.
 ********************************************************************************************.
Weight wf.
frequencies prefkosher prefkosher2.
comment there are only 13 respondents for prefkosher so nothing will be done with the information.
crosstabs tables = area subarea ccage1  cccage1 jsex cfamily cinc ccinc50 ccinc100 cocr inter synmem jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed amt100 by prefkosher2
	         /cells = row.

comment Table 10-23 Caring for an Elderly Relative.
***************************************************************.
weight wf.
missing values eldcare (1).
frequencies eldcare celdcare.

comment Table 10-25. Caring for an Elderly Relative and Has Children in Household.
weight wf.
temporary.
select if (cfamily eq 201).
frequencies eldcare.
comment the number of households who care for an eldelry relative (Detroit = 476) has to be divided by the number of households age 40 and over.)

comment Table 10-26.
weight wf.
temporary.
select if age1 ge 75.
frequencies variables = aclocal.

*********************comment the following are for the text of chapter 10*****************************************************.
comment for text on Disabiilty, omits 75+ for estimate of disabilitities.
weight wf.
mult response groups = emp 'employ' (cemp1 cemp2 cemp3 cemp4 cemp5 cemp6 cemp7 (101,108))
	         age 'age distribution' (ccage1 ccage2 ccage3 ccage4 ccage5 ccage6 ccage7 (2,5))  
	         /tables = emp by age (paired)
        	 /base=responses
        	 /cells= column.

comment following is to help determine households in which a disabled adult lives with parents.
temporary.
select if (emp1 eq 6 or emp2 eq 6 or emp3 eq 6 or emp4 eq 6 or emp5 eq 6 or emp6 eq 6 or emp7 eq 6) and (hhsiz ge 2).
Report
  /FORMAT= CHWRAP(ON) PREVIEW(OFF) CHALIGN(BOTTOM)  UNDERSCORE(ON)
  ONEBREAKCOLUMN(OFF) CHDSPACE(1)  SUMSPACE(0)  AUTOMATIC  LIST
   BRKSPACE(-1)
  PAGE(1) MISSING'.' LENGTH(1, 59) ALIGN(LEFT) TSPACE(1) FTSPACE(1)
 MARGINS(1,148)
 /TITLE=
  RIGHT 'Page )PAGE'
   /VARIABLES
 id  (VALUES)  (RIGHT)  (OFFSET(0)) (9)
 age1  (VALUES)  (RIGHT)  (OFFSET(0)) (9)
 age2  (VALUES)  (RIGHT)  (OFFSET(0)) (9)
 age3  (VALUES)  (RIGHT)  (OFFSET(0)) (9)
 rel2 (VALUES)  (RIGHT)  (OFFSET(0)) (9)
 rel3 (VALUES)  (RIGHT)  (OFFSET(0)) (9)
 emp1  (VALUES)  (RIGHT)  (OFFSET(0)) (19)
 emp2  (VALUES)  (RIGHT)  (OFFSET(0)) (19)
 emp3  (VALUES)  (RIGHT)  (OFFSET(0)) (19)
 emp4  (VALUES)  (RIGHT)  (OFFSET(0)) (19).

weight wf.
compute dischild = 2.
if any(id,24,185,263,481,856,1070,1093,1116) dischild = 1.
variable labels dischild 'Adult Disabled Child in Household'.
value labels dischild 1 'Yes' 2 'No'.
frequencies dischild.

comment for number of households with a Jewish child.
frequencies jhhc.

comment for number of households with an elderly person.
weight wf.
frequencies nelder75.

comment for getting number of households with respondent age 40 and over and number age 40+ with kids.
temporary.
select if cj1 eq 1.
frequencies cage1.
comment run without the select if for "Caring for Elderly Relatives'.
frequencies cage1.

comment for Caring for Non-Elderly Relative.
frequencies givecareyoung.

temporary.
select if (cfamily eq 201).
frequencies cage1.

********************************************************************************************************************************************************************.
comment chapter 11.
********************************************************************************************************************************************************************.
comment Table 11-1: Households Visited Israel.
**********************************************************.
weight wf.
frequencies ago goisr cgo goisrc anyisr.
crosstabs tables =  area subarea cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member donate ccamtfed by anyisr
          /cells = row.

comment Table 11-4: Trips by Jewish Children.
********************************************************.
temporary.
select if range(njchild617,1,9).
frequencies cgoisrc.

comment For the Teenage Column.
temporary.
select if range(njteen,1,7).
frequencies cgoisrc.

comment Table 11-7: Cost of Sending Kids to Israel.
****************************************************************.
weight wf.
frequencies costisr.
crosstabs tables = area subarea headage headage1849 cinc ccinc50 ccinc50a ccinc100  cocr inter synmem chabad jccmem  member cgoisr donate amt100 by costisr
          /cells = row.  

*weight off.
*crosstabs tables = area subarea headage headage1849 cinc ccinc50 ccinc100 cocr inter synmem chabad jccmem  member cgoisr donate amt100 by costisr
          /cells = count.

comment Table 11-8: Emotional Attachment to Israel.
********************************************** ***************.
crosstabs tables =  area subarea cclor10a ccage1 cccage1 jsex cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel cgoisr donate ccamtfed  by emotion
	         /cells = row.  

comment Table 11-13: Conversations about Israel.
************************************************************.
weight wf.
crosstabs tables = area subarea clor cclor10a ccage1 cccage1 sex1 cfamily cinc cocr inter synmem chabad jccmem member cgoisr donate ccamtfed by convisr
     /cells = row.

comment Table 11-14: Hesitate
**********************************************************.
weight wf.
frequencies hesitate.
crosstabs tables =  area subarea clor cclor10a cage1 sex1 cfamily cinc cocr inter synmem chabad jccmem member cgoisr antism donate ccamtfed by hesitate
   	/cells = row.

********************************************************************************************************************************************************************.
comment chapter 12.
********************************************************************************************************************************************************************.
comment Table 12-1: Personal Experience with Anti-Semitism.
***************************************************************************.
weight wf.
crosstabs tables =  area subarea cclor10a ccage1  cccage1 sex1 cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member donate ccamtfed by antiyr
          /cells = row.

comment Table 12-3: Children's Anti-Semitism Experience.
***********************************************************************.
weight wf.
temporary.
select if range(njchild617,1,9).
frequencies antichild.
comment this question asked of half the sample so get the number of households with Jewish children age 617 here.
frequencies  njchild617.

Temporary.
select if antichild eq 1.
frequencies zip.


comment Table 12-5: Perception of Anti-Semitism.
*************************************************************.
frequencies antism.
crosstabs tables =  antiyr  area subarea cclor10a ccage1  cccage1 sex1 cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cgoisr donate ccamtfed by antism
         	/cells = row.


comment Table 12-7: Survivors.
***************************************.
weight wf.
frequencies holo0 cholo0 gholo0 anyshoah anyshoahg.

weight wf.
mult responses groups = cholo 'Child of Holocaust Survivor' (cholo1 cholo2 cholo3 cholo4 cholo5 cholo6 cholo7 (1,2)) 
	holo 'Holocaust Survivor' (holo1 holo2 holo3 holo4 holo5 holo6 holo7 (1,2)) gholo 'Grandchild of Holocaust Survivor' (gholo1 gholo2 gholo3 gholo4 gholo5 gholo6 gholo7 (1,2))
	/frequencies = holo cholo gholo
	/base= responses
	/cells = column
	/missing = include.

********************************************************************************************************************************************************************.
comment chapter 13 Media.
********************************************************************************************************************************************************************.
Comment Table 13-1*************************************************************************************Readership of the Jewish Newspaper.
crosstabs tables = area subarea cclor10a ccage1 cccage1 jsex cfamily cinc ccinc50 cocr inter synmem chabad jccmem member cajed ajed sleep yg hillel cgoisr famfed donate ccamtfed by jread 
	         /cells = row.

Comment Table 13-3************************************************************************************* Print or on-line for Readership of the Jewish Newspaper.
crosstabs tables = area subarea cclor10a ccage1 cccage1 jsex cfamily cinc ccinc50 cocr inter synmem chabad jccmem member cgoisr famfed donate ccamtfed by jreadP_OL 
	/cells = row.

comment Table 13-4 ****************************************************************************************Perception of the Jewish Newspaper.
weight wf.
crosstabs tables = jread area subarea ccage1 cccage1 jsex cfamily cinc ccinc50 ccinc100 cocr inter synmem jccmem  member famfed donate ccamtfed by quaread
 	        /cells = row.

*weight off.
*crosstabs tables = jread area subarea ccage1  cccage1 jsex cfamily cinc ccinc50 ccinc100 cocr inter synmem jccmem  member famfed donate ccamtfed by quaread
          /cells = count.
*weight wf.

Comment Table 13-6*************************************************************************************Profile of Readers of the Jewish Newspaper.
crosstabs tables = area city clor ccage1  jsex profilefamily cinc profileocr mezz cseder chancan cfcan kosherin kout lights ctree  ccattend aded othered cultural 
          inter synmem chabad jccmem  member partloc aded profileajed sleep yg hillel cgoisr emotion donate ccamtfed cjchar1 cnjchar1 by cjread  
	         /cells = column.

Comment Table 13-7************************************************************************************* Visited Federation web site.
weight wf.
crosstabs tables =   area subarea ccage1 age1849  cccage1 jsex cfamily cinc ccinc50 cocr inter synmem chabad jccmem  jccmem member  cgoisr donate ccamtfed by ownweb  
          /cells = row.

Comment Table 13-9************************************************************************************* Perception of Federation web site.
weight wf.
crosstabs tables = area subarea ccage1 age1849 cccage1 jsex cfamily cinc ccinc50 ccinc100 cocr inter synmem jccmem  member famfed donate ccamtfed by quaweb
          /cells = row.

*weight off.
*crosstabs tables = area subarea ccage1 age1849 cccage1 jsex cfamily cinc ccinc50 ccinc100 cocr inter synmem jccmem  member famfed donate ccamtfed by quaweb
          /cells = count.
*weight wf.

****************************************************************************************************************************************************************** .
comment for the text of Chapters 11-13.
temporary.
select if antichild eq 1.
frequencies zip.

********************************************************************************************************************************************************************.
comment chapter 14 Philanthropy Behavior.
********************************************************************************************************************************************************************.
comment Table 14-1*************************************************************************overall levels of donations.
comment use the totals from this table in later tables.

frequencies donate amtfed jchar1 njchar1 anyJ$. 

comment Table 14-2**********************************************************Federation Market Segments.
crosstabs tables =  area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel famfed cquafed cgoisr emotion party2 by donate 
          /cells = row.

comment Table 14-6**********************************************************Jewish Federation Amounts Given.
crosstabs tables = area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel famfed cquafed cgoisr emotion party2 by camtfed 
           /cells = row.

comment Table 14-8*************************************************************Federation Market Segments Profile.
crosstabs tables = area city clor headage profilefamily inc profileocr mezz cseder chancan cfcan kosherin kout lights ctree ccattend  aded othered cultural 
               inter synmem chabad jccmem partjcc member partloc profileajed ajed sleep yg hillel famfed quafed cgoisr emotion cjchar1 cnjchar1 party2 by donate 
	         /cells = column.

comment Table 14-9*************************************************************Federation Amounts Given Profile.
crosstabs tables = area city clor headage profilefamily inc profileocr mezz cseder chancan cfcan kosherin kout lights ctree ccattend  aded othered cultural 
	            inter synmem chabad jccmem partjcc member partloc profileajed ajed sleep yg hillel famfed quafed cgoisr emotion cjchar1 cnjchar1 party2 by ccamtfed
          /cells = column.

comment Table 14-15**********************************************************Amounts Given to Other Jewish Charities.
crosstabs tables = area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel famfed cquafed cgoisr donate ccamtfed party2 by cjchar1 
	         /cells = row.

comment Table 14-17********************************************************Federations/other Jewish Charities Overlaps.
crosstabs tables = cdonate by jchar
	         /cells = total.

comment Table 14-18**********************************************************Give to Any Jewish Charities.
crosstabs tables =  area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel famfed cquafed cgoisr cgoisr emotion
    donate ccamtfed party2 by anyj$ 
          /cells = row.

comment Table 14-20**********************************************************Amounts Given to Non-Jewish Charities.
crosstabs tables = area subarea cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel  famfed cquafed cgoisr emotion
     donate ccamtfed party2 by cnjchar1 
	         /cells = row.

comment Table 14-22********************************************************Jewish Charities/Non-Jewish Charities Overlaps.
crosstabs tables = area subarea  cclor10a headage cheadage cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cajed ajed sleep yg hillel famfed cquafed cgoisr emotion
    donate ccamtfed party2 by jnjovrlp 
          /cells = row.

comment Table 14-24******************************************************** Made a Donation to a Charity Over the Internet.
crosstabs tables = area subarea  cclor10a headage cheadage sex1 cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member donate ccamtfed by giveinternet 
          /cells = row.

comment Table 14-27*******************************************************************Wills.
crosstabs tables =  heirs area subarea cclor10a cclor20 ccage1  cccage1 sex1 cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member famfed cgoisr donate ccamtfed party2 by newwill2 
          /cells = row.

*weight off.
*crosstabs tables = heirs area subarea cclor10a ccage1 cccage1 jsex cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member famfed cgoisr donate ccamtfed by newwill2
              /cells = count.
*weight wf.

*comment Table 14-29*******************************************************************Know About Department that Helps with Estate Planning.
comment only about 15 responses.
*weight wf.
*crosstabs tables =  area subarea cclor10a cclor20 ccage1  cccage1 sex1 cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member famfed cgoisr donate ccamtfed by knowplan 
          /cells = row.

*weight off.
*crosstabs tables =  area subarea cclor10a cclor20 ccage1  cccage1 sex1 cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member famfed cgoisr donate ccamtfed by knowplan 
          /cells = count.

comment Table 14-29*********************************************************************Volunteer.
weight wf.
crosstabs tables = area subarea cclor10a  ccage1 age1849 cccage1 jsex cfamily cinc cocr inter synmem chabad jccmem member ajed cajed sleep yg hillel famfed cgoisr donate ccamtfed party2 by vol 
          /cells = row.

weight wf.
frequencies nogivefed qn121cot.
Weight wf.

********************************************************************************************************************************************************************.
comment chapter 15.
********************************************************************************************************************************************************************.
comment run the following to get the order of the sections.
weight wf.
comment Table 15-1.
frequencies jedec to scholarships.

comment for new slide.
temporary.
select if range(amtfed,1,7).
frequencies jedec to scholarships.

*weight off.
*crosstabs tables = famfed ccage1 age1849 cccage1 sex1 cinc ccinc50 ccinc100 amtfed ccamtfed by pisr
          /cells = count.
w eight wf.

comment Table 15-3 Jews in Detroit in Need.
**************************************************************.
weight wf.
crosstabs tables = famfed ccage1 age1849 cccage1 sex1 ccinc50 inc100 ccamtfed  by poor
	/cell = row.

comment Table 15-4 Elderly Needs.
*******************************************.
crosstabs tables = famfed ccage1 age1849 cccage1 sex1 ccinc50 inc100 ccamtfed by eld
                  /cells = row.

comment Table 15-6 Jewish Education for Children.
**************************************************************.
crosstabs tables = famfed ccage1 age1849 cccage1 sex1 ccinc50 inc100 ccamtfed  by jedec
	/cell = row.

comment Table 15-8 People of Israel.
*********************************************.
crosstabs tables = famfed ccage1 age1849 cccage1 sex1 ccinc50 inc100 ccamtfed by pisr
                  /cells = row.

comment Table 15-11  Social, Recreational, Cultural Activities.
***************************************************************************.
crosstabs tables = famfed ccage1 age1849 cccage1 sex1 ccinc50 inc100 ccamtfed by oppsrc
                 /cells = row.

comment Table 15-13 Helping Jewish Communities Elsewhere in the World.
*******************************************************************************************.
crosstabs tables = famfed ccage1 age1849 cccage1 sex1 ccinc50 inc100 ccamtfed by jover
                  /cells = row.

comment Table 15-15 Helping Jewish Children Go to Israel.
*******************************************************************************************.
crosstabs tables = famfed ccage1 age1849 cccage1 sex1 ccinc50 inc100 ccamtfed by child2isr
                  /cells = row.

comment Table 15-16  Organizations that Help both Jews and non-Jews.
***************************************************************************************.
crosstabs tables = famfed ccage1 age1849 cccage1 sex1 ccinc50 inc100 ccamtfed  by jorgnj
	/cells = row.

comment Table 15-17  Helping Jewish Children Go to Jewish Summer Camp
***************************************************************************************.
crosstabs tables = famfed ccage1 age1849 cccage1 sex1 ccinc50 inc100 ccamtfed  by child2camp
	/cells = row.

comment Table 15-18  Supporting Scholarships to Jewish Day School.
***************************************************************************************.
crosstabs tables = famfed ccage1 age1849 cccage1 sex1 ccinc50 inc100 ccamtfed  by scholarships
	/cells = row.


comment Table 15-19 Give More to Federation if.
************************************************************.
weight wf.
crosstabs tables = famfed  ccage1 age1849 cccage1 sex1 ccinc50 inc100 spamtfed by mor2loc
	/cells = row.
crosstabs tables = famfed  ccage1 age1849 cccage1 sex1 ccinc50 inc100 spamtfed by mor2isr
	/cells = row.
crosstabs tables = famfed ccage1 age1849 cccage1 sex1 ccinc50 inc100 spamtfed  by morsay
	/cells = row.
crosstabs tables = famfed  ccage1 age1849 cccage1 sex1 ccinc50 inc100 spamtfed  by askfrnd
	/cells = row.
crosstabs tables = famfed  ccage1 age1849 cccage1 sex1 ccinc50 inc100 spamtfed  by inperson
	/cells = row.

*weight off.
*  crosstabs tables = famfed  ccage1 age1849 cccage1 sex1 ccinc50 spamtfed by mor2loc
	/cells = count.
*weight wf.

********************************************************************************************************************************************************************.
comment chapter 16.
********************************************************************************************************************************************************************.

comment Table 16-1.
crosstabs tables =  area subarea cclor10a ccage1 cccage1  sex1  cfamily cinc ccinc50 cocr inter synmem chabad jccmem  member cgoisr emotion donate ccamtfed by party2 
               /cells = rows.

********************************comment for profile by party ********************************************************************.
comment Table 16-4.
crosstabs tables =area city clor ccage1 sex1 profilefamily cinc ccinc50 profileocr inter synmem chabad jccmem  member cgoisr emotion donate camtfed cjchar1 cnjchar1 by party2 
          /cells = column.

comment Table 16-5.
frequencies reg.

comment Table 16-6.
crosstabs tables = reg by ccage1
     /cells = column.

comment for text of Chapter 16.
************************************.
weight wf.
means tables = njadult by party2.
frequencies reg2 vote.


****************************************************************************************************************************************************************************************.
****************************************************************************************************************************************************************************************.
comment  for 1989 study.
****************************************************************************************************************************************************************************************.
weight wtfactor.
frequencies variables = zip 
         /format=dfreq.

frequencies lor.
comment adults and childen are same variables.
frequencies age1 age2 age3 age4 age5 age6.
frequencies sex1 sex2 sex3 sex4 sex5 sex6.
missing values age2 (0 98) sex2 (0).
missing values age1 age3 age4 age5 age6 (98).
********************************************************************************************************************************************************************.
comment Page 5: age groups in census age categories. 1989
********************************************************************************************************************************************************************.
comment all age variables contain both adults and children.
compute cage1 = age1.
compute cage2 = age2.
compute cage3 = age3.
compute cage4 = age4.
compute cage5 = age5.
compute cage6 = age6.
variable labels cage1 'age-respondent' cage2 'age-pers 2' cage3 'age-pers 3' cage4 'age-pers 4' cage5 'age-pers 5' cage6 'age-pers 6'. 
recode cage1 to cage6 (0 thru 4 = 1) (5 thru 9 = 2) (10 thru 14 = 3) (15 thru 19 = 4) (20 thru 24 = 5) (25 thru 29 = 6) (30 thru 34 = 7) (35 thru 39 = 8) 
	(40 thru 44 = 9) (45 thru 49 = 10) (50 thru 54 = 11) (55 thru 59 = 12) (60 thru 64 = 13) (65 thru 69 = 14) (70 thru 74 = 15)
	(75 thru 79 = 16) (80 thru 84 = 17) (85 thru 89 = 18) (90 thru 110 = 19).
value labels cage1 to cage6 1 '0-4' 2 '5-9' 3 '10-14' 4 '15-19' 5 '20-24' 6 '25-29' 7 '30-34' 8 '35-39' 9 '40-44' 10 '45-49' 11 '50-54' 
	12 '55-59' 13 '60-64' 14 '65-69' 15 '70-74' 16 '75-79' 17 '80-84' 18 '85-89' 19 '90+'.
frequencies age6 cage6 .

********************************************************************************************************************************************************************.
comment Page 5: age groups in school age categories. 1989
********************************************************************************************************************************************************************.
compute sage1 = age1.
compute sage2 = age2.
compute sage3 = age3.
compute sage4 = age4.
compute sage5 = age5.
compute sage6 = age6.

variable labels sage1 'age-respondent' sage2 'age-pers 2' sage3 'age-pers 3' sage4 'age-pers 4' sage5 'age-pers 5' sage6 'age-pers 6'.

recode sage1 to sage6 (0 thru 5 = 1)(6 thru 12 = 2)(13 thru 17 = 3) (18 thru 24 = 4)(25 thru 34 = 5) 
	(35 thru 44 = 6) (45 thru 54 = 7) (55 thru 64 = 8)(65 thru 74 = 9)(75 thru 84 = 10) (85 thru 110 = 11).

value labels sage1 to sage6 1 '0-5' 2 '6-12' 3 '13-17' 4 '18-24 ' 5 '25-34 ' 6 '35-44' 7 '45-54' 8 '55-64 ' 9 '65-74 ' 10 '75-84 ' 11 '85+'.
frequencies  age1 sage1.

comment Table 5-1 Age by Sex.
mult response groups =
	      age  'age distribution' (cage1 cage2 cage3 cage4 cage5 cage6 (1,20))
	      sage 'age distribution' (sage1 sage2 sage3 sage4 sage5 sage6 (1,20))
	      sex (sex1 sex2 sex3 sex4 sex5 sex6 (1,2))	
        /frequencies age sage
        /tables = age by sex (paired) 
	       /tables = sage by sex (paired)
	       /base = responses
	       /cells = total.

********************************************************************************************************************************************************************.
comment Page 5: age groups in large age categories. 1989
********************************************************************************************************************************************************************.
compute ccage1 = cage1.
recode ccage1 (1 thru 3 = 1) (4 thru 7 = 2) (8 thru 10 = 3) (11 thru 13 = 4)(14,15 = 5) (16 thru 19 = 6).
value labels ccage1 1 '0-17'      2 '18-34'     3 '35-49'     4 '50-64'     5 '65-74'     6 '75+'.

variable labels ccage1 'age of respondent'. 
frequencies cage1 ccage1.

compute cccage1 = ccage1.
Recode cccage1 (1 thru 4=101) (5 thru 6=102).
Value labels cccage1 'Non-Elderly' 102 'Elderly 65+'.
Variable labels cccage1 'Eld-NonEld Age Adult 1'.
Value labels cccage1 101 'Non-Elderly' 102 'Elderly 65+'.
frequencies ccage1 cccage1. 

compute nchild = 0.
if range(age2,0,17) nchild = nchild + 1.
if range(age3,0,17) nchild = nchild + 1.
if range(age4,0,17) nchild = nchild + 1.
if range(age5,0,17) nchild = nchild + 1.
if range(age6,0,17) nchild = nchild + 1.
frequencies nchild.

compute nadult = 0.
if range(age1,18,97) nadult = nadult + 1.
if range(age2,18,97) nadult = nadult + 1.
if range(age3,18,97) nadult = nadult + 1.
if range(age4,18,97) nadult = nadult + 1.
if range(age5,18,97) nadult = nadult + 1.
if range(age6,18,97) nadult = nadult + 1.
frequencies nadult.

compute family = 0.
if (mar1 eq 1) and range(nchild,1,6) family = 101.
if (nadult eq 1) and range(nchild,1,6) family = 102.
frequencies family.

weight wf.
frequencies mar1.
crosstabs tables = mar1 by ccage1
    /cells = column.

compute family = 0.
if ((nchild eq 0) and (hhsiz eq 2) and (mar1 eq 1)) family eq 101.
frequencies family.
crosstabs tables = family by ccage1 cccage1
    /cells = row.

frequencies hhsiz.

temporary.
select if hhsiz eq 1.
crosstabs tables = cccage1 by sex1
    /cells = total.

compute cnadult = nadult.
recode cnadult (2 thru 6 = 2).
crosstabs tables = nchild by nadult cnadult.

comment weighted elderly is 106.

comment Table 5-18 Age.
compute chhsiz = hhsiz.
recode chhsiz (2 thru 6 = 2).
mult response groups =
	        age '  age distribution' (cage1 cage2 cage3 cage4 cage5 cage6 (1,20))
         /variables = chhsiz (1,6)
         /tables = age by chhsiz 
        	/base = responses
        	/cells = column.

frequencies mar1 deg1 emp1 emp2.

mult response groups = emp 'employment' (emp1 emp2 (1,8))
         /variables = cccage1 (101,102)
                /frequencies = emp
        /tables = emp by cccage1 (paired) 
        	/base = responses
        	/cells = column.

frequencies income.
temporary.
select if range(nchild,1,5).
frequencies income jccmem.

temporary.
select if range(age1,65,97).
frequencies income.

frequencies hancan seder fcan kosherin.
compute practice = 2.
if any(hancan,1,2) practice = 1.
if any(seder,1,2) practice = 1.
if any(fcan,1,2) practice = 1.
if (kosherin eq 1) practice = 1.
value labels practice 1 'Yes' 2 'No'.
variable labels practice 'Summary Practice Measure'.
frequencies practice.

MISSING VALUES inter (0).
crosstabs tables = ccage1 cccage1 by inter
	      /cells = row.

crosstabs tables = ccage1 cccage1 by synmem
	      /cells = row.

crosstabs tables = jccmem by inter
	      /cells = row.

crosstabs tables = ccage1 cccage1 by cjfed
	      /cells = row.
*******************************************************************************************************************************************.
comment this section is to get overall results for Chapter 8 2005 since only Non-Orthodox results were presented in that report.
comment for Detroit 2005.
weight wfhh.
temporary.
select if range(njchild,1,9).
crosstabs tables = ccocr  by consider
         /cells = row.
comment for Detroit 2005.
weight wfhh.
mult response groups = cjed 'Child Currently Attends Jewish Education' (cjed1 cjed2 cjed3 cjed4 cjed5 cjed6 cjed7 cjed8 cjed9 (101,104))
     	sagea 'school age  groups' (sagec1a sagec2a sagec3a sagec4a sagec5a sagec6a sagec7a sagec8a sagec9a (101,102))  cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1))
   	/tables = sagea by cjed by cjc (paired)
       	/base=responses
                  /cells = row.

comment for Detroit 2005.
comment for non-Orthodox by 5-12 and 13-17.
weight wfhh.
mult response groups = everjed 'Ever Attended Jewish Education' (everjed1 everjed2 everjed3 everjed4 everjed5 everjed6 everjed7 everjed8 everjed9 (101,104))
      	sagea 'school age groups' (sagec1a sagec2a sagec3a sagec4a sagec5a sagec6a sagec7a sagec8a sagec9a (101,102)) 
	cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1))
                  /variables= ccocr (101,201) 
	            /tables = everjed by sagea by ccocr by cjc (paired)
          /base=responses
          /cells= column.

weight wfhh. 
comment detroit 2005 for overnight camp.
mult response groups = scamp 'Attended Day Camp' (scamp1 scamp2 scamp3 scamp4 scamp5 scamp6 scamp7 scamp8 scamp9  (201,203)) cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9  (1,1)) 
 	        /tables = scamp by cjc (paired)
    	     /base=responses
    	    /cells = column.

comment detroit 2005 youth group.
weight wfhh.
mult response groups = ygc 'Youth Group Attendance' (ygc1 ygc2 ygc3 ygc4 ygc5 ygc6 ygc7 ygc8 ygc9 (1,2)) 	
	        sagec 'school age groups' (sagec1c sagec2c sagec3c sagec4c sagec5c sagec6c sagec7c sagec8c sagec9c (102,102)) 	cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1))
 	       /variables=  ccocr (101,201) 
	        /tables = ccocr  by ygc by sagec by cjc (paired)
 	       /base=responses
	        /cells = row.

comment any type of Jewish Education.
wfhh.
mult response groups = anyjew 'Child is doing any type of Jewish Education' (anyjew1 anyjew2 anyjew3 anyjew4 anyjew5 anyjew6 anyjew7 anyjew8 anyjew9 (101,102)) 	
	          cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1)) 
	          /variables=  ccocr (101,201) 
                            /tables anyjew by cjc (paired)
	         /tables = ccocr  by anyjew by cjc (paired)
 	        /base=responses
	         /cells = row.


comment for 2005.
mult response groups = school 'type of education' (school1 school2 school3 school4 school5 school6 school7 school8 school9 (101,103)) sex (sexc1 sexc2 sexc3 sexc4 sexc5 sexc6 sexc7 sexc8 sexc9 (1,2))
          sagea 'school age groups' (sagec1a sagec2a sagec3a sagec4a sagec5a sagec6a sagec7a sagec8a sagec9a (101,102))  cjc 'Child is Currently Jewish' (cjc1 cjc2 cjc3 cjc4 cjc5 cjc6 cjc7 cjc8 cjc9 (1,1))
         /tables = sagea by school by cjc (paired)        
          /base=responses
          /cells= row.


weight HHwght.
frequencies Qn95.

weight wf.
temporary.
select if OakPark eq 1.
*select if Huntwoods eq 1.
frequencies anyisr emotion antiyr antism party2.  


