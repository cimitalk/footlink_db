
# Footlink Database Schema

Questo repository contiene lo schema del database per la piattaforma **Footlink**, una soluzione B2B per il distretti calzaturieri. Il database è progettato per supportare un'architettura modulare, orientata alla logica di business e integrabile con un backend sviluppato in C#.

---

## 📌 Obiettivo

Centralizzare la gestione dello **schema relazionale PostgreSQL**, le migrazioni SQL manuali o generate via Entity Framework Core, e la documentazione relativa alla **struttura dei dati**.

---

## 📂 Contenuto del repository

- `footlink_schema.sql` – Schema completo del database (tutte le CREATE TABLE, FK, ecc.)
- `migrations/` – Script SQL incrementali versionati
- `changelog.md` – Registro cronologico delle modifiche applicate allo schema
- `README.md` – Questo file

---

## ⚙️ Stack Tecnologico

- **PostgreSQL 15+**
- SQL standard (compatibile con strumenti CLI e GUI)
- Migrazioni supportate da EF Core (usate nel backend)

---

## ▶️ Setup iniziale

1. **Crea il database PostgreSQL**:
   ```bash
   createdb footlink
   ```

2. **Applica lo schema**:
   ```bash
   psql -U <username> -d footlink -f footlink_schema.sql
   ```

---

## 🔄 Gestione modifiche allo schema

Le modifiche vengono gestite attraverso **script versionati** (manuali o generati dal backend):

- Inserisci nuovi script nella cartella `migrations/`, con formato:
  ```
  V<numero>__<descrizione>.sql
  Esempio: V2__add_collaboration_tables.sql
  ```

- Aggiorna `changelog.md` specificando:
  - Versione
  - Data
  - Autore
  - Descrizione della modifica

- Se usi EF Core dal backend, puoi esportare le migrazioni come SQL tramite:
  ```bash
  dotnet ef migrations script -o migrations/V3__generated.sql
  ```

---

## 📌 Convenzioni

- Tutti i nomi delle tabelle sono in **snake_case**.
- Chiavi primarie: `id` univoci, UUID.
- Relazioni tracciate con FK esplicite.
- `created_at` / `updated_at` per ogni tabella.
- Trigger lato database opzionali.

---

## 📄 Licenza

Questo repository è open source e distribuito sotto licenza **MIT**.
