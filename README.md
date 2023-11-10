
# Ensembl-Selenprotiens
## Introduction 

Annotation of Selenoproteins using [Selenoprofiles](https://github.com/marco-mariotti/selenoprofiles4)

## Requirements 
This pipeline can be run using each of the following container methods
| Method      | Instructions                                                                                   |
| ----------- | ---------------------------------------------------------------------------------------------- |
| Singularity | [docs.syslabs.io](https://docs.sylabs.io/guides/3.0/user-guide/installation.html)              |
| Docker      | [docs.docker.com](https://docs.docker.com/engine/install/)                                     |
| Conda       | [docs.conda.io](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html)  |


## Setup
##### Singularity
```
sudo singularity build singularity/selenoprofiles.sif Singularity
```
Then as the profile `singularity` specifies `container = 'singularity/pipeline'` use the following to execute:
```
nextflow run main.nf -profile singularity
```

## Usage
Call the pipeline directly
```
nextflow run main.nf
```

Run with all the frills
```
bash scripts/run-w-frills <params-file> <profile name from nextflow.config>
```
Example
```
bash scripts/run-w-frills example_parameters.yml standard
```

