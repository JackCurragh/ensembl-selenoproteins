

process RAPID {
    
    // errorStrategy  { task.attempt <= maxRetries  ? 'retry' :  'ignore' }
    
    container "$projectDir/singularity/rapid.sif"

    maxForks 20

    input:
        tuple val(species), val(accession), val(clade)

    output:
        tuple val(accession), path("*.fa*"), emit: fasta
        tuple val(accession), path("*.gtf*"), emit: gtf
        tuple val(species), val(accession), val(clade), emit: meta

    script:
        """
        python $projectDir/scripts/rapid_fetch.py -s '${species}' -a '${accession}' --file-type 'gtf'
        python $projectDir/scripts/rapid_fetch.py -s '${species}' -a '${accession}' --file-type 'fasta'

        gzip -d *.gz
        """
}