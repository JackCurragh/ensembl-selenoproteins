

include { RAPID as RAPID_FASTA  } from '../../modules/local/rapid.nf'
include { RAPID as RAPID_GTF  } from '../../modules/local/rapid.nf'
include { selenoprofiles } from '../../modules/local/selenoprofiles.nf'
include { assess } from '../../modules/local/assess.nf'

workflow selenoproteins {

    take:
        input_ch

    main:
        fasta_ch                =   RAPID_FASTA(input_ch, 'fasta')
        gtf_ch                  =   RAPID_GTF(fasta_ch.meta, 'gtf')
        selenoproteins_ch       =   selenoprofiles(fasta_ch.file, input_ch, gtf_ch.file)
        selenoproteins_ch.meta.view()
        assess_ch               =   assess(fasta_ch.file, selenoproteins_ch.prediction, selenoproteins_ch.ref_gtf, selenoproteins_ch.meta)
}
