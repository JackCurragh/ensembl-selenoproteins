

include { RAPID as RAPID_FASTA  } from '../../modules/local/rapid.nf'
include { RAPID as RAPID_GTF  } from '../../modules/local/rapid.nf'
include { selenoprofiles } from '../../modules/local/selenoprofiles.nf'
include { assess } from '../../modules/local/assess.nf'

workflow selenoproteins {

    take:
        species
        accession
        clade

    main:
        fasta_ch                =   RAPID_FASTA(species, accession, clade, 'fasta')
        gtf_ch                  =   RAPID_GTF(species, accession, clade, 'gtf')
        selenoproteins_ch       =   selenoprofiles(fasta_ch, species, accession, clade)
        assess_ch               =   assess(fasta_ch, selenoproteins_ch, gtf_ch)
}
