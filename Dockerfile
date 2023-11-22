FROM python:3.11-slim-bullseye

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /my_code
COPY . /my_code/

EXPOSE 8000

RUN pip install -r requirements.txt

CMD python manage.py makemigrations && \
    python manage.py migrate && \
    gunicorn core.wsgi:application --bind 0.0.0.0:8000

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://127.0.0.1:8000/ || exit 1