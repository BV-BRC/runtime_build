options(Ncpus = 12)
install.packages ("ggplot2", repos = "https://cran.wustl.edu")
install.packages ("svglite", repos = "https://cran.wustl.edu")
install.packages ("gridExtra", repos = "https://cran.wustl.edu")
install.packages ("reshape2", repos = "https://cran.wustl.edu")
install.packages ("BiocManager", repos = "https://cran.wustl.edu")
install.packages ("gridExtra", repos = "https://cran.wustl.edu")
install.packages ("svglite", repos = "https://cran.wustl.edu")
install.packages ("argparse", repos = "https://cran.wustl.edu")
install.packages ("DT", repos = "https://cran.wustl.edu")
install.packages ("pandoc", repos = "https://cran.wustl.edu")
install.packages ("plyr", repos = "https://cran.wustl.edu")
install.packages ("htmlwidgets", repos = "https://cran.wustl.edu")
install.packages ("promises", repos = "https://cran.wustl.edu")
install.packages ("Cairo", repos = "https://cran.wustl.edu")

install.packages ("remotes", repos = "https://cran.wustl.edu")
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
