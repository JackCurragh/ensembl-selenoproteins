

process RAPID {
    
    errorStrategy  { task.attempt <= maxRetries  ? 'retry' :  'ignore' }
    
    container "$projectDir/singularity/rapid.sif"

    publishDir "data/", mode: 'copy'

    maxForks 20

    input:
        tuple val(species), val(accession), val(clade)

    output:
        tuple val(accession), path("*.fa*"), emit: fasta, optional: true
        tuple val(accession), path("*.gtf*"), emit: gtf, optional: true
        tuple val(species), val(accession), val(clade), emit: meta

    script:
        """
        python $projectDir/scripts/rapid_fetch.py -s '${species}' -a '${accession}' --file-type 'gtf' --write-url
        # python $projectDir/scripts/rapid_fetch.py -s '${species}' -a '${accession}' --file-type 'fasta'

        # gzip -d *.gz
        """
}