from flask import Flask, render_template, request, redirect, url_for
from flask_pymongo import PyMongo
from dotenv import load_dotenv
import os

load_dotenv()

app = Flask(__name__)

# Настройка подключения к MongoDB
app.config["MONGO_URI"] = os.getenv("MONGO_URI", "mongodb://localhost:27017/anketa_db")
mongo = PyMongo(app)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        # Получаем данные из формы
        nickname = request.form.get('nickname')
        email = request.form.get('email')
        hobbies = request.form.get('hobbies')
        
        # Сохраняем в базу данных
        mongo.db.profiles.insert_one({
            'nickname': nickname,
            'email': email,
            'hobbies': hobbies
        })
        
        return redirect(url_for('index'))
    
    # Получаем все анкеты из базы
    profiles = list(mongo.db.profiles.find())
    return render_template('index.html', profiles=profiles)

if __name__ == '__main__':
    app.run(debug=True)