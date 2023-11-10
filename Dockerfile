# Use an official Miniconda3 image with Python 3.8
FROM continuumio/miniconda3:4.9.2

# Set the working directory to /app
WORKDIR /app

# Create a new environment named sp4 and activate it
RUN conda create -yn sp4 python=3.8
RUN echo "conda activate sp4" >> ~/.bashrc

# Install selenoprofiles4 and its dependencies
RUN conda install -c mmariotti -c anaconda -c bioconda -c biobuilds selenoprofiles4

# Run the selenoprofiles setup command
RUN echo "selenoprofiles -setup" >> ~/.bashrc

# Run the selenoprofiles download command
RUN echo "selenoprofiles -download" >> ~/.bashrc

# Set up config file and data directory paths
RUN echo "echo 'selenoprofiles_data_dir=/path/to/your/data/directory/' > ~/.selenoprofiles_config.txt" >> ~/.bashrc

# Install optional dependencies for selenoprofiles utilities
RUN conda install -c etetoolkit ete3
RUN conda install matplotlib

CMD ["/bin/bash"]