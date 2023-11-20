

include { RAPID } from '../../modules/local/rapid.nf'
include { selenoprofiles } from '../../modules/local/selenoprofiles.nf'
include { assess } from '../../modules/local/assess.nf'

workflow selenoproteins {

    take:
        input_ch

    main:
        rapid_ch                =   RAPID(input_ch)
        // selenoproteins_ch       =   selenoprofiles(rapid_ch.meta, rapid_ch.fasta, rapid_ch.gtf)

        // assess_ch               =   assess(selenoproteins_ch.ref_fasta, selenoproteins_ch.prediction, selenoproteins_ch.ref_gtf, selenoproteins_ch.meta)
}
