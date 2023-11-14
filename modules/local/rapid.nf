

process RAPID {
    
    container "$projectDir/singularity/rapid.sif"

    input:
        tuple val(species), val(accession), val(clade)
        val(filetype)

    output:
        path("*")

    script:
        """
        python $projectDir/scripts/rapid_fetch.py -s '${species}' -a '${accession}' --file-type '${filetype}'
        gzip -d *.gz
        """
}