# Basis-Image mit Python
FROM python:3.11-slim

# Arbeitsverzeichnis im Container
WORKDIR /app

# Kopiere Projektdateien
COPY . /app

# Installiere Abhängigkeiten
RUN pip install --no-cache-dir .

# Command wenn Container startet
CMD ["python", "-m", "domainconnect_ddns"]
