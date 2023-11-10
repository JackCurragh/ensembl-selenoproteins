

include { RAPID as RAPID_FASTA  } from '../../modules/local/rapid.nf'
include { RAPID as RAPID_GTF  } from '../../modules/local/rapid.nf'
include { selenoprofiles } from '../../modules/local/selenoprofiles.nf'
include { assess } from '../../modules/local/assess.nf'

workflow selenoproteins {

    take:
        species
        accession

    main:
        fasta_ch                =   RAPID_FASTA(species, accession, 'fasta')
        gtf_ch                  =   RAPID_GTF(species, accession, 'gtf')
        selenoproteins_ch       =   selenoprofiles(fasta_ch, species)
        assess_ch               =   assess(fasta_ch, selenoproteins_ch, gtf_ch, )

    emit:
        fasta_ch
}