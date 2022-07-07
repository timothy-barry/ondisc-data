# creates example R matrices containing gene and grna single-cell data. Converts these matrices into ODM format.
gasp_offsite <- paste0(.get_config_path("LOCAL_GASPERINI_2019_V2_DATA_DIR"), "at-scale/processed/")

gene_odm <- read_odm(odm_fp = paste0(gasp_offsite, "gene/matrix.odm"),
                     metadata_fp = paste0(gasp_offsite, "gene/metadata.rds"))
grna_assignment_odm <- read_odm(odm_fp = paste0(gasp_offsite, "grna_assignment/matrix.odm"),
                                metadata_fp = paste0(gasp_offsite, "grna_assignment/metadata.rds"))
grna_expression_odm <- read_odm(odm_fp = paste0(gasp_offsite, "grna_expression/matrix.odm"),
                                metadata_fp = paste0(gasp_offsite, "grna_expression/metadata.rds"))

# extract 2000 cells
set.seed(10)
barcodes_to_extract <- sort(sample(x = seq(1, ncol(gene_odm)), size = 2000, replace = FALSE))

gene_odm <- gene_odm[,barcodes_to_extract]
grna_assignment_odm <- grna_assignment_odm[,barcodes_to_extract]
grna_expression_odm <- grna_expression_odm[,barcodes_to_extract]

# get gene barcodes and features
save_as_matrix_and_odm <- function(odm, modality) {
  mat <- odm[[1:nrow(odm),]]
  mat <- if (modality == "grna_assignment") as(mat, "lgTMatrix") else as(mat, "dgTMatrix")
  feature_df <- data.frame(gene_id = get_feature_ids(odm))
  barcodes <- get_cell_barcodes(odm)
  # matrix portion
  saveRDS(object = mat, paste0(ondiscdata_dir, "r_matrix/", modality, "/matrix.rds"))
  saveRDS(object = barcodes, paste0(ondiscdata_dir, "r_matrix/", modality, "/barcodes.rds"))
  saveRDS(object = feature_df, paste0(ondiscdata_dir, "r_matrix/", modality, "/features.rds"))

  # odm portion
  odm_new <- create_ondisc_matrix_from_R_matrix(r_matrix = mat,
                                                barcodes = barcodes,
                                                features_df = feature_df,
                                                odm_fp = paste0(ondiscdata_dir, "odm/", modality, "/matrix.odm"),
                                                metadata_fp = paste0(ondiscdata_dir, "odm/", modality, "/metadata.rds"))
  odm_new <- odm_new |>
    ondisc::mutate_feature_covariates(ondisc::get_feature_covariates(odm)) |>
    ondisc::mutate_cell_covariates(ondisc::get_cell_covariates(odm))
  ondisc::save_odm(odm = odm_new, metadata_fp = paste0(ondiscdata_dir, "odm/", modality, "/metadata.rds"))
}

save_as_matrix_and_odm(gene_odm, "gene")
save_as_matrix_and_odm(grna_assignment_odm, "grna_assignment")
save_as_matrix_and_odm(grna_expression_odm, "grna_expression")
