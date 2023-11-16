

process selenoprofiles {

    publishDir "data/selenoprofiles/${species_out}_${accession}", mode: 'copy', overwrite: true
    
    container "$projectDir/singularity/selenoprofiles.sif"

    errorStrategy  { task.attempt <= maxRetries  ? 'retry' :  'ignore' }

    maxForks 20
    time '9h'
    
    input:
        file(genome_fasta)
        tuple val(species), val(accession), val(clade)
        file(genome_gtf)
        
    output:
        path "*_selenoprofiles_annotations.gtf", emit: prediction
        path genome_gtf, emit: ref_gtf
        path genome_fasta, emit: ref_fasta
        tuple val(species), val(accession), val(clade), emit: meta

    script:
        species_out = species.replaceAll(' ', '_')
        """
        selenoprofiles -o outputs -t $genome_fasta -s "$species" -p  $clade,machinery -output_gtf_file ${species_out}_${accession}_selenoprofiles_annotations.gtf
        """
}