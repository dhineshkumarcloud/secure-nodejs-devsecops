const mysql = require("mysql2/promise");
require("dotenv").config();

let pool;

async function initializeDatabase() {

    pool = mysql.createPool({
        host: process.env.DB_HOST,
        port: process.env.DB_PORT,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME,

        waitForConnections: true,
        connectionLimit: 10,
        queueLimit: 0
    });

    const createTable = `
        CREATE TABLE IF NOT EXISTS employees(
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            email VARCHAR(100) UNIQUE NOT NULL,
            department VARCHAR(100)
        )
    `;

    await pool.execute(createTable);

    console.log("Database Connected");
}

function getPool() {
    return pool;
}

module.exports = {
    initializeDatabase,
    getPool
};