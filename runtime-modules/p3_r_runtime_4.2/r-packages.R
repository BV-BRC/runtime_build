options(Ncpus = 12)
install.packages ("ggplot2", repos = "http://cran.wustl.edu")
install.packages ("svglite", repos = "http://cran.wustl.edu")
install.packages ("gridExtra", repos = "http://cran.wustl.edu")
install.packages ("reshape2", repos = "http://cran.wustl.edu")
install.packages ("BiocManager", repos = "http://cran.wustl.edu")
install.packages ("gridExtra", repos = "http://cran.wustl.edu")
install.packages ("svglite", repos = "http://cran.wustl.edu")
install.packages ("argparse", repos = "http://cran.wustl.edu")
install.packages ("DT", repos = "http://cran.wustl.edu")
install.packages ("htmlwidgets", repos = "http://cran.wustl.edu")
install.packages ("promises", repos = "http://cran.wustl.edu")

install.packages ("remotes", repos = "http://cran.wustl.edu")
remotes::install_github("fbreitwieser/pavian")
remotes::install_github("rstudio/httpuv")

BiocManager::install(version = '3.15', ask = FALSE)
BiocManager::install(c( "DESeq2",
    "ComplexHeatmap",
    "EnhancedVolcano",
    "Biobase",
    "edgeR",
    "limma",
    "pcaMethods",
    "qvalue",
    "impute"));
