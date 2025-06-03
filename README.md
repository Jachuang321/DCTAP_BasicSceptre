# DC-TAP Basic Sceptre Workflow: Analyzing Unbiased TAP-Seq Screens

**This repository is worked in progress.**

Note that this codebase is largely adapted from J. Galente’s
[DCTAP-seq Paper](https://github.com/jamesgalante/DC_TAP_Paper)
process_validation_datasets pipeline.

## Installation

To being, clone the repo and setup your environment.

```bash
git clone https://github.com/Jachuang321/DCTAP_BasicSceptre.git
```

### Miniconda3

Create a Conda Environment with
[Snakemake]("https://snakemake.readthedocs.io/en/stable/")
.

```bash
conda create -n sceptre -c conda-forge -c bioconda snakemake=9.3.0 python=3.12
conda activate sceptre
```

If you need to install miniconda see
[anaconda.com]("https://www.anaconda.com/docs/getting-started/miniconda/install")
.

## Usage

### Running the Pipeline

To execute the pipeline, run the following commands from the root directory
of the project:

1. **Dry Run**

   It's good practice to perform a dry run to ensure that the pipeline is
   configured correctly and all files are in place.

   ```bash
   snakemake --use-conda all -np
   ```

   This command will show you what steps the pipeline will perform without
   actually executing them.

2. **Full Run**

   If the dry run looks correct, execute the pipeline:

   ```bash
   snakemake --use-conda all
   ```

   _Note:_ The `--use-conda` flag tells Snakemake to create and use the
   necessary conda environments for each rule.

   _Note:_ See the relevant documentation
   [Snakemake Documentation](https://snakemake.readthedocs.io/en/stable/index.html)
   to understand what flags might be necessary.
