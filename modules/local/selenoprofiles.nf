

process selenoprofiles {

    publishDir "data/selenoprofiles", mode: 'copy', overwrite: true
    
    container "$projectDir/singularity/selenoprofiles.sif"

    input:
        file(genome_fasta)
        val(species)
        val(accession)
        val(clade)
        
    output:
        file "*.gtf"

    script:
        """
        selenoprofiles -o outputs -t $genome_fasta -s $species -p  $clade,machinery -output_gtf_file ${species}_${accession}_selenoprofiles_annotations.gtf
        """
}