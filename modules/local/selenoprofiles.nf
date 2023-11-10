

process selenoprofiles {

    publishDir 'data/', mode: 'copy', overwrite: true
    
    container "$projectDir/singularity/selenoprofiles.sif"

    input:
        file(genome_fasta)
        val(species)

    output:
        file "*.gtf"

    script:
        """
        selenoprofiles -o outputs -t $genome_fasta -s $species -p  ${params.clade},machinery -output_gtf_file all_annotations.gtf
        """
}