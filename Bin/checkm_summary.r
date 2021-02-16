## ---------------------------
##
## Script name: checkm_summary.r
##
## Purpose of script: Create a plot of bin quality
##
## Part of metagenomic-bin-processor
##
## Author: Gisle Vestergaard
##
## Date Created: 10-02-2021
##
## Email: gislevestergaard@gmail.com
##
## ---------------------------
## load up the packages we will need:
require(tidyverse)
## ---------------------------
## setwd("?")
file.exists("plot_binsizes.png")
file.remove("plot_binsizes.png")
args = commandArgs(trailingOnly=TRUE)
bins <- readr::read_tsv(args[1], col_names = TRUE)
bins_rounded <- bins %>% mutate_if(is.numeric, round)
bins_rounded$Quality <- "<10% contamination"
bins_rounded$Quality[bins$Contamination < 10] <- ">10% contamination"
bins_rounded$Quality[bins$Contamination < 5] <- ">5% contamination"
bins_rounded$Quality[bins$Contamination < 1] <- ">1% contamination"
bins_rounded$Quality <- factor(bins_rounded$Quality, levels = c(">10% contamination", "<10% contamination", ">5% contamination", ">1% contamination"))
ggplot(bins_rounded, aes(x = Completeness, fill = Quality)) + geom_area(binwidth = 1, stat = "bin")
ggsave(paste(dirname(args[1]), "plot_binsizes.png", sep = "/"), width = 5, height = 5)
file.exists("Rplots.pdf")
file.remove("Rplots.pdf")
