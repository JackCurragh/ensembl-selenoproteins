nextflow.enable.dsl = 2

include { selenoproteins } from './subworkflows/local/selenoproteins.nf'

log.info """\

    m i R N A    N F    P I P E L I N E
    =========================================
    species: ${params.species}
    accessions: ${params.accession}
    clade: ${params.clade}
    =========================================
"""



workflow {
    selenoproteins(params.species, params.accession, params.clade)
}

workflow.onComplete {
    log.info "Pipeline completed at: ${new Date().format('dd-MM-yyyy HH:mm:ss')}"
}
