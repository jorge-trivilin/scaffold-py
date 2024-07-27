# Use uma imagem base do Python 3.10
FROM python:3.10

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
