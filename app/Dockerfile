FROM nginx/nginx-unprivileged:alpine

COPY index.html /usr/share/nginx/html/index.html

USER 101:101

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
