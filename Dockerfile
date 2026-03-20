FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
# upgrade pip and setuptools first to get patched vendored packages
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 5000

CMD ["python", "app.py"]
