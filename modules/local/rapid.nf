

process RAPID {
    
    // errorStrategy  { task.attempt <= maxRetries  ? 'retry' :  'ignore' }
    
    container "$projectDir/singularity/rapid.sif"

    maxForks 1

    input:
        tuple val(species), val(accession), val(clade)
        val(filetype)

    output:
        path("*"), emit: file
        tuple val(species), val(accession), val(clade), emit: meta

    script:
        """
        python $projectDir/scripts/rapid_fetch.py -s '${species}' -a '${accession}' --file-type '${filetype}'
        gzip -d *.gz
        """
}