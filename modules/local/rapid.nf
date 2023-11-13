

process RAPID {

    container "$projectDir/singularity/rapid.sif"

    input:
        val(species)
        val(accession)
        val(filetype)

    output:
        file "*"

    script:
        """
        python $projectDir/scripts/rapid_fetch.py -s '${species}' -a '${accession}' --file-type '${filetype}'
        gzip -d *.gz
        """

}