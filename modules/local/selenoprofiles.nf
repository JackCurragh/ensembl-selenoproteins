

process selenoprofiles {

    publishDir '$params.outdir', mode: 'copy', overwrite: true
    
    container "$projectDir/singularity/selenoprofiles.sif"

    input:
        file(genome_fasta)
        val(species)

    output:
        file "*.gtf"

    script:
        """
        selenoprofiles -o ouputs -t $genome_fasta -s $species -p  ${params.clade},machinery -output_gtf_file all_annotations.gtf
        """
}