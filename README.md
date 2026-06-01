# dataops-loan-pipeline
Pipeline DataOps para análisis de riesgo crediticio en solicitudes de préstamos.

## Descripción
Pipeline DataOps que procesa 45.000 registros de solicitudes de préstamos, 
aplicando ingesta, limpieza, validación y carga a PostgreSQL.

## Caso de uso
Dataset de 45.000 solicitudes de préstamos con variables demográficas, 
financieras y crediticias. El objetivo es procesar y limpiar los datos 
para análisis de riesgo de default (incumplimiento de pago).

## Metodología
Se aplicó una metodología mixta basada en PMBOK:
- **Predictiva:** estructura fija del pipeline con 4 etapas definidas desde el inicio
- **Adaptativa:** validaciones ajustadas según los problemas reales encontrados en los datos

## Pipeline
1. **Ingesta:** carga del CSV a PostgreSQL como tabla loans_raw
2. **Limpieza y transformación:** corrección de tipos de datos
3. **Validación:** verificación estructural y semántica, separación de registros inválidos
4. **Carga:** almacenamiento en tablas loans_clean y loans_error

## Tecnologías
- Python 3.12.1
- Jupyter Notebook
- Pandas
- PostgreSQL
- SQLAlchemy
- Docker
- GitHub Codespaces

## Estructura del proyecto
```
dataops-loan-pipeline/
├── data/
│   ├── raw/               ← dataset original
│   └── processed/         ← datasets procesados
├── logs/                  ← logs de cada etapa
├── notebooks/
│   ├── 1_ingesta_limpieza.ipynb
│   ├── 2_validacion.ipynb
│   └── 3_carga.ipynb
├── docker-compose.yml
├── Dockerfile
├── requirements.txt
└── .env                   ← credenciales (no se sube a GitHub)
```
## Cómo ejecutar el pipeline

### 1. Levantar PostgreSQL con Docker o Reiniciarlo
```bash
docker-compose up -d

docker-compose down && docker-compose up -d
```

### 1.5 Comprobar que funcione el Docker
```bash
docker ps
```

### 2. Instalar dependencias
```bash
pip install -r requirements.txt
```

### 3. Abrir Jupyter
```bash
jupyter notebook
```

### 3.5 Borrar logs existentes si es necesario
```bash
rm logs/*.log
```

### 4. Correr los notebooks en orden
1. `1_ingesta_limpieza.ipynb`
2. `2_validacion.ipynb`
3. `3_carga.ipynb`

## Resultados
- Total registros procesados: 45.000
- Registros válidos cargados en loans_clean: 44.993
- Registros inválidos en loans_error: 7
- Tasa de completitud: 99,98%