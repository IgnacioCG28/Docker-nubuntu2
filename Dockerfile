FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    apt-get install -y tree nano bash-completion git nginx  && \
    apt-get clean

# Set the working directory
WORKDIR /var/www/html

# Create directories for projects
RUN mkdir -p proyecto1 proyecto2 proyecto3 && \
    rm -f index.nginx-debian.html

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

COPY proyecto1 /etc/nginx/sites-available/
COPY proyecto2 /etc/nginx/sites-available/
COPY proyecto3 /etc/nginx/sites-available/


RUN ln -s /etc/nginx/sites-available/proyecto1 /etc/nginx/sites-enabled/
RUN ln -s /etc/nginx/sites-available/proyecto2 /etc/nginx/sites-enabled/
RUN ln -s /etc/nginx/sites-available/proyecto3 /etc/nginx/sites-enabled/

RUN chown -R www-data:www-data /var/www/html/proyecto1
RUN chown -R www-data:www-data /var/www/html/proyecto2
RUN chown -R www-data:www-data /var/www/html/proyecto3

RUN chmod -R 755 /var/www/html/proyecto1
RUN chmod -R 755 /var/www/html/proyecto2
RUN chmod -R 755 /var/www/html/proyecto3

# Git Clones
WORKDIR /var/www/html/proyecto1
RUN git clone https://github.com/IgnacioCG28/Ejercicio-bolas-cromaticas.git .

WORKDIR /var/www/html/proyecto2
RUN git clone https://github.com/IgnacioCG28/Proyecto2_IgnacioCarmonaGonzalez.git .

WORKDIR /var/www/html/proyecto3
RUN git clone https://github.com/IgnacioCG28/Examen2_IgnacioCarmonaGonzalez.git .

WORKDIR /var/www/html
# Expose ports
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082
# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
