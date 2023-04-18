FROM ubuntu:20.04
ENV VERSION 0.6.0
RUN apt update && apt install -y python3-minimal python3-pip
RUN pip install chdb Flask
RUN strip /usr/local/lib/python3.8/dist-packages/chdb/_chdb*.so
WORKDIR /app
ADD main.py .
ADD public ./public
RUN python3 -c "import chdb; res = chdb.query('select version()', 'CSV'); print(str(res.get_memview().tobytes()))"
EXPOSE 8123
CMD ["python3","./main.py"] 
