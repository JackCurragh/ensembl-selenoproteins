

process selenoprofiles {

    publishDir "data/selenoprofiles", mode: 'copy', overwrite: true
    
    container "$projectDir/singularity/selenoprofiles.sif"

    input:
        file(genome_fasta)
        tuple val(species), val(accession), val(clade)
        file(genome_gtf)
        
    output:
        path "*_selenoprofiles_annotations.gtf", emit: prediction
        path genome_gtf, emit: ref_gtf

    script:
        species_out = species.replaceAll(' ', '_')
        """
        selenoprofiles -o outputs -t $genome_fasta -s "$species" -p  $clade,machinery -output_gtf_file ${species_out}_${accession}_selenoprofiles_annotations.gtf
        """
}