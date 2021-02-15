#!/usr/bin/env Rscript
## ---------------------------
##
## Script name: biopieces_fasta_select_file_size.r
##
## Purpose of script: Create a plot of all bin sizes
##
## Part of Biopythonpieces
##
## Author: Gisle Vestergaard
##
## Date Created: 02-02-2021
##
## Email: gislevestergaard@gmail.com
##
## ---------------------------
## load up the packages we will need:
require(tidyverse)
## ---------------------------
## setwd("?")
args = commandArgs(trailingOnly=TRUE)
bins <- read_delim(args[1], "\t", col_names = FALSE)
ggplot(data=bins, aes(X2)) + geom_histogram(binwidth = 1000) + xlab("Bin size in bp") + coord_cartesian(ylim=c(0,20), xlim=c(0,10000000)) + theme_bw() + geom_vline(xintercept = as.numeric(args[2]), linetype="dotted", color = "red", size=1)
ggsave("plot_binsizes.png")
file.exists("Rplots.pdf")
file.remove("Rplots.pdf")
