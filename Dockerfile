# Usando a imagem oficial do Flutter
FROM cirruslabs/flutter:latest AS builder

# Definindo o diretório de trabalho
WORKDIR /app

# Copiando os arquivos pubspec.yaml e pubspec.lock
COPY pubspec.* ./

# Instalando as dependências
RUN flutter pub get

# Copiando o restante dos arquivos do projeto
COPY . .

# Compilando a aplicação Flutter para web
RUN flutter build web

# Usando a imagem do Nginx
FROM nginx:alpine

# Copiando os arquivos da build para o Nginx
COPY --from=builder /app/build/web /usr/share/nginx/html

# Expondo a porta 80 do Nginx
EXPOSE 80
