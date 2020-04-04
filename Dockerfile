# FROM python:3.8.1-alpine3.11
FROM continuumio/miniconda3

# 파이썬에는 출력 버퍼가 기본으로 작동하면서 출력 로그를 붙잡고 있기 때문에
# 로그가 한 발 늦게 출력된다. 이 버퍼링을 없애려면 아래 환경 변수를 추가하면 된다. 
ENV PYTHONUNBUFFERED 0
WORKDIR /app
# COPY requirements.txt ./
# RUN pip install --upgrade pip && pip install -r requirements.txt
RUN conda update conda
RUN conda create --name nilmtk-env
# RUN conda create -n nilmtk-env -c nilmtk -c conda-forge nilmtk
RUN conda config --add channels conda-forge

# Make RUN commands use the new environment:
# SHELL ["conda", "run","-n", "nilmtk-env", "/bin/bash","-c"]
RUN /bin/bash -c "source activate nilmtk-env"
RUN conda install -c nilmtk nilmtk
RUN echo "source activate nilmtk-env" > ~/.bashrc

ENTRYPOINT ["/bin/bash"]