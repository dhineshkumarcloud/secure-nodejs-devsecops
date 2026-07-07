require("dotenv").config();

const app = require("./app");
const { initializeDatabase } = require("./db");

const PORT = process.env.PORT || 8080;

app.listen(PORT, async () => {

    console.log(`Server running on ${PORT}`);

    try {

        await initializeDatabase();

        console.log("Database connected.");

    } catch (err) {

        console.log("Database connection will be established in Cloud Run.");
        console.error(err.message);
    }

});