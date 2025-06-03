# Script: # Script: create_sceptre_diffex_input_JR89_WTC11_DE_SCREEN.R

### SETUP =====================================================================

# Saving image for debugging
save.image(paste0("RDA_objects/create_sceptre_diffex_input_WTC11_DC_TAP_Seq.rda"))
message("Saved Image")
# stop("Manually Stopped Program after Saving Image")

# Open log file to collect messages, warnings, and errors
log_filename <- snakemake@log[[1]]
log <- file(log_filename, open = "wt")
sink(log)
sink(log, type = "message")


### LOADING FILES =============================================================

message("Loading in packages")
suppressPackageStartupMessages({
  library(sceptre)
  library(tidyverse)
  library(data.table)
  library(rtracklayer)
  library(GenomicRanges)
  source(file.path(snakemake@scriptdir, "gene_target_pairing_functions_20240807_VEGFA_TAP_06.R"))
})

message("Loading input files")
# Import the main counts data matrix
dge <- readRDS(snakemake@input$dge)
# Import the perturbation status dataframe
perturb_status <- readRDS(snakemake@input$perturb_status)
# Import the annotation file
annot <- import(snakemake@input$annot)
# Import the gRNA_groups_table file
gRNA_groups_table <- read_tsv(snakemake@input$gRNA_groups_table)
# Import the gene_gRNA_group_pairs file
gene_gRNA_group_pairs <- read_tsv(snakemake@input$gene_gRNA_group_pairs)

### CREATE THE METADATA FILE ==================================================

# Create the metadata indicating the batch for each cell barcode
cell_barcode <- colnames(dge)
cell_batches <- as.factor(str_extract(cell_barcode, "\\d+$"))

# Create the metadata dataframe
metadata <- data.frame(row.names = cell_barcode, batch = cell_batches)


### CREATE SCEPTRE OBJECT =====================================================

# Create sceptre_object
sceptre_object <- import_data(
  response_matrix = dge,
  grna_matrix = perturb_status,
  grna_target_data_frame = gRNA_groups_table,
  moi = "low",
)

# Set analysis parameters
sceptre_object <- set_analysis_parameters(
  sceptre_object = sceptre_object,
  discovery_pairs = gene_gRNA_group_pairs,
  side = "both",
  grna_integration_strategy = "union",
)

print(sceptre_object)


### SAVE OUTPUT ===============================================================

# Save output files
message("\nSaving output files")
saveRDS(gene_gRNA_group_pairs, snakemake@output$gene_gRNA_group_pairs)
saveRDS(gRNA_groups_table, snakemake@output$gRNA_groups_table)
saveRDS(metadata, snakemake@output$metadata)
saveRDS(sceptre_object, snakemake@output$sceptre_diffex_input)


### CLEAN UP ==================================================================

message("Closing log file")
sink()
sink(type = "message")
close(log)