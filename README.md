# dataops-loan-pipeline
Pipeline DataOps para análisis de riesgo crediticio en solicitudes de préstamos.

## Descripción
Pipeline DataOps que procesa 45.000 registros de solicitudes de préstamos, 
aplicando ingesta, limpieza, validación y carga a PostgreSQL. En la Fase 2 
se entrenó un modelo de Machine Learning para predecir el riesgo de 
incumplimiento (default) en las solicitudes.

## Caso de uso
Dataset de 45.000 solicitudes de préstamos con variables demográficas, 
financieras y crediticias. El objetivo es procesar y limpiar los datos 
para análisis de riesgo de default (incumplimiento de pago), y posteriormente 
entrenar un modelo predictivo que apoye la decisión de aprobación de préstamos.

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
- Scikit-learn
- Matplotlib / Seaborn

## Estructura del proyecto

    dataops-loan-pipeline/
    ├── data/
    │   ├── raw/               ← dataset original
    │   └── processed/         ← datasets procesados
    ├── logs/                  ← logs de cada etapa
    ├── notebooks/
    │   ├── 1_ingesta_limpieza.ipynb
    │   ├── 2_validacion.ipynb
    │   ├── 3_carga.ipynb
    │   └── 4_entrenamiento_modelo.ipynb
    ├── docker-compose.yml
    ├── Dockerfile
    ├── requirements.txt
    └── .env                   ← credenciales (no se sube a GitHub)

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
4. `4_entrenamiento_modelo.ipynb`

## Resultados
- Total registros procesados: 45.000
- Registros válidos cargados en loans_clean: 44.993
- Registros inválidos en loans_error: 7
- Tasa de completitud: 99,98%

## Fase 2 — Entrenamiento de Modelo de IA (Parcial 3)

A partir del dataset validado (`loans_validos.csv`, 44.993 registros), se entrenó un modelo de Machine Learning supervisado para predecir el riesgo de incumplimiento (`loan_status`) en solicitudes de préstamos.

### Proceso
- Análisis de calidad de datos, univariado y bivariado (incluye matriz de correlación)
- Preprocesamiento: codificación de variables categóricas (One-Hot Encoding y mapeo ordinal)
- División train/test (80% / 20%) estratificada
- Entrenamiento y comparación de dos algoritmos: Regresión Logística y Random Forest

### Resultados del modelo

| Métrica | Regresión Logística | Random Forest |
|---|---|---|
| Accuracy | 89.5% | **92.1%** |
| Precision | 77.2% | **91.5%** |
| Recall | **74.8%** | 71.0% |
| F1-Score | 76.0% | **79.9%** |
| AUC (ROC) | 0.952 | **0.969** |
| Gini | 0.905 | **0.938** |

**Modelo elegido:** Random Forest, por su mejor desempeño general. La Regresión Logística se mantiene como referencia por su mayor interpretabilidad, relevante en el contexto bancario.

**Variables más influyentes:** `previous_loan_defaults_on_file`, `loan_percent_income` y `loan_int_rate`, consistentes entre ambos modelos.

Ver detalle completo en `notebooks/4_entrenamiento_modelo.ipynb`.
