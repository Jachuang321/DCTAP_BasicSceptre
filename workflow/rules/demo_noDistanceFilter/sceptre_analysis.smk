# Snakemake rules to run basic analysis using Sceptre

# Run sceptre differential expression with "union"
rule sceptre_differential_expression_demo_noDistanceFilter:
  input:
    sceptre_diffex_input = "results/sceptre_setup/demo_noDistanceFilter/{sample}/differential_expression/sceptre_diffex_input.rds"
  output:
    discovery_results = "results/sceptre_setup/demo_noDistanceFilter/{sample}/differential_expression/results_run_discovery_analysis.rds",
    final_sceptre_object = "results/sceptre_setup/demo_noDistanceFilter/{sample}/differential_expression/final_sceptre_object.rds"
  log: "results/sceptre_setup/demo_noDistanceFilter/{sample}/logs/sceptre_differential_expression_demo_noDistanceFilter_{sample}.log"
  conda:
    "../../envs/all_packages.yml"
  resources:
    mem = "32G",
    time = "12:00:00"
  script:
    "../../scripts/sceptre_analysis/sceptre_differential_expression.R"
