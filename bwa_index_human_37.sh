#!/bin/sh
#PJM -L rscgrp=cx-share
#PJM -L elapse=2:00:00
#PJM -L jobenv=singularity
#PJM -j
#PJM -s

LOGIN_NODE_EXEC_DIR="/home/z44331r/"

login_node_out_dir=${LOGIN_NODE_EXEC_DIR} # LOGIN_NODE_EXEC_DIR='2107241442_E100009254'; SAMPLE_NAME='B000209'
exec_node_out_dir=${PJM_LOCALDIR}

SINGULARITY_CONTAINER="/home/z44331r/furo_ngs/singularity_containers/Germline_pipeline_v0.12.sif"
singularity_bind_path=${PJM_LOCALDIR}
REF_ORIGIN_DIR="/home/z44331r/furo_ngs/references/human/b37_decoy/"
REF_FASTA="b37_decoy/human_g1k_v37_decoy.fasta"
_1KG_INDELS="b37_decoy/1000G_phase1.indels.b37.vcf"
_GOLD_STD_INDELS="b37_decoy/Mills_and_1000G_gold_standard.indels.b37.vcf"

ADAPTOR_FASTA="b37_decoy/adapters_${ADAPTOR}.fa"

cp -r ${REF_ORIGIN_DIR} ${PJM_LOCALDIR}
cp -r ${SINGULARITY_CONTAINER} ${PJM_LOCALDIR}

cd ${PJM_LOCALDIR}
module load singularity

#PJM_LOCALDIR（/local/jobID)のときはbind設定は、 --bind $PWD:$PWD 
singularity exec --bind $PWD:$PWD Germline_pipeline_v0.12.sif /opt/NGS/software/bwa-0.7.17/bwa index -p ${PJM_LOCALDIR}/${REF_FASTA} ${PJM_LOCALDIR}/b37_decoy/human_g1k_v37_decoy.fasta

index_name.amb、index_name.ann、index_name.pac

cp -r ${exec_node_out_dir}/${REF_FASTA}.amb ${login_node_out_dir}/furo_ngs/references/human/b37_decoy/
cp -r ${exec_node_out_dir}/${REF_FASTA}.ann ${login_node_out_dir}/furo_ngs/references/human/b37_decoy/
cp -r ${exec_node_out_dir}/${REF_FASTA}.pac ${login_node_out_dir}/furo_ngs/references/human/b37_decoy/
cp -r ${exec_node_out_dir}/${REF_FASTA}.bwt ${login_node_out_dir}/furo_ngs/references/human/b37_decoy/
cp -r ${exec_node_out_dir}/${REF_FASTA}.sa ${login_node_out_dir}/furo_ngs/references/human/b37_decoy/
wait
rm -rf ${PJM_LOCALDIR}/*

exit0
