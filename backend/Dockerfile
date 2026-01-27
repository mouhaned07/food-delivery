FROM node:18

WORKDIR /app

# Copier les fichiers package.json et installer les dépendances dans le conteneur
COPY package*.json ./

# Supprimer node_modules au cas où, puis installer bcrypt proprement
RUN rm -rf node_modules package-lock.json && npm install && npm rebuild bcrypt --build-from-source

# Copier le reste du code
COPY . .

EXPOSE 4000

CMD ["npm", "start"]
