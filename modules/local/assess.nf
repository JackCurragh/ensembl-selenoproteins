

process assess {
    publishDir "data/${genome_fasta.baseName}", mode: 'copy', overwrite: true

    container "$projectDir/singularity/assess.sif"

    input:
        file(genome_fasta)
        file(selenoprofiles_gtf)
        file(genome_gtf)

    output:
        file 'Ensembl_transcript.csv'
        file 'aggregated.csv'


    script:
        """
        python $projectDir/scripts/checking_annotations.py \\
            -s $selenoprofiles_gtf \\
            -e $genome_gtf \\
            -f $genome_fasta \\
            -o Ensembl_transcript.csv \\
            -agg aggregated.csv \\
            -cg transcript_id

        """
}