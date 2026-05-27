# Imagen base de Python
FROM python:3.12.1

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo de dependencias
COPY requirements.txt .

# Instalar las dependencias
RUN pip install -r requirements.txt

# Copiar todo el proyecto
COPY . .

# Exponer el puerto de Jupyter
EXPOSE 8888

# Comando para iniciar Jupyter
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser"]