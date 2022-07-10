# Run this script to create all package data
# Note: this script requires the Xie offsite directory to be present
library(ondisc)
ondiscdata_code <- paste0(.get_config_path("LOCAL_CODE_DIR"), "ondiscdata/data-raw/")
ondiscdata_dir <- paste0(.get_config_path("LOCAL_CODE_DIR"), "ondiscdata/inst/extdata/")
xie_dir <- .get_config_path("LOCAL_XIE_2019_DATA_DIR")

dirs_to_create <- c("h5_list",
                    "mtx",
                    "mtx_list/mtx_dir1",
                    "mtx_list/mtx_dir2",
                    "mtx_list/mtx_dir3",
                    "odm/grna_expression",
                    "odm/grna_assignment",
                    "odm/gene",
                    "r_matrix/grna_expression",
                    "r_matrix/grna_assignment",
                    "r_matrix/gene")
for (dir_to_create in dirs_to_create) {
  curr_dir <- paste0(ondiscdata_dir, dir_to_create)
  if (!dir.exists(curr_dir)) dir.create(path = curr_dir, recursive = TRUE)
}

# 1. create the list of synthetic mtx files
source(paste0(ondiscdata_code, "create_mtx_list.R"))

# 2. copy three h5 files from the "raw" directory of the Xie offsite directory to the ondiscdata h5_list directory
cmds <- paste0("cp ", paste0(xie_dir, "raw/", c("GSM3722729_K562-dCas9-KRAB_5K-sgRNAs_Batch-1_1_filtered_gene_bc_matrices_h5.h5",
                                                "GSM3722730_K562-dCas9-KRAB_5K-sgRNAs_Batch-1_2_filtered_gene_bc_matrices_h5.h5",
                                                "GSM3722731_K562-dCas9-KRAB_5K-sgRNAs_Batch-2_1_filtered_gene_bc_matrices_h5.h5"), " ", paste0(ondiscdata_dir, "h5_list/"),
                             c("batch-1_1.h5", "batch-1_2.h5", "batch_2-1.h5")))
for (cmd in cmds) system(cmd)

# 3. download sample mtx data from 10x
mtx_dir <- paste0(ondiscdata_dir, "mtx/")
dest_f <- paste0(mtx_dir, "mat.tar.gz")
download.file(url = "https://cf.10xgenomics.com/samples/cell/pbmc3k/pbmc3k_filtered_gene_bc_matrices.tar.gz",
              destfile = dest_f)
untar(tarfile = dest_f, exdir = mtx_dir)
cmds <- paste0("mv ", mtx_dir, paste0("filtered_gene_bc_matrices/hg19/", c("barcodes.tsv", "genes.tsv", "matrix.mtx")), " ", mtx_dir)
for (cmd in cmds) system(cmd)
cmds <- paste0("rm -rf ", mtx_dir, c("filtered_gene_bc_matrices", "mat.tar.gz"))
for (cmd in cmds) system(cmd)
cmd <- paste0("mv ", mtx_dir, "genes.tsv ", mtx_dir, "features.tsv")
system(cmd)

# 4. create R matrices and ODMs using the processed Gasperini data
source(paste0(ondiscdata_code, "create_r_matrices_and_odms.R"))
