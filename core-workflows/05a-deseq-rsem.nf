#!/usr/bin/env nextflow 


log.info """\
 R N A S E Q - N F   P I P E L I N E
 ===================================
 deseq_meta    : ${params.deseq_meta}
 rsem_counts   : ${params.rsem_counts}
 low_count_max : ${params.low_count_max}
 results_dir   : ${params.results_dir}
 """

// import modules
include { LOW_COUNT_FILTER; DESEQ_EXEC } from "${launchDir}/modules/de-seq-tools"

/* 
 * main script flow
 */
workflow {
  counts_ch = channel.value( params.rsem_counts ) 
  deseq_meta_ch = channel.fromPath( params.deseq_meta, checkIfExists: true ) 
  LOW_COUNT_FILTER( counts_ch, params.low_count_max )
  DESEQ_EXEC( LOW_COUNT_FILTER.out.low_count_file, deseq_meta_ch )
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Open the following report in your browser --> ${params.results_dir}/multiqc_rsem_report.html\n" : "Oops .. something went wrong" )
}
