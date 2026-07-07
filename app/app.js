require("dotenv").config();

const express = require("express");

const employeeRoutes = require("./routes/employees");

const app = express();

app.use(express.json());

app.use("/employees", employeeRoutes);

app.get("/health", (req, res) => {
    res.status(200).json({
        status: "Healthy"
    });
});

module.exports = app;