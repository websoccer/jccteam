* Encoding: UTF-8.
sex* Encoding: UTF-8.
comment this program for Detroit 2018.
comment page numbers refer to the Easy to Read Questoinnaire.

if (bj1 eq 1) experiences = 0.
if (cajed eq 101) experiences = experiences + 1.
if (cajed eq 102) experiences = experiences + 1.
if (sleep eq 1) experiences = experiences + 1.
if (yg eq 1) experiences = experiences + 1.
if (hillel eq 1) experiences = experiences + 1.
if (cgoisr eq 100) experiences = experiences + 1.
if (cgoisr eq 101) experiences = experiences + 1.
frequencies experiences.
compute cexp = experiences.
recode cexp (3 4 5 = 3).
weight wf.
crosstabs tables = synmem amt100 inter seder by cexp 
    /cells = column.

crosstabs tables = synmem amt100 inter seder by cexp
    /cells = row.

crosstabs tables = amt100 inter seder by cajed sleep yg hillel cgoisr
    /cells = column.


variable labels length 'Length of Interview in Minutes'.

compute WF = HHwght.
variable labels WF 'Household Weighting Factor'.
comment to round number of households to 10000.
compute WF3 = wf*31500/31676.
weight wf3.
comment i then changed wf3 to wf in the file.
frequencies hhsiz.
means hhsiz.

****************************************************************************************************************************************************************.
comment residential changes Page 4.
comment page numbers refer to Demographic Study Committee version of questionnaire.
********************************************************************************************************************************************************************.
weight off.
frequencies lor to wmove.

*******************************************************************************************************************************************************************.
compute area = 102.
comment adding Royal Oak to the Core Area as requested by Linda Blumberg.
if any(zip,48009, 48025, 48034, 48067, 48070, 48072, 48073, 48075, 48076, 48237, 48301, 48302, 48304, 48322, 48323, 48324, 48331, 48334, 48335, 48336, 48382, 48390) area = 101.
comment 48033 is Southfield and was not included in 2005 only because no interviews were done there in 2005 (6 interviews in 2018).
comment 48322 is Farmingtonand was not included in 2005 only because no interviews were done there in 2005 (1 interview in 2018).
if any(zip,48033,48332,48333) area eq 101.
value labels area 101 'Core Area'   102 'Non-Core Area' .
variable labels area 'Geographic Areas'.
weight wf.
frequencies area.
comment defines Macomb County, SSRS created a variable called Wayne and set it equal to 1 if a Wayne interview was done. I changed the name of Wayne to County.
if any(zip,48015,48038,48042,48044,48045,48080,48082,48089,48092,48093,48310,48313,48314,48315,48317) county = 2.
add value labels county 2 'Macomb' 0 'Oakland'. 
weight off.
frequencies county.

weight wf.
frequencies zip.

compute city2 = city.
weight wf.
compute city = zip.
if any(zip,48322,48323,48324) city = 101.
if any(zip,48009,48301,48302,48304,48025) city = 102.
if any(zip,48331,48332,48333,48334,48335,48336) city = 103.
if any(zip,48034,48037,48075,48076,48033) city = 104.
if any(zip,48070, 48237) city = 105.
if any(zip,48017,48067,48069,48071,48072,48073,48083,48084,48098,48220,48085) city = 106.
if any(zip,48306,48309,48326,48327,48328,48329,48340,48341,48346,48348,48357,48360,48386,48387,48455,48462,48320,48307,48359,48362,48371,48442) city = 107.
if any(zip,48178,48374,48375,48377,48381,48382,48390,48393,48380) city = 108.
if any(zip, 48170,48150) city = 900.
if (county eq 1) city = 900.
if (county eq 2) city = 901.
value labels city 101 'West Bloomfield' 102 'Bloomfield-Birmingham-Franklin' 103 'Farmington' 104 'Southfield' 105 'Oak Park-Huntington Woods' 
	106 'East Oakland County' 107 'North Oakland County' 108 'West Oakland County'  900 'Wayne County' 901 'Macomb'. 
*missing values city (106 thru 108, 901).
missing values city ().
frequencies city county.

compute subarea = city.
recode subarea (106 107 108 901 = 999).
if (county eq 1) subarea = 900.
value labels subarea 101 'West Bloomfield' 102 'Bloomfield-Birmingham-Franklin' 103 'Farmington' 104 'Southfield' 105 'Oak Park-Huntington Woods' 
	900 'Wayne County' 999 'Other Areas'. 
missing values subarea (999).
variable labels subarea '5 Subareas ReDefined ifromn 2005 Report'.
frequencies city county subarea.

temporary.
select if any(zip, 99998,99999).
frequencies case_ID. 

comment breaking up Oak Park - Huntington Woods.
compute Huntwoods = 2.
if (zip eq 48070) HuntWoods eq 1.
variable labels Huntwoods 'Identifies Huntington Woods Zip'.
value labels Huntwoods 1 'In Huntington Woods' 2 'Not'.
frequencies Huntwoods.

compute OakPark eq 2.
if (zip eq 48237) OakPark eq 1.
variable labels OakPark 'Identifies OakPark Zip'.
value labels OakPark 1 'In OakPark' 2 'Not'.
frequencies OakPark.

weight wf.
temporary.
select if Huntwoods eq 1.
frequencies cocr.

temporary.
select if OakPark eq 1.
frequencies cocr.

compute city2 = city.
if any(zip,48322,48323,48324) city2 = 101.
if any(zip,48009,48301,48302,48304) city2 = 102.
if any(zip,48331,48332,48333,48334,48335,48336) city2 = 103.
if any(zip,48025, 48034,48037,48075,48076,48033) city2 = 104.
if any(zip,48070, 48237) city2 = 105.
if any(zip,48017,48067,48069,48071,48072,48073,48083,48084,48098,48220,48085) city2 = 106.
if any(zip,48306,48309,48326,48327,48328,48329,48340,48341,48346,48348,48357,48360,48386,48387,48455,48462,48320,48307,48359,48362,48371,48442) city2 = 107.
if any(zip,48178,48374,48375,48377,48381,48382,48390,48393,48380) city2 = 108.
if any(zip,48170,48150) city2 = 900.
if any(zip,48111,48120,48124,48126,48134,48152,48174,48195,48216,48236) city2 = 900.
if any(zip,48201,48202,48207,48208,48211,48212,48219,48221,48224,48226,48227,48228,48234,48235,48239,48265,48267) city2 = 901.
if any(zip,48015,48021,48035,48038,48065,48081,48088,48092,48093,48101,48125,48128,48154,48167,48214,48242,48312,48313,48315,48316) city2 = 902.
value labels city2 101 'West Bloomfield' 102 'Bloomfield-Birmingham-Franklin' 103 'Farmington' 104 'Southfield' 105 'Oak Park-Huntington Woods' 
	106 'East Oakland County' 107 'North Oakland County' 108 'West Oakland County'  900 'Wayne-Not Detroit' 901 'City of Detroit' 902 'Macomb'.
variable labels city2 'For Home zip, with City of Detroit broken out'.
frequencies city2.

value labels zip zipwork 48322 'West Bloomfield' 48331 'Farmington' 48237  'Oak Park'  48334 'Farmington' 48323 'West Bloomfield' 48034 'Southfield' 48301 'Bloomfield Hills' 48075 'Southfield' 
    48076 'Southfield' 48070 'Huntington Woods' 48302 'Bloomfield Hills' 48390 'Walled Lake'  48025 'Franklin' 48152 'Livonia'  48233 'Detroit' 48009 'Birmingham' 48219 'Detroit' 48168 'Northville'
    48327 'Waterford' 48332 'Farmington' 48324 'West Bloomfield' 48037 'Southfield' 48304 'Bloomfield Hills' 48341 'Pontiac' 48167 'Northville' 48071 'Madison Heights' 48073 'Royal Oak'
    48382 'Commerce Township' 48328 'Waterford' 48223 'Detroit' 48336 'Farmington' 48067 'Royal Oak' 48309 'Rochester' 48329 'Waterford' 48221 'Detroit'  48170 'Plymouth' 48375 'Novi'
    48393 'Wixom' 48205 'Detroit' 48005 'Armada' 48455 'Metamora' 48185 'Westland' 48320 'Keego Harbor' 48377 'Novi' 48154 'Livonia' 48232 'Detroit' 48220 'Ferndale' 48081 'Saint Clair Shores' 
    48127 'Dearborn Heights' 48335 'Farmington' 48126 'Dearborn' 48222 'Detroit' 48207 'Detroit' 48098 'Troy' 48084 'Troy' 48038 'Clinton Township' 48178 'South Lyon' 48230 'Grosse Pointe'
    48224 'Detroit' 48072 'Berkley' 48387 'Union Lake' 48083 'Troy' 48180 'Taylor' 48203 'Highland Park' 48215 'Detroit' 48183 'Trenton' 48188 'Canton' 48346 'Clarkson' 48310 'Stirling Heights'
    48315 'Utica' 48386 'White Lake' 48227 'Detroit' 48069 'Pleasant Ridge' 48187 'Canton' 48236 'Grosse Pointe' 48017 'Clawson' 48238 'Detroit' 48326 'Auburn Hills' 48333 'Farmington'
    48374 'Novi' 48043 'Mount Clemens' 48381 'Milford' 48192 'Wyandotte' 48124 'Dearborn' 48066 'Roseville' 48150 'Livonia' 48340 'Pontiac' 48360 'Lake Orion' 48120 'Dearborn' 48226 'Detroit'
    48348 'Clarkson' 48462 'Ortonville' 48357 'Highland' 48306 'Rochester' 48094 'Washington'.

add value labels zip zipwork 48015 'Center Line' 48033 'Southfield'  48042 'Macomb' 48044 'Macomb'  48045 'Harrison Township' 48080 'Saint Clair Shores' 48082 'Saint Clair Shores' 48085 'Troy' 48089 'Warren' 48092 'Warren'
      48093 'Warren' 48111 'Belleville' 48122 'Melvindale' 48125 'Dearborn Heights' 48128 'Dearborn' 48186 'Westland' 48201 'Detroit' 48202 'Detroit' 48208 'Detroit' 48210 'Detroit' 48212 'Detroit' 48214 'Detroit' 48216 'Detroit' 
      48234 'Detroit' 48235 'Detroit' 48239 'Detroit' 48307  'Rochester' 48313 'Sterling Heights' 48314 'Stirling Heights' 48317 'Shelby Township' 48359 'Lake Orion' 48362 'Lake Orion' 48371 'Oxford' 48380 'Milford' 48442 'Holly'
       48170 'Plymouth' 48150 'Livonia'.

add value labels zipwork 48001 'Algonac' 48021 'East Detroit' 48032 'Grant Township' 48035 'Clinton Township' 48052 'Oxford' 48065 'Bruce' 48079  'Saint Clair'  48088 'Warren' 48101 'Allen Park' 48103 'Ann Arbor' 48104 'Ann Arbor' .
add value labels zipwork 48016 'Dartmoor-Wash' 48108 'Ann Arbor' 48109 'Ann Arbor' 48116 'Brighton' 48134 'Flat Rock' 48161 'Monroe' 48174 'Romulus' 48195 'Southgate' 48198 'Ypsilanti' 48211 'Detroit' 48228 'Detroit' 48242 'Detroit' 48265 'Detroit'.
add value labels zipwork 48267 'Detroit'  48312 'Stirling Heights' 48316 'Shelby Township' 48321 'Pontiac' 48337 'Novi' 48342  'Pontiac' 48503 'Flint' 48876 'Potterville' 48933 'Lansing'  48937 'Lansing' 49310 'Blanchard'.
add value labels zipwork 48106 'Ann Arbor'.
frequencies zipwork.

weight wf.
compute citywork = zipwork.
if any(zipwork,48322,48323,48324) citywork = 101.
if any(zipwork,48009,48301,48302,48304,48025) citywork = 102.
if any(zipwork,48331,48332,48333,48334,48335,48336) citywork = 103.
if any(zipwork,48034,48037,48075,48076,48033) citywork = 104.
if any(zipwork,48070, 48237) citywork = 105.
if any(zipwork,48017,48067,48069,48071,48072,48073,48083,48084,48098,48220,48085) citywork = 106.
if any(zipwork,48306,48309,48326,48327,48328,48329,48340,48341,48346,48348,48357,48360,48386,48387,48455,48462,48320,48307,48359,48362,48371,48442) citywork = 107.
if any(zipwork,48178,48374,48375,48377,48381,48382,48390,48393,48380) citywork = 108.
if any(zipwork,48170,48150) citywork = 900.
if any(zipwork,48111,48120,48124,48126,48134,48152,48174,48195,48216,48236) citywork = 900.
if any(zipwork,48201,48202,48207,48208,48211,48212,48219,48221,48224,48226,48227,48228,48234,48235,48239,48265,48267) citywork = 901.
if any(zipwork,48015,48021,48035,48038,48065,48081,48088,48092,48093,48101,48125,48128,48154,48167,48214,48242,48312,48313,48315,48316) citywork = 902.
if any(zipwork,48001,48032,48079,48103,48104,48106,48108,48109,48116,48161,48198,48321,48341,48503,48876,48933,48937,49310) citywork = 903.
value labels citywork 101 'West Bloomfield' 102 'Bloomfield-Birmingham-Franklin' 103 'Farmington' 104 'Southfield' 105 'Oak Park-Huntington Woods' 
	106 'East Oakland County' 107 'North Oakland County' 108 'West Oakland County'  900 'Wayne-Not Detroit' 901 'City of Detroit' 902 'Macomb' 903 'Work Out of 3 Counties'.
recode citywork (48010 48013 48052 48337 = 99999).
missing values citywork (48402,48245,99999).

frequencies citywork zipwork.

weight off.
frequencies months.
compute cmonths=months.
recode  cmonths (3 thru  9=1)(10 thru 12=2).
variable labels cmonths 'months in residence'.
value labels cmonths 1 '3-9     months'        2 '10-12    months'.
frequencies cmonths.

frequencies lor lorca.
compute clor=lor.
compute clorca=lorca.
recode clorca clor (0 thru 4=1) (5 thru 9=2) (10 thru 19=3) (20 thru 120 = 4).
variable labels clorca 'length of residence at current address'.
variable labels clor 'length of residence in local area'. 
value labels clorca clor 1 '0-4 yrs' 2 '5-9 yrs' 3 '10-19   yrs' 4 '20+ yrs'.
frequencies  clor clorca.

recode ownrent (1=102) (2=101).
value labels ownrent 101 'Rent' 102 'Own'.
frequencies ownrent.

compute cclor5 = clor.
recode cclor5 (2 thru 4 = 2).
variable labels cclor5 'length of residence 5'.
value labels cclor5 1 '0-4 years' 2 '5 or more years'.
frequencies cclor5 clor.

compute cclor10 = clor.
recode cclor10 (1,2 = 1) (3,4 =3).
variable labels cclor10 'length of residence 10'.
value labels cclor10 1 '0-9 years' 3 '10 or more years'.
frequencies cclor10 clor.

compute cclor10a = clor.
recode cclor10a (1,2 = 1).
variable labels cclor10a 'length of residence 10, 10-19, 20+'.
value labels cclor10a 1 '0-9 years' 3 '10-19 years' 4 '20 or more years'.
frequencies cclor10a clor.

compute cclor20 = clor.
recode cclor20 (1,2,3 = 1) (4 =3).
variable labels cclor20 'length of residence 20'.
value labels cclor20 1 '0-19 years' 3 '20 or more years'.
frequencies cclor20 clor.

compute defmove = 2.
if (move eq 1 and range(wmove,2,5)) defmove = 1.
variable labels defmove 'definitely moving out of area'.
value labels defmove 1 'yes' 2 'no'.
frequencies move wmove defmove.

compute probmove = 2.
if (move eq 2 and range(wmove,2,5)) probmove = 1.
variable labels probmove 'probably moving out of area'.
value labels probmove 1 'yes' 2 'no'.
frequencies probmove.

missing values move ().
if any(move,3,4,8,9)  wmove = 100.
add value labels wmove 100 'Not Moving'.
frequencies move defmove probmove wmove.

comment calculates jews from former soviet union.
compute fsu = 2.
if (range(born1,200,217)) fsu = 1.
if (range(born2,200,217)) fsu = 1.
if (range(born3,200,217)) fsu = 1.
if (range(born4,200,217)) fsu = 1.
if (range(born5,200,217)) fsu = 1.
if (range(born6,200,217)) fsu = 1.
if (range(born7,200,217)) fsu = 1.
if range(lbefor,200,217) fsu = 1.
variable labels fsu 'Household from the FSU'.
value labels fsu  1 'FSU Household'   2 'Not an FSU Household'.
frequencies fsu.

comment combines LGBT variables.
frequencies lgbt childgay.
If (childgay eq 1) lgbt = 3.
add value labels lgbt 3 'Child is gay, not adult'.
frequencies lgbt childgay.

********************************************************************************************************************************************************************.
comment Page 5: age groups in census age categories.
********************************************************************************************************************************************************************.
comment all age variables contain both adults and children.
compute cage1 = age1.
compute cage2 = age2.
compute cage3 = age3.
compute cage4 = age4.
compute cage5 = age5.
compute cage6 = age6.
compute cage7 = age7.
compute cagec1 = agec1.
compute cagec2 = agec2.
compute cagec3 = agec3.
compute cagec4 = agec4.
compute cagec5 = agec5.
compute cagec6 = agec6.
compute cagec7 = agec7.
compute cagec8 = agec8.
compute cagec9 = agec9.

variable labels cage1 'age-respondent' cage2 'age-adult 2' cage3 'age-adult 3' cage4 'age-adult 4' cage5 'age-adult 5' cage6 'age-adult 6' cage7 'age-adult 7'.
variable labels cagec1 'age-child 1' cagec2 'age-child 2' cagec3 'age-child 3' cagec4 'age-child 4' cagec5 'age-child 5' cagec6 'age-child 6' cagec7 'age-child 7' cagec8 'age-child 8' cagec9 'age-child 9'.

recode cage1 to cage7 cagec1 cagec2 cagec3 cagec4 cagec5 cagec6 cagec7 cagec8 cagec9 (0 thru 4 = 1) (5 thru 9 = 2) (10 thru 14 = 3) (15 thru 19 = 4) (20 thru 24 = 5) (25 thru 29 = 6) (30 thru 34 = 7) (35 thru 39 = 8) 
	(40 thru 44 = 9) (45 thru 49 = 10) (50 thru 54 = 11) (55 thru 59 = 12) (60 thru 64 = 13) (65 thru 69 = 14) (70 thru 74 = 15)
	(75 thru 79 = 16) (80 thru 84 = 17) (85 thru 89 = 18) (90 thru 110 = 19).

value labels cage1 to cage7 cagec1 to cagec9 1 '0-4' 2 '5-9' 3 '10-14' 4 '15-19' 5 '20-24' 6 '25-29' 7 '30-34' 8 '35-39' 9 '40-44' 10 '45-49' 11 '50-54' 
	12 '55-59' 13 '60-64' 14 '65-69' 15 '70-74' 16 '75-79' 17 '80-84' 18 '85-89' 19 '90+'.

frequencies age1 cage1 agec2 cagec2.

********************************************************************************************************************************************************************.
comment Page 5: age groups in school age categories.
********************************************************************************************************************************************************************.
compute sage1 = age1.
compute sage2 = age2.
compute sage3 = age3.
compute sage4 = age4.
compute sage5 = age5.
compute sage6 = age6.
compute sage7 = age7.
compute sagec1 = agec1.
compute sagec2 = agec2.
compute sagec3 = agec3.
compute sagec4 = agec4.
compute sagec5 = agec5.
compute sagec6 = agec6.
compute sagec7 = agec7.
compute sagec8 = agec8.
compute sagec9 = agec9.

variable labels sage1 'age-respondent' sage2 'age-adult 2' sage3 'age-adult 3' sage4 'age-adult 4' sage5 'age-adult 5' sage6 'age-adult 6' sage7 'age-adult 7' 
	 sagec1 'age-child 1' sagec2 'age-child 2' sagec3 'age-child 3' sagec4 'age-child 4' sagec5 'age-child 5' sagec6 'age-child 6' sagec7 'age-child 7' sagec8 'age-child 8' sagec9 'age-child 9'.

recode sage1 to sagec9 (0 thru 5 = 1)(6 thru 12 = 2)(13 thru 17 = 3) (18 thru 24 = 4)(25 thru 34 = 5) 
	(35 thru 44 = 6) (45 thru 54 = 7) (55 thru 64 = 8)(65 thru 74 = 9)(75 thru 84 = 10) (85 thru 110 = 11).

value labels sage1 to sagec9 1 '0-5' 2 '6-12' 3 '13-17' 4 '18-24 ' 5 '25-34 ' 6 '35-44' 7 '45-54' 8 '55-64 ' 9 '65-74 ' 10 '75-84 ' 11 '85+'.
frequencies  age1 sage1 agec2 sagec2.

comment makes part Jewish kids Jewish for the purpose of Table 5-12. Use cjc1 in chapter 8, but newcjc1 here.
compute newcjc1 = cjc1.
compute newcjc2 = cjc2.
compute newcjc3 = cjc3.
compute newcjc4 = cjc4.
compute newcjc5 = cjc5.
compute newcjc6 = cjc6.
compute newcjc7 = cjc7.
compute newcjc8 = cjc8.
compute newcjc9 = cjc9.

recode newcjc1 newcjc2 newcjc3 newcjc4 newcjc5 newcjc6 newcjc7 newcjc8 newcjc9 (3=1).
variable labels newcjc1 'Jewishness of child 1 with part Jews included'.
variable labels newcjc2 'Jewishness of child 2 with part Jews included'.
variable labels newcjc3 'Jewishness of child 3 with part Jews included'.
variable labels newcjc4 'Jewishness of child 4 with part Jews included'.
variable labels newcjc5 'Jewishness of child 5 with part Jews included'.
variable labels newcjc6 'Jewishness of child 6 with part Jews included'.
variable labels newcjc7 'Jewishness of child 7 with part Jews included'.
variable labels newcjc8 'Jewishness of child 8 with part Jews included'.
variable labels newcjc9 'Jewishness of child 9 with part Jews included'.
Value Labels newcjc1 to newcjc7 1 'Jewish or Part Jewish' 2 'Not Jewish'.
frequencies newcjc2 cjc2.

********************************************************************************************************************************************************************.
comment Page 5: age groups in secular education age categories.area					
********************************************************************************************************************************************************************.
weight off.
compute edage1 = age1.
compute edage2 = age2.
compute edage3 = age3.
compute edage4 = age4.
compute edage5 = age5.
compute edage6 = age6.
compute edage7 = age7.
variable labels edage1 'age-respondent' edage2 'age-adult 2' edage3 'age-adult 3' edage4 'age-adult 4' edage5 'age-adult 5' edage6 'edge-adult6' edage7 'age-adult7'.
recode edage1 to edage7 (18 thru 24 = 1) (25 thru 34 = 2) (35 thru 49 = 3) (50 thru 64 = 4) (65 thru 74 = 5) (75 thru 110 = 6).
value labels edage1 to edage7 1 '18-24' 2 '25-34' 3 '35-49' 4 '50-64' 5 '65-74' 6 '75 and over'.
frequencies age1 edage1.

compute cedage1 = edage1.
compute cedage2 = edage2.
compute cedage3 = edage3.
compute cedage4 = edage4.
compute cedage5 = edage5.
compute cedage6 = edage6.
compute cedage7 = edage7.
variable labels cedage1 'age-respondent' cedage2 'age-adult 2' cedage3 'age-adult 3' cedage4 'age-adult 4' cedage5 'age-adult 5' cedage6 'age-adult 6' cedage7 'age-adult 7'.
recode cedage1 to cedage7 (1 = 1) (2 thru 6 = 2).
value labels cedage1 to cedage7 1 '18-24' 2 '25+'.

frequencies age1 edage1 cedage1.

********************************************************************************************************************************************************************.
comment Page 5: age groups in large age categories.
********************************************************************************************************************************************************************.
compute ccage1 = cage1.
compute ccage2 = cage2.
compute ccage3 = cage3.
compute ccage4 = cage4.
compute ccage5 = cage5.
compute ccage6 = cage6.
compute ccage7 = cage7.
compute ccagec1 = sagec1.
compute ccagec2 = sagec2.
compute ccagec3 = sagec3.
compute ccagec4 = sagec4.
compute ccagec5 = sagec5.
compute ccagec6 = sagec6.
compute ccagec7 = sagec7.
compute ccagec8 = sagec8.
compute ccagec9 = sagec9.
recode ccage1 to ccagec9 (1 thru 3 = 1) (4 thru 7 = 2) (8 thru 10 = 3) (11 thru 13 = 4)(14,15 = 5) (16 thru 19 = 6).

variable labels ccage1 'age of respondent' ccage2 'age of adult 2' ccage3 'age of adult 3' ccage4 'age of adult 4' ccage5 'age of adult 5' ccage6 'age of adult 6'
	 ccage7 'age of adult 7'.
variable labels ccagec1 'age of child 1' ccagec2 'age of child 2' ccagec3 'age of child 3' ccagec4 'age of child 4' ccagec5 'age of child 5' ccagec6 'age of child 6' 
		ccagec7 'age of child 7' ccagec8 'age of child 8' ccagec9 'age of child 9'.

value labels ccage1 to ccagec9
		1 '0-17'      2 '18-34'     3 '35-49'     4 '50-64'     5 '65-74'     6 '75+'.
frequencies ccage1 to ccagec9 .

comment creates under age 50 variable.
***************************************************************************************************************************************************************.
compute age1849 = ccage1.
recode age1849 (3 = 2).
variable labels age1849 'Age of Respondent with Under 50 Category'.
value labels age1849
		2 ' 18-49' 4 '50-64' 5 '65-74' 6 '75+'.
frequencies ccage1 age1849.
comment similar variable for headage created after we create headage below.

********************************************************************************************************************************************************************.
comment Page 5: age groups in categories for row percentage by area.
********************************************************************************************************************************************************************.
comment used for the table where we show the percentage of each age group living in each geographic area.
compute nage1 = age1.
compute nage2 = age2.
compute nage3 = age3.
compute nage4 = age4.
compute nage5 = age5.
compute nage6 = age6.
compute nage7 = age7.
compute nagec1 = agec1.
compute nagec2 = agec2.
compute nagec3 = agec3.
compute nagec4 = agec4.
compute nagec5 = agec5.
compute nagec6 = agec6.
compute nagec7 = agec7.
compute nagec8 = agec8.
compute nagec9 = agec9.

variable labels nage1 'age-respondent-rows' nage2 'age-adult 2-rows' nage3 'age-adult 3-rows' nage4 'age-adult 4-rows' nage5 'age-adult 5-rows' 
	nage6 'age-adult 6-rows' nage7 'age-adult 7-rows' 
	nagec1 'age-child 1-rows' nagec2 'age-child 2-rows' nagec3 'age-child 3-rows' nagec4 'age-child 4-rows' nagec5 'age-child 5-rows' 
	nagec6 'age-child 6-rows' nagec7 'age-child 7-rows' nagec8 'age-child 8-rows' nagec9 'age-child 9-rows'.

recode nage1 to nagec9 (0 thru 5 = 1) (6 thru 12 = 2) (13 thru 17 = 3) (18 thru 24 = 4) (25 thru 34 = 5) (35 thru 49 = 6) (50 thru 64 = 7) (65 thru 74 = 8) (75 thru 110 = 9).

value labels nage1 to nagec9 1 '0-5' 2 '6-12' 3 '13-17' 4 '18-24' 5 '25-34' 6 '35-49' 7 '50-64' 8 '65-74' 9 '75+'.
frequencies nage1 to nagec9 .

compute mage1 = age1.
compute mage2 = age2.
compute mage3 = age3.
compute mage4 = age4.
compute mage5 = age5.
compute mage6 = age6.
compute mage7 = age7.
compute magec1 = agec1.
compute magec2 = agec2.
compute magec3 = agec3.
compute magec4 = agec4.
compute magec5 = agec5.
compute magec6 = agec6.
compute magec7 = agec7.
compute magec8 = agec8.
compute magec9 = agec9.

variable labels mage1 'age of respondent in row cats' mage2 'age of adult 2 in row cats' mage3 'age of adult 3 in row cats' mage4 'age of adult 4 in row cats'
	mage5 'age of adult 5 in row cats' mage6 'age of adult 6 in row cats' mage7 'age of adult 7 in row cats' 
	magec1 'age of child 1 in row cats' magec2 'age of child 2 in row cats' magec3 'age of child 3 in row cats' magec4 'age of child 4 in row cats'
	magec5 'age of child 5 in row cats' magec6 'age of child 6 in row cats' magec7 'age of child 7 in row cats' magec8 'age of child 8 in row cats'
	magec9 'age of child 9 in row cats'.

recode mage1 to magec9 (0 thru 17 = 1) (18 thru 64 = 2) (65 thru 110 = 3).

value labels mage1 to magec9 1 '0-17' 2 '18-64' 3 '65+'.
frequencies mage1 magec1.


********************************************************************************************************************************************************************.
comment Page 5: age groups in PJ Library categories.
********************************************************************************************************************************************************************.
comment all age variables contain both adults and children, 

compute pjage1 = age1.
compute pjage2 = age2.
compute pjage3 = age3.
compute pjage4 = age4.
compute pjage5 = age5.
compute pjage6 = age6.
compute pjage7 = age7.
compute pjagec1 = agec1.
compute pjagec2 = agec2.
compute pjagec3 = agec3. 
compute pjagec4 = agec4.
compute pjagec5 = agec5.
compute pjagec6 = agec6.
compute pjagec7 = agec7.
compute pjagec8 = agec8.
compute pjagec9 = agec9.

variable labels pjage1 'age-respondent' pjage2 'age-adult 2' pjage3 'age-adult 3' pjage4 'age-adult 4' pjage5 'ageadult 5' pjage6 'age-adult 6' pjage7 'age-adult 7' 
      pjagec1 'age child 1 in pj categories'  pjagec2 'age child 2 in pj categories'  pjagec3 'age child 3 in pj categories'  pjagec4 'age child 4 in pj categories'  pjagec5 'age child 5 in pj categories'  pjagec6 'age child 6 in pj categories'
       pjagec7 'age child 7 in pj categories'  pjagec8 'age child 8 in pj categories'  pjagec9 'age child 9 in pj categories'.

recode pjage1 to pjage7 pjagec1 to pjagec9 (0 thru 8 = 1) (9 thru 11 = 2) (12 thru 14 = 3) (15 thru 19 = 4) (20 thru 24 = 5) (25 thru 29 = 6) (30 thru 34 = 7) (35 thru 39 = 8) 
	(40 thru 44 = 9) (45 thru 49 = 10) (50 thru 54 = 11) (55 thru 59 = 12) (60 thru 64 = 13) (65 thru 69 = 14) (70 thru 74 = 15) 	(75 thru 79 = 16) (80 thru 84 = 17) (85 thru 89 = 18) (90 thru 110 = 19).

value labels pjage1 to pjagec9 1 '0-8' 2 '9-11' 3 '12-14' 4 '15-19' 5 '20-24' 6 '25-29' 7 '30-34' 8 '35-39' 9 '40-44' 10 '45-49' 11 '50-54' 12 '55-59' 13 '60-64' 14 '65-69' 15 '70-74' 16 '75-79' 17 '80-84' 18 '85-89' 19 '90+'.

frequencies age1 pjage1 agec2  pjagec2.

********************************************************************************************************************************************************************.
comment Page 5: age groups in Early Childhood Age 2-5 categories.
********************************************************************************************************************************************************************.
comment all age variables contain both adults and children.
compute eceage1 = age1.
compute eceage2 = age2.
compute eceage3 = age3.
compute eceage4 = age4.
compute eceage5 = age5.
compute eceage6 = age6.
compute eceage7 = age7.
compute eceagec1 = agec1.
compute eceagec2 = agec2.
compute eceagec3 = agec3.
compute eceagec4 = agec4.
compute eceagec5 = agec5.
compute eceagec6 = agec6.
compute eceagec7 = agec7.
compute eceagec8 = agec8.
compute eceagec9 = agec9.

variable labels eceage1 'age-respondent in ECE Categories' eceage2 'age-person 2 in ECE Categories' eceage3 'age-person 3 in ECE Categories' eceage4 'age-person 4 in ECE Categories' 
       eceage5 'age-person 5 in ECE Categories' eceage6 'age-person 6 in ECE Categories' eceage7 'age-person 7 in ECE Categories' 
       eceagec1 'age child 1 in ece categories'  eceagec2 'age child 2 in ece categories'  eceagec3 'age child 3 in ece categories'  eceagec4 'age child 4 in ece categories'  
       eceagec5 'age child 5 in ece categories'  eceagec6 'age child 6 in ece categories'
       eceagec7 'age child 7 in ece categories'  eceagec8 'age child 8 in ece categories'  eceagec9 'age child 9 in ece categories'.

recode eceage1 to eceage7 eceagec1 to eceagec9 (0 thru 1 = 1) (2 thru 5 = 2) (6 thru 14 = 3) (15 thru 19 = 4) (20 thru 24 = 5) (25 thru 29 = 6) (30 thru 34 = 7) (35 thru 39 = 8) 
	(40 thru 44 = 9) (45 thru 49 = 10) (50 thru 54 = 11) (55 thru 59 = 12) (60 thru 64 = 13) (65 thru 69 = 14) (70 thru 74 = 15) 	(75 thru 79 = 16) (80 thru 84 = 17) (85 thru 89 = 18) (90 thru 110 = 19).

value labels eceage1 to eceagec9 1 '0-1' 2 '2-5' 3 '6-14' 4 '15-19' 5 '20-24' 6 '25-29' 7 '30-34' 8 '35-39' 9 '40-44' 10 '45-49' 11 '50-54' 12 '55-59' 13 '60-64' 14 '65-69' 15 '70-74' 16 '75-79' 17 '80-84' 18 '85-89' 19 '90+'.

frequencies age1 eceage1 agec2  eceagec2.

********************************************************************************************************************************************************************.
comment Page 5: following determines whether respondent is elderly.
********************************************************************************************************************************************************************.
compute eldage65  = ccage1.
recode eldage65 (1 thru 4 = 1)(5 thru 6 = 2).
variable labels eldage65 'age of respondent 65+'.
value labels eldage65 1 '< 65' 2 '65+'.
frequencies age1  eldage65.

compute eldage75  = ccage1.
recode eldage75 (1 thru 5 = 1) (6 = 2).
variable labels eldage75 'age of respondent 75+'.
value labels eldage75 1 '< 75' 2 '75+'.
frequencies age1  eldage65 eldage75.

********************************************************************************************************************************************************************.
comment Page 5: develops an age variable for the head of the household.
********************************************************************************************************************************************************************.
compute headage = ccage1.
comment switches cases where we interviews elderly person and head is really a child.
if (age1 ge 75 and emp1 ne 1 and range(rel2,7,10) and range(rel3,7,10) and cj3 eq 1) and (age3 ge 30) headage = ccage3.
if (age1 ge 75 and emp1 ne 1 and range(rel2,7,10) and cj2 eq 1) and (age2 ge 30) headage = ccage2.

if (age1 ge 75 and emp1 ne 1 and rel2 eq 1 and age2 ge 65 and emp2 ne 1 and range(rel4,7,10) and age4 ge 30 and cj4 eq 1) headage = ccage4.
if (age1 ge 75 and emp1 ne 1 and rel2 eq 1 and age2 ge 65 and emp2 ne 1 and range(rel3,7,10) and age3 ge 30 and cj3 eq 1) headage = ccage3.

if (any(rel2,13,14) and cj2 eq 1 and age1 lt 30) headage = ccage2.
if (any(rel2,13,14) eq 2 and cj2 eq 2) and (any(rel3,2) and cj3 eq 1) and (age1 lt 30) headage = ccage3.
if (hhsiz eq 2 and any(rel2,13,14) and age1 lt 30) headage = ccage2.

if (any(rel2,13,14) and age2 lt 75 and cj2 eq 1) headage = ccage2.
if (any(rel3,13,14) and age3 lt 75 and cj3 eq 1) and (any(rel2,13,14) and cj2 eq 2) headage = ccage3.

if (any(rel2,2,3,4,5,6,25) and cj2 eq 1 and cj1 eq 2 ) headage = ccage2.

comment identifies survey where age of head is different from respondents age.
temporary.
select if headage ne ccage1.
Report
  /FORMAT=CHWRAP(ON) PREVIEW(OFF) CHALIGN(BOTTOM) UNDERSCORE(ON) ONEBREAKCOLUMN(OFF) CHDSPACE(1) 
    SUMSPACE(0) AUTOMATIC LIST BRKSPACE(-1) PAGE(1) MISSING'.' LENGTH(1, 59) ALIGN(LEFT) TSPACE(1) 
    FTSPACE(1) MARGINS(1,37)
  /TITLE=RIGHT 'Page )PAGE'
  /VARIABLES ccage1 (VALUES) (RIGHT) (OFFSET(0)) (10) 
    headage (VALUES) (RIGHT) (OFFSET(0)) (8) 
    ID (VALUES) (RIGHT) (OFFSET(0)) (14) .

comment examine cases one by one for rel4 to rel7.
weight off.
frequencies rel4 rel5 rel6 rel7.
temporary.
select if (range(rel4,7,14) and (rel2 ne 2)).
frequencies id.
comment generated survey 408, changed head to age 62.

temporary.
select if (range(rel5,7,14) and (rel2 ne 2)).
frequencies id.
comment generated survey 210 and left respondent as head.

temporary.
select if (range(rel6,6,14) and (rel2 ne 2)).
frequencies id.
comment generated nothing.

variable labels headage 'age of hh head'.
value labels headage 	2 '< 35' 3 '35-49' 4 '50-64' 	5 '65-74' 	6 '75+'.
weight off.
frequencies ccage1 headage.


********************************************************************************************************************************************************************.
comment Page 5: develops an age variable for head of the household with an under 50 age cat.
********************************************************************************************************************************************************************.
compute headage1849 = headage.
recode headage1849 (3 = 2).
variable labels headage1849 'Age of Head of Household with Under 50 Category'.
value labels headage1849      2 ' 18-49'      4 '50-64'      5 '65-74'      6 '75+'.
frequencies headage headage1849.

********************************************************************************************************************************************************************.
comment Page 5: develops an age variable for elderly non-elderly respondent and head of the household.
********************************************************************************************************************************************************************.
compute cccage1 = ccage1.
compute cccage2 = ccage2.
compute cccage3 = ccage3.
compute cccage4 = ccage4.
compute cccage5 = ccage5.
compute cccage6 = ccage6.
compute cccage7 = ccage7.
compute cheadage = headage.
Recode cccage1 cccage2 cccage3 cccage4 cccage5 cccage6 cccage7 cheadage (1 thru 4=101) (5 thru 6=102).
Value labels cccage1 cccage2 cccage3 cccage4 cccage5 cccage6 cccage7 cheadage 101 'Non-Elderly' 102 'Elderly 65+'.

Variable labels cccage1 'Eld-NonEld Age Adult 1'.
Variable labels cccage2 'Eld-NonEld Age Adult 2'.
Variable labels cccage3 'Eld-NonEld Age Adult 3'.
Variable labels cccage4 'Eld-NonEld Age Adult 4'.
Variable labels cccage5 'Eld-NonEld Age Adult 5'.
Variable labels cccage6 'Eld-NonEld Age Adult 6'.
Variable labels cccage7 'Eld-NonEld Age Adult 7'.
Variable labels cheadage 'Eld-NonEld Age of Household Head'.

frequencies cccage1 cccage2 cccage3 cccage4 cccage5 cccage6 cccage7 cheadage .

********************************************************************************************************************************************************************.
comment Page 5: age groups for day camps -- creates an Age 3-17 variable.
********************************************************************************************************************************************************************.
compute campagec1=agec1.
compute campagec2=agec2.
compute campagec3=agec3.
compute campagec4=agec4.
compute campagec5=agec5.
compute campagec6=agec6.
compute campagec7=agec7.
compute campagec8=agec8.
compute campagec9=agec9.
recode campagec1 to campagec9 (0 thru 2=1) (3 thru 17=2).
value labels campagec1 to campagec9 1 '0-2' 2 '3-17'.
variable labels campagec1 'Age of Child 1 for Day Camp Purposes' .
variable labels campagec2 'Age of Child 2 for Day Camp Purposes' .
variable labels campagec3 'Age of Child 3 for Day Camp Purposes' .
variable labels campagec4 'Age of Child 4 for Day Camp Purposes' .
variable labels campagec5 'Age of Child 5 for Day Camp Purposes' .
variable labels campagec6 'Age of Child 6 for Day Camp Purposes' .
variable labels campagec7 'Age of Child 7 for Day Camp Purposes' .
variable labels campagec8 'Age of Child 8 for Day Camp Purposes' .
variable labels campagec9 'Age of Child 9 for Day Camp Purposes' .
frequencies agec2 campagec2.

*********************************************************************************************************************.
comment creates an age variable that creates an Age 5-12 variable.
*********************************************************************************************************************.
compute sagec1a = agec1.
compute sagec2a = agec2.
compute sagec3a = agec3.
compute sagec4a = agec4.
compute sagec5a = agec5.
compute sagec6a = agec6.
compute sagec7a = agec7.
compute sagec8a = agec8.
compute sagec9a = agec9.

variable labels sagec1a 'Child 1 Age Variable for Age 5-12'.
variable labels sagec2a 'Child 2 Age Variable for Age 5-12'.
variable labels sagec3a 'Child 3 Age Variable for Age 5-12'.
variable labels sagec4a 'Child 4 Age Variable for Age 5-12'.
variable labels sagec5a 'Child 5 Age Variable for Age 5-12'.
variable labels sagec6a 'Child 6 Age Variable for Age 5-12'.
variable labels sagec7a 'Child 7 Age Variable for Age 5-12'.
variable labels sagec8a 'Child 8 Age Variable for Age 5-12'.
variable labels sagec9a 'Child 9 Age Variable for Age 5-12'.

recode sagec1a to sagec9a (0 thru 4 = 100) (5 thru 12 = 101) (13 thru 17 = 102).
value labels sagec1a to sagec9a 100 'age 0-4' 101 'age 5-12' 102 'age 13-17'.
missing values sagec1a to sagec9a (100).
weight off.
frequencies sagec2a agec2. 

********************************************************************************************************************************************************************.
comment Page 5: age groups for Overnight camps creates an age 6-17 variable .
********************************************************************************************************************************************************************.
comment calculate age variable for use with Jewish Overnight camp variable. 
compute sagec1b = agec1.
compute sagec2b = agec2.
compute sagec3b = agec3.
compute sagec4b = agec4.
compute sagec5b = agec5.
compute sagec6b = agec6.
compute sagec7b = agec7.
compute sagec8b = agec8.
compute sagec9b = agec9.

variable labels sagec1b 'Child 1 Age Variable for Overnight Camp'.
variable labels sagec2b 'Child 2 Age Variable for Overnight Camp'.
variable labels sagec3b 'Child 3 Age Variable for Overnight Camp'.
variable labels sagec4b 'Child 4 Age Variable for Overnight Camp'.
variable labels sagec5b 'Child 5 Age Variable for Overnight Camp'.
variable labels sagec6b 'Child 6 Age Variable for Overnight Camp'.
variable labels sagec7b 'Child 7 Age Variable for Overnight Camp'.
variable labels sagec8b 'Child 8 Age Variable for Overnight Camp'.
variable labels sagec9b 'Child 9 Age Variable for Overnight Camp'.

recode sagec1b to sagec9b (6 thru 17 = 101) (else = 102).
missing values sagec1b to sagec9b (102).
value labels sagec1b to sagec9b 101 'Age 6-17' 102 'Not Age 6-17'.
frequencies sagec1b sagec2b sagec3b sagec4b sagec5b sagec6b sagec7b sagec8b sagec9b.


*********************************************************************************************************************.
comment creates an age variable that creates an Age 13-17 variable.
*********************************************************************************************************************.
comment creates an age variable that creates an Age 13-17 variable.
compute sagec1c = agec1.
compute sagec2c = agec2.
compute sagec3c = agec3.
compute sagec4c = agec4.
compute sagec5c = agec5.
compute sagec6c = agec6.
compute sagec7c = agec7.
compute sagec8c = agec8.
compute sagec9c = agec9.

variable labels sagec1c 'Child 1 Age Variable for Age 13-17'.
variable labels sagec2c 'Child 2 Age Variable for Age 13-17'.
variable labels sagec3c 'Child 3 Age Variable for Age 13-17'.
variable labels sagec4c 'Child 4 Age Variable for Age 13-17'.
variable labels sagec5c 'Child 5 Age Variable for Age 13-17'.
variable labels sagec6c 'Child 6 Age Variable for Age 13-17'.
variable labels sagec7c 'Child 7 Age Variable for Age 13-17'.
variable labels sagec8c 'Child 8 Age Variable for Age 13-17'.
variable labels sagec9c 'Child 9 Age Variable for Age 13-17'.

recode sagec1c to sagec9c (0 thru 12 = 101) (13 thru 17 = 102).
value labels sagec1c to sagec9c 101 'age 0-12' 102 'age 13-17'.
missing values sagec1c to sagec9c (101).
frequencies sagec2c agec2. 

********************************************************************************************************************************************************************.
comment Page 5: establishes a household size variable with a 6 plus category.
********************************************************************************************************************************************************************.
comment checking for multiple roomate or friend situations.
temporary.
select if (rel3 eq 6) and (rel4 eq 6).
frequencies id.

temporary.
select if (rel3 eq 25) and (rel4 eq 25).
frequencies id.
 
compute chhsiz = hhsiz.
recode chhsiz (6 thru 20 = 6).
variable labels chhsiz 'Household Size with 6+ Category'.
value labels chhsiz 6 '6+'.
frequencies hhsiz chhsiz.
means hhsiz.

********************************************************************************************************************************************************************.
comment Page 5: compute number of persons.
********************************************************************************************************************************************************************.
********************************************************************************************************************************************************************.
comment compute number of persons These do not inlcude part Jewish children as Jewish Children.
********************************************************************************************************************************************************************.
compute nchild = 0.
if range(agec1,0,17) nchild = nchild + 1.
if range(agec2,0,17) nchild = nchild + 1.
if range(agec3,0,17) nchild = nchild + 1.
if range(agec4,0,17) nchild = nchild + 1.
if range(agec5,0,17) nchild = nchild + 1.
if range(agec6,0,17) nchild = nchild + 1.
if range(agec7,0,17) nchild = nchild + 1.
if range(agec8,0,17) nchild = nchild + 1.
if range(agec9,0,17) nchild = nchild + 1.

compute njchild = 0.
if (range(agec1,0,17) and cjc1 eq 1) njchild = njchild + 1.
if (range(agec2,0,17) and cjc2 eq 1) njchild = njchild + 1.
if (range(agec3,0,17) and cjc3 eq 1) njchild = njchild + 1.
if (range(agec4,0,17) and cjc4 eq 1) njchild = njchild + 1.
if (range(agec5,0,17) and cjc5 eq 1) njchild = njchild + 1.
if (range(agec6,0,17) and cjc6 eq 1) njchild = njchild + 1.
if (range(agec7,0,17) and cjc7 eq 1) njchild = njchild + 1.
if (range(agec8,0,17) and cjc8 eq 1) njchild = njchild + 1.
if (range(agec9,0,17) and cjc9 eq 1) njchild = njchild + 1.

compute nchild5 = 0.
if range(agec1,0,5) nchild5 = nchild5 + 1.
if range(agec2,0,5) nchild5 = nchild5 + 1.
if range(agec3,0,5) nchild5 = nchild5 + 1.
if range(agec4,0,5) nchild5 = nchild5 + 1.
if range(agec5,0,5) nchild5 = nchild5 + 1.
if range(agec6,0,5) nchild5 = nchild5 + 1.
if range(agec7,0,5) nchild5 = nchild5 + 1.
if range(agec8,0,5) nchild5 = nchild5 + 1.
if range(agec9,0,5) nchild5 = nchild5 + 1.

compute njchild5 = 0.
if (range(agec1,0,5) and cjc1 eq 1) njchild5 = njchild5 + 1.
if (range(agec2,0,5) and cjc2 eq 1) njchild5 = njchild5 + 1.
if (range(agec3,0,5) and cjc3 eq 1) njchild5 = njchild5 + 1.
if (range(agec4,0,5) and cjc4 eq 1) njchild5 = njchild5 + 1.
if (range(agec5,0,5) and cjc5 eq 1) njchild5 = njchild5 + 1.
if (range(agec6,0,5) and cjc6 eq 1) njchild5 = njchild5 + 1.
if (range(agec7,0,5) and cjc7 eq 1) njchild5 = njchild5 + 1.
if (range(agec8,0,5) and cjc8 eq 1) njchild5 = njchild5 + 1.
if (range(agec9,0,5) and cjc9 eq 1) njchild5 = njchild5 + 1.

compute njchild8 = 0.
if (range(agec1,0,8) and cjc1 eq 1) njchild8 = njchild8 + 1.
if (range(agec2,0,8) and cjc2 eq 1) njchild8 = njchild8 + 1.
if (range(agec3,0,8) and cjc3 eq 1) njchild8 = njchild8 + 1.
if (range(agec4,0,8) and cjc4 eq 1) njchild8 = njchild8 + 1.
if (range(agec5,0,8) and cjc5 eq 1) njchild8 = njchild8 + 1.
if (range(agec6,0,8) and cjc6 eq 1) njchild8 = njchild8 + 1.
if (range(agec7,0,8) and cjc7 eq 1) njchild8 = njchild8 + 1.
if (range(agec8,0,8) and cjc8 eq 1) njchild8 = njchild8 + 1.
if (range(agec9,0,8) and cjc9 eq 1) njchild8 = njchild8 + 1.

compute njchild9 = 0.
if (range(agec1,9,11) and cjc1 eq 1) njchild9 = njchild9 + 1.
if (range(agec2,9,11) and cjc2 eq 1) njchild9 = njchild9 + 1.
if (range(agec3,9,11) and cjc3 eq 1) njchild9 = njchild9 + 1.
if (range(agec4,9,11) and cjc4 eq 1) njchild9 = njchild9 + 1.
if (range(agec5,9,11) and cjc5 eq 1) njchild9 = njchild9 + 1.
if (range(agec6,9,11) and cjc6 eq 1) njchild9 = njchild9 + 1.
if (range(agec7,9,11) and cjc7 eq 1) njchild9 = njchild9 + 1.
if (range(agec8,9,11) and cjc8 eq 1) njchild9 = njchild9 + 1.
if (range(agec9,9,11) and cjc9 eq 1) njchild9 = njchild9 + 1.

compute nchild12 = 0.
if range(agec1,0,12) nchild12 = nchild12 + 1.
if range(agec2,0,12) nchild12 = nchild12 + 1.
if range(agec3,0,12) nchild12 = nchild12 + 1.
if range(agec4,0,12) nchild12 = nchild12 + 1.
if range(agec5,0,12) nchild12 = nchild12 + 1.
if range(agec6,0,12) nchild12 = nchild12 + 1.
if range(agec7,0,12) nchild12 = nchild12 + 1.
if range(agec8,0,12) nchild12 = nchild12 + 1.
if range(agec9,0,12) nchild12 = nchild12 + 1.

compute njchild12 = 0.
if (range(agec1,0,12) and cjc1 eq 1) njchild12 = njchild12 + 1.
if (range(agec2,0,12) and cjc2 eq 1) njchild12 = njchild12 + 1.
if (range(agec3,0,12) and cjc3 eq 1) njchild12 = njchild12 + 1.
if (range(agec4,0,12 ) and cjc4 eq 1) njchild12 = njchild12 + 1.
if (range(agec5,0,12) and cjc5 eq 1) njchild12 = njchild12 + 1.
if (range(agec6,0,12) and cjc6 eq 1) njchild12 = njchild12 + 1.
if (range(agec7,0,12) and cjc7 eq 1) njchild12 = njchild12 + 1.
if (range(agec8,0,12) and cjc8 eq 1) njchild12 = njchild12 + 1.
if (range(agec9,0,12) and cjc9 eq 1) njchild12 = njchild12 + 1.

compute njchild317 = 0.
if (range(agec1,3,17) and cjc1 eq 1) njchild317 = njchild317 + 1.
if (range(agec2,3,17) and cjc2 eq 1) njchild317 = njchild317 + 1.
if (range(agec3,3,17) and cjc3 eq 1) njchild317 = njchild317 + 1.
if (range(agec4,3,17) and cjc4 eq 1) njchild317 = njchild317 + 1.
if (range(agec5,3,17) and cjc5 eq 1) njchild317 = njchild317 + 1.
if (range(agec6,3,17) and cjc6 eq 1) njchild317 = njchild317 + 1.
if (range(agec7,3,17) and cjc7 eq 1) njchild317 = njchild317 + 1.
if (range(agec8,3,17) and cjc8 eq 1) njchild317 = njchild317 + 1.
if (range(agec9,3,17) and cjc9 eq 1) njchild317 = njchild317 + 1.

compute njchild617 = 0.
if (range(agec1,6,17) and cjc1 eq 1) njchild617 = njchild617 + 1.
if (range(agec2,6,17) and cjc2 eq 1) njchild617 = njchild617 + 1.
if (range(agec3,6,17) and cjc3 eq 1) njchild617 = njchild617 + 1.
if (range(agec4,6,17) and cjc4 eq 1) njchild617 = njchild617 + 1.
if (range(agec5,6,17) and cjc5 eq 1) njchild617 = njchild617 + 1.
if (range(agec6,6,17) and cjc6 eq 1) njchild617 = njchild617 + 1.
if (range(agec7,6,17) and cjc7 eq 1) njchild617 = njchild617 + 1.
if (range(agec8,6,17) and cjc8 eq 1) njchild617 = njchild617 + 1.
if (range(agec9,6,17) and cjc9 eq 1) njchild617 = njchild617 + 1.

compute njchild517 = 0.
if (range(agec1,5,17) and cjc1 eq 1) njchild517 = njchild517 + 1.
if (range(agec2,5,17) and cjc2 eq 1) njchild517 = njchild517 + 1.
if (range(agec3,5,17) and cjc3 eq 1) njchild517 = njchild517 + 1.
if (range(agec4,5,17) and cjc4 eq 1) njchild517 = njchild517 + 1.
if (range(agec5,5,17) and cjc5 eq 1) njchild517 = njchild517 + 1.
if (range(agec6,5,17) and cjc6 eq 1) njchild517 = njchild517 + 1.
if (range(agec7,5,17) and cjc7 eq 1) njchild517 = njchild517 + 1.
if (range(agec8,5,17) and cjc8 eq 1) njchild517 = njchild517 + 1.
if (range(agec9,5,17) and cjc9 eq 1) njchild517 = njchild517 + 1.

compute npjchild617 = 0.
if (range(agec1,6,17) and cjc1 eq 3) npjchild617 = npjchild617 + 1.
if (range(agec2,6,17) and cjc2 eq 3) npjchild617 = npjchild617 + 1.
if (range(agec3,6,17) and cjc3 eq 3) npjchild617 = npjchild617 + 1.
if (range(agec4,6,17) and cjc4 eq 3) npjchild617 = npjchild617 + 1.
if (range(agec5,6,17) and cjc5 eq 3) npjchild617 = npjchild617 + 1.
if (range(agec6,6,17) and cjc6 eq 3) npjchild617 = npjchild617 + 1.
if (range(agec7,6,17) and cjc7 eq 3) npjchild617 = npjchild617 + 1.
if (range(agec8,6,17) and cjc8 eq 3) npjchild617 = npjchild617 + 1.
if (range(agec9,6,17) and cjc9 eq 3) npjchild617 = npjchild617 + 1.

compute nteen = 0.
if range(agec1,13,17) nteen = nteen + 1.
if range(agec2,13,17) nteen = nteen + 1.
if range(agec3,13,17) nteen = nteen + 1.
if range(agec4,13,17) nteen = nteen + 1.
if range(agec5,13,17) nteen = nteen + 1.
if range(agec6,13,17) nteen = nteen + 1.
if range(agec7,13,17) nteen = nteen + 1.
if range(agec8,13,17) nteen = nteen + 1.
if range(agec9,13,17) nteen = nteen + 1.

compute njteen = 0.
if (range(agec1,13,17) and cjc1 eq 1) njteen = njteen + 1.
if (range(agec2,13,17) and cjc2 eq 1) njteen = njteen + 1.
if (range(agec3,13,17) and cjc3 eq 1) njteen = njteen + 1.
if (range(agec4,13,17) and cjc4 eq 1) njteen = njteen + 1.
if (range(agec5,13,17) and cjc5 eq 1) njteen = njteen + 1.
if (range(agec6,13,17) and cjc6 eq 1) njteen = njteen + 1.
if (range(agec7,13,17) and cjc7 eq 1) njteen = njteen + 1.
if (range(agec8,13,17) and cjc8 eq 1) njteen = njteen + 1.
if (range(agec9,13,17) and cjc9 eq 1) njteen = njteen + 1.

compute nadultch20 = 0.
if   any(rel2,13,14) and range(age1,18,29) nadultch20 = nadultch20 + 1.
if range(rel2,7,10) and range(age2,18,29) nadultch20 = nadultch20 + 1.
if range(rel3,7,10) and range(age3,18,29) nadultch20 = nadultch20 + 1.
if range(rel4,7,10) and range(age4,18,29) nadultch20 = nadultch20 + 1.
if range(rel5,7,10) and range(age5,18,29) nadultch20 = nadultch20 + 1.
if range(rel6,7,10) and range(age6,18,29) nadultch20 = nadultch20 + 1.
if range(rel7,7,10) and range(age7,18,29) nadultch20 = nadultch20 + 1.

compute nadultch30 = 0.
if any(rel2,13,14)   and range(age1,30,98) nadultch30 = nadultch30 + 1.
if range(rel2,7,10) and range(age2,30,98) nadultch30 = nadultch30 + 1.
if range(rel3,7,10) and range(age3,30,98) nadultch30 = nadultch30 + 1.
if range(rel4,7,10) and range(age4,30,98) nadultch30 = nadultch30 + 1.
if range(rel5,7,10) and range(age5,30,98) nadultch30 = nadultch30 + 1.
if range(rel6,7,10) and range(age6,30,98) nadultch30 = nadultch30 + 1.
if range(rel7,7,10) and range(age7,30,98) nadultch30 = nadultch30 + 1.

compute nadultch2 = 0.
if (range(rel2,7,10) or range(rel3,7,10) or range(rel4,7,10) or range(rel5,7,10) or range(rel6,7,10) or range(rel7,7,10)) nadultch2 = 1.
if range(age1,18,49) nadultch2 = 2.
missing values nadultch2 (2).

compute nadult = 1.
if range(age2,18,120) nadult = nadult + 1.
if range(age3,18,120) nadult = nadult + 1.
if range(age4,18,120) nadult = nadult + 1.
if range(age5,18,120) nadult = nadult + 1.
if range(age6,18,120) nadult = nadult + 1.
if range(age7,18,120) nadult = nadult + 1.

compute njadult = 0.
if (cj1 eq 1) njadult = njadult + 1.
if (range(age2,18,120) and cj2 eq 1) njadult = njadult + 1.
if (range(age3,18,120) and cj3 eq 1) njadult = njadult + 1.
if (range(age4,18,120) and cj4 eq 1) njadult = njadult + 1.
if (range(age5,18,120) and cj5 eq 1) njadult = njadult + 1.
if (range(age6,18,120) and cj6 eq 1) njadult = njadult + 1.
if (range(age7,18,120) and cj7 eq 1) njadult = njadult + 1.

compute nelder65 = 0.
if range(age1,65,120) nelder65 = nelder65 + 1.
if range(age2,65,120) nelder65 = nelder65 + 1.
if range(age3,65,120) nelder65 = nelder65 + 1.
if range(age4,65,120) nelder65 = nelder65 + 1.
if range(age5,65,120) nelder65 = nelder65 + 1.
if range(age6,65,120) nelder65 = nelder65 + 1.
if range(age7,65,120) nelder65 = nelder65 + 1.

compute nelder2 = nelder65.
recode nelder2 (1 thru 9 = 1).
recode nelder2 (0 = 2).

compute nelder75 = 0.
if range(age1,75,120) nelder75 = nelder75 + 1.
if range(age2,75,120) nelder75 = nelder75 + 1.
if range(age3,75,120) nelder75 = nelder75 + 1.
if range(age4,75,120) nelder75 = nelder75 + 1.
if range(age5,75,120) nelder75 = nelder75 + 1.
if range(age6,75,120) nelder75 = nelder75 + 1.
if range(age7,75,120) nelder75 = nelder75 + 1.

compute nelder3 = nelder75.
recode nelder3 (1 thru 9 = 1).
recode nelder3 (0 = 2).

compute nadults1864 = 0.
if range(age1,18,64) nadults1864 = nadults1864 + 1.
if range(age2,18,64) nadults1864 = nadults1864 + 1.
if range(age3,18,64) nadults1864 = nadults1864 + 1.
if range(age4,18,64) nadults1864 = nadults1864 + 1.
if range(age5,18,64) nadults1864 = nadults1864 + 1.
if range(age6,18,64) nadults1864 = nadults1864 + 1.
if range(age7,18,64) nadults1864 = nadults1864 + 1.

Compute nsing = 0.
If (range(age1,18,64) and cj1 eq 1 and any(mar1,5,6,7)) nsing = nsing + 1.
If (range(age2,18,64) and cj2 eq 1 and any(mar2,5,6,7)) nsing = nsing + 1.
If (range(age3,18,64) and cj3 eq 1 and any(mar3,5,6,7)) nsing = nsing + 1.
If (range(age4,18,64) and cj4 eq 1 and any(mar4,5,6,7)) nsing = nsing + 1.
If (range(age5,18,64) and cj5 eq 1 and any(mar5,5,6,7)) nsing = nsing + 1.
If (range(age6,18,64) and cj6 eq 1 and any(mar6,5,6,7)) nsing = nsing + 1.
If (range(age7,18,64) and cj7 eq 1 and any(mar7,5,6,7)) nsing = nsing + 1.

compute nsing2 = nsing.
recode nsing2 (1 thru 9 = 1).
recode nsing2 (0 = 2).

compute nmarried = 0.
if (any(mar1,1,2,3)) nmarried = nmarried + 1.
if (any(mar2,1,2,3)) nmarried = nmarried + 1.
if (any(mar3,1,2,3)) nmarried = nmarried + 1.
if (any(mar4,1,2,3)) nmarried = nmarried + 1.
if (any(mar5,1,2,3)) nmarried = nmarried + 1.
if (any(mar6,1,2,3)) nmarried = nmarried + 1.
if (any(mar7,1,2,3)) nmarried = nmarried + 1.

temporary.
select if nmarried eq 1.
frequencies id. 

compute njews = 0.
if any(cj1,1,3) njews = njews + 1.
if any(cj2,1,3) njews = njews + 1.
if any(cj3,1,3) njews = njews + 1.
if any(cj4,1,3) njews = njews + 1.
if any(cj5,1,3) njews = njews + 1.
if any(cj6,1,3) njews = njews + 1.
if any(cj7,1,3) njews = njews + 1.
if any(cjc1,1,3) njews = njews + 1.
if any(cjc2,1,3) njews = njews + 1.
if any(cjc3,1,3) njews = njews + 1.
if any(cjc4,1,3) njews = njews + 1.
if any(cjc5,1,3) njews = njews + 1.
if any(cjc6,1,3) njews = njews + 1.
if any(cjc7,1,3) njews = njews + 1.
if any(cjc8,1,3) njews = njews + 1.
if any(cjc9,1,3) njews = njews + 1.

variable labels nchild 'Number of children' 
		 njchild 'Number of Jewish Children' 	
   nchild5 'Number of Children Age 0-5'
   njchild5 'Number of Jewish Children Age 0-5'
   njchild8 'Number of Jewish Children Age 0-8'
   njchild9 'Number of Jewish Children Age 9-11' 
 		nchild12 'Number of Children Age 0-12'
		 njchild12 'Number of Jewish Children Age 0-12'
  	njchild317 'Number of Jewish Children Age 3-17'			
		 njchild617 'Number of Jewish Children Age 6-17'
 		njchild517 'Number of Jewish Children Age 5-17'
   npjchild617 'Number of Part Jewish Children Age 6-17'
 		nteen 'Number of Teens' 	
	 	njteen 'Number of Jewish Teens'	
   nadultch20 'Number of Adult Children < Age 30'
   nadultch30 'Number of Adult Children > Age 30'
 	nadultch2 'At Least One Adult Child in household'
		nadult 'Number of Adults' 	
  njadult 'Number of Jewish Adults'	
		nelder65 'Number of Persons Age 65+' 
		nelder2 'Any 65+ Person in Household' 	
		nelder75 'Number of Persons Age 75+'
	 nelder3 'Any 75+ Person in Household' 	
		nadults1864 'Number of adults Age 18-64'
		nsing 'Number of Jewish Singles Age 18-64'
		nsing2 'At Least One Jewish Adult Single Age 18-64'
  nmarried 'Number of Married Adults'
  njews 'Number of Jews Per household'.

value labels nsing2 nelder2 nelder3 1 'Yes' 2 'No'.

WEIGHT OFF.
frequencies nchild njchild nchild5 njchild5 njchild8 njchild9 nchild12 njchild12 njchild317 njchild617 njchild517 npjchild617 nteen njteen
  nadultch20 nadultch30 nadultch2 nadult njadult nelder65 nelder2 nelder75 nelder3 nadults1864 nsing nsing2 nmarried njews.

comment run this and examine whether to continue to include these households in the file. In Detroit, we eliminated 3 households.
temporary.
select if njews eq 0.
frequencies id. 

********************************************************************************************************************************************************************.
comment Page 5: establishes household structure categories. 
********************************************************************************************************************************************************************.
comment must create number of XXX variables before running this.

weight off. 
compute family = 0.

comment married couple with children.
if (rel2 eq 2 and range(nchild,1,9)) family = 101.
if (any(rel2,15,16) and any(rel3,15,16) and range(nchild,1,9)) family = 101.
if (any(rel2,13,14) and any(rel3,13,14) and range(nchild,1,9)) family = 101.
if (any(rel2,7,8) and any(rel3,9,10) and range(nchild,1,9)) family = 101.
if (any(rel2,9,10) and any(rel3,7,8) and range(nchild,1,9)) family = 101.

comment UNmarried heterosexual couple with children.
if (any(rel2,3,4,5) and range(nchild,1,9) and sex1 ne sex2) family = 102.

comment gay couple with children.
if (any(rel2,2,3,4,5) and range(nchild,1,9) and sex1 eq sex2) family = 801.

comment single parent with children.
if (hhsiz eq 2 and nchild eq 1) family = 103.
if (hhsiz eq 3 and nchild eq 2) family = 103.
if (hhsiz eq 3 and nchild eq 1 and any(rel2,7,8)) family = 103. 
if (hhsiz eq 4 and nchild eq 3) family = 103.
if (hhsiz eq 4 and nchild eq 1) and any(rel2,7,8) and any(rel3,7,8)  family = 103.
if (hhsiz eq 4 and nchild eq 2) and any(rel2,7,8)  family = 103.
if (hhsiz eq 5 and (nchild eq 1) and any(rel2,7,8) and any(rel3,7,8) and any(rel4,7,8)) family = 103.
if (hhsiz eq 5 and (nchild eq 2) and any(rel2,7,8) and any(rel3,7,8)) family = 103.
if (hhsiz eq 5 and (nchild eq 3) and any(rel2,7,8)) family = 103.
if (hhsiz eq 5 and nchild eq 4)  family = 103.

comment other households with children.
if (any(rel2,6,25) and range(nchild,1,9)) family = 802.

comment married couple with adult children only under 30 living at home.
if (hhsiz eq 3 and rel2 eq 2 and range(rel3,7,8) and (age3 le 29)) family = 104.
if (hhsiz eq 3 and any(rel2,13,14) and any(rel3,13,14) and (age1 le 29)) family = 104.
if (hhsiz eq 4 and rel2 eq 2 and range(rel3,7,8) and range(rel4,7,8) and (age3 le 29 or age4 le 29)) family = 104.
if (hhsiz eq 4 and any(rel2,13,14) and any(rel3,13,14) and any(rel4,17,18) and (age1 le 29 or age4 le 29)) family = 104.
if (hhsiz eq 4 and any(rel2,17,18) and any(rel3,13,14) and any(rel4,13,14) and (age1 le 29 or age2 le 29)) family eq 104.
if (hhsiz eq 5 and rel2 eq 2 and range(rel3,7,8) and range(rel4,7,8) and range(rel5,7,8) and (age3 le 29 or age4 le 29 or age5 le 29)) family = 104.
if (hhsiz eq 5 and any(rel2,13,14) and any(rel3,13,14) and any(rel4,17,18) and any(rel5,17,18) and (age1 le 29 or age4 le 29 or age5 le 29)) family = 104.

comment UNmarried heterosexual couple with adult children only under 30 living at home.
if (hhsiz eq 3 and any(rel2,3,4,5) and any(rel3,7,8) and (sex1 ne sex2) and age3 le 29) family = 105.
if (hhsiz eq 4 and any(rel2,3,4,5) and any(rel3,7,8) and any(rel4,7,8) and (sex1 ne sex2)) and (age3 le 29 or age4 le 29) family = 105.

comment gay couple with adult children only under 30 living at home.
if (hhsiz eq 3 and any(rel2,2,3,4,5) and any(rel3,7,8) and (sex1 eq sex2) and age3 le 29) family = 901.
if (hhsiz eq 4 and any(rel2,2,3,4,5) and any(rel3,7,8) and any(rel4,7,8) and (sex1 eq sex2)) and (age3 le 29 or age4 le 29) family = 901.

comment single parent with adult children only under 30 living at home.
if (hhsiz eq 2 and range(rel2,7,8) and (age2 le 29)) family = 106.
if (hhsiz eq 2 and any(rel2,13,14) and (age1 le 29)) family = 106.
if (hhsiz eq 3 and range(rel2,7,8) and range(rel3,7,8) and (age2 le 29 or age3 le 29)) family = 106.
if (hhsiz eq 3 and any(rel2,13,14) and any(rel3,17,18) and (age1 le 29 or age3 le 29)) family = 106.
if (hhsiz eq 3 and any(rel2,17,18) and any(rel3,13,14) and (age1 le 29 or age2 le 29)) family = 106.
if (hhsiz eq 4 and range(rel2,7,8) and range(rel3,7,8) and range(rel4,7,8) and (age2 le 29 or age3 le 29 or age4 le 29)) family = 106.
if (hhsiz eq 4 and any(rel2,13,14) and any(rel3,17,18) and any(rel4,17,18) and (age1 le 29 or age3 le 29 or age4 le 29)) family = 106.
if (hhsiz eq 4 and any(rel2,17,18) and any(rel3,13,14) and any(rel4,17,18) and (age1 le 29 or age2 le 29 or age4 le 29)) family = 106.

comment other households with adult children only under 30 living at home.
if (hhsiz eq 3 and any(rel2,6,25) and any(rel3,7,8) and (age3 le 29)) family = 902.
if (hhsiz eq 4 and any(rel2,6,25) and any(rel3,7,8) and (any(rel4,7,8)) and (age3 le 29 or age4 le 29)) family = 902.

comment non-elderly married couple with adult children only 30 and over living at home.
if (hhsiz eq 3 and rel2 eq 2 and any(rel3,7,8)) and (age3 gt 29) and (nelder2 eq 2) family = 204.
if (hhsiz eq 3 and any(rel2,13,14) and any(rel3,13,14)) and (age1 gt 29) and (nelder2 eq 2) family = 204.
if (hhsiz eq 4 and rel2 eq 2 and any(rel3,7,8) and any(rel4,7,8)) and (age3 gt 29 and age4 gt 29) and (nelder2 eq 2) family = 204.
if (hhsiz eq 4 and any(rel2,13,14) and any(rel3,13,14) and any(rel4,17,18)) and (age1 gt 29 and age4 gt 29) and (nelder2 eq 2) family = 204.
if (hhsiz eq 5 and rel2 eq 2 and any(rel3,7,8) and any(rel4,7,8) and any(rel5,7,8)) and (age3 gt 29 and age4 gt 29 and age5 gt 29) and (nelder2 eq 2) family = 204.
if (hhsiz eq 5 and any(rel2,13,14) and any(rel3,13,14) and any(rel4,17,18) and any(rel5,17,18)) and (age1 gt 29 and age4 gt 29 and age5 gt 29) and (nelder2 eq 2) family = 204.

comment elderly married couple with adult children only 30 and over living at home.
if (hhsiz eq 3 and rel2 eq 2 and any(rel3,7,8)) and (age3 gt 29) and (nelder2 eq 1) family = 304.
if (hhsiz eq 3 and any(rel2,13,14) and any(rel3,13,14)) and (age1 gt 29) and (nelder2 eq 1) family = 304.
if (hhsiz eq 4 and rel2 eq 2 and any(rel3,7,8) and any(rel4,7,8)) and (age3 gt 29 and age4 gt 29) and (nelder2 eq 1) family = 304.
if (hhsiz eq 4 and any(rel2,13,14) and any(rel3,13,14) and any(rel4,17,18)) and (age1 gt 29 and age4 gt 29) and (nelder2 eq 1) family = 304.
if (hhsiz eq 5 and rel2 eq 2 and any(rel3,7,8) and any(rel4,7,8) and any(rel5,7,8)) and (age3 gt 29 and age4 gt 29 and age5 gt 29) and (nelder2 eq 1) family = 304.
if (hhsiz eq 5 and any(rel2,13,14) and any(rel3,13,14) and any(rel4,17,18) and any(rel5,17,18)) and (age1 gt 29 and age4 gt 29 and age5 gt 29) and (nelder2 eq 1) family = 304.

comment non-elderly single parent with adult children only 30 and over living at home.
if (hhsiz eq 2 and any(rel2,7,8) and age2 gt 29) and (nelder2 eq 2) family = 206.
if (hhsiz eq 2 and any(rel2,13,14) and age1 gt 29) and (nelder2 eq 2) family = 206.
if (hhsiz eq 3 and any(rel2,7,8) and any(rel3,7,8)) and (age2 gt 29 and age3 gt 29) and (nelder2 eq 2) family = 206.
if (hhsiz eq 3 and any(rel2,13,14) and any(rel3,17,18)) and (age1 gt 29 and age3 gt 29) and (nelder2 eq 2) family = 206.
if (hhsiz eq 3 and any(rel2,17,18) and any(rel3,13,14)) and (age1 gt 29 and age2 gt 29) and (nelder2 eq 2) family = 206.
if (hhsiz eq 4 and any(rel2,7,8) and any(rel3,7,8) and any(rel4,7,8)) and (age2 gt 29 and age3 gt 29 and age4 gt 29) and (nelder2 eq 2) family = 206.
if (hhsiz eq 4 and any(rel2,13,14) and any(rel3,17,18) and any(rel4,17,18)) and (age1 gt 29 and age3 gt 29 and age4 gt 29) and (nelder2 eq 2) family = 206.
if (hhsiz eq 4 and any(rel2,17,18) and any(rel3,13,14) and any(rel4,17,18)) and (age1 gt 29 and age2 gt 29 and age4 gt 29) and (nelder2 eq 2) family = 206.

comment elderly single parent with adult children only 30 and over living at home.
if (hhsiz eq 2 and range(rel2,7,8) and age2 gt 29) and (nelder2 eq 1) family = 306.
if (hhsiz eq 2 and range(rel2,13,14) and age1 gt 29) and (nelder2 eq 1) family = 306.
if (hhsiz eq 3 and any(rel2,7,8) and any(rel3,7,8)) and (age2 gt 29 and age3 gt 29) and (nelder2 eq 1) family = 306.
if (hhsiz eq 3 and any(rel2,13,14) and any(rel3,17,18)) and (age1 gt 29 and age3 gt 29) and (nelder2 eq 1) family = 306.
if (hhsiz eq 3 and any(rel2,17,18) and any(rel3,13,14)) and (age1 gt 29 and age2 gt 29) and (nelder2 eq 1) family = 306.
if (hhsiz eq 4 and any(rel2,7,8) and any(rel3,7,8) and any(rel4,7,8)) and (age2 gt 29 and age3 gt 29 and age4 gt 29) and (nelder2 eq 1) family = 306.
if (hhsiz eq 4 and any(rel2,13,14) and any(rel3,17,18) and any(rel4,17,18)) and (age1 gt 29 and age3 gt 29 and age4 gt 29) and (nelder2 eq 1) family = 306.
if (hhsiz eq 4 and any(rel2,17,18) and any(rel3,13,14) and any(rel4,17,18)) and (age1 gt 29 and age2 gt 29 and age4 gt 29) and (nelder2 eq 1) family = 306.

comment married couple without children.
if (hhsiz eq 2 and rel2 eq 2 and age1 lt 35) family = 107.
if (hhsiz eq 2 and rel2 eq 2 and range(age1,35,49)) family = 108.
if (hhsiz eq 2 and rel2 eq 2 and range(age1,50,64)) family = 109.
if (hhsiz eq 2 and rel2 eq 2 and range(age1,65,74)) family = 110.
if (hhsiz eq 2 and rel2 eq 2 and age1 ge 75) family = 111.

comment single person households.
if (hhsiz eq 1 and age1 lt 65 and sex1 eq 1) family = 112.
if (hhsiz eq 1 and age1 lt 65 and sex1 eq 2) family = 113.
if (hhsiz eq 1) and (range(age1,65,74)) and (sex1 eq 1) family = 114.
if (hhsiz eq 1 and range(age1,65,74) and sex1 eq 2) family = 115.
if (hhsiz eq 1 and age1 ge 75 and sex1 eq 1) family = 116.
if (hhsiz eq 1 and age1 ge 75 and sex1 eq 2) family = 117.

comment UNmarried hetero couples without children.
if (hhsiz eq 2 and any(rel2,3,4,5) and (sex1 ne sex2)) family = 118.

comment gay couples without children.
if (hhsiz eq 2 and any(rel2,2,3,4,5) and (sex1 eq sex2)) family = 918.

comment roommates/friends.
if (hhsiz eq 2 and any(rel2,6,25)) family = 119.
if (hhsiz eq 3 and any(rel2,6,25) and any(rel3,6,25)) family = 119.
if (hhsiz eq 4 and any(rel2,6,25) and any(rel3,6,25) and any(rel4,6,25)) family = 119.

comment married couple and parent(s).
if (hhsiz eq 3 and rel2 eq 2 and any(rel3,13,14)) family = 121. 
if (hhsiz eq 3 and any(rel2,7,8) and any(rel3,9,10)) family = 121.
if (hhsiz eq 3 and any(rel2,9,10) and any(rel3,7,8)) family = 121.
if (hhsiz eq 4 and rel2 eq 2 and any(rel3,13,14) and any(rel4,13,14)) family = 121.

comment single parent with adult children only under 30 living at home and parent(s).
if (hhsiz eq 3 and any(rel2,13,14) and any(rel3,7,8) and age3 le 29) family = 126.
if (hhsiz eq 3 and any(rel2,7,8) and any(rel3,13,14) and age2 le 29) family = 126.

comment other relatives living together.
if (hhsiz eq 2 and any(rel2,17,18)) family = 122.
if (hhsiz eq 3 and any(rel2,17,18) and any(rel3,17,18)) family = 122.
if (hhsiz eq 2 and rel2 eq 21) family = 124.

variable labels family 'Household Stucture'.
value labels family 
	101 'married couple + child' 
	102 'unmarried hetero couple + child' 
	103 'single parent + child' 
	104 'married couple + adult child only < 30' 
	105 'unmarried hetero couple + adult child < 30' 
	106 'single parent + adult child < 30'
	107 'married couple < 35'
	108 'married couple 35-49' 
	109 'married couple 50-64' 
	110 'married couple 65-74' 
	111 'married couple 75+' 
	112 'single male < 65' 
	113 'single female < 65' 
	114 'single male 65-74' 		
	115 'single female 65-74' 
	116 'single male 75+'			
	117 'single female 75+' 
	118 'unmarried hetero couple'
	119 'roommates/friends' 
	120 'married couple + adult child < 30 + parent' 
	121 'married couple + parent' 	
	122 'siblings living together'
	124 'cousins living together'
	126 'single parent + adult child <30 + parent'
	127 'married couple + other relatives'
	204 'non-elderly married couple + adult child 30+'
	206 'non-elderly single parent + adult child 30+'
	304 'elderly married couple + adult child 30+'
	306 'elderly single parent + adult child 30+'
	801 'gay couple + child'
	802 'other household with child'
	901 'gay couple + adult child < 30' 
	902 'other household + adult child < 30'
                  903 'other household + adult child 30+'
	918 'gay couple'. 
FREQUENCIES family.

comment deals with specific cases in Detroit.
if any(id,511,1178) family = 101.
if any(id,954) family = 102.
if any(id,1155) family = 103.
if any(id,89,1077,1134) family = 104.
if any(id,881,935) family = 105.
if any(id,1105) family = 106.
if any(id,590,1007) family = 118.
if any(id,198) family = 120.
if any(id,558) family = 121.
if any(id,549,553,643) family = 122.
if any(id,556) family = 126.
if any(id,1135) family = 127.
if any(id,651) family = 204.
if any(id,421,449,489,591,1197) family = 304.
if any(id,37,579) family = 306.
if any(id,819,856) family = 802.
if any(id,94,275,325) family = 902.
if any(id,518,756) family = 903.

temporary.
select if family eq 0.
frequencies id.

FREQUENCIES family.

comment if married couple in household, do not put in 802.

comment check on existence-non-existence of children.
crosstabs tables = family by nchild
	/cells = count.

compute cfamily = family.
recode cfamily 	(101 102 103 801 802 = 201)
	 	(104 105 106 120 126 901 902 = 202)
		(107 108 109 = 203)
		(112 113 = 204)
		(110 111 = 205)
		(114 115 116 117 = 206)
		(204 304 206 306 118 119 121 122 124 127 902 903 918 = 207).

variable labels cfamily 'Household Structure in Large Categories'.
value labels cfamily 
		201 'hh w children' 
		202 'hh w adult children only' 
		203 'non-elderly couple' 
		204 'non-elderly single' 
		205 'eld couple' 
		206 'eld single' 
		207 'other' .
frequencies family cfamily.

missing values cfamily ().
compute profilefamily = cfamily.
variable labels profilefamily 'Household Structure in Large Categories for Profiles'.
value labels profilefamily 
		201 'hh w children' 
		202 'hh w adult children only' 
		203 'non-elderly couple' 
		204 'non-elderly single' 
		205 'eld couple' 
		206 'eld single' 
		207 'other' .
missing values profilefamily ().
frequencies family cfamily profilefamily.
missing values cfamily (207).
frequencies cfamily.

comment jhhc and bhhc.

missing values cfamily ().
compute jhhc = 2.
if (range(njchild,1,9)) jhhc = 1.
if (cfamily ne 201) jhhc = 3.
variable labels jhhc 'Household with Jewish Children'.
value labels jhhc 1 'Yes-HH with Jewish children' 2 'No-HH has No Jewish children' 3 'Not a HH with Children'.
missing values jhhc (3).
frequencies jhhc.
missing values cfamily (207).

compute bhhc = 2.
if ((cfamily eq 201) and ((cjc1 eq 3) or (cjc2 eq 3) or (cjc3 eq 3) or (cjc4 eq 3) or (cjc5 eq 3) or (cjc6 eq 3) or (cjc7 eq 3) or (cjc8 eq 3) or (cjc9 eq 3)) and (jhhc ne 1)) bhhc = 1.
if (cfamily ne 201) bhhc = 3.
variable labels bhhc 'Household Contains Children Being Raised Part Jewish'.
value lablels bhhc 1 'Yes-HH with Part Jewish children' 2 'No-HH has no Part Jewish children' 3 'Not a HH with children'.
missing values bhhc (3).
frequencies bhhc.

compute jsex = sex1.
frequencies jsex sex1.
if (cj1 ne 1) jsex = sex2.
frequencies jsex sex1.
if (any(rel2,13,14) and any(rel3,13,14) and cj1 eq 2 and cj2 eq 2) jsex = sex3.
variable labels jsex 'Sex of Jewish Household Head'.
value labels jsex 1 'male' 2 'female'.
frequencies sex1 jsex.

********************************************************************************************************************************************************************.
comment page 5: computes convert status.
********************************************************************************************************************************************************************.
comment children who are part Jewish are omitted from the analysis.

if (bj1 eq 2 and cj1 eq 1) conv1 = 1.
if (bj2 eq 2 and cj2 eq 1) conv2 = 1.
if (bj3 eq 2 and cj3 eq 1) conv3 = 1.
if (bj4 eq 2 and cj4 eq 1) conv4 = 1.
if (bj5 eq 2 and cj5 eq 1) conv5 = 1.
if (bj6 eq 2 and cj6 eq 1) conv6 = 1.
if (bj7 eq 2 and cj7 eq 1) conv7 = 1.

if (bjc1 eq 2 and cjc1 eq 1) convc1 = 1.
if (bjc2 eq 2 and cjc2 eq 1) convc2 = 1.
if (bjc3 eq 2 and cjc3 eq 1) convc3 = 1.
if (bjc4 eq 2 and cjc4 eq 1) convc4 = 1.
if (bjc5 eq 2 and cjc5 eq 1) convc5 = 1.
if (bjc6 eq 2 and cjc6 eq 1) convc6 = 1.
if (bjc7 eq 2 and cjc7 eq 1) convc7 = 1. 
if (bjc8 eq 2 and cjc8 eq 1) convc8 = 1. 
if (bjc9 eq 2 and cjc9 eq 1) convc9 = 1. 

if (bj1 eq 1 and cj1 eq 1) conv1 = 2.
if (bj2 eq 1 and cj2 eq 1) conv2 = 2.
if (bj3 eq 1 and cj3 eq 1) conv3 = 2.
if (bj4 eq 1 and cj4 eq 1) conv4 = 2.
if (bj5 eq 1 and cj5 eq 1) conv5 = 2.
if (bj6 eq 1 and cj6 eq 1) conv6 = 2.
if (bj7 eq 1 and cj7 eq 1) conv7 = 2.

if (bjc1 eq 1 and cjc1 eq 1) convc1 = 2.
if (bjc2 eq 1 and cjc2 eq 1) convc2 = 2.
if (bjc3 eq 1 and cjc3 eq 1) convc3 = 2.
if (bjc4 eq 1 and cjc4 eq 1) convc4 = 2.
if (bjc5 eq 1 and cjc5 eq 1) convc5 = 2.
if (bjc6 eq 1 and cjc6 eq 1) convc6 = 2.
if (bjc7 eq 1 and cjc7 eq 1) convc7 = 2.
if (bjc8 eq 1 and cjc8 eq 1) convc8 = 2.
if (bjc9 eq 1 and cjc9 eq 1) convc9 = 2.

if (bj1 eq 2 and cj1 eq 2) conv1 = 3.
if (bj2 eq 2 and cj2 eq 2) conv2 = 3.
if (bj3 eq 2 and cj3 eq 2) conv3 = 3.
if (bj4 eq 2 and cj4 eq 2) conv4 = 3.
if (bj5 eq 2 and cj5 eq 2) conv5 = 3.
if (bj6 eq 2 and cj6 eq 2) conv6 = 3.
if (bj7 eq 2 and cj7 eq 2) conv7 = 3.

if (bjc1 eq 2 and cjc1 eq 2) convc1 = 3.
if (bjc2 eq 2 and cjc2 eq 2) convc2 = 3.
if (bjc3 eq 2 and cjc3 eq 2) convc3 = 3.
if (bjc4 eq 2 and cjc4 eq 2) convc4 = 3.
if (bjc5 eq 2 and cjc5 eq 2) convc5 = 3.
if (bjc6 eq 2 and cjc6 eq 2) convc6 = 3.
if (bjc7 eq 2 and cjc7 eq 2) convc7 = 3.
if (bjc8 eq 2 and cjc8 eq 2) convc8 = 3.
if (bjc9 eq 2 and cjc9 eq 2) convc9 = 3.

if (bj1 eq 1 and cj1 eq 2) conv1 = 4.
if (bj2 eq 1 and cj2 eq 2) conv2 = 4.
if (bj3 eq 1 and cj3 eq 2) conv3 = 4.
if (bj4 eq 1 and cj4 eq 2) conv4 = 4.
if (bj5 eq 1 and cj5 eq 2) conv5 = 4.
if (bj6 eq 1 and cj6 eq 2) conv6 = 4.
if (bj7 eq 1 and cj7 eq 2) conv7 = 4.

if (bjc1 eq 1 and cjc1 eq 2) convc1 = 4.
if (bjc2 eq 1 and cjc2 eq 2) convc2 = 4.
if (bjc3 eq 1 and cjc3 eq 2) convc3 = 4.
if (bjc4 eq 1 and cjc4 eq 2) convc4 = 4.
if (bjc5 eq 1 and cjc5 eq 2) convc5 = 4.
if (bjc6 eq 1 and cjc6 eq 2) convc6 = 4.
if (bjc7 eq 1 and cjc7 eq 2) convc7 = 4.
if (bjc8 eq 1 and cjc8 eq 2) convc8 = 4.
if (bjc9 eq 1 and cjc9 eq 2) convc9 = 4.

variable labels conv1 'Conversion-Respondent'
 		conv2 'Conversion-Adult 2'
		 conv3 'Conversion-Adult 3'
 		conv4 'Conversion-Adult 4'
 		conv5 'Conversion-Adult 5'
 		conv6 'Conversion-Adult 6'
		conv7 'Conversion-Adult 7'
 		convc1 'Conversion-Child 1'
 		convc2 'Conversion-Child 2'
		convc3 'Conversion-Child 3'
 		convc4 'Conversion-Child 4'
 		convc5 'Conversion-Child 5'
		convc6 'Conversion-Child 6'
		convc7 'Conversion-Child 7'
		convc8 'Conversion-Child 8'
		convc9 'Conversion-Child 9'.

Value labels conv1 to convc9
	1 'Jewish, Convert' 2 'Jewish, Not a Convert' 3 'Not Jewish, Not a Convert' 4 'Not Jewish, Apostate'.

frequencies conv1 to convc9.

recode conv1 (sysmis =999).
temporary.
select if conv3 eq  4.
frequencies id.

frequencies bjc2 cjc2.

********************************************************************************************************************************************************************.
comment Page 5: computes intermarriage. 
********************************************************************************************************************************************************************.
compute inter1 = 0.

comment covers if adults 1 and 2 are a married couple and covers if adults 2 and 3 are parents.
comment only one married couple per household is coded with preference given to adults 1 and 2.

comment handle gay couples individually if reported as partner but marital status is married.

comment following is an inmarriage.
if (rel2 eq 2 and bj1 eq 1 and bj2 eq 1 and cj1 eq 1 and cj2 eq 1) inter1 = 1.
if (any(rel2,13,14) and any(rel3,13,14) and bj2 eq 1 and bj3 eq 1 and cj2 eq 1 and cj3 eq 1) inter1 = 1.

comment following is a conversionary inmarriage.
if (rel2 eq 2 and (conv1 eq 1 or conv2 eq 1)) inter1 = 2.
if (any(rel2,13,14) and any(rel3,13,14) and (conv2 eq 1 or conv3 eq 1)) inter1 = 2.
 
comment following is an intermarriage.
if ((rel2 eq 2) and (cj1 ne cj2)) inter1 = 3.
if (any(rel2,13,14) and any(rel3,13,14) and (cj2 ne cj3)) inter1 = 3.

comment following picks up intermarriages in which the Jew is a convert.
if (rel2 eq 2) and (conv1 eq 1) and (cj2 eq 2) inter1 = 4.
if (rel2 eq 2) and (conv2 eq 1) and (cj1 eq 2) inter1 = 4.
if any(rel2,13,14) and any(rel3,13,14) and (conv2 eq 1) and (cj3 eq 2) inter1 = 4.
if any(rel2,13,14) and any(rel3,13,14) and (conv3 eq 1) and (cj2 eq 2) inter1 = 4.

variable labels inter1 'intermarriage including conversionary intermarriages'.
value labels inter1 0 'No Married Couple in HH' 1 'inmarriage' 2 'conversionary' 3 'intermarriage' 4 'Conversionary Intermarriage' .
missing values inter1 ().
frequencies inter1.

comment following finds households with a married couple, neither of whom are Jewish, to see if coding error.
temporary.
select if rel2 eq 2 and cj1 eq 2 and cj2 eq 2.
frequencies id.

temporary.
select if any(rel2,13,14) and any(rel3,13,14) and cj2 eq 2 and cj3 eq 2.
frequencies id.

**************************************************************************************************************************.
comment identifies households where an intermarried adult child couple lives with a parent.
temporary.
select if any(rel2,7,8) and any(rel3,9,10) and (cj2 ne cj3).
frequencies id.

temporary.
select if any(rel2,9,10) and any(rel3,7,8) and (cj2 ne cj3).
frequencies id.

temporary.
select if any(rel3,7,8) and any(rel4,9,10) and (cj3 ne cj4) and rel2 ne 2.
frequencies id.

temporary.
select if any(rel3,9,10) and any(rel4,7,8) and (cj3 ne cj4) and rel2 ne 2.
frequencies id.

comment this will pick up anything missed by the above programming, like 2 married cousins, 2 married grandparents, etc.
missing values inter1 ().
temporary.
select if nmarried ge 1 and inter1 eq 0.
frequencies id.
missing values inter1 (0).

if any(id,320,988,1178) inter1 = 3.
if any(id,511,586) inter1 = 3.

compute inter = inter1.
variable labels inter 'Intermarriage Status'.
recode inter (4 = 3).

weight off.
crosstabs tables = inter by nmarried.

missing values inter (0).

FREQUENCIES inter.

comment 0 may include married couples between non-Jews.
variable labels inter 'intermarriage'.
value labels inter 0 'No Married Couple with a Jew in HH' 1 'Inmarriage' 2 'Conversionary' 3 'Intermarriage'.
missing values inter1 inter (0).

weight wf.
frequencies inter1 inter.
weight off.

compute interhhk = 2.
if (inter eq 3 and range(njchild,1,9)) interhhk = 1.
variable labels interhhk 'Intermarried Household with Jewish Children'.
value labels interhhk 1 'Yes '2 'No'.
frequencies interhhk.

********************************************************************************************************************************************************************.
comment Page 5: is everyone in hh jewish.
********************************************************************************************************************************************************************.
weight off.
compute all_jews = 1.
if (cj1 eq 2 or cj2 eq 2 or cj3 eq 2 or cj4 eq 2 or cj5 eq 2 or cj6 eq 2 or cj7 eq 2 or cjc1 eq 2 or cjc2 eq 2 or cjc3 eq 2 or cjc4 eq 2
	or cjc5 eq 2 or cjc6 eq 2 or cjc7 eq 2 or cjc8 eq 2 or cjc9 eq 2) all_jews = 2.
variable labels all_jews 'everyone in hh is jewish'.
value labels all_jews 1 'yes' 2 'no'.
frequencies all_jews.

compute all_brnj = 1.
if (bj1 eq 2 or bj2 eq 2 or bj3 eq 2 or bj4 eq 2 or bj5 eq 2 or bj6 eq 2 or bj7 eq 2 or bjc1 eq 2 or bjc2 eq 2 or bjc3 eq 2 or bjc4 eq 2
	or bjc5 eq 2 or bjc6 eq 2 or bjc7 eq 2 or bjc8 eq 2 or bjc9 eq 2) all_brnj = 2.
variable labels all_brnj 'everyone in hh is born jewish'.
value labels all_brnj 1 'yes' 2 'no'.
frequencies all_brnj.


********************************************************************************************************************************************************************.
comment Page 5: Living Arrangments of the Elderly.
********************************************************************************************************************************************************************.
compute alone = 102.
if range(family,112,117) alone = 101.
variable labels alone 'Elderly Person Lives Alone'.
value labels alone 101 'Live Alone' 102 'Not Live Alone'.
frequencies alone.

*******************************************************************************************************************************************************************.
comment page 6: geography categories.  
********************************************************************************************************************************************************************.
frequencies lbefor born1 born2 born3 born4 born5 born6 born7.
compute clbefor = lbefor.
compute cborn1 = born1.
compute cborn2 = born2.
compute cborn3 = born3.
compute cborn4 = born4.
compute cborn5 = born5.
compute cborn6 = born6.
compute cborn7 = born7.

variable labels 
	clbefor 'place of previous residence' 
	cborn1 'birthplace-respondent' 
	cborn2 'birthplace-adult 2' 
	cborn3 'birthplace-adult 3'
	cborn4 'birthplace-adult 4' 
	cborn5 'birthplace-adult 5' 
	cborn6 'birthplace-adult 6' 
	cborn7 'birthplace-adult 7' .

comment redo state that community is in if necessary in the following recode.
comment if have to run this a second time, go above and recreate the cborn series again.
recode clbefor cborn1 to cborn7 
	(1 = 90)
                  (2 5 9 10 11 12 19 20 22 26 35 38 42 44 45 48 50 53 = 101)
	(8 21 23 31 32 34 40 41 47 54 = 102)
	(15 16 17 18 24 25 27 29 36 37 43 51 = 103) 
	(3 4 6 7 13 14 28 30 33 39 46 49 52 58 = 104) 
	(100 101 104 105 106 107 113 114 119 121 122 123 124 = 105)
	(102 103 108 109 110 111 112 115 116 117 118 120 125 126 127 128 610 906 129 = 106)
	(200 thru 217 = 107)
	(300 thru 320 = 108) 
	(400 thru 430 57 905 418 = 109) 
	(500 thru 530 = 110) 
	(600 thru 650 907 908 = 111)
	(900, 619 = 111)
                   (98=999) .

value labels clbefor cborn1 cborn2 cborn3 cborn4 cborn5 cborn6 cborn7 
	 90 'Detroit Area'
                   98 'Dont Know'
	101 'South'
	102 'Northeast' 
	103 'Midwest'
	104 'West' 
	105 'Eastern Europe - non-FSU' 
	106 'Western and Northern Europe' 
	107 'FSU'
	108 'South America' 
	109 'Middle America'
	110 'Middle East' 
	111 'Other Foreign' 
                  999 'Dont Know'.
frequencies born1 cborn1.
missing values clbefor cborn1 cborn2 cborn3 cborn4 cborn5 cborn6 cborn7 (98,999). 
frequencies clbefor cborn1 cborn2 cborn3 cborn4 cborn5 cborn6 cborn7. 

compute cclbefor = clbefor.
compute ccborn1=cborn1.
compute ccborn2=cborn2.
compute ccborn3=cborn3.
compute ccborn4=cborn4.
compute ccborn5=cborn5.
compute ccborn6=cborn6.
compute ccborn7=cborn7.

variable labels 
	cclbefor 'place of previous residence' 
	ccborn1 'birthplace-respondent' 
	ccborn2 'birthplace-adult 2' 
	ccborn3 'birthplace-adult 3'
	ccborn4 'birthplace-adult 4' 
	ccborn5 'birthplace-adult 5' 
	ccborn6 'birthplace-adult 6' 
	ccborn7 'birthplace-adult 7' .


recode ccborn1 to ccborn7 cclbefor 
	(90 thru 98 = 201)
	(100 thru 104 = 201)
	(105 thru 111 = 202).

value labels ccborn1 ccborn2 ccborn3 ccborn4 ccborn5 ccborn6 ccborn7 
	201 'US Born'
	202 'Foreign Born'.

value labels cclbefor
	201 'US Locations'
	202 'Foreign Locations'.

frequencies born1 cborn1 ccborn1.

********************************************************************************************************************************************************************.
comment Page 6: degree categorization.
********************************************************************************************************************************************************************.
compute cdeg1 = deg1.
compute cdeg2 = deg2.
compute cdeg3 = deg3.
compute cdeg4 = deg4.
compute cdeg5 = deg5.
compute cdeg6 = deg6.
compute cdeg7 = deg7.

variable labels cdeg1 'Degree-Respondent' cdeg2 'Degree-Adult 2' cdeg3 'Degree-Adult 3' cdeg4 'Degree-Adult 4' cdeg5 'Degree-Adult 5'
 cdeg6 'Degree-Adult 6' cdeg7 'Degree-Adult 7'.

recode cdeg1 cdeg2 cdeg3 cdeg4 cdeg5 cdeg6 cdeg7 (1 2 3 4 = 101) (5 6 7 = 102) (8 9 10 = 103) (11 12 13 14 15 16 17 = 104).
value labels cdeg1 cdeg2 cdeg3 cdeg4 cdeg5 cdeg6 cdeg7 101 'high school deg or less' 102 'Some coll-grad 2-yr college' 103 'grad 4-yr college' 104 'grad degree'.
frequencies deg1 cdeg1.

********************************************************************************************************************************************************************.
comment Page 6: Marital categorization
********************************************************************************************************************************************************************.
frequencies mar1.
recode mar1 mar2 mar3 mar4 mar5 mar6 mar7 (1 = 101) (2 = 103) (3 = 104) (4=108) (5 = 102)(6 = 105) (7 = 106) (8 = 107).

value labels mar1 mar2 mar3 mar4 mar5 mar6 mar7 101 'Married First Time' 102 'Single Never Married' 108 'Living with a Partner'
	103 'Divorced-remarried' 104 'Widowed-remarried' 105 'Currently Divorced' 106 'Currently Widowed' 107 'Separated' 9 'dknr' 
	1 'Married First Time' 2 'Divorced-Remarried' 3 'Widowed-Remarried' 4 'Living with a partner' 5 'Single Never Married' 6 'Currently Divorced' 7 'Currently Widowed' 8 'Separated'.
frequencies mar1.

compute cmar1 = mar1.
compute cmar2 = mar2.
compute cmar3 = mar3.
compute cmar4 = mar4.
compute cmar5 = mar5.
compute cmar6 = mar6.
compute cmar7 = mar7.

variable labels cmar1 'Marital Status-Respondent' cmar2 'Marital Status-Adult 2' cmar3 'Marital Status-Adult 3' cmar4 'Marital Status-Adult 4'
 cmar5 'Marital Status-Adult 5' cmar6 'Marital Status-Adult 6' cmar7 'Marital Status-Adult 7'.

recode cmar1 cmar2 cmar3 cmar4 cmar5 cmar6 cmar7 (101 103 104 107 = 110) (106 = 111) (105 = 112) (102 = 113).
value labels cmar1 cmar2 cmar3 cmar4 cmar5 cmar6 cmar7 107 'Separated' 110 'Now Married' 111 'Widowed' 112 'Divorced' 113 'Single Never Married' 108 'Living with a Partner'.
frequencies mar1 mar2 mar3 mar4 mar5 mar6 mar7 cmar1 cmar2 cmar3 cmar4 cmar5 cmar6 cmar7.
frequencies mar1 cmar1.

compute divor_hh = 2.
if (any(mar1,103,105) or any(mar2,103,105) or any(mar3,103,105) or any(mar4,103,105) or any(mar5,103,105) or any(mar6,103,105) or any(mar7,103,105)) divor_hh = 1.
variable labels divor_hh 'Ever Divorced Person in Household'.
value labels divor_hh	1 'Yes' 	2 'No'.
frequencies divor_hh.

Compute nsing = 0.
If (range(age1,18,64) and cj1 eq 1 and any(mar1,102,105,106)) nsing = nsing + 1.
If (range(age2,18,64) and cj2 eq 1 and any(mar2,102,105,106)) nsing = nsing + 1.
If (range(age3,18,64) and cj3 eq 1 and any(mar3,102,105,106)) nsing = nsing + 1.
If (range(age4,18,64) and cj4 eq 1 and any(mar4,102,105,106)) nsing = nsing + 1.
If (range(age5,18,64) and cj5 eq 1 and any(mar5,102,105,106)) nsing = nsing + 1.
If (range(age6,18,64) and cj6 eq 1 and any(mar6,102,105,106)) nsing = nsing + 1.
If (range(age7,18,64) and cj7 eq 1 and any(mar7,102,105,106)) nsing = nsing + 1.
Variable labels nsing 'number of jewish single adults under age 65 in hh'.

compute nsing2 = nsing.
recode nsing2 (1 thru 9 = 1).
recode nsing2 (0 = 2).
variable labels nsing2 'Any Jewish Single Person in Household Age 18-64'.
value labels nsing2 1 'Yes' 2 'No'.
frequencies nsing nsing2.

compute anydiv = 102.
variable labels anydiv 'Anyone in the Household is Divorced'.
value labels anydiv 101 'Someone is Divorced' 102 'No One is Divorced'.
if (cmar1 eq 112) anydiv = 101.
if (cmar2 eq 112) anydiv = 101.
if (cmar3 eq 112) anydiv = 101.
if (cmar4 eq 112) anydiv = 101.
if (cmar5 eq 112) anydiv = 101.
if (cmar6 eq 112) anydiv = 101.
if (cmar7 eq 112) anydiv = 101.
frequencies anydiv.

compute anywid = 102.
variable labels anywid 'Anyone in the Household is Widowed'.
value labels anywid 101 'Someone is Widowed' 102 'No One is Widowed'.
if (cmar1 eq 111) anywid = 101.
if (cmar2 eq 111) anywid = 101.
if (cmar3 eq 111) anywid = 101.
if (cmar4 eq 111) anywid = 101.
if (cmar5 eq 111) anywid = 101.
if (cmar6 eq 111) anywid = 101.
if (cmar7 eq 111) anywid = 101.
frequencies anywid.


comment Creates ccmar to make calculating for single adults table easier and more accurate, because of less rounding.
******************************************************************************************************************************************.
compute ccmar1 = cmar1.
compute ccmar2 = cmar2.
compute ccmar3 = cmar3.
compute ccmar4 = cmar4.
compute ccmar5 = cmar5.
compute ccmar6 = cmar6.
compute ccmar7 = cmar7.
recode ccmar1 ccmar2 ccmar3 ccmar4 ccmar5 ccmar6 ccmar7 (111 112 113 = 201).
variable labels ccmar1 'Marital Status Adult 1 for Singles Table'.
variable labels ccmar2 'Marital Status Adult 2 for Singles Table'.
variable labels ccmar3 'Marital Status Adult 3 for Singles Table'.
variable labels ccmar4 'Marital Status Adult 4 for Singles Table'.
variable labels ccmar5 'Marital Status Adult 5 for Singles Table'.
variable labels ccmar6 'Marital Status Adult 6 for Singles Table'.
variable labels ccmar7 'Marital Status Adult 7 for Singles Table'.
value labels ccmar1 ccmar2 ccmar3 ccmar4 ccmar5 ccmar6 ccmar7 201 'Single' 110 'Now Married' 107 'Separated' 108 'Partners'.
frequencies cmar1 ccmar1.


********************************************************************************************************************************************************************.
comment Page 6: Employment Changes to make order of response match report.
********************************************************************************************************************************************************************.
frequencies emp1.
compute cemp1 = emp1.
compute cemp2 = emp2.
compute cemp3 = emp3.
compute cemp4 = emp4.
compute cemp5 = emp5.
compute cemp6 = emp6.
compute cemp7 = emp7.

variable labels cemp1 'Combined Employment Status Variable in Correct Order for Respondent'
          cemp2 'Combined Employment Status Variable in Correct Order for Adult 2'
          cemp3 'Combined Employment Status Variable in Correct Order for Adult 3'
          cemp4 'Combined Employment Status Variable in Correct Order for Adult 4'
          cemp5 'Combined Employment Status Variable in Correct Order for Adult 5'
          cemp6 'Combined Employment Status Variable in Correct Order for Adult 6'
          cemp7 'Combined Employment Status Variable in Correct Order for Adult 7'.

value labels emp1 emp2 emp3 emp4 emp5 emp6 emp7 1 'Full Time' 2 'Part Time' 3 'Homemaker' 4 'Retired' 5 'Volunteer' 6 'Disabled' 7 'Unemployed' 8 'Student'
	9 'Retired and Part Time' 10 'Student and Part Time'.

recode cemp1 cemp2 cemp3 cemp4 cemp5 cemp6 cemp7 (1 = 101) (2 9 = 102) (7 = 103) (4 = 104) (3 = 105) (8 10 = 106) (6 = 107) (5 = 108).
value labels cemp1 cemp2 cemp3 cemp4 cemp5 cemp6 cemp7 
		101 'Full Time' 
		102 'Part Time' 
		103 'Unemployed' 
		104 'Retired' 
		105 'Homemaker' 
		106 'Student'
		107 'Disabled'
		108 'Volunteer'.
frequencies emp1 cemp1.

********************************************************************************************************************************************************************.
comment Page 5-6: latch key children 
********************************************************************************************************************************************************************.
if (cfamily eq 201) latch = 2.
if (nadult eq 1 and cemp1 eq 101) and (cfamily eq 201) latch = 1.
if (rel2 eq 2 and cemp1 eq 101 and cemp2 eq 101) and (cfamily eq 201) latch = 1.
if (any(rel2,13,14) and any(rel3,13,14) and cemp2 eq 101 and cemp3 eq 101) and (cfamily eq 201) latch = 1.
variable labels latch 'both parents or single parent work full time'.
value labels latch 1 'yes' 2 'no'.
frequencies latch cfamily.


********************************************************************************************************************************************************************.
comment Page 7: Holocaust Programming Survivors.
********************************************************************************************************************************************************************.
frequencies holo1 holo2 holo3 holo4 holo5 holo6 holo7.
compute holo0= 2.
if (holo1 eq 1) holo0 eq 1.
if (holo2 eq 1) holo0 eq 1.
if (holo3 eq 1) holo0 eq 1.
if (holo4 eq 1) holo0 eq 1.
if (holo5 eq 1) holo0 eq 1.
if (holo6 eq 1) holo0 eq 1.
if (holo7 eq 1) holo0 eq 1. 
variable labels holo0 'Anyone in the Household is a Survivor'.
value labels holo0 1 'Yes'  2 'No'.
frequencies holo0.

frequencies cholo1 cholo2 cholo3 cholo4 cholo5 cholo6 cholo7.
compute cholo0= 2.
if (cholo1 eq 1) cholo0 eq 1.
if (cholo2 eq 1) cholo0 eq 1.
if (cholo3 eq 1) cholo0 eq 1.
if (cholo4 eq 1) cholo0 eq 1.
if (cholo5 eq 1) cholo0 eq 1.
if (cholo6 eq 1) cholo0 eq 1.
if (cholo7 eq 1) cholo0 eq 1. 
variable labels cholo0 'Anyone in the Household is a Child of a Survivor'.
value labels cholo0 1 'Yes'  2 'No'.
frequencies cholo0.

frequencies gholo1 gholo2 gholo3 gholo4 gholo5 gholo6 gholo7.
compute gholo0= 2.
if (gholo1 eq 1) gholo0 eq 1.
if (gholo2 eq 1) gholo0 eq 1.
if (gholo3 eq 1) gholo0 eq 1.
if (gholo4 eq 1) gholo0 eq 1.
if (gholo5 eq 1) gholo0 eq 1.
if (gholo6 eq 1) gholo0 eq 1.
if (gholo7 eq 1) gholo0 eq 1. 
variable labels gholo0 'Anyone in the Household is a Grandchild of a Survivor'.
value labels gholo0 1 'Yes'  2 'No'.
frequencies gholo0.

comment following shows if any adult in household is a survivor and/or the child of a survivior.
compute anyshoah = 2.
if (holo0 eq 1) anyshoah = 1.
if (cholo0 eq 1) anyshoah = 1.
variable labels anyshoah 'anyone in hh is a survivor or the child of a survivor'.
value labels anyshoah 1 'yes' 2 'no'.
frequencies anyshoah.

compute anyshoahG = 2.
if (holo0 eq 1) anyshoahG= 1.
if (cholo0 eq 1) anyshoahG = 1.
if (gholo0 eq 1) anyshoahG = 1.
variable labels anyshoahG 'anyone in hh is a survivor or the child of a survivor or the grandchild of a survivor'.
value labels anyshoahg 1 'yes' 2 'no'.
frequencies anyshoahG.


********************************************************************************************************************************************************************.
comment Page 8: Adult Jewish Education as a Child
*******************************************************************************************************************************************************************.
frequencies ajed jdssun.

if (ajed eq 2) cajed = 105.
if any(jdssun,1,5) cajed = 101.
if any(jdssun,2) cajed = 102.
if any(jdssun,4) cajed = 103.
if any(jdssun,3) cajed = 104.

variable labels cajed 'Highest form of Jewish education'.
value labels cajed 
	101 'Respondent to Day School'  
	102 'Respondent to Supplemental School'  
	103 'Respondent is Israeli Educated' 
	104 'Respondent Had a Tutor' 
	105 'Respondent Had No Formal Jewish Education'.
frequencies cajed.

missing values cajed ().
compute profileajed = cajed.
variable labels profileajed 'Jewish Education as a Child for Profiles'.
value labels profileajed  
	101 'Respondent to Day School'  
	102 'Respondent to Supplemental School'  
	103 'Respondent is Israeli Educated' 
	104 'Respondent Had a Tutor' 
	105 'Respondent Had No Formal Jewish Education'.	
missing values profileajed ().
frequencies cajed profileajed.
missing values cajed (103 104).
frequencies cajed.



********************************************************************************************************************************************************************.
comment Page 9: Religiosity Changes.
********************************************************************************************************************************************************************.
frequencies kosherin kout.
if (kosherin eq 2) kout = 2.
frequencies kosherin kout.

frequencies lights.
recode lights (sysmis = 1).
frequencies lights.

frequencies hancan seder fcan kosherin.
compute practice = 2.
if any(hancan,1,2) practice = 1.
if any(seder,1,2) practice = 1.
if any(fcan,1,2) practice = 1.
if (kosherin eq 1) practice = 1.
value labels practice 1 'Yes' 2 'No'.
variable labels practice 'Summary Practice Measure'.
frequencies practice.

compute pracmezz = 2.
compute pracmezz = practice.
if (mezz eq 1) pracmezz = 1.
value labels pracmezz 1 'Yes' 2 'No'.
variable labels pracmezz 'Summary Practice Measure with Mezuzah'.
frequencies pracmezz.

recode oth_sab (sysmis = 0).
add value labels oth_sab 0 'Alw-Usu-Som Light Candles'.
frequencies fcan oth_sab.

frequencies seder hancan tree fcan.
compute cseder = seder.
compute chancan = hancan.
compute cfcan = fcan.
compute ctree = tree.
variable labels cseder 'Combined Seder Variable'.
variable labels chancan 'Combined Chanukah Candles Variable'.
variable labels cfcan 'Combined Friday Night Candles Variable'.
variable labels ctree 'Combined Christmas Tree Variable'.
recode cseder chancan cfcan (1 2 = 101) (3 4 =102).
recode ctree (1 2 3 = 101) (4 = 102).
value labels cseder chancan cfcan 101 'Always-Usually' 102 'Sometimes-Never' 9 'DKNR'.
value labels ctree 101 'Always-Usually-Sometimes' 102 'Never' 9 'DKNR'.
frequencies seder cseder chancan ctree cfcan.

comment traditional under Conservative.
frequencies ocr.
compute cocr = ocr.
recode cocr (1 7 8= 101) (2 20 = 102) (3 = 103) (4 21 = 104) (5 6 12 11 = 105) (9=106).
variable labels cocr 'Jewish Identification for Crosstabs'.
value labels cocr 101 'Orthodox' 102 'Conservative' 103 'Reconstructionist' 104 'Reform' 105 'Just Jewish' 106 'Humanist'.
frequencies ocr cocr.

compute ccocr = profileocr.
variable labels ccocr 'Orthodox - Non-Orthodox Jewish ID Variable'.
recode ccocr (102 103 104 105 106 = 201).
value labels ccocr 101 'Orthodox' 201 'Non-Orthodox'.
frequencies profileocr ccocr.

if any(ocr,7,8) modorth = 2.
frequencies modorth.

missing values cocr ().
compute profileocr = cocr.
variable labels profileocr 'Jewish Identification for Profiles'.
value labels profileocr  101 'Orthodox' 102 'Conservative' 103 'Reconstructionist' 104 'Reform' 105 'Just Jewish' 106 'Humanist'.
missing values profileocr ().
frequencies ocr cocr profileocr.
missing values cocr (103).
frequencies cocr.

compute cattend = attend.
recode cattend (1 2 = 101) (3 = 102) (4 = 103) (5 = 104) (6 = 105) (7 8 9 = 106).
variable labels cattend 'Synagogue Attendance in Categories'.
value labels cattend 101 'Never+Special Occasions' 102 'Only High Holidays' 103 'A Few Times Per Year' 104 'About Once Per Month' 
	105 'Few Times Per Month' 106 'Once Per Week or More'.
frequencies attend cattend.

compute ccattend = cattend.
recode ccattend (104 105 106 = 201).
value labels ccattend 101 'Never+Special Occasions' 102 'Only High Holidays' 103 'A Few Times Per Year' 201 'About Once Per Month+' .
variable labels ccattend 'Synagogue Attendance in Large Categories'.
frequencies cattend ccattend.

********************************************************************************************************************************************************************.
comment Page 10: Disability changes 
********************************************************************************************************************************************************************.
comment adult disability.
if (dis eq 2) disability = 100.
if (supweek eq 2) disability = 101. 
if (sup eq 1) disability = 102.
if (supweek eq 1) disability = 103.
variable labels disability 'Level of Disability'. 
value labels disability 100 'No Disabilities' 101 'No Help Needed' 102 'Help needed on a Daily Basis' 103 'Help Needed on a Weekly Basis'.
frequencies dis sup supweek disability.


*****************************************************************************************************************************************************************.
comment Page 11: Needs Variables.
********************************************************************************************************************************************************************.
compute coor = 0.
if (needcoor eq 1 and reccoor eq 1 and jreccoor eq 1) coor =101.
if (needcoor eq 1 and reccoor eq 1 and jreccoor eq 2) coor = 102.
if (needcoor eq 1 and reccoor eq 2) coor = 103.
if (needcoor eq 2) coor = 104.
variable labels coor 'combined coordinate elderly services variable'.
value labels coor 	101 'Received Jewish Help' 
			102 'Received Other Help'
			103 'No Help Received'
			104 'No Need'.
missing values coor (0).
frequencies needcoor reccoor jreccoor coor.

compute coory = 0.
if (needcoory eq 1 and reccoory eq 1 and jreccoory eq 1) coory =101.
if (needcoory eq 1 and reccoory eq 1 and jreccoory eq 2) coory = 102.
if (needcoory eq 1 and reccoory eq 2) coory = 103.
if (needcoory eq 2) coory = 104.
variable labels coory 'combined coordinate non-elderly disabled services variable'.
value labels coory	101 'Received Jewish Help' 
			102 'Received Other Help'
			103 'No Help Received'
			104 'No Need'.
missing values coory (0).
frequencies needcoory reccoory jreccoory coory.

compute coun = 0.
if (needcoun eq 1 and reccoun eq 1 and jreccoun eq 1) coun = 101.
if (needcoun eq 1 and reccoun eq 1 and jreccoun eq 2) coun = 102.
if (needcoun eq 1 and reccoun eq 2) coun = 103.
if (needcoun eq 2) coun = 104.
variable labels coun 'combined counseling variable'.
value labels coun 	101 'Received Jewish Help' 
			102 'Received Other Help'
			103 'No Help Received'
			104 'No Need'.
missing values coun (0).
frequencies needcoun reccoun jreccoun coun.

comment households with income above $50,000 are assumed to have no need. In some cases, we only know that income is over $100,000 and 
these households are also assumed to have no financial need. The missing values are on households whose income is unknown or who refused the financial need question.
compute fin = 0.
if (needfin eq 1 and recfin eq 1 and jrecfin eq 1) fin = 101.
if (needfin eq 1 and recfin eq 1 and jrecfin eq 2) fin = 102.
if (needfin eq 1 and recfin eq 2) fin = 103.
if (needfin eq 2) fin = 104.
if range(inc,4,8) fin = 104.
if (inc100 eq 2) fin = 104.
variable labels fin 'combined financial assistance variable'.
value labels fin 		0 'Income not known'
			101 'Received Jewish Help' 
			102 'Received Other Help'
			103 'No Help Received'
			104 'No Need'.
missing values fin (0).
frequencies needfin recfin jrecfin fin.

compute job = 0.
if (needjob eq 1 and recjob eq 1 and jrecjob eq 1) job = 101.
if (needjob eq 1 and recjob eq 1 and jrecjob eq 2) job = 102.
if (needjob eq 1 and recjob eq 2) job = 103.
if (needjob eq 2) job = 104.
variable labels job 'combined job counseling variable'.
value labels job 		
			101 'Received Jewish Help' 
			102 'Received Other Help'
			103 'No Help Received'
			104 'No Need'
			0 'No Adult in Household Age 18-64'.
missing values job (0).
frequencies needjob recjob jrecjob job.

compute ldis = 0.
if (needis eq 1 and recdis eq 1 and jrecdis eq 1) ldis =101.
if (needis eq 1 and recdis eq 1 and jrecdis eq 2) ldis = 102.
if (needis eq 1 and recdis eq 2) ldis = 103.
if (needis eq 2) ldis = 104.
variable labels ldis 'combined learning disabled variable'.
value labels ldis 	101 'Received Jewish Help' 
		102 'Received Other Help'
		103 'No Help Received'
		104 'No Need'
    0 'No children in household'.
missing values ldis (0).
frequencies needis recdis jrecdis ldis.

compute cment = 0.
if (needcment eq 1 and reccment eq 1 and jreccment eq 1) cment = 101.
if (needcment eq 1 and reccment eq 1 and jreccment eq 2) cment = 102.
if (needcment eq 1 and reccment eq 2) cment = 103.
if (needcment eq 2) cment = 104.
variable labels cment 'combined mental health variable'.
value labels cment 	101 'Received Jewish Help' 
			102 'Received Other Help'
			103 'No Help Received'
			104 'No Need'.
missing values cment (0).
frequencies needcment reccment jreccment cment.

compute ccoor = coor.
recode ccoor (101 thru 103 = 201) (104 = 202).
variable labels ccoor 'Categorized Combined Coordinating Services Variable'.
value labels ccoor 201 'Need' 202 'No Need'.
frequencies coor ccoor.

compute ccoory = coory.
recode ccoory (101 thru 103 = 201) (104 = 202).
variable labels ccoory 'Categorized Combined Coordinating Services Variable'.
value labels ccoory 201 'Need' 202 'No Need'.
frequencies coory ccoory.

compute ccoun = coun.
recode ccoun (101 thru 103 = 201) (104 = 202).
variable labels ccoun 'Categorized Combined Counseling Variable'.
value labels ccoun 201 'Need' 202 'No Need'.
frequencies coun ccoun.

compute cfin = fin.
recode cfin (101 thru 103 = 201) (104 = 202).
variable labels cfin 'Categorized Combined Financial Need Variable'.
value labels cfin 201 'Need' 202 'No Need'.
frequencies fin cfin.

compute ccment = cment.
recode ccment (101 thru 103 = 201) (104 = 202).
variable labels ccment 'Categorized Combined Mentral Variable'.
value labels ccment 201 'Need' 202 'No Need'.
frequencies cment ccment.

compute cjob = job.
recode cjob (101 thru 103 = 201) (104 = 202).
variable labels cjob 'Categorized Combined Job Counseling Variable'.
value labels cjob 201 'Need' 202 'No Need' 105 'No Adult in Household Age 18-64' 0 'Dont know'.
frequencies job cjob.

compute cldis = ldis.
recode cldis (101 thru 103 = 201) (104 = 202).
variable labels cldis 'Categorized Combined Learning Disability Variable'.
value labels cldis 201 'Need' 202 'No Need'.
frequencies ldis cldis.

********************************************************************************************************************************************************************.
comment Elderly Needs Variables p 12.
********************************************************************************************************************************************************************.
compute hh = 0.
if (needhh eq 1 and rechh eq 1 and jrechh eq 1) hh =101.
if (needhh eq 1 and rechh eq 1 and jrechh eq 2) hh = 102.
if (needhh eq 1 and rechh eq 2) hh = 103.
if (needhh eq 2) hh = 104.
variable labels hh 'combined home health care variable'.
value labels hh 101 'Received Jewish Help' 
		102 'Received Other Help'
		103 'No Help Received'
		104 'No Need'.
missing values hh (0).
frequencies needhh rechh jrechh hh.

compute supserv = 0.
if (needsupserv eq 1 and recsupserv eq 1 and jrecsupserv eq 1) supserv =101.
if (needsupserv eq 1 and recsupserv eq 1 and jrecsupserv eq 2) supserv = 102.
if (needsupserv eq 1 and recsupserv eq 2) supserv = 103.
if (needsupserv eq 2) supserv = 104.
variable labels supserv 'combined support services variable'.
value labels supserv 101 'Received Jewish Help' 
		102 'Received Other Help'
		103 'No Help Received'
		104 'No Need'.
missing values supserv (0).
frequencies needsupserv recsupserv jrecsupserv supserv.

compute handy= 0.
if (needhandy eq 1 and rechandy eq 1 and jrechandy eq 1) handy =101.
if (needhandy eq 1 and rechandy eq 1 and jrechandy eq 2) handy = 102.
if (needhandy eq 1 and rechandy eq 2) handy= 103.
if (needhandy eq 2) handy = 104.
variable labels handy 'combined handyman services variable'.
value labels handy 101 'Received Jewish Help' 
		102 'Received Other Help'
		103 'No Help Received'
		104 'No Need'.
missing values handy (0).
frequencies needhandy rechandy jrechandy handy.

compute alf = 0.
if (needalf eq 1 and recalf eq 1 and jrecalf eq 1) alf =101.
if (needalf eq 1 and recalf eq 1 and jrecalf eq 2) alf = 102.
if (needalf eq 1 and recalf eq 2) alf = 103.
if (needalf eq 2) alf= 104.
variable labels alf 'combined ALF variable'.
value labels alf 101 'Received Jewish Help' 
		102 'Received Other Help'
		103 'No Help Received'
		104 'No Need'.
missing values alf (0).
frequencies needalf recalf jrecalf alf.

compute nurs = 0.
if (neednurs eq 1 and recnurs eq 1 and jrecnurs eq 1) nurs =101.
if (neednurs eq 1 and recnurs eq 1 and jrecnurs eq 2) nurs = 102.
if (neednurs eq 1 and recnurs eq 2) nurs = 103.
if (neednurs eq 2) nurs = 104.
variable labels nurs 'combined nursing home variable'.
value labels nurs 101 'Received Jewish Help' 
		102 'Received Other Help'
		103 'No Help Received'
		104 'No Need'.
missing values nurs (0).
frequencies neednurs recnurs jrecnurs nurs.

compute meal = 0.
if (needmeal eq 1 and recmeal eq 1 and jrecmeal eq 1) meal =101.
if (needmeal eq 1 and recmeal eq 1 and jrecmeal eq 2) meal = 102.
if (needmeal eq 1 and recmeal eq 2) meal = 103.
if (needmeal eq 2) meal = 104.
variable labels meal 'combined home delivered meals variable'.
value labels meal 101 'Received Jewish Help' 
		102 'Received Other Help'
		103 'No Help Received'
		104 'No Need'.
missing values meal (0).
frequencies needmeal recmeal jrecmeal meal.

compute sday = 0.
if (needsday eq 1 and recsday eq 1 and jrecsday eq 1) sday =101.
if (needsday eq 1 and recsday eq 1 and jrecsday eq 2) sday = 102.
if (needsday eq 1 and recsday eq 2) sday = 103.
if (needsday eq 2) sday = 104.
variable labels sday 'combined adult day care variable'.
value labels sday 101 'Received Jewish Help' 
		102 'Received Other Help'
		103 'No Help Received'
		104 'No Need'.
missing values sday (0).
frequencies needsday recsday jrecsday sday.

compute tran = 0.
if (needtran eq 1 and rectran eq 1 and jrectran eq 1) tran =101.
if (needtran eq 1 and rectran eq 1 and jrectran eq 2) tran = 102.
if (needtran eq 1 and rectran eq 2) tran = 103.
if (needtran eq 2) tran = 104.
variable labels tran 'combined transportation variable'.
value labels tran 101 'Received Jewish Help' 
		102 'Received Other Help'
		103 'No Help Received'
		104 'No Need'.
missing values tran (0).
frequencies needtran rectran jrectran tran.


compute chh = hh.
recode chh (101 thru 103 = 201) (104 = 202).
variable labels chh 'Categorized Combined Home Health Care Variable'.
value labels chh 201 'Need' 202 'No Need'.
frequencies hh chh.

compute csupserv= supserv.
recode csupserv (101 thru 103 = 201) (104 = 202).
variable labels csupserv 'Categorized Combined Support Services Variable'.
value labels csupserv 201 'Need' 202 'No Need'.
frequencies supserv csupserv.

compute chandy= handy.
recode chandy (101 thru 103 = 201) (104 = 202).
variable labels chandy 'Categorized Combined Handyman Variable'.
value labels chandy 201 'Need' 202 'No Need'.
frequencies handy chandy.

compute calf= alf.
recode calf (101 thru 103 = 201) (104 = 202).
variable labels calf 'Categorized Combined Assisted Living Facility Variable'.
value labels calf 201 'Need' 202 'No Need'.
frequencies alf calf.

compute cnurs = nurs.
recode cnurs (101 thru 103 = 201) (104 = 202).
variable labels cnurs 'Categorized Combined Nursing Home Variable'.
value labels cnurs 201 'Need' 202 'No Need'.
frequencies nurs cnurs.

compute cmeal = meal.
recode cmeal (101 thru 103 = 201) (104 = 202).
variable labels cmeal 'Categorized Combined Home-Delivered Meal Variable'.
value labels cmeal 201 'Need' 202 'No Need'.
frequencies meal cmeal.

compute csday = sday.
recode csday (101 thru 103 = 201) (104 = 202).
variable labels csday 'Categorized Combined Adult Day Care Variable'.
value labels csday 201 'Need' 202 'No Need'.
frequencies sday csday.

compute ctran= tran.
recode ctran (101 thru 103 = 201) (104 = 202).
variable labels ctran 'Categorized Combined Senior Transportation Variable'.
value labels ctran 201 'Need' 202 'No Need'.
frequencies tran ctran.

compute anyelderly = 2.
if range(hh,101,102) anyelderly = 1.
if range(supserv,101,102) anyelderly = 1.
if range(handy,101,102) anyelderly = 1.
if range(alf,101,102) anyelderly = 1.
if range(nurs,101,102) anyelderly = 1.
if range(meal,101,102) anyelderly = 1.
if range(sday,101,102) anyelderly = 1.
if range(tran,101,102) anyelderly = 1. 
variable labels anyelderly 'Received One or More Elderly Service'.
if (nelder75 eq 0) anyelderly = 3.
value labels anyelderly 1 'Yes' 2 'No' 3 'No Elderly 75 + in HH'.
missing values anyelderly (3).
frequencies anyelderly.

compute needss = 2.
if any(coor,101,102,103) needss = 1.
if any(coory,101,102,103) needss = 1.
if any(coun,101,102,103) needss = 1.
if any(fin,101,102,103) needss = 1.
if any(job,101,102,103) needss = 1.
if any(ldis,101,102,103) needss = 1.
if any(cment,101,102,103) needss = 1.
if any(hh,101,102,103) needss = 1.
if any(supserv,101,102,103) anyelderly = 1.
if any(handy,101,102,103) needss = 1.
if any(alf,101,102,103) needss = 1.
if any(nurs,101,102,103) needss = 1.
if any(meal,101,102,103) needss = 1.
if any(sday,101,102,103) needss = 1.
if any(tran,101,102,103) needss = 1.
variable labels needss 'Need One of the Social Services'.
value labels needss 1 'Yes' 2 'No'.
frequencies needss.


********************************************************************************************************************************************************************.
comment Page 12: ADL Programming.
********************************************************************************************************************************************************************.
*compute numadl = 0.
*if (eat eq 1) numadl = numadl + 1.
*if (dress eq 1) numadl = numadl + 1.
*if (bath eq 1) numadl = numadl + 1.
*if (meds eq 1) numadl = numadl + 1.
*if (elim eq 1) numadl = numadl + 1.
*if (appear eq 1) numadl = numadl + 1.
*variable labels numadl 'Number of ADLs that Person Has Trouble With'.
*frequencies numadl.

comment any adl problem. 
*compute adl = 2.
*if (eat eq 1 or dress eq 1 or bath eq 1 or meds eq 1 or elim eq 1 or appear eq 1) adl = 1.
*variable labels adl 'ADLs'.
*value labels adl 1 'Has Problem with At Least One ADL' 2 'Has no Problem'.
*variable labels adl 'Activity of Daily Living'.
*frequencies adl.


********************************************************************************************************************************************************************.
comment Page 13: Care Programming.
********************************************************************************************************************************************************************.
FREQUENCIES givecare live100 facility.
comment if get a 1 on eldcare it means that the case did not get transformed into eldcare.

compute eldcare=givecare.
comment live in local area.
if (live100 eq 1 and facility eq 1) eldcare = 101.
if (live100 eq 1 and facility eq 2) eldcare = 102.
if (live100 eq 1 and facility eq 3) eldcare = 103.
if (live100 eq 1 and facility eq 4) eldcare = 104.
if (live100 eq 1 and facility eq 5) eldcare = 105.
if (live100 eq 1 and facility eq 6) eldcare = 106.
if (live100 eq 1 and facility eq 7) eldcare = 107.

comment use this battery of statements if live in an adjacent area.
*if (live100 eq 2 and facility eq 1) eldcare = 201.
*if (live100 eq 2 and facility eq 2) eldcare = 202.
*if (live100 eq 2 and facility eq 3) eldcare = 203.
*if (live100 eq 2 and facility eq 4) eldcare = 204.
*if (live100 eq 2 and facility eq 5) eldcare = 205.
*if (live100 eq 2 and facility eq 6) eldcare = 206.
*if (live100 eq 2 and facility eq 7) eldcare = 207.

if (live100 eq 2 and facility eq 1) eldcare = 401.
if (live100 eq 2 and facility eq 2) eldcare = 402.
if (live100 eq 2 and facility eq 3) eldcare = 403.
if (live100 eq 2 and facility eq 4) eldcare = 404.
if (live100 eq 2 and facility eq 5) eldcare = 405.
if (live100 eq 2 and facility eq 6) eldcare = 406.
if (live100 eq 2 and facility eq 7) eldcare = 407.

variable labels eldcare 'Combined Care for Elderly Parent'.
value labels eldcare 2 'No Elderly Care Given' 
	101 'Relative Lives Local in Own Home - No Help'  102 'Relative Lives Local in Own Home - Help' 103  'Relative Lives Local in Relative Home - No Help' 
 104 'Relative Lives Local in Relative Home - Help'   105 'Relative Lives Local in ILF' 106 'Relative Lives Local in ALF' 107 'Relative Lives Local in Nursing Home' 
 401 'Relative Lives Elsewhere in Own Home - No Help'  402 'Relative Lives Elsewhere in Own Home - Help' 403  'Relative Lives Elsewhere in Relative Home - No Help' 
 404 'Relative Lives Elsewhere in Relative Home - Help'   405 'Relative Lives Elsewhere in ILF' 406 'Relative Lives Elsewhere in ALF' 407 'Relative Lives Elsewhere in Nursing Home'.

missing values eldcare (2 1).
frequencies givecare live100 facility eldcare.

compute celdcare = eldcare.
recode celdcare (101 thru 107 = 301) (401 thru 407 = 402). 
variable labels celdcare 'Care for Elderly Parent'.
value labels celdcare 301 'Within Local' 402 'Elsewhere'.
frequencies celdcare eldcare.

********************************************************************************************************************************************************************.
comment Page 13: Adult Children Programming.
********************************************************************************************************************************************************************.
frequencies ac wac1 wac2.

comment puts the one childfrom WAC1 into WAC2.
if (wac1 eq 1) wac2 = 1.
frequencies ac wac1 wac2.

if range(age1,50,98) aclocal = 103.
if (ac eq 0) aclocal = 101. 
if range(wac2,1,20) aclocal = 102.

variable labels aclocal 'One or More Adult Children Live in Local Area'.
value labels aclocal 
	101 'No Adult Children Who Live Independently' 
	102 'Adult Child in Local Area'
	103 'No Local Adult Child'.
frequencies aclocal.

compute nac = 0.
if (any(rel2,7,8,9,10)) nac = nac + 1.
if (any(rel3,7,8,9,10)) nac = nac + 1.
if (any(rel4,7,8,9,10)) nac = nac + 1.
if (any(rel5,7,8,9,10)) nac = nac + 1.
if (any(rel6,7,8,9,10)) nac = nac + 1.
if (any(rel7,7,8,9,10)) nac = nac + 1.
variable labels nac 'Number of Adult Children in Household'.
frequencies nac.

compute heirs = 1.
if ((nchild eq 0) and (ac eq 0) and (nac eq 0)) heirs = 2. 
if (age1 lt 50) heirs = 9. 
missing values heirs (9).
variable labels heirs 'Household Has Heirs'.
value labels heirs 1 'Has Heirs' 2 'Has No Heirs' 9 'Respondent <50'.
frequencies heirs.

********************************************************************************************************************************************************************.
comment Page 15: Preschool Changes.
********************************************************************************************************************************************************************.
comment Done in transitions file.

*******************************************************************************************************************************************************************.
comment Page 16: Child Jewish Education Changes for Day and Supplemental School.
********************************************************************************************************************************************************************.
frequencies school2.
recode school1 school2 school3 school4 school5 school6 school7 school8 school9 (3 = 101) (2 = 102) (1 = 103).
value labels school1 school2  school3 school4 school5 school6 school7 school8 school9
	101 'Jewish Day School' 102 'NJ Private' 103 'Public' 4 'Home Schooled/Not in School'
	 8 'dont know' 3 'Jewish Day School' 2 'NJ Private' 1 'Public' 6 'In College' 9 'Refusal'. 
missing values school1 school2 school3 school4 school5 school6 school7 school8 school9 (8,9,4).
frequencies school2.

weight off.
if (school1 eq 103 or school2 eq 103 or school3 eq 103 or school4 eq 103 or school5 eq 103 or school6 eq 103 or school7 eq 103 or school8 eq 103 or school9 eq 103) schoolchoice = 103.
if (school1 eq 102 or school2 eq 102 or school3 eq 102 or school4 eq 102 or school5 eq 102 or school6 eq 102 or school7 eq 102 or school8 eq 102 or school9 eq 102) schoolchoice = 102.
if (school1 eq 101 or school2 eq 101 or school3 eq 101 or school4 eq 101 or school5 eq 101 or school6 eq 101 or school7 eq 101 or school8 eq 101 or school9 eq 101) schoolchoice = 101.
variable labels schoolchoice 'Public, NJ Private, or Day school Household'.
value labels schoolchoice 101 'Jewish Day School' 102 'NJ Private' 103 'Public'.
temporary.
select if jhhc eq 1.
frequencies schoolchoice.

*******************************************************************************************************************************************************************.
comment adds children currently in Jewish day school to the type of Jewish education children are currently getting.
frequencies school2 everjed2 cjed2.
recode cjed1 cjed2 cjed3 cjed4 cjed5 cjed6 cjed7 cjed8 cjed9 (1 = 101) (2= 101.5) (3 = 103).
value labels cjed1 cjed2 cjed3 cjed4 cjed5 cjed6 cjed7 cjed8 cjed9 101 'Synagogue School' 101.5 'Tutor' 102 'Jewish Day School' 103 'Not Currently Enrolled'.
print formats cjed1 cjed2 cjed3 cjed4 cjed5 cjed6 cjed7 cjed8 cjed9 (F8.1).

if (school1 eq 101) cjed1 eq 102.
if (school2 eq 101) cjed2 eq 102.
if (school3 eq 101) cjed3 eq 102.
if (school4 eq 101) cjed4 eq 102.
if (school5 eq 101) cjed5 eq 102.
if (school6 eq 101) cjed6 eq 102.
if (school7 eq 101) cjed7 eq 102.
if (school8 eq 101) cjed8 eq 102.
if (school9 eq 101) cjed9 eq 102.

if (everjed1 eq 104) cjed1 eq 103.
if (everjed2 eq 104) cjed2 eq 103.
if (everjed3 eq 104) cjed3 eq 103.
if (everjed4 eq 104) cjed4 eq 103.
if (everjed5 eq 104) cjed5 eq 103.
if (everjed6 eq 104) cjed6 eq 103.
if (everjed7 eq 104) cjed7 eq 103.
if (everjed8 eq 104) cjed8 eq 103.
if (everjed9 eq 104) cjed9 eq 103.

comment mult response cannot handle 101.5.
recode cjed1 cjed2 cjed3 cjed4 cjed5 cjed6 cjed7 cjed8 cjed9 (101.5= 104).
value labels cjed1 cjed2 cjed3 cjed4 cjed5 cjed6 cjed7 cjed8 cjed9 101 'Synagogue School' 101.5 'Tutor' 102 'Jewish Day School' 103 'Not Currently Enrolled' 104 'Tutor'.

comment if currently in Jewish Day School, makes ever been enrolled into Jewish day school.
if (school1 eq 101) everjed1 eq 102.
if (school2 eq 101) everjed2 eq 102.
if (school3 eq 101) everjed3 eq 102.
if (school4 eq 101) everjed4 eq 102.
if (school5 eq 101) everjed5 eq 102.
if (school6 eq 101) everjed6 eq 102.
if (school7 eq 101) everjed7 eq 102.
if (school8 eq 101) everjed8 eq 102.
if (school9 eq 101) everjed9 eq 102.

comment makes certain that if everjed is missing it is a NEVER.
frequencies cjc2 school2 everjed2 cjed2.

recode everjed1 (sysmis = 999).
if (range(agec1,6,17) and cjc1 eq 1 and everjed1 eq 999) everjed1 eq 104.
recode everjed1 (999=sysmis).
frequencies everjed1.

recode everjed2 (sysmis = 999).
if (range(agec2,6,17) and cjc2 eq 1 and everjed2 eq 999) everjed2 eq 104.
recode everjed2 (999=sysmis).
frequencies everjed2.

recode everjed3 (sysmis = 999).
if (range(agec3,6,17) and cjc3 eq 1 and everjed3 eq 999) everjed3 eq 104.
recode everjed3 (999=sysmis).
frequencies everjed3.

recode everjed4 (sysmis = 999).
if (range(agec4,6,17) and cjc4 eq 1 and everjed4 eq 999) everjed4 eq 104.
recode everjed4 (999=sysmis).
frequencies everjed4.

recode everjed5 (sysmis = 999).
if (range(agec5,6,17) and cjc5 eq 1 and everjed5 eq 999) everjed5 eq 104.
recode everjed5 (999=sysmis).
frequencies everjed2.

recode everjed6 (sysmis = 999).
if (range(agec6,6,17) and cjc6 eq 1 and everjed6 eq 999) everjed6 eq 104.
recode everjed6 (999=sysmis).
frequencies everjed2.

recode everjed2 (sysmis = 999).
if (range(agec7,6,17) and cjc7 eq 1 and everjed7 eq 999) everjed7 eq 104.
recode everjed7 (999=sysmis).
frequencies everjed7.

recode everjed8 (sysmis = 999).
if (range(agec8,6,17) and cjc8 eq 1 and everjed8 eq 999) everjed8 eq 104.
recode everjed8 (999=sysmis).
frequencies everjed8.

recode everjed9 (sysmis = 999).
if (range(agec9,6,17) and cjc9 eq 1 and everjed9 eq 999) everjed9 eq 104.
recode everjed9 (999=sysmis).
frequencies everjed9.

frequencies everjed1 everjed2 everjed3 everjed4 everjed5 everjed6 everjed7 everjed8 everjed9.

********************************************************************************************************************************************************************.
comment creates  a new variable that assigns kids who did supplemental and JDS to JDS'.

frequencies school2 everjed2 cjed2 cjc2.

compute neweverjed1 = everjed1.
compute neweverjed2 = everjed2.
compute neweverjed3 = everjed3.
compute neweverjed4 = everjed4.
compute neweverjed5 = everjed5.
compute neweverjed6 = everjed6.
compute neweverjed7 = everjed7.
compute neweverjed8 = everjed8.
compute neweverjed9 = everjed9.
variable labels neweverjed1 'Ever to Jewish Education Adding both to JDS for child 1'.
variable labels neweverjed2 'Ever to Jewish Education Adding both to JDS for child 2'.
variable labels neweverjed3 'Ever to Jewish Education Adding both to JDS for child 3'.
variable labels neweverjed4 'Ever to Jewish Education Adding both to JDS for child 4'.
variable labels neweverjed5 'Ever to Jewish Education Adding both to JDS for child 5'.
variable labels neweverjed6 'Ever to Jewish Education Adding both to JDS for child 6'.
variable labels neweverjed7 'Ever to Jewish Education Adding both to JDS for child 7'.
variable labels neweverjed8 'Ever to Jewish Education Adding both to JDS for child 8'.
variable labels neweverjed9 'Ever to Jewish Education Adding both to JDS for child 9'.
recode neweverjed1 to neweverjed9 (103 = 102).
value labels neweverjed1 to neweverjed9 101 'Ever Supplemental' 102 'Ever JDS or JDS-Supp' 104 'Never Attended Jewish Education'.

weight off.
comment check sample sizes and logic of the frequencies statement to make sure it is OK.
recode everjed1 everjed2 everjed3 everjed4 everjed5 everjed6 everjed7 everjed8 everjed9 (999=sysmis).
recode neweverjed1 neweverjed2 neweverjed3 neweverjed4 neweverjed5 neweverjed6 neweverjed7 neweverjed8 neweverjed9  (999=sysmis).
frequencies school2 cjed2 everjed2 neweverjed2.
weight wf.

*******************************************************************************************************************************************************************.
comment Page 17: Jewish Day School Market.
********************************************************************************************************************************************************************.
compute consider = 100.
variable labels consider 'Seriously Investigate Jewish Day School'.

comment all kids are 0-5, so these are answers for the future.
if (consid eq 3) and (njchild617 eq 0) consider = 103.
if (consid eq 1) and (njchild617 eq 0) consider = 105.
if (consid eq 2) and (njchild617 eq 0) consider = 107.

if (consid eq 1) and range(njchild617,1,9) consider = 104.
if (consid eq 2) and range(njchild617,1,9) consider = 106.

if (neweverjed1 eq 102 and school1 ne 101) consider = 102.
if (neweverjed2 eq 102 and school2 ne 101) consider = 102.
if (neweverjed3 eq 102 and school3 ne 101) consider = 102.
if (neweverjed4 eq 102 and school4 ne 101) consider = 102.
if (neweverjed5 eq 102 and school5 ne 101) consider = 102.
if (neweverjed6 eq 102 and school6 ne 101) consider = 102.
if (neweverjed7 eq 102 and school7 ne 101) consider = 102.
if (neweverjed8 eq 102 and school8 ne 101) consider = 102.
if (neweverjed9 eq 102 and school9 ne 101) consider = 102.

if (school1 eq 101 or school2 eq 101 or school3 eq 101 or school4 eq 101 or school5 eq 101 or school6 eq 101 or school7 eq 101 
   or school8 eq 101 or school9 eq 101) consider = 101.

add value labels consider  
	100 'HH w/No children or with a DK for the Investigate Question'
	101 'Currently Have Children in Jewish Day School' 
	102 'Did Send Children to Jewish Day School in Past'
	103 'Will Definitely Send Children to Jewish Day School' 
	104 'Did Investigate'
	105 'Will Investigate' 
	106 'Did Not Investigate'
	107 'Will Not Investigate'.
missing values consider (100).
frequencies consider.

compute consider2 = consider.
recode consider2 (101 102 103 104 105 = 201) (106 107 = 202).
variable labels consider2 'Consider Day School in Larger Categories'.
value labels consider2 201 'Part of Day School Market' 202 'Not Part of Market'.
frequencies consider consider2.

comment reasons done in transitions file.

********************************************************************************************************************************************************************.
comment Page 19: child jewish informal education changes.
********************************************************************************************************************************************************************.
comment cump created in transitions file.
frequencies cump1 cump2 cump3 cump4 cump5 cump6 cump7 cump8 cump9.

compute dcamp1 = cump1.
compute dcamp2 = cump2.
compute dcamp3 = cump3.
compute dcamp4 = cump4.
compute dcamp5 = cump5.
compute dcamp6 = cump6.
compute dcamp7 = cump7.
compute dcamp8 = cump8.
compute dcamp9 = cump9.

variable labels dcamp1 'Day Camp Attendance Child 1'.
variable labels dcamp2 'Day Camp Attendance Child 2'.
variable labels dcamp3 'Day Camp Attendance Child 3'.
variable labels dcamp4 'Day Camp Attendance Child 4'.
variable labels dcamp5 'Day Camp Attendance Child 5'.
variable labels dcamp6 'Day Camp Attendance Child 6'.
variable labels dcamp7 'Day Camp Attendance Child 7'.
variable labels dcamp8 'Day Camp Attendance Child 8'.
variable labels dcamp9 'Day Camp Attendance Child 9'.

recode dcamp1 dcamp2 dcamp3 dcamp4 dcamp5 dcamp6 dcamp7 dcamp8 dcamp9 (101 105 106 = 101) (102 107 108 = 102) (100 103 104 = 103) .
value labels dcamp1 dcamp2 dcamp3 dcamp4 dcamp5 dcamp6 dcamp7 dcamp8 dcamp9 101 'Jewish Day Camp'  102 'Non-Jewish Day Camp' 103 'Not Attend Day Camp'.

frequencies cump2 dcamp2.

compute scamp1 = cump1.
compute scamp2 = cump2.
compute scamp3 = cump3.
compute scamp4 = cump4.
compute scamp5 = cump5.
compute scamp6 = cump6.
compute scamp7 = cump7.
compute scamp8 = cump8.
compute scamp9 = cump9.

variable labels scamp1 'Overnight Camp Attendance Child 1'.
variable labels scamp2 'Overnight Camp Attendance Child 2'.
variable labels scamp3 'Overnight Camp Attendance Child 3'.
variable labels scamp4 'Overnight Camp Attendance Child 4'.
variable labels scamp5 'Overnight Camp Attendance Child 5'.
variable labels scamp6 'Overnight Camp Attendance Child 6'.
variable labels scamp7 'Overnight Camp Attendance Child 7'.
variable labels scamp8 'Overnight Camp Attendance Child 8'.
variable labels scamp9 'Overnight Camp Attendance Child 9'.
recode scamp1 scamp2 scamp3 scamp4 scamp5 scamp6 scamp7 scamp8 scamp9 (103 105 107  = 101) (104 106 108 = 102) (100 101 102 = 103).
value labels scamp1 scamp2 scamp3 scamp4 scamp5 scamp6 scamp7 scamp8 scamp9 101 'Jewish Overnight Camp' 102 'Non-Jewish Overnight Camp' 103 'Not Attend Overnight Camp'.
frequencies cump2 scamp2.

********************************************************************************************************************************************************************.
comment Page 19 and 21: Israel transformations.
********************************************************************************************************************************************************************.
comment any adult been to Israel.
if (ago eq 2)  cgoisr = 102.
if any(goisr,2,4) cgoisr = 101.
if any(goisr,1,3,5,6) cgoisr = 100.
variable labels cgoisr 'Some Adult in Household to Israel'.
value labels cgoisr 100 'Jewish Trip' 101 'General Trip' 102 'No Adult to Israel' .
frequencies cgoisr goisr.

comment any child been to Israel.
if (cgo eq 2)  cgoisrc = 102.
if any(goisrc,2,4) cgoisrc = 101.
if any(goisrc,1,3,5,6) cgoisrc = 100.
variable labels cgoisrc 'Some Child in Household to Israel'.
value labels cgoisrc 100 'Jewish Trip' 101 'General Trip' 102 'No Child to Israel' .
frequencies cgoisrc goisrc.

comment any household member has been to Israel.
comment special programming was necessary here because adults going to Israel in Detroit was only asked of half the sample.
recode cgoisr (sysmis=999).
if (cgoisr eq 102) anyisr = 102.
if (cgoisr eq 101 or cgoisrc eq 101) anyisr = 101.
if (cgoisr eq 100 or cgoisrc eq 100) anyisr = 100.
if (cgoisr = 999) anyisr = 999.
recode anyisr (999=sysmis).
variable labels anyisr 'Anyone in Household to Israel'.
value labels anyisr 100 'Jewish Trip' 101 'General Trip' 102 'No One in Household to Israel' .
missing values cgoisr (999).
frequencies cgoisr cgoisrc anyisr.

***************************************************************************************************.
comment figures out whether each kid is doing some type of Jewish education.
***************************************************************************************************.
if (range(agec1,0,17) and cjc1 eq 1) anyjew1 = 102.
if (range(agec2,0,17) and cjc2 eq 1) anyjew2 = 102.
if (range(agec3,0,17) and cjc3 eq 1) anyjew3 = 102.
if (range(agec4,0,17) and cjc4 eq 1) anyjew4 = 102.
if (range(agec5,0,17) and cjc5 eq 1) anyjew5 = 102.
if (range(agec6,0,17) and cjc6 eq 1) anyjew6 = 102.
if (range(agec7,0,17) and cjc7 eq 1) anyjew7 = 102.
if (range(agec8,0,17) and cjc8 eq 1) anyjew8 = 102.
if (range(agec9,0,17) and cjc9 eq 1) anyjew9 = 102.

if (ygc1 eq 1 or pre1 eq 101 or school1 eq 101 or any(cjed1,101,102) or any(cump1,101,103,105,106,107)) anyjew1 eq 101.
if (ygc2 eq 1 or pre2 eq 101 or school2 eq 101 or any(cjed2,101,102) or any(cump2,101,103,105,106,107)) anyjew2 eq 101.
if (ygc3 eq 1 or pre3 eq 101 or school3 eq 101 or any(cjed3,101,102) or any(cump3,101,103,105,106,107)) anyjew3 eq 101.
if (ygc4 eq 1 or pre4 eq 101 or school4 eq 101 or any(cjed4,101,102) or any(cump4,101,103,105,106,107)) anyjew4 eq 101.
if (ygc5 eq 1 or pre5 eq 101 or school5 eq 101 or any(cjed5,101,102) or any(cump5,101,103,105,106,107)) anyjew5 eq 101.
if (ygc6 eq 1 or pre6 eq 101 or school6 eq 101 or any(cjed6,101,102) or any(cump6,101,103,105,106,107)) anyjew6 eq 101.
if (ygc7 eq 1 or pre7 eq 101 or school7 eq 101 or any(cjed7,101,102) or any(cump7,101,103,105,106,107)) anyjew7 eq 101.
if (ygc8 eq 1 or pre8 eq 101 or school8 eq 101 or any(cjed8,101,102) or any(cump8,101,103,105,106,107)) anyjew8 eq 101.
if (ygc9 eq 1 or pre9 eq 101 or school9 eq 101 or any(cjed9,101,102) or any(cump9,101,103,105,106,107)) anyjew9 eq 101.

variable labels anyjew1 'Child 1 Does Some Jewish Education-formal or informal'.
variable labels anyjew2 'Child 2 Does Some Jewish Education-formal or informal'.
variable labels anyjew3 'Child 3 Does Some Jewish Education-formal or informal'.
variable labels anyjew4 'Child 4 Does Some Jewish Education-formal or informal'.
variable labels anyjew5 'Child 5 Does Some Jewish Education-formal or informal'.
variable labels anyjew6 'Child 6 Does Some Jewish Education-formal or informal'.
variable labels anyjew7 'Child 7 Does Some Jewish Education-formal or informal'.
variable labels anyjew8 'Child 8 Does Some Jewish Education-formal or informal'.
variable labels anyjew9 'Child 9 Does Some Jewish Education-formal or informal'.
value labels anyjew1 anyjew2 anyjew3 anyjew4 anyjew5 anyjew6 anyjew7 anyjew8 anyjew9 101' Yes' 102 'No'.

frequencies anyjew1 to anyjew9.

********************************************************************************************************************************************************************.
comment Page 20-21 Membership changes.
********************************************************************************************************************************************************************.
if (synmem eq 1) synpart eq 1.
frequencies synmem synpart.

compute assoc = 2.
if (synmem eq 1) or  (member eq 1) or (jccmem eq 1) assoc = 1.
variable labels assoc 'Associated with the Jewish Community'.
value labels assoc 1 'Yes' 2 'No'.
frequencies assoc.

compute assoc2 = assoc.
if (chabad eq 1) assoc2 = 1.
variable labels assoc2 'Associated with the Jewish Community Adding Chabad'.
value labels assoc2 1 'Yes' 2 'No'.
frequencies assoc assoc2.

compute chabad = outreach.
variable labels chabad 'Participated in Chabad'.
value labels chabad 1 'Yes' 2 'No'.
if any(partchabad,2,3) chabad = 2.
frequencies outreach chabad partchabad partaish partwell.




compute alljew = 2.
if (assoc eq 1 or practice eq 1 or jfed eq 1 or jchar eq 1 or range(attend,3,9)) alljew = 1.
variable labels alljew 'Does Respondent Do Something Jewish'.
value labels alljew 1 'Do Something Jewish' 2 'Not Do Jewish'.
frequencies alljew.

********************************************************************************************************************************************************************.
comment Page 21
********************************************************************************************************************************************************************.
if (jccmem eq 1) partjcc eq 1.
frequencies jccmem partjcc jccprogram.
if (jccprogram eq 1) partjcc eq 1.
frequencies jccmem partjcc.

frequencies nojoin.
comment this section not done until i do chapter 7.
compute cnojoin = nojoin.
missing values nojoin ().
recode cnojoin (1 8 = 101) (4 = 102) (2=103) (7 = 104) (98 99 = 200) (sysmis = 200) (else = 105).
value labels cnojoin 101 'Distance' 102 'No Need' 103 'Cost' 104 'Time' 105 'other'.
missing values cnojoin (200).
variable labels cnojoin 'Combined Variable for Not Joining JCC'.
frequencies cnojoin.
missing values nojoin (98 99).

********************************************************************************************************************************************************************.
comment Page 22.
********************************************************************************************************************************************************************.
missing values antism ().
if any(antism,4,8,9) antiyr =2. 
frequencies antiyr.
missing values antism (8 9).
frequencies antism antiyr.

frequencies antichild.
if (any(antism,4,8,9) and range(njchild617,1,9)) antichild = 2.
frequencies antichild.

********************************************************************************************************************************************************************.
comment Page 23.
********************************************************************************************************************************************************************.
********************************************************************************************************************************************************************.
comment Page 23 Volunteer Changes.
********************************************************************************************************************************************************************.
frequencies voljew volnj.
compute vol = 0.
if (volnj eq 2 and voljew eq 1) vol = 1.
if (volnj eq 1 and voljew eq 2) vol = 2.
if (volnj eq 1 and voljew eq 1) vol = 3.
if (volnj eq 2 and voljew eq 2) vol = 4.
variable labels vol 'Combined Volunteer Variable'.
value labels vol 2 'Non-Jewish Only' 1 'Jewish Only' 3 'Both' 4 'Neither' 0 'DKNR'.
missing values vol (0).


compute cquafed = quafed.
recode cquafed (1=101)(2=102) (3,4 = 103).
value labels cquafed 101 'Excellent' 102 'Good' 103 'Fair or Poor'.
variable labels cquafed 'Quality of Federation'.
frequencies quafed cquafed.

******************************************************************************************************************************************************************.
comment Page 25: Media 
********************************************************************************************************************************************************************.
compute cjread = jread.
recode cjread (1,2,3=101) (4=102).
variable labels cjread 'Read Local Jewish Newspaper'.
value labels cjread 101 'Always-Usually-Sometimes' 102 'Never'.
frequencies jread cjread.

********************************************************************************************************************************************************************.
comment Page 25.
********************************************************************************************************************************************************************.
frequencies citizen.

compute citizen2 = citizen.
if (ccborn1 eq 201) citizen2 eq 1.
recode citizen2 (sysmis = 1).
variable labels citizen2 'Citizenship with US Born as Citizens'.
value labels citizen2 1' Yes' 2 'No'.
frequencies ccborn1 citizen citizen2.

compute reg2 = 0.
variable labels reg2 'Voter Registration with Citizen Category'.
if  (citizen2 eq 2) reg2 eq 3.
if (reg eq 1) reg2 eq 1.
if (reg eq 2) reg2 eq 2.
value labels reg2 1 'Registered' 2 'Not Registered' 3 'Not a Citizen'.
missing values reg2 (0).
frequencies citizen2 reg reg2.

frequencies party.
compute party2 =  party.
variable labels  party2 'Political Party'.
recode party2 (4 8 = 3) (6 7 9 = 5) (10 = sysmis).
value labels party2 1 'Republican' 2 'Democratic' 3 'Independent' 5 'Other' 98 'Dont know' 99 'Refusal'.
missing values party2 (5 98 99).
frequencies party party2.

******************************************************************************************************************************************************************.
comment Page 26: Philanthropy Changes. 
********************************************************************************************************************************************************************.
frequencies  amtfed jchar1 njchar1.

compute donate = 0.
if range(amtfed,0,7) donate = 1.
if (cont eq 1) donate = 2.
if (cont eq 2) donate = 3.
value labels donate 1 'Donated' 2 'Asked, did not Give' 3 'Not Asked' 0 'Donate, But DK-NR to Amount'.
variable labels donate 'donation market segments'.
missing values donate (0).
frequencies amtfed donate cont.

compute cdonate = donate.
comment includes syntax if ask separately about other Jewish federations.
recode cdonate (1 = 101) (2 3 = 102).
variables labels cdonate 'Donate,Not Donate to All Jewish Federations'.
value labels cdonate 101 'Donated to Fed' 102 'Not Donated' 103 'Donated, But DK-NR to Amount'.
recode cdonate (sysmis = 103).
missing values cdonate (103).
frequencies cdonate donate.

*****************************************.
compute camtfed=amtfed.
recode camtfed (3 thru 7 =3).
variable labels camtfed 'Giving to Local Federation with Collapsed Categories'.
value labels camtfed   -1 'nothing'   0 '<$100'	1 '$100-500'	2 '$500-1000'	3 '$1000 +' 9 'dk-nr'.
missing values camtfed (9).
frequencies amtfed camtfed.

compute ccamtfed=camtfed.
recode ccamtfed (2 thru 3 =2). 
variable labels ccamtfed 'Giving to Local Federation'.
value labels ccamtfed -1 'Nothing'  0 '$<$100'	1 '$100 - $500'  2 '$500 +' 9 'dk-nr'.
missing values ccamtfed (9).
frequencies camtfed ccamtfed.

compute amt100=camtfed.
recode amt100 (1 thru 3 =1). 
variable labels amt100 'giving to local federation'.
value labels amt100	 -1 'nothing'	 0 '$<$100' 	1 '$100 +' 	 9 'dk-nr'.
missing values amt100 (9).
frequencies camtfed amt100.

********************************.
compute cjchar1 = jchar1.
recode cjchar1 (3 thru 7 = 3).
variable labels cjchar1 'Giving to Other Jewish Charities in Categories'.
value labels cjchar1  -1 'nothing'    0 '<$100' 	1 '$100-$500' 	2 '$500-$1,000'   3 '$1000+' 	9 'dk-nr'.
frequencies jchar1 cjchar1.

compute cnjchar1 = njchar1.
recode cnjchar1 (3 thru 7 = 3).
variable labels cnjchar1 'Giving to Non-Jewish Charities in Categories'.
value labels cnjchar1 	-1 'nothing' 	0 '<$100' 	1 '$100-$500' 	2 '$500-$1,000'  3 '$1000+' 	9 'dk-nr'.
missing values cnjchar1 (9).
frequencies njchar1 cnjchar1.

compute amtfedYN = amtfed.
recode amtfedYN (-1 = 102) (0 thru 7 = 101) (else = 103).
variable labels amtfedYN 'Gave to the Local Jewish Federation'.
value labels amtfedYN 101 'Donated' 102 'Not Donated' 103 'Donated, but DK-NR to Amount'.
missing values amtfedYN (103).
frequencies jfed amtfed amtfedYN.

compute jcharYN = jchar1.
recode jcharYN (-1 = 102) (0 thru 7 = 101) (else = 103).
variable labels jcharYN 'Gave to the Other Jewish Charities'.
value labels jcharYN 101 'Donated' 102 'Not Donated' 103 'Donated, but DK-NR to Amount'.
missing values jcharYN (103).
frequencies jchar jchar1 jcharYN.

compute njcharYN = njchar1.
recode njcharYN (-1 = 102) (0 thru 7 = 101) (else = 103).
variable labels njcharYN 'Gave to the Non-Jewish Charities'.
value labels njcharYN 101 'Donated' 102 'Not Donated' 103 'Donated, but DK-NR to Amount'.
missing values njcharYN (103).
frequencies njchar njchar1 njcharYN.

compute anyj$ = 103.
missing values amtfedYN jcharYN anyj$ ().
if (amtfedYN eq 102 and jcharYN eq 102) anyj$ = 102.
if (amtfedYN eq 101 or jcharYN eq 101) anyj$ = 101.
variable labels anyj$ 'Give to Any Jewish Charity including Federation'.
value labels anyj$ 101 'Donated to Any Jewish Charities' 102 'Not Donated' 103 'Donated, but DK-NR to Amount'.
missing values amtfedYN jcharYN anyj$ (103).
frequencies anyj$.

missing values anyj$ njcharYN ().
if (anyj$ eq 102 and njcharYN eq 101) jnjovrlp = 101.
if (anyj$ eq 101 and njcharYN eq 102) jnjovrlp = 102.
if (anyj$ eq 101 and njcharYN eq 101) jnjovrlp = 103.
if (anyj$ eq 102 and njcharYN eq 102) jnjovrlp = 104.
if (anyj$ eq 103 or njcharYN eq 103) jnjovrlp = 100.
variable labels jnjovrlp 'Overlap Between Giving to Jewish and Non-Jewish Charities'.
value labels jnjovrlp 101 'Non-Jewish Only' 102 'Jewish Only' 103 'Both' 104 'Did Not Donate to Charities' 
	100 'Donated, but DK-NR to Amount to Either-Both J and NJ Char'.
missing values jnjovrlp (100).
missing values anyj$ njcharYN (103).
frequencies jnjovrlp njchar.

compute spamtfed = amtfed.
recode spamtfed (1 = 101) (2 3 = 102) (4 5 6 7  = 103).
variable labels spamtfed 'Amount Donated to Local Federation to Crosstab with Increased Donations'.
value labels spamtfed   -1 'Not give' 101 '$100-$500'     102 '$500-$2500'       103 '$2500+'    9 'DKNR'   0 'Under $100'.   
missing values spamtfed (-1 0).
frequencies amtfed spamtfed.

*******************************************************************************************************************************************************************.
comment Page 26: Will.
********************************************************************************************************************************************************************.
*******************************************************************************************************************************************************************.
if (will eq 2) newwill = 100.
if (prov eq 2) newwill = 101.
if (prov eq 1 and jprov eq 1) newwill = 102.
if (prov eq 1 and jprov eq 2) newwill = 103.
if (prov eq 1 and jprov eq 3) newwill = 104.
if (fedprov eq 1) newwill = 102.5.
variable labels newwill 'Combined Will Variable'.
value labels newwill 100 'No Will' 101 'No Provision' 102 'Jewish Provision' 103 'Non-Jewish Provision' 104 'Jewish and Non-Jewish Provision'
     102.5 'Federation Provision'.
frequencies will prov jprov fedprov newwill.

compute newwill2 = newwill.
recode newwill2 (104 = 102).
variable labels newwill2 'Combined Will Variable 2'.
value labels newwill2 100 'No Will' 101 'No Provision' 102 'Jewish Provision' 103 'Non-Jewish Provision'
     102.5 'Federation Provision'.
frequencies newwill newwill2.
frequencies fedprov.

********************************************************************************************************************************************************************.
comment Page 27: Income.
********************************************************************************************************************************************************************.
frequencies inc100 inc.
missing values inc (9).
compute cinc = inc.
recode cinc (1 2 = 101) (3 = 102) (4 5 = 103) (6 7 = 104) (8 = 105).
variable labels cinc 'Household Income in Large Categories'.
missing values cinc (9).
value labels cinc  101 '< $25'	102 ' $25-$50'	 103 '$50-$100'    104 '$100-$200'  105 '$200+'.
frequencies inc cinc.

compute ccinc50 = inc.
recode ccinc50 (1 2 3 = 101) (4 5 = 103) (6 7 = 104) (8 = 105).
variable labels ccinc50 'Income Groups with an < $50 Category'.
missing values ccinc50 (9).
value labels ccinc50  101 '< $50'    103 '$50-$100'    104 '$100-$200'    105 '$200+'.
frequencies inc ccinc50.

compute ccinc50a = inc.
recode ccinc50a (1 2 3 = 101) (4 thru 8 = 102).
variable labels ccinc50 'Income Groups with < $50 and >$50 Categories'.
value labels ccinc50a  101 '< $50'   102 '$50+'.
missing values ccinc50a (9).
frequencies inc ccinc50a.

compute ccinc100 = inc.
recode ccinc100 (1 thru 5 = 101) (6 thru 8 = 102).
value labels ccinc100   101 '< $100,000'  102 '$100,000+'.
variable labels ccinc100 'Income < $100 and > $100'.
missing values ccinc100 (9).
frequencies ccinc100.

if (inc100 eq 1) ccinc100 = 101.
if (inc100 eq 2) ccinc100 = 102.
frequencies ccinc100.

compute ccinc200 = inc.
recode ccinc200 (1 thru 7 = 101) (8 = 102).
value labels ccinc200  101 '< $200,000'  102 '$200,000+'.
variable labels ccinc200 'Income < $200 and > $200'.
if (inc100 eq 1) ccinc200 = 101.
missing values ccinc200 (9).
frequencies inc cinc ccinc50 ccinc100 ccinc200.

compute ccinc25_100 = inc.
recode ccinc25_100 (3 thru 5 = 3).
add value labels ccinc25_100 3 '$25-$100000'.
variable labels ccinc25_100 'Income with $25,000-$100,000 Category'.
missing values ccinc25_100 (9).
frequencies inc ccinc25_100.

*****************************************************************************************************.
comment poverty variable.
*****************************************************************************************************.
compute poverty = 2.
if ((inc12 eq 1) or (inc20 eq 1) or (inc24 eq 1) or (inc28 eq 1) or (inc33 eq 1) or (inc37 eq 1) or (inc42 eq 1)) poverty = 1.
if (inc eq 1 and hhsiz ge 2) poverty eq 1.
if (inc eq 2 and hhsiz ge 5) poverty eq 1.
value labels poverty 1 'Yes' 2 'No'.
variable labels poverty 'Below Federal Poverty Level'.
frequencies poverty.

temporary.
select if poverty eq 1.
frequencies id.
comment All but cases of poverty were plausible.
if any(id,897,1105 ) poverty eq 2.
frequencies poverty.









