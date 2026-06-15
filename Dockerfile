FROM python:3-alpine

LABEL "student"="Atis Krieviņš"

WORKDIR /app

COPY requirements.txt app.py ./

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 3000

ENTRYPOINT ["python3", "./app.py"]
