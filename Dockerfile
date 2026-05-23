# Use official Continuum Anaconda image
FROM continuumio/anaconda3:latest

# Set working directory
WORKDIR /app

# Prevent Python from writing pyc files & enable unbuffered logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Copy requirements file
COPY requirements-tf2.txt .

# Update conda and install Jupyter
RUN conda update -n base -c defaults conda -y \
    && conda install -y jupyter \
    && conda clean -afy

# Create TensorFlow 2.0 environment
RUN conda create -n tf2 python=3.7 -y \
    && conda run -n tf2 pip install --no-cache-dir -r requirements-tf2.txt \
    && conda run -n tf2 python -m ipykernel install --user --name=tf2 --display-name "Python (TF2)" \
    && conda clean -afy

# Expose Jupyter port
EXPOSE 8888

# Start Jupyter Notebook
# CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]

CMD ["conda", "run", "--no-capture-output", "-n", "tf2", \
     "jupyter", "notebook", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--allow-root", \
     "--NotebookApp.token=''"]
