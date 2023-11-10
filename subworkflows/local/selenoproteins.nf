

include { RAPID } from '../../modules/local/rapid.nf'
include { selenoprofiles } from '../../modules/local/selenoprofiles.nf'

workflow selenoproteins {

    take:
        species
        accession

    main:
        fasta_ch                =   RAPID(species, accession)
        selenoproteins_ch       =   selenoprofiles(fasta_ch, species)

    
    emit:
        fasta_ch
}