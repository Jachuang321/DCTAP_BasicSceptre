# download gencode annotations
rule download_gencode_v32lift37_DC_TAP:
  output: "resources/sceptre_setup/demo/external_refs/gencode.v32lift37.annotation.gtf.gz"
  params:
    url = "https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_32/GRCh37_mapping/gencode.v32lift37.annotation.gtf.gz"
  conda: "../../envs/r_process_crispr_data.yml"
  shell:
    "wget -O {output} {params.url}"

# Process Cell Ranger Outputs
rule process_cell_ranger_outputs_demo_noDistanceFilter:
  input:
    cell_ranger_directory = "resources/sceptre_setup/demo_noDistanceFilter/{sample}/cell_ranger_output/"
  output:
    guide_matrix = "results/sceptre_setup/demo_noDistanceFilter/{sample}/raw_counts/perturb_status.rds",
    gene_matrix = "results/sceptre_setup/demo_noDistanceFilter/{sample}/raw_counts/dge.rds"
  log: "results/sceptre_setup/demo_noDistanceFilter/{sample}/logs/process_cell_ranger_outputs_demo_noDistanceFilter_{sample}.log"
  conda:
    "../../envs/seurat_for_cell_ranger_outputs.yml"
  resources:
    mem = "64G",
    time = "2:00:00"
  script:
    "../../scripts/process_validation_datasets/sceptre_setup/process_cell_ranger_outputs_demo_noDistanceFilter.R"
    
rule create_sceptre_diffex_input_demo_noDistanceFilter:
  input:
    dge = "results/sceptre_setup/demo_noDistanceFilter/{sample}/raw_counts/dge.rds",
    perturb_status = "results/sceptre_setup/demo_noDistanceFilter/{sample}/raw_counts/perturb_status.rds",
    gRNA_groups_table = "resources/sceptre_setup/demo_noDistanceFilter/guide_targets/demo_noDistanceFilter_grna_table.tsv",
    gene_gRNA_group_pairs = "resources/sceptre_setup/demo_noDistanceFilter/guide_targets/demo_noDistanceFilter_gRNA_group_pairs.tsv",
    annot = "resources/sceptre_setup/demo/external_refs/gencode.v32lift37.annotation.gtf.gz"
  output:
    gene_gRNA_group_pairs = "results/sceptre_setup/demo_noDistanceFilter/{sample}/gene_gRNA_group_pairs.rds",
    gRNA_groups_table = "results/sceptre_setup/demo_noDistanceFilter/{sample}/gRNA_groups_table.rds",
    metadata = "results/sceptre_setup/demo_noDistanceFilter/{sample}/metadata.rds",
    sceptre_diffex_input = "results/sceptre_setup/demo_noDistanceFilter/{sample}/differential_expression/sceptre_diffex_input.rds",
  params:
    negative_control_genes = lambda wildcards: config["sceptre_setup"]["negative_controls"][wildcards.sample]
  log: "results/sceptre_setup/demo_noDistanceFilter/{sample}/logs/create_sceptre_diffex_input_demo_noDistanceFilter_{sample}.log"
  conda:
    "../../envs/all_packages.yml"
  resources:
    mem = "64G",
    time = "2:00:00"
  script:
    "../../scripts/process_validation_datasets/sceptre_setup/create_sceptre_diffex_input_demo_noDistanceFilter.R"
