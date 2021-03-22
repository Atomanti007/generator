"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Importing the class from the location of the file
const FileReader_1 = require("./logic/FileReader");
// Creating an object of the class which is imported
// let fileReader = new FileReader("./template/java/spring-boot");
const fileReader = new FileReader_1.FileReader(FileReader_1.TYPE.SPRING, {
    name: "cacheman-downloader",
    "db-name": "TEST",
    version: '1.0.0-SNAPSHOT'
});
// Calling the imported class function
fileReader.run();
// fileReader.genStubFromTemplate("template.mustache", {name: 'test', package: 'hu.kzsolt'});
// let consoleReader = new ConsoleReader();
// consoleReader.readProperties();
