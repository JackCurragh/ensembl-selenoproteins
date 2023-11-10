BootStrap: docker
From: continuumio/miniconda3:4.9.2

%post
    conda create -yn sp4 python=3.8 && \
    echo "conda activate sp4" >> /root/.bashrc && \
    conda install -c mmariotti -c anaconda -c bioconda -c biobuilds selenoprofiles4 && \
    echo "selenoprofiles -setup" >> /root/.bashrc && \
    echo "selenoprofiles -download" >> /root/.bashrc && \
    echo "echo 'selenoprofiles_data_dir=/path/to/your/data/directory/' > /root/.selenoprofiles_config.txt" >> /root/.bashrc && \
    conda install -c etetoolkit ete3 && \
    conda install matplotlib

%environment
    export PATH=$PATH:/opt/conda/envs/sp4/bin

%runscript
    exec /bin/bash -c "source /opt/conda/bin/activate sp4 && exec $@"
