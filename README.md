shimmer
=======

`shimmer` is an [R-package](https://www.r-project.org/) for reading physiologic data recorded with a [shimmer device](http://www.shimmersensing.com/).

Installation
------------
To install the `shimmer` package in R, proceed as follows in R.

First install the `devtools`-package and load it:
```
   install.packages("devtools")
   library(devtools)
```

You can now install the `shimmer` package:
```
   install_github("bwrc/shimmer-r")
```

Usage
-----
To read data data recorded with a Shimmer device into R:

```
library(shimmer)
datapath <- "/tmp/my_recording/filename.csv"
recording <- read.shimmer(datapath)
```

License
-------
The `shimmer` R-package is licensed under the [MIT-license](http://opensource.org/licenses/MIT).
