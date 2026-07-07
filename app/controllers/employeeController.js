const { getPool } = require("../db");

// Get all employees
exports.getEmployees = async (req, res) => {
    try {
        const [rows] = await getPool().query("SELECT * FROM employees");
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

// Get employee by ID
exports.getEmployeeById = async (req, res) => {
    try {
        const [rows] = await getPool().query(
            "SELECT * FROM employees WHERE id = ?",
            [req.params.id]
        );

        if (rows.length === 0) {
            return res.status(404).json({
                message: "Employee not found"
            });
        }

        res.json(rows[0]);
    } catch (err) {
        res.status(500).json({
            error: err.message
        });
    }
};

// Create employee
exports.createEmployee = async (req, res) => {
    try {
        const { name, email, department } = req.body;

        const [result] = await getPool().query(
            "INSERT INTO employees(name,email,department) VALUES(?,?,?)",
            [name, email, department]
        );

        res.status(201).json({
            message: "Employee Created",
            id: result.insertId
        });

    } catch (err) {
        res.status(500).json({
            error: err.message
        });
    }
};

// Update employee
exports.updateEmployee = async (req, res) => {
    try {

        const { name, email, department } = req.body;

        await getPool().query(
            `UPDATE employees
             SET name=?,email=?,department=?
             WHERE id=?`,
            [name, email, department, req.params.id]
        );

        res.json({
            message: "Employee Updated"
        });

    } catch (err) {

        res.status(500).json({
            error: err.message
        });

    }
};

// Delete employee
exports.deleteEmployee = async (req, res) => {

    try {

        await getPool().query(
            "DELETE FROM employees WHERE id=?",
            [req.params.id]
        );

        res.json({
            message: "Employee Deleted"
        });

    } catch (err) {

        res.status(500).json({
            error: err.message
        });

    }

};