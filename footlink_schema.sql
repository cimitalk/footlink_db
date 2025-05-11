-- Active: 1746921981614@@0.0.0.0@5432@footlink

-- FOOTLINK Database Schema
-- Generated: 2025-05-10T12:25:52.242295 UTC

-- Aziende
CREATE TABLE companies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    vat_number VARCHAR(50) UNIQUE NOT NULL,
    address TEXT,
    city VARCHAR(100),
    province VARCHAR(50),
    postal_code VARCHAR(20),
    country VARCHAR(100) DEFAULT 'Italy',
    email VARCHAR(255),
    phone VARCHAR(50),
    website VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Utenti
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL REFERENCES companies(id),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(50) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Prodotti
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL REFERENCES companies(id),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    sku VARCHAR(100) UNIQUE,
    category VARCHAR(100),
    unit_price NUMERIC(12,2) NOT NULL,
    currency VARCHAR(10) DEFAULT 'EUR',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Ordini
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    buyer_company_id INTEGER NOT NULL REFERENCES companies(id),
    supplier_company_id INTEGER NOT NULL REFERENCES companies(id),
    status VARCHAR(50) DEFAULT 'Pending',
    order_date DATE DEFAULT CURRENT_DATE,
    delivery_date DATE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Dettagli Ordine
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL,
    unit_price NUMERIC(12,2) NOT NULL,
    total_price NUMERIC(12,2) GENERATED ALWAYS AS (quantity * unit_price) STORED
);

-- Avanzamento Produzione
CREATE TABLE production_progress (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id),
    stage VARCHAR(100), -- es. "Taglio", "Montaggio", "Rifinitura"
    description TEXT,
    progress_percent INTEGER CHECK (progress_percent BETWEEN 0 AND 100),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Spedizioni
CREATE TABLE shipments (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id),
    tracking_number VARCHAR(100),
    carrier VARCHAR(100),
    shipped_date DATE,
    delivery_estimate DATE,
    status VARCHAR(50) DEFAULT 'Preparing',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Fatture
CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id),
    invoice_number VARCHAR(100) UNIQUE NOT NULL,
    issue_date DATE NOT NULL,
    total_amount NUMERIC(12,2) NOT NULL,
    xml_file TEXT, -- encoded XML for e-invoicing
    status VARCHAR(50) DEFAULT 'Draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
