FROM nginx:alpine

# Copie des fichiers du site web
COPY . /usr/share/nginx/html

# Définit la variable d'environnement pour le port d'écoute, par défaut 80
#ENV LISTEN_PORT=80

# Copie le fichier de configuration Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Créer un script d'entrée pour modifier dynamiquement le port dans le fichier de configuration
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Utilise le script d'entrée pour démarrer Nginx
ENTRYPOINT ["/start.sh"]

