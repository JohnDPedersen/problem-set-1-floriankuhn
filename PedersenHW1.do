clear


*The Following commands need to be downloaded: glcurve, and descogini
import excel using "C:\Users\John\Desktop\Macro\PSID Earnings.xlsx", firstrow

keep ER33601 ER33627A ER33702 ER33926A

rename ER33601 ID2001
rename ER33627A Earn2001
rename ER33702 ID2007
rename ER33926A Earn2007

*Delete nonpositive and missing values
drop if Earn2001<=0 | Earn2001==9999999 | Earn2007<=0 | Earn2007==9999999 ///
| Earn2001==9999998 | Earn2007==9999998

xtile Dist2001=Earn2001, n(5)
xtile Dist2007=Earn2007, n(5)
tab Dist2001 Dist2007, row nofreq


descogini Earn2001 Earn2007

glcurve Earn2001, lorenz plot(function equality=x) title("Lorenze Curve, GINI=0.440") ///
xtitle("Percentile of Earn") ytitle("Cum. Earnings") saving("C:\Users\John\Desktop\Macro\2001 Lorenz.png", replace)

glcurve Earn2007, lorenz plot(function equality=x) title("Earn 2001, GINI=0.443") ///
xtitle("Percentile of Earn") ytitle("Cum. Earnings") saving("C:\Users\John\Desktop\Macro\2007 Lorenz.png", replace)


glcurve Earn2001, gl(g1) p(p1) nograph lorenz
glcurve Earn2007, gl(g2) p(p2) nograph lorenz

twoway (line g1 p1, sort) (line g2 p2, sort) (function y=x, range(0 1)), title("Lorenze Curve, Both Years") ///
 xtitle("Percentile of Earn") ytitle("Cum. Earnings") saving("C:\Users\John\Desktop\Macro\Both Lorenz.png", replace)

descogini Earn2001 Earn2007

