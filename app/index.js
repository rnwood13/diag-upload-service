const fileUpload = require('express-fileupload');
// const basicAuth = require('express-basic-auth');
const express = require('express');
const app = express();
const path = require('path');
const fs = require('fs');
const port = 8000;

const diagDir = path.join(__dirname, 'diags');
// const directoryPath = path.join(__dirname, diagDir);
app.use(fileUpload());
app.use(express.static(diagDir));

// app.use(basicAuth({
//     users: { 'admin': 'admin' },
//     challenge: true
// }));

app.post('/upload', (req, res) => {
    if (!req.files || Object.keys(req.files).length === 0) {
        return res.status(400).send('No files uploaded.');
    }
    let diag = req.files.diag;
    diag.mv(`${diagDir}/${diag.name}`, function (err) {
        if (err) {
            console.error(err);
            return res.status(500).send(err);
        } else {
            console.log(`File ${diag.name} uploaded`);
            res.send(`File ${diag.name} uploaded`);
        }
    });
});

app.get('/download/:id', (req, res) => {
    res.sendFile(req.params.id, {root: diagDir})
});

app.get('/', (req, res) => {
    fs.readdir(diagDir, function (err, files) {
        if (err) {
            return console.log('Unable to scan directory: ' + err);
        } 
        //listing all files in EFS
        files.forEach(function (file) {
            // Display list of files to console
            console.log(file); 
        });
    });

    // Present HTML page
    res.sendFile(path.join(__dirname, "index.html"));
});

app.listen(port, () => {
    console.log(`App is listening on port ${port}!`);
});
