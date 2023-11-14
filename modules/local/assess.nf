

process assess {
    publishDir "data/selenoprofiles", mode: 'copy', overwrite: true

    container "$projectDir/singularity/assess.sif"

    input:
        file(genome_fasta)
        file(selenoprofiles_gtf)
        file(genome_gtf)

    output:
        file "${species_out}_${accession}_Ensembl_transcript.csv"
        file "${species_out}_${accession}_aggregated.csv"

    script:
        species_out = ${params.species}.replaceAll(' ', '_')
        """
        python $projectDir/scripts/checking_annotations.py \\
            -s $selenoprofiles_gtf \\
            -e $genome_gtf \\
            -f $genome_fasta \\
            -o ${species_out}_${accession}_Ensembl_transcript.csv \\
            -agg ${species_out}_${accession}_aggregated.csv \\
            -cg transcript_id

        """
}