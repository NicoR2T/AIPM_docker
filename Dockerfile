FROM python:3.7-stretch

# install build utilities
RUN apt-get update && \
	apt-get install -y gcc make apt-transport-https ca-certificates build-essential

# check our python environment
RUN python3 --version
RUN pip3 --version

# set the working directory for containers
WORKDIR  /

# When it will be official, replace git clone by pip install en première intention
#RUN pip3 install -i https://test.pypi.org/simple/ aipowermeter
RUN git clone https://github.com/GreenAI-Uppa/AIPowerMeter AIPM
RUN cp AIPM/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy python model and requirements
COPY alexnet.py .
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Compare between interactive and non-interactive container
#CMD ["python3", "/src/main.py"]