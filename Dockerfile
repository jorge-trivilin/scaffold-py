# Use uma imagem base do Python que não seja a versão 3.12
FROM python:3.11

# Configurar o diretório de trabalho
WORKDIR /app

# Copiar arquivos necessários
COPY requirements.txt .

# Instalar dependências
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copiar o código do projeto
COPY . .

# Comando para rodar o contêiner (pode ser ajustado conforme necessário)
CMD ["python", "hello.py"]
