# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.1.2 (2014-10-31) |
|system   |x86_64, darwin13.4.0         |
|ui       |RStudio (0.99.85)            |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |America/Chicago              |

## Packages

|package  |*  |version |date       |source         |
|:--------|:--|:-------|:----------|:--------------|
|plyr     |*  |1.8.1   |2014-02-26 |CRAN (R 3.1.0) |
|Rcpp     |*  |0.11.3  |2014-09-29 |CRAN (R 3.1.1) |
|reshape2 |   |1.4     |2014-04-23 |CRAN (R 3.1.0) |
|stringr  |*  |0.6.2   |2012-12-06 |CRAN (R 3.1.0) |
|testthat |   |0.9.1   |2014-10-01 |CRAN (R 3.1.1) |

# Check results
141 checked out of 141 dependencies 

## afex (0.12-135)
Maintainer: Henrik Singmann <singmann+afex@gmail.com>

__OK__

## agridat (1.10)
Maintainer: Kevin Wright <kw.stat@gmail.com>  
Bug reports: https://github.com/kwstat/agridat/issues

```
checking package dependencies ... NOTE
Packages suggested but not available for checking:
  ‘agricolae’ ‘equivalence’ ‘FrF2’ ‘gstat’ ‘lucid’ ‘MCMCglmm’ ‘pscl’
```
```
checking examples ... ERROR
Running examples in ‘agridat-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: archbold.apple
> ### Title: Split-split plot experiment on apple trees
> ### Aliases: archbold.apple
> ### Keywords: datasets
> 
> ### ** Examples
> 
> dat <- archbold.apple
> 
> # Define main plot and subplot
> dat <- transform(dat, rep=factor(rep), spacing=factor(spacing), trt=factor(trt),
+                  mp = factor(paste(row,spacing,sep="")),
+                  sp = factor(paste(row,spacing,stock,sep="")))
> 
> # Due to 'spacing', the plots are different sizes, but the following layout
> # shows the relative position of the plots and treatments. Note that the
> # 'spacing' treatments are not contiguous in some reps.
> desplot(spacing~row*pos, dat, col=stock, cex=1, num=gen,
+         main="archbold.apple")
> 
> if(require("lme4")){
+ 
+ m1 <- lmer(yield ~ -1 + trt + (1|rep/mp/sp), dat)
+ 
+ require(lucid)
+ vc(m1)  # Variances/means on page 59
+ ##         grp        var1 var2   vcov sdcor
+ ## sp:(mp:rep) (Intercept) <NA>  193.3 13.9
+ ##      mp:rep (Intercept) <NA>  203.8 14.28
+ ##         rep (Intercept) <NA>  197.3 14.05
+ ##    Residual        <NA> <NA> 1015   31.86
+ 
+ }
Loading required package: lme4
Loading required package: Matrix
Loading required package: Rcpp
Loading required package: lucid
Warning in library(package, lib.loc = lib.loc, character.only = TRUE, logical.return = TRUE,  :
  there is no package called ‘lucid’
Error: could not find function "vc"
Execution halted
```

## aLFQ (1.3.2)
Maintainer: George Rosenberger <rosenberger@imsb.biol.ethz.ch>

__OK__

## alm (0.3.1)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: http://www.github.com/ropensci/alm/issues

```
checking package dependencies ... NOTE
Package which this enhances but not available for checking: ‘rCharts’
```

## aoristic (0.5)
Maintainer: George Kikuchi <gkikuchi@csufresno.edu>

```
checking package dependencies ... ERROR
Packages required but not available: ‘GISTools’ ‘plotKML’

See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```

## AppliedPredictiveModeling (1.1-6)
Maintainer: Max Kuhn <mxkuhn@gmail.com>

```
checking R code for possible problems ... NOTE
bookTheme: no visible global function definition for ‘trellis.par.set’
transparentTheme: no visible global function definition for
  ‘trellis.par.set’
upperp: no visible global function definition for ‘ellipse’
upperp: no visible global function definition for ‘panel.xyplot’
upperp: no visible global function definition for ‘trellis.par.get’
```

## apsimr (0.1)
Maintainer: Bryan Stanfill <bryan.stanfill@csiro.au>  
Bug reports: https://github.com/stanfill/apsimr/issues

```
checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘APSIMBatch’
```

## bams (1.6)
Maintainer: Toby Dylan Hocking <toby@sg.cs.titech.ac.jp>

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘gada’
```
```
checking dependencies in R code ... NOTE
Missing or unexported object: ‘ggplot2::coord_transform’
Unexported objects imported by ':::' calls:
  ‘cghseg:::segmeanCO’ ‘ggplot2:::GeomRect’
  See the note in ?`:::` about the use of this operator.
See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```
```
checking R code for possible problems ... NOTE
dnacopy.smoothvec : <anonymous>: no visible global function definition
  for ‘smooth.CNA’
dnacopy.smoothvec : <anonymous>: no visible global function definition
  for ‘segment’
dnacopy.smoothvec : <anonymous>: no visible binding for global variable
  ‘segment’
gada.results : <anonymous> : <anonymous>: no visible global function
  definition for ‘WextIextToSegments’
geom_tallrect: no visible global function definition for ‘proto’
geom_tallrect : draw_groups: no visible global function definition for
  ‘unit’
run.pelt: no visible binding for global variable ‘cpt.mean’
runglad: no visible global function definition for ‘as.profileCGH’
runglad : <anonymous>: no visible binding for global variable ‘daglad’
runglad : <anonymous> : <anonymous>: no visible binding for global
  variable ‘glad’
```

## BBEST (0.1-0)
Maintainer: Anton Gagin <anton.gagin@nist.gov>

```
checking package dependencies ... ERROR
Packages required but not available: ‘DEoptim’ ‘aws’

See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```

## BEQI2 (1.0-1)
Maintainer: Dennis Walvoort <dennis.Walvoort@wur.nl>

```
checking dependencies in R code ... NOTE
Package in Depends field not imported from: ‘tcltk’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```
```
checking R code for possible problems ... NOTE
BEQI2dir: no visible global function definition for ‘tk_choose.dir’
beqi2: no visible global function definition for ‘tk_choose.files’
```

## bmmix (0.1-2)
Maintainer: Thibaut Jombart <t.jombart@imperial.ac.uk>

__OK__

## capm (0.5)
Maintainer: Oswaldo Santos <oswaldosant@gmail.com>

```
checking package dependencies ... ERROR
Package required but not available: ‘FME’

See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```

## caret (6.0-37)
Maintainer: Max Kuhn <Max.Kuhn@pfizer.com>

__OK__

## cda (1.5.1)
Maintainer: Baptiste Auguie <baptiste.auguie@gmail.com>

```
checking whether package ‘cda’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/cda.Rcheck/00install.out’ for details.
```

## ChainLadder (0.1.8)
Maintainer: Markus Gesmann <markus.gesmann@googlemail.com>  
Bug reports: http://code.google.com/p/chainladder/issues/list

__OK__

## chemosensors (0.7.8)
Maintainer: Andrey Ziyatdinov <andrey.ziyatdinov@upc.edu>

__OK__

## CINOEDV (2.0)
Maintainer: Junliang Shang <shangjunliang110@163.com>

__OK__

## classify (1.3)
Maintainer: Dr Chris Wheadon <chris.wheadon@gmail.com>

```
checking whether package ‘classify’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/classify.Rcheck/00install.out’ for details.
```

## clhs (0.5-4)
Maintainer: Pierre Roudier <roudierp@landcareresearch.co.nz>

__OK__

## clickstream (1.1.2)
Maintainer: Michael Scholz <michael.scholz@uni-passau.de>

__OK__

## ClimClass (1.0)
Maintainer: Emanuele Eccel <emanuele.eccel@fmach.it>

__OK__

## clusterfly (0.4)
Maintainer: Hadley Wickham <h.wickham@gmail.com>

```
checking package dependencies ... ERROR
Packages required but not available: ‘rggobi’ ‘RGtk2’

Packages suggested but not available for checking: ‘som’ ‘kohonen’

See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```

## coefplot (1.2.0)
Maintainer: Jared P. Lander <packages@jaredlander.com>

```
checking DESCRIPTION meta-information ... NOTE
Deprecated license: BSD
```

## cooccur (1.2)
Maintainer: Daniel M. Griffith <griffith.dan@gmail.com>

__OK__

## COPASutils (0.1.4)
Maintainer: Erik Andersen <erik.andersen@northwestern.edu>

__OK__

## cplm (0.7-2)
Maintainer: Wayne Zhang <actuary_zhang@hotmail.com>

```
checking whether package ‘cplm’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/cplm.Rcheck/00install.out’ for details.
```

## Cubist (0.0.18)
Maintainer: Max Kuhn <mxkuhn@gmail.com>

__OK__

## cutoffR (1.0)
Maintainer: Lingbing Feng <fenglb88@gmail.com>

__OK__

## data.table (1.9.4)
Maintainer: Matt Dowle <mdowle@mdowle.plus.com>  
Bug reports: https://github.com/Rdatatable/data.table/issues

__OK__

## dataRetrieval (2.0.1)
Maintainer: Laura DeCicco <ldecicco@usgs.gov>

__OK__

## dcmr (1.0)
Maintainer: Diane Losardo <dlosardo@amplify.com>

__OK__

## decctools (0.2.0)
Maintainer: James Keirstead <j.keirstead@imperial.ac.uk>

```
checking whether package ‘decctools’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/decctools.Rcheck/00install.out’ for details.
```

## DescribeDisplay (0.2.4)
Maintainer: Di Cook <dicook@iastate.edu>

```
checking DESCRIPTION meta-information ... NOTE
Deprecated license: BSD
```
```
checking top-level files ... NOTE
Non-standard files/directories found at top level:
  ‘ggobi-xml’ ‘load.r’ ‘write-xml.rnw’
```
```
checking dependencies in R code ... NOTE
Package in Depends field not imported from: ‘proto’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```

## directlabels (2013.6.15)
Maintainer: Toby Dylan Hocking <toby@sg.cs.titech.ac.jp>

```
checking dependencies in R code ... NOTE
'library' or 'require' calls to packages already attached by Depends:
  ‘grid’ ‘quadprog’
  Please remove these calls from your code.
Packages in Depends field not imported from:
  ‘grid’ ‘quadprog’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
Unexported objects imported by ':::' calls:
  ‘ggplot2:::Geom’ ‘ggplot2:::StatIdentity’ ‘ggplot2:::aesdefaults’
  ‘ggplot2:::coord_transform’
  See the note in ?`:::` about the use of this operator.
See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```
```
checking R code for possible problems ... NOTE
ahull.points: no visible global function definition for ‘ashape’
calc.boxes: no visible global function definition for
  ‘current.viewport’
direct.label.ggplot: no visible global function definition for
  ‘aes_string’
direct.label.ggplot: no visible global function definition for ‘guides’
dl.move : pf: no visible global function definition for ‘unit’
dl.move : pf: no visible global function definition for ‘convertUnit’
dlcompare: no visible global function definition for ‘grid.newpage’
dlcompare: no visible global function definition for ‘grid.layout’
dlcompare: no visible global function definition for ‘unit’
dlcompare: no visible global function definition for ‘pushViewport’
dlcompare: no visible global function definition for ‘viewport’
dlcompare: no visible global function definition for ‘grid.text’
dlcompare: no visible global function definition for ‘popViewport’
dlcompare: no visible global function definition for ‘grid.rect’
dldoc: no visible global function definition for ‘theme_set’
dldoc: no visible global function definition for ‘theme_grey’
dldoc : makehtml : <anonymous>: no visible global function definition
  for ‘grid.text’
dlgrob: no visible global function definition for ‘grob’
drawDetails.dlgrob: no visible global function definition for
  ‘convertX’
drawDetails.dlgrob: no visible global function definition for ‘unit’
drawDetails.dlgrob: no visible global function definition for
  ‘convertY’
drawDetails.dlgrob: no visible binding for global variable ‘gpar’
empty.grid: no visible global function definition for ‘convertX’
empty.grid: no visible global function definition for ‘unit’
empty.grid: no visible global function definition for ‘convertY’
empty.grid : draw : drawlines: no visible global function definition
  for ‘grid.segments’
empty.grid : draw : drawlines: no visible global function definition
  for ‘gpar’
extract.posfun: no visible global function definition for
  ‘extract.docs.file’
geom_dl: no visible global function definition for ‘proto’
geom_dl : default_aes: no visible global function definition for ‘aes’
panel.superpose.dl: no visible binding for global variable
  ‘panel.superpose’
panel.superpose.dl: no visible global function definition for
  ‘trellis.par.get’
panel.superpose.dl: no visible global function definition for
  ‘grid.draw’
project.onto.segments: no visible global function definition for
  ‘grid.segments’
qp.labels : <anonymous>: no visible global function definition for
  ‘solve.QP’
static.labels : <anonymous>: no visible global function definition for
  ‘convertX’
static.labels : <anonymous>: no visible global function definition for
  ‘unit’
static.labels : <anonymous>: no visible global function definition for
  ‘convertY’
xlimits: no visible global function definition for ‘convertX’
xlimits: no visible global function definition for ‘unit’
ylimits: no visible global function definition for ‘convertY’
ylimits: no visible global function definition for ‘unit’
```

## EasyHTMLReport (0.1.1)
Maintainer: Yohei Sato <yohei0511@gmail.com>

```
checking top-level files ... NOTE
Non-standard files/directories found at top level:
  ‘easy_html_report_tmp_1376284934.59207.tsv’
  ‘easy_html_report_tmp_1376284935.5951.tsv’
  ‘easy_html_report_tmp_1376284936.59848.tsv’
```
```
checking dependencies in R code ... NOTE
Namespaces in Imports field not imported from:
  ‘ggplot2’ ‘reshape2’ ‘scales’ ‘xtable’
  All declared Imports should be used.
Packages in Depends field not imported from:
  ‘base64enc’ ‘knitr’ ‘markdown’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```
```
checking R code for possible problems ... NOTE
.file_attachment: no visible global function definition for
  ‘base64encode’
easyHtmlReport: no visible global function definition for ‘knit’
easyHtmlReport: no visible global function definition for
  ‘markdownToHTML’
```

## EpiDynamics (0.2)
Maintainer: Oswaldo Santos Baquero <oswaldosant@gmail.com>

__OK__

## ESGtoolkit (0.1)
Maintainer: Thierry Moudiki <thierry.moudiki@gmail.com>

```
checking R code for possible problems ... NOTE
esgplotshocks: no visible global function definition for ‘geom_point’
esgplotshocks: no visible global function definition for ‘aes’
esgplotshocks: no visible global function definition for ‘theme’
esgplotshocks: no visible global function definition for
  ‘element_blank’
esgplotshocks: no visible global function definition for
  ‘scale_color_manual’
esgplotshocks: no visible global function definition for ‘geom_density’
esgplotshocks: no visible global function definition for
  ‘scale_fill_manual’
esgplotshocks: no visible global function definition for ‘coord_flip’
esgplotts: no visible global function definition for ‘xlab’
esgplotts: no visible global function definition for ‘ylab’
esgplotts: no visible global function definition for ‘theme’
```

## extracat (1.7-1)
Maintainer: Alexander Pilhoefer <alexander.pilhoefer@math.uni-augsburg.de>

```
checking dependencies in R code ... NOTE
No Java runtime present, requesting install.
See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```

## ez (4.2-2)
Maintainer: Michael A. Lawrence <mike.lwrnc@gmail.com>

__OK__

## FinCal (0.6)
Maintainer: Felix Yanhui Fan <nolanfyh@gmail.com>

__OK__

## fSRM (0.6)
Maintainer: Felix Schönbrodt <felix@nicebread.de>

__OK__

## gapmap (0.0.2)
Maintainer: Ryo Sakai <ryo.sakai@esat.kuleuven.be>

__OK__

## gettingtothebottom (3.0)
Maintainer: Jocelyn T. Chi <jocelynchi@alum.berkeley.edu>

__OK__

## ggmap (2.3)
Maintainer: David Kahle <david.kahle@gmail.com>

```
checking DESCRIPTION meta-information ... NOTE
License components which are templates and need '+ file LICENSE':
  MIT
```
```
checking dependencies in R code ... NOTE
Package in Depends field not imported from: ‘ggplot2’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
Unexported objects imported by ':::' calls:
  ‘ggplot2:::Geom’ ‘ggplot2:::Position’ ‘ggplot2:::Stat’
  ‘ggplot2:::is.constant’ ‘ggplot2:::rename_aes’
  ‘plyr:::list_to_dataframe’
  See the note in ?`:::` about the use of this operator.
There are ::: calls to the package's namespace in its code. A package
  almost never needs to use ::: for its own objects:
  ‘annotation_raster’
See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```
```
checking R code for possible problems ... NOTE
ggimage: no visible global function definition for ‘ggplot’
ggimage: no visible global function definition for ‘aes’
ggimage: no visible global function definition for ‘geom_blank’
ggimage: no visible global function definition for ‘scale_x_continuous’
ggimage: no visible global function definition for ‘scale_y_continuous’
gglocator: no visible global function definition for ‘last_plot’
ggmap: no visible global function definition for ‘ggplot’
ggmap: no visible global function definition for ‘aes’
ggmap: no visible global function definition for ‘geom_blank’
ggmap: no visible global function definition for ‘annotate’
ggmap: no visible global function definition for ‘geom_tile’
ggmap: no visible global function definition for ‘scale_fill_identity’
ggmap: no visible global function definition for ‘xlim’
ggmap: no visible global function definition for ‘ylim’
ggmap: no visible global function definition for ‘coord_map’
ggmap: no visible global function definition for ‘scale_x_continuous’
ggmap: no visible global function definition for ‘scale_y_continuous’
ggmap: no visible global function definition for ‘theme’
ggmap: no visible global function definition for ‘element_rect’
qmplot: no visible global function definition for ‘ggplot’
qmplot: no visible global function definition for ‘annotate’
qmplot: no visible global function definition for ‘coord_map’
qmplot: no visible global function definition for ‘scale_x_continuous’
qmplot: no visible global function definition for ‘scale_y_continuous’
qmplot: no visible global function definition for ‘theme’
qmplot: no visible global function definition for ‘element_rect’
qmplot: no visible global function definition for ‘facet_null’
qmplot: no visible global function definition for ‘facet_wrap’
qmplot: no visible global function definition for ‘facet_grid’
qmplot : <anonymous>: no visible global function definition for ‘layer’
theme_inset: no visible global function definition for ‘theme_get’
theme_inset: no visible global function definition for ‘element_blank’
theme_nothing: no visible global function definition for ‘theme’
theme_nothing: no visible global function definition for
  ‘element_blank’
```
```
checking Rd line widths ... NOTE
Rd file 'get_cloudmademap.Rd':
  \usage lines wider than 90 characters:
       get_cloudmademap(bbox = c(left = -95.80204, bottom = 29.38048, right = -94.92313, top = 30.14344),

Rd file 'get_openstreetmap.Rd':
  \usage lines wider than 90 characters:
       get_openstreetmap(bbox = c(left = -95.80204, bottom = 29.38048, right = -94.92313, top = 30.14344),

Rd file 'get_stamenmap.Rd':
  \usage lines wider than 90 characters:
       get_stamenmap(bbox = c(left = -95.80204, bottom = 29.38048, right = -94.92313, top = 30.14344),

These lines will be truncated in the PDF manual.
```

## ggmcmc (0.5.1)
Maintainer: Xavier Fernández i Marín <xavier.fim@gmail.com>

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘rstan’
```

## ggparallel (0.1.1)
Maintainer: Heike Hofmann <hofmann@iastate.edu>

```
checking DESCRIPTION meta-information ... NOTE
License components which are templates and need '+ file LICENSE':
  MIT
```
```
checking top-level files ... NOTE
Non-standard file/directory found at top level:
  ‘ggparallel.Rproj’
```
```
checking dependencies in R code ... NOTE
Packages in Depends field not imported from:
  ‘ggplot2’ ‘plyr’ ‘reshape2’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```
```
checking R code for possible problems ... NOTE
ggparallel : getRibbons: no visible global function definition for
  ‘melt’
ggparallel : getRibbons: no visible global function definition for
  ‘geom_ribbon’
ggparallel : getRibbons: no visible global function definition for
  ‘aes’
ggparallel : getRibbons: no visible binding for global variable ‘id’
ggparallel : getRibbons: no visible global function definition for
  ‘ddply’
ggparallel : getRibbons: no visible global function definition for ‘.’
ggparallel : getRibbons: no visible global function definition for
  ‘geom_line’
ggparallel : getRibbons: no visible global function definition for
  ‘scale_size’
ggparallel : getRibbons: no visible binding for global variable
  ‘summarise’
ggparallel: no visible global function definition for ‘melt’
ggparallel: no visible global function definition for ‘ddply’
ggparallel: no visible global function definition for ‘.’
ggparallel: no visible binding for global variable ‘summarize’
ggparallel: no visible global function definition for ‘geom_text’
ggparallel: no visible global function definition for ‘aes’
ggparallel: no visible global function definition for ‘theme’
ggparallel: no visible global function definition for ‘ggplot’
ggparallel: no visible global function definition for ‘geom_bar’
ggparallel: no visible global function definition for ‘xlab’
ggparallel: no visible global function definition for
  ‘scale_x_discrete’
```
```
checking Rd line widths ... NOTE
Rd file 'genes.Rd':
  \examples lines wider than 100 characters:
     ggparallel(list("path", "chrom"), text.offset=c(0.03, 0,-0.03), data = genes,  width=0.1, order=c(1,0), angle=0, color="white",
        scale_colour_manual(values = c(   brewer.pal("YlOrRd", n = 9), rep("grey80", 24)), guide="none") +

Rd file 'ggparallel.Rd':
  \examples lines wider than 100 characters:
     ggparallel(names(titanic)[c(1,4,2,3)], titanic, weight=1, asp=0.5, method="hammock", ratio=0.2, order=c(0,0)) +
     ggparallel(names(titanic)[c(1,4,2,3)], titanic, weight="Freq", asp=0.5, method="hammock", order=c(0,0)) +
     ggparallel(list("path", "chrom"), text.offset=c(0.03, 0,-0.03), data = genes,  width=0.1, order=c(1,0), text.angle=0, color="white",
        scale_colour_manual(values = c(   brewer.pal("YlOrRd", n = 9), rep("grey80", 24)), guide="none") +

These lines will be truncated in the PDF manual.
```

## ggplot2 (1.0.0)
Maintainer: Hadley Wickham <h.wickham@gmail.com>  
Bug reports: https://github.com/hadley/ggplot2/issues

```
checking R code for possible problems ... NOTE
fortify.SpatialPolygonsDataFrame: no visible global function definition
  for ‘unionSpatialPolygons’
hexBin: no visible global function definition for ‘hexbin’
hexBin: no visible global function definition for ‘hcell2xy’
hexGrob: no visible global function definition for ‘hexcoords’
mproject: no visible global function definition for ‘mapproject’
```

## ggRandomForests (1.0.0)
Maintainer: John Ehrlinger <john.ehrlinger@gmail.com>

__OK__

## ggswissmaps (0.0.2)
Maintainer: Sandro Petrillo Burri <gibo.gaf@gmail.com>

__OK__

## ggtern (1.0.3.2)
Maintainer: Nicholas Hamilton <nick@ggtern.com>

```
checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘chemometrics’
```

## ggthemes (1.7.0)
Maintainer: Jeffrey B. Arnold <jeffrey.arnold@gmail.com>  
Bug reports: http://github.com/jrnold/ggthemes

__OK__

## granovaGG (1.2)
Maintainer: Brian A. Danielak <brian@briandk.com>

```
checking top-level files ... NOTE
Non-standard file/directory found at top level:
  ‘README.markdown’
```
```
checking R code for possible problems ... NOTE
GrandMeanPoint: no visible binding for global variable ‘score’
JitteredScoresByGroupContrast: no visible binding for global variable
  ‘contrast’
JitteredScoresByGroupContrast: no visible binding for global variable
  ‘score’
granovagg.1w : GetSummary: no visible binding for global variable
  ‘score’
granovagg.1w : GetSummary: no visible binding for global variable
  ‘contrast’
granovagg.1w : PrintGroupSummary: no visible binding for global
  variable ‘maximum.score’
granovagg.1w : GroupMeanLine: no visible binding for global variable
  ‘x’
granovagg.1w : GroupMeanLine: no visible binding for global variable
  ‘y’
granovagg.1w : GroupMeanLine: no visible binding for global variable
  ‘xend’
granovagg.1w : GroupMeanLine: no visible binding for global variable
  ‘yend’
granovagg.1w : GroupMeansByContrast: no visible binding for global
  variable ‘contrast’
granovagg.1w : GroupMeansByContrast: no visible binding for global
  variable ‘group.mean’
granovagg.1w : Residuals: no visible binding for global variable
  ‘within.group.residuals’
granovagg.1w : Residuals: no visible binding for global variable
  ‘within.1.sd.of.the.mean.of.all.residuals’
granovagg.1w : OuterSquare: no visible binding for global variable
  ‘xmin’
granovagg.1w : OuterSquare: no visible binding for global variable
  ‘xmax’
granovagg.1w : OuterSquare: no visible binding for global variable
  ‘ymin’
granovagg.1w : OuterSquare: no visible binding for global variable
  ‘ymax’
granovagg.1w : OuterSquare: no visible binding for global variable
  ‘fill’
granovagg.1w : InnerSquare: no visible binding for global variable
  ‘xmin’
granovagg.1w : InnerSquare: no visible binding for global variable
  ‘xmax’
granovagg.1w : InnerSquare: no visible binding for global variable
  ‘ymin’
granovagg.1w : InnerSquare: no visible binding for global variable
  ‘ymax’
granovagg.1w : InnerSquare: no visible binding for global variable
  ‘fill’
granovagg.1w : SquaresText: no visible binding for global variable ‘x’
granovagg.1w : SquaresText: no visible binding for global variable ‘y’
granovagg.1w : SquaresText: no visible binding for global variable
  ‘label’
granovagg.1w : WithinGroupVariation: no visible binding for global
  variable ‘x’
granovagg.1w : WithinGroupVariation: no visible binding for global
  variable ‘ymin’
granovagg.1w : WithinGroupVariation: no visible binding for global
  variable ‘ymax’
granovagg.1w : MaxWithinGroupVariation: no visible binding for global
  variable ‘x’
granovagg.1w : MaxWithinGroupVariation: no visible binding for global
  variable ‘ymin’
granovagg.1w : MaxWithinGroupVariation: no visible binding for global
  variable ‘ymax’
granovagg.1w : BaselineWithinGroupVariation: no visible binding for
  global variable ‘baseline.variation’
granovagg.1w : BackgroundForGroupSizesAndLabels: no visible binding for
  global variable ‘ymin’
granovagg.1w : BackgroundForGroupSizesAndLabels: no visible binding for
  global variable ‘ymax’
granovagg.1w : BackgroundForGroupSizesAndLabels: no visible binding for
  global variable ‘xmin’
granovagg.1w : BackgroundForGroupSizesAndLabels: no visible binding for
  global variable ‘xmax’
granovagg.1w : GroupSizes: no visible binding for global variable ‘x’
granovagg.1w : GroupSizes: no visible binding for global variable ‘y’
granovagg.1w : GroupSizes: no visible binding for global variable
  ‘label’
granovagg.1w : GroupSizes: no visible binding for global variable
  ‘angle’
granovagg.1w : NonOverplottedGroupLabels: no visible binding for global
  variable ‘x’
granovagg.1w : NonOverplottedGroupLabels: no visible binding for global
  variable ‘y’
granovagg.1w : NonOverplottedGroupLabels: no visible binding for global
  variable ‘label’
granovagg.1w : NonOverplottedGroupLabels: no visible binding for global
  variable ‘angle’
granovagg.1w : NonOverplottedGroupLabels: no visible binding for global
  variable ‘overplotted’
granovagg.1w : OverplottedGroupLabels: no visible binding for global
  variable ‘x’
granovagg.1w : OverplottedGroupLabels: no visible binding for global
  variable ‘y’
granovagg.1w : OverplottedGroupLabels: no visible binding for global
  variable ‘label’
granovagg.1w : OverplottedGroupLabels: no visible binding for global
  variable ‘angle’
granovagg.1w : OverplottedGroupLabels: no visible binding for global
  variable ‘overplotted’
granovagg.1w : PrintOverplotWarning: no visible binding for global
  variable ‘overplotted’
granovagg.1w : PrintOverplotWarning: no visible binding for global
  variable ‘group.mean’
granovagg.1w : PrintOverplotWarning: no visible binding for global
  variable ‘contrast’
granovagg.contr : GetSummary: no visible binding for global variable
  ‘x.values’
granovagg.contr : GetSummary: no visible binding for global variable
  ‘y.values’
granovagg.contr : JitteredResponsesByContrast: no visible binding for
  global variable ‘x.values’
granovagg.contr : JitteredResponsesByContrast: no visible binding for
  global variable ‘y.values’
granovagg.contr : EffectsOfContrasts: no visible binding for global
  variable ‘responses’
granovagg.contr : ConnectEffectMeans: no visible binding for global
  variable ‘responses’
granovagg.contr : GetGroupSummary: no visible binding for global
  variable ‘variable’
granovagg.contr : GetGroupSummary: no visible binding for global
  variable ‘value’
granovagg.contr : GetGroupSummary: no visible binding for global
  variable ‘standard.deviation’
granovagg.contr : RawScoresByGroup: no visible binding for global
  variable ‘variable’
granovagg.contr : RawScoresByGroup: no visible binding for global
  variable ‘value’
granovagg.contr : MeansByGroup: no visible binding for global variable
  ‘group’
granovagg.contr : MeansByGroup: no visible binding for global variable
  ‘group.mean’
granovagg.contr : ConnectGroupResponseMeans: no visible binding for
  global variable ‘group’
granovagg.contr : ConnectGroupResponseMeans: no visible binding for
  global variable ‘group.mean’
granovagg.ds : GetCrossElementCoordinates: no visible binding for
  global variable ‘color’
granovagg.ds : TreatmentLine: no visible binding for global variable
  ‘intercept’
granovagg.ds : TreatmentLine: no visible binding for global variable
  ‘slope’
granovagg.ds : TreatmentLine: no visible binding for global variable
  ‘color’
granovagg.ds : Crossbow: no visible binding for global variable ‘x’
granovagg.ds : Crossbow: no visible binding for global variable ‘y’
granovagg.ds : Crossbow: no visible binding for global variable ‘x.end’
granovagg.ds : Crossbow: no visible binding for global variable ‘y.end’
granovagg.ds : CIBand: no visible binding for global variable ‘x’
granovagg.ds : CIBand: no visible binding for global variable ‘y’
granovagg.ds : CIBand: no visible binding for global variable ‘x.end’
granovagg.ds : CIBand: no visible binding for global variable ‘y.end’
granovagg.ds : CIBand: no visible binding for global variable ‘color’
granovagg.ds : Shadows: no visible binding for global variable
  ‘x.shadow’
granovagg.ds : Shadows: no visible binding for global variable
  ‘y.shadow’
granovagg.ds : Trails: no visible binding for global variable
  ‘x.trail.start’
granovagg.ds : Trails: no visible binding for global variable
  ‘y.trail.start’
granovagg.ds : Trails: no visible binding for global variable
  ‘x.trail.end’
granovagg.ds : Trails: no visible binding for global variable
  ‘y.trail.end’
```
```
checking Rd line widths ... NOTE
Rd file 'granovagg.ds.Rd':
  \examples lines wider than 100 characters:
                  main = "Assessment Plot for weights to assess Family Therapy treatment for Anorexia Patients",

These lines will be truncated in the PDF manual.
```

## growcurves (0.2.3.9)
Maintainer: "terrance savitsky" <tds151@gmail.com>

```
checking whether package ‘growcurves’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/growcurves.Rcheck/00install.out’ for details.
```

## growfunctions (0.1)
Maintainer: Terrance Savitsky <tds151@gmail.com>

```
checking whether package ‘growfunctions’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/growfunctions.Rcheck/00install.out’ for details.
```

## gstudio (1.3)
Maintainer: Rodney J. Dyer <rjdyer@vcu.edu>

__OK__

## hazus (0.1)
Maintainer: Gopi Goteti <my.ration.shop@gmail.com>

__OK__

## heplots (1.0-12)
Maintainer: Michael Friendly <friendly@yorku.ca>

```
checking R code for possible problems ... NOTE
arrow3d: no visible global function definition for ‘lines3d’
arrow3d: no visible global function definition for ‘rotate3d’
cross3d: no visible global function definition for ‘scale3d’
cross3d: no visible global function definition for ‘translate3d’
cross3d: no visible global function definition for ‘segments3d’
ellipse3d.axes: no visible global function definition for ‘scale3d’
ellipse3d.axes: no visible global function definition for ‘translate3d’
ellipse3d.axes: no visible global function definition for ‘segments3d’
ellipse3d.axes: no visible global function definition for ‘texts3d’
heplot3d.mlm : ellipsoid: no visible global function definition for
  ‘asEuclidean’
heplot3d.mlm : ellipsoid: no visible global function definition for
  ‘qmesh3d’
heplot3d.mlm : ellipsoid: no visible global function definition for
  ‘shade3d’
heplot3d.mlm : ellipsoid: no visible global function definition for
  ‘wire3d’
heplot3d.mlm : ellipsoid: no visible global function definition for
  ‘par3d’
heplot3d.mlm : ellipsoid: no visible global function definition for
  ‘texts3d’
heplot3d.mlm: no visible global function definition for ‘open3d’
heplot3d.mlm: no visible global function definition for ‘view3d’
heplot3d.mlm: no visible global function definition for ‘bg3d’
heplot3d.mlm: no visible global function definition for ‘par3d’
heplot3d.mlm: no visible global function definition for ‘texts3d’
heplot3d.mlm: no visible global function definition for ‘decorate3d’
heplot3d.mlm: no visible global function definition for ‘rgl.pop’
heplot3d.mlm: no visible global function definition for ‘axis3d’
heplot3d.mlm: no visible global function definition for ‘mtext3d’
heplot3d.mlm: no visible global function definition for ‘box3d’
heplot3d.mlm: no visible global function definition for ‘aspect3d’
mark.H0: no visible global function definition for ‘par3d’
mark.H0: no visible global function definition for ‘points3d’
```
```
checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘Sleuth2’
```

## HH (3.1-5)
Maintainer: Richard M. Heiberger <rmh@temple.edu>

__OK__

## HLMdiag (0.2.5)
Maintainer: Adam Loy <loyad01@gmail.com>

```
checking whether package ‘HLMdiag’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/HLMdiag.Rcheck/00install.out’ for details.
```

## imputeR (1.0.0)
Maintainer: Lingbing Feng <fenglb88@gmail.com>

__OK__

## jaatha (2.7.0)
Maintainer: Paul Staab <develop@paulstaab.de>  
Bug reports: https://github.com/paulstaab/jaatha

__OK__

## jsonlite (0.9.14)
Maintainer: Jeroen Ooms <jeroen.ooms@stat.ucla.edu>  
Bug reports: http://github.com/jeroenooms/jsonlite/issues

__OK__

## Kmisc (0.5.0)
Maintainer: Kevin Ushey <kevinushey@gmail.com>  
Bug reports: https://github.com/kevinushey/Kmisc/issues

__OK__

## knitrBootstrap (0.9.0)
Maintainer: Jim Hester <james.f.hester@gmail.com>  
Bug reports: https://github.com/jimhester/knitrBootstrap/issues

__OK__

## Lahman (3.0-1)
Maintainer: Michael Friendly <friendly@yorku.ca>

```
checking installed package size ... NOTE
  installed size is  7.4Mb
  sub-directories of 1Mb or more:
    data   7.2Mb
```

## lda (1.3.2)
Maintainer: Jonathan Chang <jonchang@fb.com>

```
checking whether package ‘lda’ can be installed ... WARNING
Found the following significant warnings:
  gibbs.c:26:1: warning: control may reach end of non-void function [-Wreturn-type]
Found the following additional warnings:
  gibbs.c:26:1: warning: control may reach end of non-void function [-Wreturn-type]
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/lda.Rcheck/00install.out’ for details.
```
```
checking top-level files ... NOTE
Non-standard files/directories found at top level:
  ‘DESCRIPTION.orig’ ‘DESCRIPTION.rej’
```
```
checking dependencies in R code ... NOTE
Missing or unexported object: ‘Matrix::xtabs’
See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```
```
checking R code for possible problems ... NOTE
slda.em : estimate.params: no visible global function definition for
  ‘penalized’
```
```
checking Rd line widths ... NOTE
Rd file 'nubbi.collapsed.gibbs.sampler.Rd':
  \usage lines wider than 90 characters:
     nubbi.collapsed.gibbs.sampler(contexts, pair.contexts, pairs, K.individual, K.pair, vocab, num.iterations, alpha, eta, xi)

Rd file 'rtm.collapsed.gibbs.sampler.Rd':
  \usage lines wider than 90 characters:
             alpha, eta, lambda = sum(sapply(links, length))/(length(links) * (length(links) -1)/2),

These lines will be truncated in the PDF manual.
```

## ltbayes (0.3)
Maintainer: Timothy R. Johnson <trjohns@uidaho.edu>

```
checking whether package ‘ltbayes’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/ltbayes.Rcheck/00install.out’ for details.
```

## mapStats (1.17)
Maintainer: Samuel Ackerman <ackerman@temple.edu>

```
checking R code for possible problems ... NOTE
plotStats: no visible global function definition for ‘coordinates’
```

## marmap (0.9)
Maintainer: Eric Pante <pante.eric@gmail.com>

__OK__

## metafolio (0.1.0)
Maintainer: Sean C. Anderson <sean@seananderson.ca>  
Bug reports: http://github.com/seananderson/metafolio/issues

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘devtools’
```
```
checking whether package ‘metafolio’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/metafolio.Rcheck/00install.out’ for details.
```

## MGLM (0.0.6)
Maintainer: Yiwen Zhang <yzhang31@ncsu.edu>

__OK__

## mizer (0.2)
Maintainer: Finlay Scott <finlay.scott@jrc.ec.europa.eu>

__OK__

## mlr (2.2)
Maintainer: Bernd Bischl <bernd_bischl@gmx.net>  
Bug reports: https://github.com/berndbischl/mlr/issues

```
checking dependencies in R code ... NOTE
No Java runtime present, requesting install.
See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```
```
checking examples ... ERROR
Running examples in ‘mlr-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: plotFilterValues
> ### Title: Plot filter values.
> ### Aliases: plotFilterValues
> 
> ### ** Examples
> 
> fv = getFilterValues(iris.task, method = "chi.squared")
Loading required package: FSelector
No Java runtime present, requesting install.
```

## Mobilize (2.16-4)
Maintainer: Jeroen Ooms <jeroen.ooms@stat.ucla.edu>

__OK__

## mosaic (0.9.1-3)
Maintainer: Randall Pruim <rpruim@calvin.edu>

```
checking package dependencies ... NOTE
Package which this enhances but not available for checking: ‘manipulate’
```
```
checking installed package size ... NOTE
  installed size is  9.0Mb
  sub-directories of 1Mb or more:
    R     1.8Mb
    doc   6.7Mb
```

## mosaicData (0.9.1)
Maintainer: Randall Pruim <rpruim@calvin.edu>

```
checking data for non-ASCII characters ... NOTE
  Note: found 7 marked UTF-8 strings
```

## MRMR (0.1.3)
Maintainer: Brian A. Fannin <BFannin@RedwoodsGroup.com>

```
checking R code for possible problems ... NOTE
PlotResiduals: no visible global function definition for ‘.’
```

## networkreporting (0.0.1)
Maintainer: Dennis Feehan <dfeehan@princeton.edu>

__OK__

## ngramr (1.4.5)
Maintainer: Sean Carmody <seancarmody@gmail.com>

__OK__

## NMF (0.20.5)
Maintainer: Renaud Gaujoux <renaud@tx.technion.ac.il>  
Bug reports: http://github.com/renozao/NMF/issues

```
checking package dependencies ... NOTE
Packages suggested but not available for checking:
  ‘RcppOctave’ ‘doMPI’ ‘devtools’
```
```
checking R code for possible problems ... NOTE
devnmf: no visible global function definition for ‘load_all’
nmfReport: no visible global function definition for ‘knit2html’
posICA: no visible binding for global variable ‘fastICA’
posICA: no visible global function definition for ‘fastICA’
runit.lsnmf: no visible global function definition for ‘checkTrue’
setupLibPaths: no visible global function definition for ‘load_all’
test.match_atrack : .check: no visible global function definition for
  ‘checkEquals’
```
```
checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘RcppOctave’
```

## nullabor (0.3.0)
Maintainer: Di Cook <dicook@iastate.edu>

__OK__

## oaxaca (0.1)
Maintainer: Marek Hlavac <hlavac@fas.harvard.edu>

__OK__

## OpasnetUtils (1.1.0)
Maintainer: Teemu Rintala <teemu.rintala.a@gmail.com>

__OK__

## openair (1.0)
Maintainer: David Carslaw <david.carslaw@kcl.ac.uk>

```
checking whether package ‘openair’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/openair.Rcheck/00install.out’ for details.
```

## orderedLasso (1.7)
Maintainer: Xiaotong Suo <xiaotong@stanford.edu>

__OK__

## OutbreakTools (0.1-11)
Maintainer: Thibaut Jombart <t.jombart@imperial.ac.uk>

__OK__

## pbdPROF (0.2-3)
Maintainer: Wei-Chen Chen <wccsnow@gmail.com>  
Bug reports: http://group.r-pbd.org/

```
checking whether package ‘pbdPROF’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/pbdPROF.Rcheck/00install.out’ for details.
```

## pdfetch (0.1.6)
Maintainer: Abiel Reinhart <abielr@gmail.com>

__OK__

## planar (1.5.2)
Maintainer: Baptiste Auguie <baptiste.auguie@gmail.com>

```
checking whether package ‘planar’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/planar.Rcheck/00install.out’ for details.
```

## poppr (1.1.2)
Maintainer: Zhian N. Kamvar <kamvarz@science.oregonstate.edu>

```
checking R code for possible problems ... NOTE
gen2polysat : <anonymous>: no visible global function definition for
  ‘Genotypes<-’
```

## pqantimalarials (0.2)
Maintainer: J. Patrick Renschler <patrick.renschler@gmail.com>

__OK__

## proteomics (0.2)
Maintainer: Thomas W. D. Möbius <kontakt@thomasmoebius.de>

__OK__

## PSAboot (1.1)
Maintainer: Jason Bryer <jason@bryer.org>  
Bug reports: https://github.com/jbryer/PSAboot/issues

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘devtools’
```
```
checking R code for possible problems ... NOTE
boxplot.PSAboot: no visible global function definition for
  ‘geom_tufteboxplot’
```
```
checking data for non-ASCII characters ... NOTE
  Note: found 4 marked UTF-8 strings
```

## psd (0.4-1)
Maintainer: Andrew J. Barbour <andy.barbour@gmail.com>

```
checking package dependencies ... ERROR
Packages required but not available: ‘fftw’ ‘signal’

Packages suggested but not available for checking:
  ‘bspec’ ‘multitaper’ ‘RSEIS’ ‘rbenchmark’

See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```

## pxR (0.40.0)
Maintainer: Carlos J. Gil Bellosta <cgb@datanalytics.com>

```
checking R code for possible problems ... NOTE
read.px : get.attributes: no visible global function definition for
  ‘ldply’
read.px: no visible global function definition for ‘str_locate_all’
read.px: no visible global function definition for ‘str_sub’
read.px: no visible global function definition for ‘str_length’
```

## qdap (2.2.0)
Maintainer: Tyler Rinker <tyler.rinker@gmail.com>  
Bug reports: http://github.com/trinker/qdap/issues

```
checking whether package ‘qdap’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/qdap.Rcheck/00install.out’ for details.
```

## qgraph (1.3)
Maintainer: Sacha Epskamp <mail@sachaepskamp.com>

```
checking package dependencies ... ERROR
Packages required but not available: ‘sendplot’ ‘d3Network’ ‘ggm’

See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```

## quadrupen (0.2-4)
Maintainer: Julien Chiquet <julien.chiquet@genopole.cnrs.fr>

```
checking whether package ‘quadrupen’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/quadrupen.Rcheck/00install.out’ for details.
```

## rAltmetric (0.3)
Maintainer: Karthik Ram <karthik.ram@gmail.com>

```
checking package dependencies ... NOTE
Depends: includes the non-default packages:
  ‘plyr’ ‘RCurl’ ‘reshape2’ ‘png’ ‘ggplot2’ ‘RJSONIO’
Adding so many packages to the search path is excessive and importing
selectively is preferable.
```
```
checking top-level files ... NOTE
Non-standard files/directories found at top level:
  ‘acuna.png’ ‘altmetric_logo_title.png’
```
```
checking dependencies in R code ... NOTE
Packages in Depends field not imported from:
  ‘RCurl’ ‘RJSONIO’ ‘ggplot2’ ‘plyr’ ‘png’ ‘reshape2’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```
```
checking R code for possible problems ... NOTE
altmetric_data: no visible global function definition for ‘rbind.fill’
altmetric_data: no visible global function definition for ‘unrowname’
altmetric_data: no visible global function definition for ‘melt’
altmetric_data: no visible global function definition for ‘dcast’
altmetrics: no visible global function definition for ‘getCurlHandle’
altmetrics: no visible global function definition for ‘compact’
altmetrics: no visible global function definition for ‘getURL’
altmetrics: no visible global function definition for ‘fromJSON’
plot.altmetric: no visible global function definition for ‘melt’
plot.altmetric: no visible global function definition for ‘readPNG’
plot.altmetric: no visible global function definition for
  ‘getURLContent’
plot.altmetric: no visible global function definition for ‘ggplot’
plot.altmetric: no visible global function definition for ‘aes’
plot.altmetric: no visible global function definition for ‘geom_point’
plot.altmetric: no visible global function definition for ‘ggtitle’
plot.altmetric: no visible global function definition for ‘xlab’
plot.altmetric: no visible global function definition for ‘ylab’
plot.altmetric: no visible global function definition for ‘theme’
plot.altmetric: no visible global function definition for
  ‘element_blank’
plot.altmetric: no visible global function definition for
  ‘element_line’
plot.altmetric: no visible global function definition for
  ‘annotation_raster’
plot.altmetric: no visible global function definition for
  ‘element_text’
print.altmetric: no visible global function definition for ‘melt’
```

## RAM (1.1.0)
Maintainer: Wen Chen <Wen.Chen@agr.gc.ca>

```
checking package dependencies ... ERROR
Package required but not available: ‘labdsv’

Packages suggested but not available for checking:
  ‘Heatplus’ ‘indicspecies’

See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```

## RCMIP5 (1.1)
Maintainer: Kathe Todd-Brown <ktoddbrown@gmail.com>

__OK__

## RDS (0.6)
Maintainer: Mark S. Handcock <handcock@stat.ucla.edu>

__OK__

## repra (0.4.2)
Maintainer: Eduardo Ibanez <eduardo.ibanez@nrel.gov>  
Bug reports: https://github.com/NREL/repra/issues

__OK__

## reshapeGUI (0.1.0)
Maintainer: Jason Crowley <crowley.jason.s@gmail.com>

```
checking package dependencies ... ERROR
Packages required but not available: ‘gWidgets’ ‘gWidgetsRGtk2’

See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```

## rfordummies (0.0-2)
Maintainer: Andrie de Vries <apdevries@gmail.com>  
Bug reports: https://github.com/andrie/rfordummies/issues

__OK__

## rgauges (0.2.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/rgauges/issues

__OK__

## RNeXML (1.1.3)
Maintainer: Carl Boettiger <cboettig@gmail.com>

```
checking package dependencies ... NOTE
Packages suggested but not available for checking: ‘rrdf’ ‘Sxslt’
```
```
checking R code for possible problems ... NOTE
get_rdf: no visible global function definition for
  ‘xsltApplyStyleSheet’
nexml_figshare: no visible global function definition for ‘fs_create’
nexml_figshare: no visible global function definition for
  ‘fs_add_authors’
nexml_figshare: no visible global function definition for
  ‘fs_add_categories’
nexml_figshare: no visible global function definition for ‘fs_add_tags’
nexml_figshare: no visible global function definition for ‘fs_upload’
nexml_figshare: no visible global function definition for
  ‘fs_make_private’
nexml_figshare: no visible global function definition for
  ‘fs_make_public’
```

## robustbase (0.92-2)
Maintainer: Martin Maechler <maechler@stat.math.ethz.ch>

```
checking whether package ‘robustbase’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8QdyFe/check_cran1038e2ed74367/robustbase.Rcheck/00install.out’ for details.
```

## robustlmm (1.6)
Maintainer: Manuel Koller <koller.manuel@gmail.com>

```
checking R code for possible problems ... NOTE
.S: no visible global function definition for ‘symmpart’
.calcE.psi_bbt: no visible global function definition for ‘Matrix’
.calcE.psi_bbt: no visible global function definition for ‘Diagonal’
.calcE.psi_bpsi_bt: no visible global function definition for ‘Matrix’
.calcE.psi_bpsi_bt: no visible global function definition for
  ‘Diagonal’
fit.effects: no visible global function definition for ‘Matrix’
fit.effects: no visible global function definition for ‘Diagonal’
lchol: no visible global function definition for ‘Diagonal’
rlmer.fit.DAS.nondiag: no visible global function definition for
  ‘symmpart’
rlmer.fit.DAS.nondiag: no visible global function definition for
  ‘Diagonal’
updateThetaTau: no visible global function definition for ‘Diagonal’
vcov.rlmerMod : calc.vcov.hess: no visible global function definition
  for ‘forceSymmetric’
zero.theta.DASexp: no visible global function definition for ‘Matrix’
```

## rpf (0.43)
Maintainer: Joshua Pritikin <jpritikin@pobox.com>

```
checking package dependencies ... ERROR
Package required but not available: ‘RcppEigen’

See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```

## rplexos (0.10.0.1)
Maintainer: Eduardo Ibanez <eduardo.ibanez@nrel.gov>  
Bug reports: https://github.com/NREL/rplexos/issues

__OK__

## rplos (0.4.1)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: http://www.github.com/ropensci/rplos/issues

__OK__

## rspear (0.1-2)
Maintainer: Eduard Szoecs <eduardszoecs@gmail.com>

__OK__

## rWBclimate (0.1.3)
Maintainer: Edmund Hart <edmund.m.hart@gmail.com>  
Bug reports: http://github.com/ropensci/rWBclimate/issues

```
checking R code for possible problems ... NOTE
check_ISO_code: no visible binding for global variable ‘NoAm_country’
check_ISO_code: no visible binding for global variable ‘SoAm_country’
check_ISO_code: no visible binding for global variable ‘Oceana_country’
check_ISO_code: no visible binding for global variable ‘Africa_country’
check_ISO_code: no visible binding for global variable ‘Asia_country’
check_ISO_code: no visible binding for global variable ‘Eur_country’
```

## rYoutheria (1.0.0)
Maintainer: Tom August <tomaug@ceh.ac.uk>  
Bug reports: 
        https://github.com/biologicalrecordscentre/rYoutheria/issues

__OK__

## saps (1.0.0)
Maintainer: Daniel Schmolze <saps@schmolze.com>

```
checking package dependencies ... ERROR
Packages required but not available: ‘piano’ ‘survcomp’

Package suggested but not available for checking: ‘snowfall’

See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```

## SGP (1.2-0.0)
Maintainer: Damian W. Betebenner <dbetebenner@nciea.org>  
Bug reports: https://github.com/CenterForAssessment/SGP/issues

```
checking package namespace information ... NOTE
  Namespace with empty importFrom: ‘reshape2’
```
```
checking installed package size ... NOTE
  installed size is  7.8Mb
  sub-directories of 1Mb or more:
    data   6.9Mb
```
```
checking R code for possible problems ... NOTE
abcSGP: no visible binding for global variable ‘SGPstateData’
analyzeSGP: no visible binding for global variable ‘SGPstateData’
analyzeSGP: no visible global function definition for ‘clusterApplyLB’
analyzeSGP: no visible global function definition for ‘mclapply’
analyzeSGP : <anonymous>: no visible binding for global variable
  ‘SGPstateData’
baselineSGP: no visible binding for global variable ‘SGPstateData’
bubblePlot_Styles: no visible binding for global variable
  ‘SGPstateData’
bubblePlot_Styles : get.my.cutscore.year: no visible binding for global
  variable ‘SGPstateData’
checkSGP: no visible binding for global variable ‘SGPstateData’
checksplineMatrix: no visible binding for global variable
  ‘SGPstateData’
combineSGP: no visible binding for global variable ‘SGPstateData’
combineSGP : get.target.arguments: no visible binding for global
  variable ‘SGPstateData’
csemScoreSimulator: no visible binding for global variable
  ‘SGPstateData’
getAchievementLevel : get.cutscore.label: no visible binding for global
  variable ‘SGPstateData’
getAchievementLevel : getAchievementLevel_INTERNAL: no visible binding
  for global variable ‘SGPstateData’
getKnotsBoundaries: no visible binding for global variable
  ‘SGPstateData’
getKnotsBoundaries : <anonymous>: no visible binding for global
  variable ‘SGPstateData’
getMaxOrderForProgression: no visible binding for global variable
  ‘SGPstateData’
getPercentileTableNames: no visible binding for global variable
  ‘SGPstateData’
getPreferredSGP: no visible binding for global variable ‘SGPstateData’
getTargetInitialStatus: no visible binding for global variable
  ‘SGPstateData’
getTargetSGP: no visible binding for global variable ‘SGPstateData’
getTargetSGPContentArea: no visible binding for global variable
  ‘SGPstateData’
getTargetScaleScore: no visible binding for global variable
  ‘SGPstateData’
getTargetScaleScore: no visible global function definition for
  ‘clusterApplyLB’
getTargetScaleScore : <anonymous>: no visible binding for global
  variable ‘SGPstateData’
getTargetScaleScore: no visible global function definition for
  ‘mclapply’
getYearsContentAreasGrades: no visible binding for global variable
  ‘SGPstateData’
gofSGP : .goodness.of.fit: no visible binding for global variable
  ‘SGPstateData’
growthAchievementPlot: no visible binding for global variable
  ‘SGPstateData’
growthAchievementPlot : get.my.label: no visible binding for global
  variable ‘SGPstateData’
growthAchievementPlot : create.long.cutscores: no visible binding for
  global variable ‘SGPstateData’
growthAchievementPlot : piecewise.transform: no visible binding for
  global variable ‘SGPstateData’
growthAchievementPlot : smoothPercentileTrajectory: no visible binding
  for global variable ‘SGPstateData’
outputSGP : get.my.label: no visible binding for global variable
  ‘SGPstateData’
outputSGP : piecewise.transform: no visible binding for global variable
  ‘SGPstateData’
outputSGP: no visible global function definition for ‘randomNames’
prepareSGP: no visible binding for global variable ‘sgpData_LONG’
sqliteSGP: no visible binding for global variable ‘SGPstateData’
sqliteSGP : get.grade: no visible binding for global variable
  ‘SGPstateData’
sqliteSGP : get.year: no visible binding for global variable
  ‘SGPstateData’
startParallel: no visible global function definition for ‘clusterEvalQ’
startParallel: no visible global function definition for
  ‘clusterExport’
startParallel: no visible global function definition for ‘makeCluster’
stopParallel: no visible global function definition for ‘stopCluster’
studentGrowthPercentiles : .create.coefficient.matrices: no visible
  global function definition for ‘mclapply’
studentGrowthPercentiles : .create.coefficient.matrices: no visible
  global function definition for ‘parLapplyLB’
studentGrowthPercentiles : .simex.sgp: no visible binding for global
  variable ‘SGPstateData’
studentGrowthPercentiles : .simex.sgp: no visible global function
  definition for ‘mclapply’
studentGrowthPercentiles : .simex.sgp: no visible global function
  definition for ‘parLapply’
studentGrowthPercentiles: no visible binding for global variable
  ‘SGPstateData’
studentGrowthPlot: no visible binding for global variable
  ‘SGPstateData’
studentGrowthPlot : get.my.cutscore.year: no visible binding for global
  variable ‘SGPstateData’
studentGrowthPlot_Styles : create.long.cutscores.sgPlot: no visible
  binding for global variable ‘SGPstateData’
studentGrowthPlot_Styles: no visible binding for global variable
  ‘SGPstateData’
studentGrowthProjections : .get.trajectories.and.cuts: no visible
  binding for global variable ‘SGPstateData’
studentGrowthProjections: no visible binding for global variable
  ‘SGPstateData’
summarizeSGP: no visible binding for global variable ‘SGPstateData’
summarizeSGP : summarizeSGP.config: no visible binding for global
  variable ‘SGPstateData’
summarizeSGP : summarizeSGP_INTERNAL: no visible global function
  definition for ‘parLapply’
summarizeSGP : summarizeSGP_INTERNAL: no visible global function
  definition for ‘mclapply’
testSGP: no visible global function definition for ‘detectCores’
visualizeSGP : get.max.order.for.progression: no visible binding for
  global variable ‘SGPstateData’
visualizeSGP : get.gaPlot.iter: no visible binding for global variable
  ‘SGPstateData’
visualizeSGP: no visible binding for global variable ‘SGPstateData’
visualizeSGP: no visible global function definition for
  ‘clusterApplyLB’
visualizeSGP: no visible global function definition for ‘mclapply’
visualizeSGP : get.next.grade: no visible binding for global variable
  ‘SGPstateData’
visualizeSGP : get.my.label: no visible binding for global variable
  ‘SGPstateData’
visualizeSGP : piecewise.transform: no visible binding for global
  variable ‘SGPstateData’
visualizeSGP: no visible global function definition for ‘randomNames’
```

## sharpshootR (0.6-3)
Maintainer: Dylan Beaudette <dylan.beaudette@ca.usda.gov>

```
checking package dependencies ... ERROR
Packages required but not available: ‘aqp’ ‘circular’

Package suggested but not available for checking: ‘soilDB’

See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```

## simPH (1.2.3)
Maintainer: Christopher Gandrud <christopher.gandrud@gmail.com>  
Bug reports: https://github.com/christophergandrud/simPH/issues

__OK__

## SixSigma (0.8-1)
Maintainer: Emilio L. Cano <emilio.lopez@urjc.es>

```
checking R code for possible problems ... NOTE
ss.rr: no visible binding for global variable ‘ss.data.rr’
```

## sjPlot (1.6)
Maintainer: Daniel Luedecke <d.luedecke@uke.de>  
Bug reports: https://github.com/sjPlot/devel/issues

__OK__

## sparseMVN (0.1.0)
Maintainer: Michael Braun <braunm@smu.edu>

```
checking R code for possible problems ... NOTE
.mvnSparse.compare: no visible global function definition for ‘tril’
.mvnSparse.compare: no visible global function definition for ‘Matrix’
.mvnSparse.compare: no visible global function definition for ‘cBind’
.mvnSparse.compare: no visible global function definition for ‘rBind’
.mvnSparse.compare: no visible global function definition for
  ‘Diagonal’
.mvnSparse.compare: no visible global function definition for
  ‘Cholesky’
.mvnSparse.compare: no visible global function definition for ‘dmvnorm’
.mvnSparse.compare: no visible global function definition for ‘rmvnorm’
.run.compare: no visible global function definition for ‘dcast’
.run.compare: no visible global function definition for ‘melt’
dmvn.sparse: no visible global function definition for ‘expand’
rmvn.sparse: no visible global function definition for ‘expand’
```

## ss3sim (0.8.2)
Maintainer: Sean Anderson <sean@seananderson.ca>

```
checking R code for possible problems ... NOTE
run_ss3sim: no visible global function definition for ‘%dopar%’
run_ss3sim: no visible global function definition for ‘foreach’
setup_parallel: no visible global function definition for
  ‘getDoParWorkers’
```

## structSSI (1.1)
Maintainer: Kris Sankaran <kriss1@stanford.edu>

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘phyloseq’
```
```
checking data for non-ASCII characters ... NOTE
  Error in .requirePackage(package) : 
    unable to find required package 'phyloseq'
  Calls: <Anonymous> ... .extendsForS3 -> extends -> getClassDef -> .requirePackage
  Execution halted
```
```
checking examples ... ERROR
Running examples in ‘structSSI-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: treePValues
> ### Title: Create tree of p-values for phyloseq data
> ### Aliases: treePValues
> 
> ### ** Examples
> 
> library('phyloseq')
Error in library("phyloseq") : there is no package called ‘phyloseq’
Execution halted
The file /tmp/Rtmpjixlg8/hyp_tree20141204155645.html does not exist.
```

## Tampo (1.0)
Maintainer: Matthias Vignon <Matthias.Vignon@univ-pau.fr>

__OK__

## taRifx (1.0.6)
Maintainer: Ari B. Friedman <abfriedman@gmail.com>

```
checking R code for possible problems ... NOTE
autoplot.microbenchmark: no visible global function definition for
  ‘ggplot’
autoplot.microbenchmark: no visible global function definition for
  ‘aes’
autoplot.microbenchmark: no visible global function definition for
  ‘coord_cartesian’
autoplot.microbenchmark: no visible global function definition for
  ‘stat_summary’
autoplot.microbenchmark: no visible global function definition for
  ‘opts’
autoplot.microbenchmark: no visible global function definition for
  ‘theme_text’
compareplot: no visible global function definition for ‘grid.newpage’
compareplot: no visible global function definition for
  ‘latticeParseFormula’
compareplot: no visible global function definition for ‘pushViewport’
compareplot: no visible global function definition for ‘viewport’
compareplot: no visible global function definition for ‘grid.layout’
compareplot: no visible global function definition for ‘unit’
compareplot: no visible global function definition for ‘seekViewport’
compareplot: no visible global function definition for ‘grid.rect’
compareplot : makeNat: no visible global function definition for
  ‘convertUnit’
compareplot: no visible global function definition for ‘grid.text’
compareplot: no visible global function definition for ‘gpar’
compareplot: no visible global function definition for ‘grid.lines’
compareplot: no visible global function definition for ‘grid.points’
compareplot: no visible global function definition for ‘grid.polyline’
compareplot: no visible global function definition for ‘upViewport’
compareplot: no visible global function definition for ‘convertUnit’
compareplot: no visible global function definition for ‘popViewport’
hist_horiz: no visible global function definition for
  ‘latticeParseFormula’
latex.table.by: no visible global function definition for ‘xtable’
panel.densityplot.enhanced: no visible global function definition for
  ‘panel.densityplot’
panel.densityplot.enhanced: no visible global function definition for
  ‘unit’
panel.densityplot.enhanced: no visible global function definition for
  ‘grid.text’
panel.densityplot.enhanced: no visible global function definition for
  ‘gpar’
panel.ecdf: no visible global function definition for ‘panel.xyplot’
panel.ecdf: no visible global function definition for ‘panel.lines’
panel.xyplot_rug: no visible global function definition for
  ‘panel.xyplot’
panel.xyplot_rug: no visible global function definition for
  ‘grid.segments’
panel.xyplot_rug: no visible global function definition for ‘unit’
panel.xyplot_rug: no visible global function definition for ‘gpar’
searchPattern: no visible global function definition for ‘interleave’
xtable.CrossTable: no visible global function definition for
  ‘caption<-’
xtable.CrossTable: no visible global function definition for ‘label<-’
xtable.CrossTable: no visible global function definition for ‘align<-’
xtable.CrossTable: no visible global function definition for ‘digits<-’
xtable.CrossTable: no visible global function definition for
  ‘display<-’
xtable.summary.lme: no visible global function definition for
  ‘caption<-’
xtable.summary.lme: no visible global function definition for ‘label<-’
xtable.summary.lme: no visible global function definition for ‘align<-’
xtable.summary.lme: no visible global function definition for
  ‘digits<-’
xtable.summary.lme: no visible global function definition for
  ‘display<-’
xtablelm: no visible global function definition for ‘xtable’
```

## taxize (0.4.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/taxize/issues

__OK__

## TcGSA (0.9.8)
Maintainer: Boris P. Hejblum <boris.hejblum@isped.u-bordeaux2.fr>

```
checking R code for possible problems ... NOTE
TcGSA.LR.parallel: no visible global function definition for
  ‘makeCluster’
TcGSA.LR.parallel: no visible global function definition for
  ‘registerDoSNOW’
TcGSA.LR.parallel: no visible global function definition for ‘%dopar%’
TcGSA.LR.parallel: no visible global function definition for ‘foreach’
TcGSA.LR.parallel: no visible global function definition for
  ‘stopCluster’
```

## tidyr (0.1)
Maintainer: 'Hadley Wickham' <h.wickham@gmail.com>

__OK__

## toaster (0.2.5)
Maintainer: Gregory Kanevsky <gregory.kanevsky@teradata.com>

```
checking package dependencies ... ERROR
Package required but not available: ‘RODBC’

See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```

## tourr (0.5.3)
Maintainer: Hadley Wickham <h.wickham@gmail.com>

```
checking R code for possible problems ... NOTE
display_dist : render_data: no visible global function definition for
  ‘ash1’
display_dist : render_data: no visible global function definition for
  ‘bin1’
display_faces : render_data: no visible global function definition for
  ‘faces2’
display_trails : render_data: no visible binding for '<<-' assignment
  to ‘past_x’
plot.path_curve: no visible global function definition for ‘qplot’
plot.path_curve: no visible global function definition for ‘facet_grid’
plot.path_index: no visible global function definition for ‘qplot’
plot.path_index: no visible global function definition for ‘labs’
```

## treebase (0.0-7.1)
Maintainer: Carl Boettiger <cboettig@gmail.com>  
Bug reports: http://www.github.com/ropensci/treebase/issues

__OK__

## treecm (1.2.1)
Maintainer: Marco Bascietto <marco.bascietto@cnr.it>

__OK__

## TriMatch (0.9.1)
Maintainer: Jason Bryer <jason@bryer.org>  
Bug reports: https://github.com/jbryer/TriMatch/issues

```
checking dependencies in R code ... NOTE
Namespaces in Imports field not imported from:
  ‘PSAgraphics’ ‘compiler’ ‘psych’ ‘stats’
  All declared Imports should be used.
Packages in Depends field not imported from:
  ‘ez’ ‘ggplot2’ ‘reshape2’ ‘scales’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```
```
checking R code for possible problems ... NOTE
balance.plot: no visible global function definition for ‘melt’
balance.plot: no visible global function definition for ‘ggplot’
balance.plot: no visible global function definition for ‘aes’
balance.plot: no visible global function definition for ‘facet_grid’
balance.plot: no visible global function definition for ‘geom_boxplot’
balance.plot: no visible global function definition for ‘geom_point’
balance.plot: no visible global function definition for ‘geom_line’
balance.plot: no visible global function definition for ‘geom_errorbar’
balance.plot: no visible global function definition for ‘geom_bar’
balance.plot: no visible global function definition for
  ‘scale_fill_hue’
balance.plot: no visible global function definition for
  ‘scale_y_continuous’
balance.plot: no visible binding for global variable ‘percent’
balance.plot: no visible global function definition for ‘theme’
balance.plot: no visible global function definition for ‘element_text’
balance.plot: no visible global function definition for ‘element_rect’
balance.plot: no visible global function definition for
  ‘scale_x_discrete’
balance.plot: no visible global function definition for ‘ezANOVA’
boxdiff.plot: no visible global function definition for ‘melt’
boxdiff.plot: no visible global function definition for ‘ggplot’
boxdiff.plot: no visible global function definition for ‘aes’
boxdiff.plot: no visible global function definition for ‘geom_boxplot’
boxdiff.plot: no visible global function definition for ‘geom_crossbar’
boxdiff.plot: no visible global function definition for ‘geom_hline’
boxdiff.plot: no visible global function definition for ‘geom_point’
boxdiff.plot: no visible global function definition for ‘geom_text’
boxdiff.plot: no visible global function definition for
  ‘scale_x_discrete’
boxdiff.plot: no visible global function definition for ‘xlab’
distances.plot: no visible global function definition for ‘melt’
distances.plot: no visible global function definition for ‘ggplot’
distances.plot: no visible global function definition for ‘aes’
distances.plot: no visible global function definition for ‘geom_bar’
distances.plot: no visible global function definition for ‘coord_flip’
distances.plot: no visible global function definition for ‘geom_hline’
distances.plot: no visible global function definition for ‘theme’
distances.plot: no visible global function definition for
  ‘element_blank’
distances.plot: no visible global function definition for ‘xlab’
distances.plot: no visible global function definition for ‘xlim’
distances.plot: no visible global function definition for ‘geom_text’
loess3.plot: no visible binding for global variable ‘geom_point’
loess3.plot: no visible global function definition for ‘melt’
loess3.plot: no visible global function definition for ‘ggplot’
loess3.plot: no visible global function definition for ‘aes’
loess3.plot: no visible global function definition for ‘geom_path’
loess3.plot: no visible global function definition for ‘geom_smooth’
loess3.plot: no visible global function definition for
  ‘scale_color_brewer’
loess3.plot: no visible global function definition for
  ‘scale_fill_brewer’
multibalance.plot: no visible global function definition for ‘melt’
multibalance.plot: no visible global function definition for ‘ggplot’
multibalance.plot: no visible global function definition for ‘aes’
multibalance.plot: no visible global function definition for
  ‘geom_point’
multibalance.plot: no visible global function definition for
  ‘geom_path’
multibalance.plot: no visible global function definition for ‘ylab’
multibalance.plot: no visible global function definition for ‘xlab’
multibalance.plot: no visible global function definition for
  ‘scale_color_hue’
multibalance.plot: no visible global function definition for
  ‘scale_linetype’
multibalance.plot: no visible global function definition for
  ‘scale_shape’
multibalance.plot: no visible global function definition for
  ‘facet_grid’
parallel.plot: no visible global function definition for ‘melt’
parallel.plot: no visible global function definition for ‘ggplot’
parallel.plot: no visible global function definition for ‘geom_line’
parallel.plot: no visible global function definition for ‘aes’
parallel.plot: no visible global function definition for ‘theme’
parallel.plot: no visible global function definition for
  ‘scale_colour_gradient’
parallel.plot: no visible global function definition for ‘geom_point’
plot.balance.plots: no visible global function definition for
  ‘grid.newpage’
plot.balance.plots: no visible global function definition for
  ‘pushViewport’
plot.balance.plots: no visible global function definition for
  ‘viewport’
plot.balance.plots: no visible global function definition for
  ‘grid.layout’
plot.balance.plots : vplayout: no visible global function definition
  for ‘viewport’
plot.triangle.matches: no visible global function definition for ‘melt’
plot.triangle.matches: no visible global function definition for
  ‘geom_path’
plot.triangle.matches: no visible global function definition for ‘aes’
plot.triangle.matches: no visible global function definition for
  ‘geom_point’
plot.triangle.psa: no visible global function definition for ‘ggplot’
plot.triangle.psa: no visible global function definition for
  ‘geom_segment’
plot.triangle.psa: no visible global function definition for
  ‘geom_line’
plot.triangle.psa: no visible global function definition for ‘aes’
plot.triangle.psa: no visible global function definition for
  ‘geom_text’
plot.triangle.psa: no visible binding for global variable ‘label’
plot.triangle.psa: no visible global function definition for
  ‘geom_point’
plot.triangle.psa: no visible global function definition for
  ‘scale_color_manual’
plot.triangle.psa: no visible global function definition for ‘xlim’
plot.triangle.psa: no visible global function definition for ‘ylim’
plot.triangle.psa: no visible global function definition for ‘xlab’
plot.triangle.psa: no visible global function definition for ‘ylab’
plot.triangle.psa: no visible global function definition for
  ‘coord_equal’
plot.triangle.psa: no visible global function definition for ‘theme’
plot.triangle.psa: no visible global function definition for
  ‘element_blank’
summary.triangle.matches: no visible global function definition for
  ‘melt’
summary.triangle.matches: no visible global function definition for
  ‘ezANOVA’
```

## TripleR (1.4)
Maintainer: Felix Schönbrodt <felix.schoenbrodt@psy.lmu.de>

__OK__

## tvm (0.2)
Maintainer: Juan Manuel Truppia <jmtruppia@gmail.com>

__OK__

## vardpoor (0.2.0.14)
Maintainer: Juris Breidaks <Juris.Breidaks@csb.gov.lv>  
Bug reports: https://github.com/CSBLatvia/vardpoor/issues/

__OK__

## wordmatch (1.0)
Maintainer: Amit Singh Rathore <amitplatinum@gmail.com>

```
checking dependencies in R code ... NOTE
Packages in Depends field not imported from:
  ‘plyr’ ‘reshape2’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.
See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```
```
checking R code for possible problems ... NOTE
wordmatch: no visible global function definition for ‘llply’
wordmatch : <anonymous>: no visible global function definition for
  ‘llply’
wordmatch: no visible global function definition for ‘melt’
wordmatch: no visible global function definition for ‘count’
```

## wppExplorer (1.4-0)
Maintainer: Hana Sevcikova <hanas@uw.edu>

__OK__

## wq (0.4-1)
Maintainer: Anthony Malkassian <anthonym@sfei.org>

```
checking package namespace information ... NOTE
  Namespace with empty importFrom: ‘methods’
```
```
checking R code for possible problems ... NOTE
eofNum: no visible global function definition for ‘ggplot’
eofNum: no visible global function definition for ‘aes’
eofNum: no visible global function definition for ‘geom_errorbar’
eofNum: no visible global function definition for ‘geom_point’
eofNum: no visible global function definition for ‘geom_text’
eofNum: no visible global function definition for
  ‘scale_colour_discrete’
eofNum: no visible global function definition for ‘labs’
eofNum: no visible global function definition for ‘theme’
eofNum: no visible global function definition for ‘element_blank’
eofNum: no visible global function definition for ‘theme_bw’
eofPlot: no visible global function definition for ‘melt’
eofPlot: no visible global function definition for ‘ggplot’
eofPlot: no visible global function definition for ‘aes_string’
eofPlot: no visible global function definition for ‘geom_vline’
eofPlot: no visible global function definition for ‘geom_point’
eofPlot: no visible global function definition for ‘facet_wrap’
eofPlot: no visible global function definition for ‘labs’
eofPlot: no visible global function definition for ‘geom_hline’
eofPlot: no visible global function definition for ‘aes’
eofPlot: no visible global function definition for ‘geom_line’
layOut: no visible global function definition for ‘pushViewport’
layOut: no visible global function definition for ‘viewport’
layOut: no visible global function definition for ‘grid.layout’
mannKen: no visible global function definition for ‘ggplot’
mannKen: no visible global function definition for ‘aes’
mannKen: no visible global function definition for ‘geom_point’
mannKen: no visible global function definition for
  ‘scale_colour_manual’
mannKen: no visible global function definition for ‘scale_shape_manual’
mannKen: no visible global function definition for ‘labs’
plotSeason: no visible global function definition for ‘melt’
plotSeason: no visible global function definition for ‘ggplot’
plotSeason: no visible global function definition for ‘aes’
plotSeason: no visible global function definition for ‘geom_boxplot’
plotSeason: no visible global function definition for ‘labs’
plotSeason: no visible global function definition for
  ‘scale_x_discrete’
plotSeason: no visible global function definition for
  ‘scale_y_continuous’
plotSeason: no visible global function definition for
  ‘scale_colour_manual’
plotSeason: no visible global function definition for ‘theme’
plotSeason: no visible global function definition for ‘element_blank’
plotSeason: no visible global function definition for ‘element_text’
plotSeason: no visible global function definition for ‘facet_wrap’
plotTs: no visible global function definition for ‘melt’
plotTs: no visible global function definition for ‘ggplot’
plotTs: no visible global function definition for ‘geom_line’
plotTs: no visible global function definition for ‘aes_string’
plotTs: no visible global function definition for ‘facet_wrap’
plotTs: no visible global function definition for ‘labs’
plotTs: no visible global function definition for ‘theme’
plotTs: no visible global function definition for ‘element_text’
plotTs: no visible global function definition for ‘geom_point’
plotTs: no visible global function definition for ‘aes’
plotTsAnom: no visible global function definition for ‘melt’
plotTsAnom: no visible global function definition for ‘ggplot’
plotTsAnom: no visible global function definition for ‘aes’
plotTsAnom: no visible global function definition for ‘geom_linerange’
plotTsAnom: no visible global function definition for ‘geom_hline’
plotTsAnom: no visible global function definition for ‘labs’
plotTsAnom: no visible global function definition for ‘facet_wrap’
plotTsAnom: no visible global function definition for ‘theme’
plotTsAnom: no visible global function definition for ‘element_blank’
plotTsAnom: no visible global function definition for ‘element_text’
plotTsTile: no visible global function definition for ‘ggplot’
plotTsTile: no visible global function definition for ‘aes’
plotTsTile: no visible global function definition for ‘geom_tile’
plotTsTile: no visible global function definition for
  ‘scale_x_continuous’
plotTsTile: no visible global function definition for
  ‘scale_y_discrete’
plotTsTile: no visible global function definition for
  ‘scale_fill_manual’
plotTsTile: no visible global function definition for ‘theme_bw’
plotTsTile: no visible global function definition for ‘theme’
plotTsTile: no visible global function definition for ‘element_blank’
plotTsTile: no visible global function definition for ‘labs’
plotTsTile: no visible global function definition for ‘coord_equal’
seaRoll: no visible global function definition for ‘ggplot’
seaRoll: no visible global function definition for ‘aes’
seaRoll: no visible global function definition for ‘geom_point’
seaRoll: no visible global function definition for ‘scale_shape_manual’
seaRoll: no visible global function definition for ‘labs’
seaRoll: no visible global function definition for ‘theme’
seasonTrend: no visible global function definition for ‘ggplot’
seasonTrend: no visible global function definition for ‘aes’
seasonTrend: no visible global function definition for ‘geom_bar’
seasonTrend: no visible global function definition for
  ‘scale_fill_manual’
seasonTrend: no visible global function definition for ‘labs’
seasonTrend: no visible global function definition for ‘theme’
seasonTrend: no visible global function definition for ‘element_blank’
seasonTrend: no visible global function definition for ‘facet_wrap’
wqData: no visible global function definition for ‘melt’
```

## YourCast (1.6.2)
Maintainer: Konstantin Kashin <kkashin@fas.harvard.edu>

__OK__

