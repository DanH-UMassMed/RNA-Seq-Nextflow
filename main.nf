#!/usr/bin/env nextflow 


if(params.run_get_dropbox_data) {
  include { GET_EXPERIMENT_DATA } from "./workflows/01-get-dropbox-data"
}

if(params.run_create_star_rsem_index) {
  include { CREATE_STAR_RSEM_INDEX } from "./workflows/00-create-star-rsem-index"
}

if(params.run_create_salmon_index) {
  include { CREATE_SALMON_INDEX } from "./workflows/00-create-salmon-index"
}

if(params.run_fastqc) {
  include { RUN_FASTQC } from "./workflows/02-run-fastqc"
}

if(params.run_trimmomatic) {
  include { RUN_TRIMMOMATIC } from "./workflows/03-run-trimmomatic"
}

if(params.run_rnaseq_rsem) {
  include { RUN_RNASEQ_RSEM } from "./workflows/04-run-rnaseq-rsem"
}

if(params.run_rnaseq_salmon) {
  include { RUN_RNASEQ_SALMON } from "./workflows/04-run-rnaseq-salmon"
}

if(params.run_deseq_rsem) {
  include { RUN_DESEQ_RSEM } from "./workflows/05a-run-deseq-rsem"
}

if(params.run_deseq_rsem_report) {
  include { RUN_DESEQ_RSEM_REPORT } from "./workflows/05b-run-deseq-rsem-report"
}

if(params.run_wormcat) {
  include { RUN_WORMCAT } from "./workflows/06-run-wormcat"
}

if(params.run_overview_report) {
  include { RUN_OVERVIEW_REPORT } from "./workflows/07-run-overview-report"
}

WorkflowUtils.initialize(params, log)

workflow {
  //HELLOWORLD("hello")
  if(params.run_create_star_rsem_index ) {
    log.info("Running Create Star rsem index")
    CREATE_STAR_RSEM_INDEX() 
  }

  if(params.run_create_salmon_index ) {
    log.info("Running Salmon index")
    CREATE_SALMON_INDEX() 
  }

  if(params.run_get_dropbox_data == true) {
    log.info("Running Get Experiment Data")
    GET_EXPERIMENT_DATA()
  }

  if(params.run_fastqc == true) {
    log.info("Running Get Experiment Data")
    RUN_FASTQC()
  }

  if(params.run_trimmomatic == true) {
    log.info("Running Trimmomatic")
    RUN_TRIMMOMATIC()
  }

  if(params.run_rnaseq_rsem == true) {
    log.info("Running RNA Seq RSEM")
    RUN_RNASEQ_RSEM()
  }

  if(params.run_rnaseq_salmon == true) {
    log.info("Running RNA Seq Salmon")
    RUN_RNASEQ_SALMON()
  }

  if(params.run_deseq_rsem == true) {
    log.info("Running DESeq RSEM")
    RUN_DESEQ_RSEM()
  }

  if(params.run_deseq_rsem_report == true) {
    log.info("Running DESeq RSEM Report")
    RUN_DESEQ_RSEM_REPORT()
  }

  if(params.run_wormcat) {
    log.info("Running Wormcat")
    RUN_WORMCAT()
  }

  if(params.run_overview_report) {
    log.info("Running Overview Report")
    RUN_OVERVIEW_REPORT()
  }



}

