# DevOps pet project

Простое веб-приложение для создания анкет пользователей с сохранением данных в MongoDB.

## Технологический стек

- Backend: Python + Flask
- Database: MongoDB
- Frontend: HTML5, CSS3
- DevOps: Docker, Kubernetes, Minikube 

## Функционал

- Создание анкет пользователей (никнейм, email, увлечения)
- Просмотр всех анкет

## Запуск приложения

1. установите Minikube, kubernates и kubectl

2. склонируйте репозиторий и перейдите в него:
   ```bash
   git clone https://github.com/tonkaxxx/about-me-pet.git
   cd about-me-pet
   ```

3. запустите Minikube:
   ```bash
   minikube start --driver=docker
   ```

4. примените конфигурации:
   ```bash
   kubectl apply -f mongo-secret.yaml
   kubectl apply -f mongo-config.yaml
   kubectl apply -f mongo.yaml
   kubectl apply -f webapp.yaml
   ```

5. проверьте, запустилось ли приложение:
   ```bash
   kubectl rollout status deployment/webapp
   ```
   вывод должен быть таким:
   ```bash
   deployment "webapp" successfully rolled out
   ```
   если нет, просто подождите минуту и запустите команду еще раз
   
6. откройте приложение:
   ```bash
   minikube service webapp --url
   ```

## Контакты

Telegram - @tonkaxxx


