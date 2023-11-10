
# Ensembl-Selenprotiens
## Introduction 

Annotation of Selenoproteins using [Selenoprofiles](https://github.com/marco-mariotti/selenoprofiles4)

## Requirements 
This pipeline can be run using singularity: 

| Method      | Instructions                                                                                   |
| ----------- | ---------------------------------------------------------------------------------------------- |
| Singularity | [docs.syslabs.io](https://docs.sylabs.io/guides/3.0/user-guide/installation.html)              |


## Usage
Two singularity containers require building prior to execution.
```
sudo singularity build singularity/selenoprofiles.sif singularity/Selenoprofiles
sudo singularity build singularity/assess.sif singularity/Assess
```
Then as the profile `singularity` specifies `container = 'singularity/pipeline'` use the following to execute:
```
nextflow run main.nf -profile singularity
```
