#PJM -L elapse=2:00:00
#PJM -L jobenv=singularity
#PJM -j
#PJM -s

LOGIN_NODE_EXEC_DIR="/home/z44331r/"

login_node_out_dir=${LOGIN_NODE_EXEC_DIR} # LOGIN_NODE_EXEC_DIR='2107241442_E100009254'; SAMPLE_NAME='B000209'
exec_node_out_dir=${PJM_LOCALDIR}

SINGULARITY_CONTAINER="/home/z44331r/furo_ngs/singularity_containers/Germline_pipeline_v0.12.sif"
singularity_bind_path=${PJM_LOCALDIR}
FASTQC_ORIGIN_DIR=${login_node_out_dir}/furo_ngs/mitsu_fastq/

cp -r ${FASTQC_ORIGIN_DIR} ${PJM_LOCALDIR}
cp -r ${SINGULARITY_CONTAINER} ${PJM_LOCALDIR}

cd ${PJM_LOCALDIR}
module load singularity

#PJM_LOCALDIR（/local/jobID)のときはbind設定は、 --bind $PWD:$PWD 
singularity exec --bind $PWD:$PWD Germline_pipeline_v0.12.sif multiqc ${exec_node_out_dir}

#xx.html

cp -r ${exec_node_out_dir}/*.html ${login_node_out_dir}/furo_ngs/mitsu_fastq/multiqc_results
wait
rm -rf ${exec_node_out_dir}/*

exit0
