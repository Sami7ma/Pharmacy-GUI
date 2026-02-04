# 💊 Pharmacy Management System (GUI)

![Java](https://img.shields.io/badge/Java-21-blue.svg) ![SQL Server](https://img.shields.io/badge/Database-SQL%20Server-507DBC.svg)

A sleek, lightweight desktop solution for small pharmacy operations — built with Java Swing. Manage customers, suppliers, products, inventory and sales with a simple GUI.

---

Why you'll ❤️ this
- Fast desktop UI for daily pharmacy tasks
- Simple data model that maps to SQL Server
- Easy to extend: modular tabs for Customers, Products, Suppliers, Inventory, Sales

Quick links
- 📁 src/ — Java source files (UI & Database Access)
- 📁 lib/ — Third-party libraries (Place JDBC driver here)
- 📄 Thesql.sql — Database schema & seed data

---

Getting started (2 minutes)
1) Requirements
   - Java JDK 17+ (Java 21 recommended)
   - Microsoft SQL Server (local or remote)
   - Microsoft JDBC Driver (drop the .jar into `lib/`)

2) Create DB (run the included script)
```bash
# Windows Integrated Auth
sqlcmd -S localhost -E -i Thesql.sql

# SQL Server Auth
sqlcmd -S localhost -U <user> -P <pass> -i Thesql.sql
```

3) Build & run
```bash
javac -d bin -cp "lib/*" src/*.java
java -cp "bin;lib/*" Pharmacy
```

4) Tip: If using Integrated Security on Windows, ensure `sqljdbc_auth.dll` is available or switch to SQL auth in `src/DatabaseConnection.java`.

---

Features (what it does)
- 🔐 Login: checks `users` table
- 👥 Customers: add and list customers (inserts into `Customers`)
- 🏷 Products: add products and link to suppliers
- 📦 Inventory: select product/batch/expiry; UI is present (DB insert handler can be added)
- 💸 Sales: add items to cart and commit to `Sales` + `SalesDetails`

Quick architecture (how it works)
- `Pharmacy.main()` → `DatabaseConnection.connectDB()` → `Login` UI
- After login → `PharmacyManagementApp` opens with tabs (each tab is a class in `src/`)

Recommended small improvements (low-effort wins)
- Hash passwords (BCrypt) instead of storing plain text in `users`.
- Implement `InventoryTab` DB insert handler so "Add Inventory" persists rows.
- Rename `CreateProductPanel()` → `createProductPanel()` for consistent naming.

🔍 TROUBLE SHOOTING

- [ ] SQL Server Connection refused: is SQL Server running? Is TCP/IP enabled in SQL Configuration Manager?
- [ ] JDBC Driver missing: put the JDBC JAR into `lib/` and include it on the classpath when compiling/running.
- [ ] Auth DLL Integrated auth errors: ensure `sqljdbc_auth.dll` in PATH or switch to SQL auth.
- [ ] Data Integrity Empty lists in UI: verify `Thesql.sql` executed successfully and populated tables.

🛠️ TECHNICAL NOTES
- Authentication: The system validates users against the users table upon launch.
- Sales Logic: Transactions are atomically written to both Sales and SalesDetails tables.
- VS Code Integration: Use the JAVA PROJECTS view to manage dependencies easily.