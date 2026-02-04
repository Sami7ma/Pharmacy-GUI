## Getting Started

Welcome to the VS Code Java world. Here is a guideline to help you get started to write Java code in Visual Studio Code.

## Folder Structure

The workspace contains two folders by default, where:

- `src`: the folder to maintain sources
- `lib`: the folder to maintain dependencies

Meanwhile, the compiled output files will be generated in the `bin` folder by default.

> If you want to customize the folder structure, open `.vscode/settings.json` and update the related settings there.

## Dependency Management

The `JAVA PROJECTS` view allows you to manage your dependencies. More details can be found [here](https://github.com/microsoft/vscode-java-dependency#manage-dependencies).

---

Project quickstart
 - **Overview:** This is a Swing-based Pharmacy Management desktop app. Source files are in `src/` and compiled classes go to `bin/`.
 - **JDBC driver:** `lib/mssql-jdbc-12.8.1.jre8.jar` is included for Microsoft SQL Server connectivity.

Prerequisites
 - Java 21 JDK installed and on PATH.
 - Microsoft SQL Server running locally (default port 1433) or reachable from your machine.

Create and populate the database
 - Use SQL Server Management Studio (open `Thesql.sql` and execute) OR use `sqlcmd`.
 - Example using Windows integrated authentication:

```bash
sqlcmd -S localhost -E -i Thesql.sql
```

 - If you prefer SQL Server authentication, run:

```bash
sqlcmd -S localhost -U <username> -P <password> -i Thesql.sql
```

JDBC / authentication note
 - The default `DatabaseConnection.DB_URL` uses integrated security:
	 `jdbc:sqlserver://localhost:1433;databaseName=Pharmacy;integratedSecurity=true;encrypt=false;trustServerCertificate=true`
 - For SQL Server authentication you can change it to:
	 `jdbc:sqlserver://localhost:1433;databaseName=Pharmacy;user=sa;password=YourPassword;encrypt=false;trustServerCertificate=true`
 - If you keep `integratedSecurity=true`, ensure the appropriate native auth DLL (`sqljdbc_auth.dll`) is available and the driver supports your JVM.

Build and run
 - Compile:

```bash
javac -d bin -cp "lib/*" src/*.java
```

 - Run:

```bash
java -cp "bin;lib/*" Pharmacy
```

Notes and recommended next steps
 - The app expects the `Pharmacy` database and tables to exist (see `Thesql.sql`).
 - Security: passwords are stored/checked in plain text in the `users` table — consider hashing passwords.
 - UI: `InventoryTab` currently builds the form but doesn't persist inventory rows — add an INSERT handler.
 - Code style: rename `CreateProductPanel()` to `createProductPanel()` in `ProductTab.java` to match other panel methods.

Git
 - You already pushed a `dev-sam` branch. To push `main` use:

```bash
git checkout -b main
git push -u origin main
```

If you'd like, I can: add the inventory insert handler, rename the ProductPanel method, or add a hashed-password login flow. Tell me which to do next.

<p align="right"><sub>dev-sam</sub></p>
