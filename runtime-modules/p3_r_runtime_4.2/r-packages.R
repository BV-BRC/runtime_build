options(Ncpus = 12)
<<<<<<< HEAD
install.packages ("ggplot2", repos = "https://cloud.r-project.org")
install.packages ("svglite", repos = "https://cloud.r-project.org")
install.packages ("gridExtra", repos = "https://cloud.r-project.org")
install.packages ("reshape2", repos = "https://cloud.r-project.org")
install.packages ("BiocManager", repos = "https://cloud.r-project.org")
install.packages ("gridExtra", repos = "https://cloud.r-project.org")
install.packages ("svglite", repos = "https://cloud.r-project.org")
install.packages ("argparse", repos = "https://cloud.r-project.org")
install.packages ("DT", repos = "https://cloud.r-project.org")
install.packages ("pandoc", repos = "https://cloud.r-project.org")
install.packages ("plyr", repos = "https://cloud.r-project.org")
install.packages ("htmlwidgets", repos = "https://cloud.r-project.org")
install.packages ("promises", repos = "https://cloud.r-project.org")

install.packages ("remotes", repos = "https://cloud.r-project.org")
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
