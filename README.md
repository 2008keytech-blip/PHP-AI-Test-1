# Movie Cast Lookup

This small app looks up the actors and the roles they played for a given movie title.

Files added:
- `index.html` — front end UI (jQuery)
- `css/style.css` — styles
- `js/app.js` — AJAX and DOM logic
- `api.php` — PHP backend API using PDO_Mysql
- `db/config.php` — PDO connection helper (uses env vars by default)
- `sql/schema.sql` — schema + sample data

Setup
1) Create the database and sample data (adjust user/privileges as needed):

```bash
mysql -u root -p < sql/schema.sql
```

2) Configure DB credentials. You can set environment variables before starting PHP, or edit `db/config.php` defaults:

```bash
export DB_HOST=127.0.0.1
export DB_NAME=movies_db
export DB_USER=root
export DB_PASS=yourpassword
```

3) Run the built-in PHP server from the project root:

```bash
php -S 0.0.0.0:8000
```

Open http://localhost:8000/index.html in your browser and try a search (e.g. `The Matrix`).

Notes
- The backend expects POST requests to `api.php` with form parameter `title`.
- `db/config.php` uses PDO with prepared statements. Update environment variables or the file to match your environment.

PHP-AI-Test-1
