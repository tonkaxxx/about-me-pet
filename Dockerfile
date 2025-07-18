FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
ENV FLASK_APP=app.py
ENV FLASK_ENV=development
ENV MONGO_URI=mongodb://mongo:27017/anketa_db
EXPOSE 5000
CMD ["flask", "run", "--host=0.0.0.0"]