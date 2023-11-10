nextflow.enable.dsl = 2

include { selenoproteins } from './subworkflows/local/selenoproteins.nf'

log.info """\

    m i R N A    N F    P I P E L I N E
    =========================================
    species: ${params.species}
    accession: ${params.accession}
    clade: ${params.clade}
    =========================================
"""

workflow {
    selenoproteins(params.species, params.accession)
}

workflow.onComplete {
    log.info "Pipeline completed at: ${new Date().format('dd-MM-yyyy HH:mm:ss')}"
}
