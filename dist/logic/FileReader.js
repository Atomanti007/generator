"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.TYPE = exports.FileReader = void 0;
const fs = __importStar(require("fs"));
const path = __importStar(require("path"));
const Mustache = __importStar(require("mustache"));
const not_text_files = ['gradle-wrapper.jar', 'mariadb-java-client-2.6.0.jar'];
class FileReader {
    constructor(baseDir, view) {
        this.baseDir = path.join(__dirname, '..', 'template', baseDir.toString());
        this.view = view;
        this.view.package = this.view.name.replace('-', '.');
    }
    run() {
        this.processDir("");
        fs.copyFileSync(path.join(this.baseDir, '.gitignore'), path.join(__dirname, '..', 'generate', '.gitignore'));
    }
    processDir(dir) {
        const directoryPath = path.join(this.baseDir, dir);
        fs.readdirSync(directoryPath)
            .forEach((file) => {
            let rightFileName = this.replaceProjectName(dir, file);
            this.processStranger(dir, rightFileName);
        });
    }
    replaceProjectName(dir, file) {
        if (file == 'project-name') {
            let split = this.view.name.split('-');
            if (split.length === 1) {
                fs.renameSync(path.join(this.baseDir, dir, file), path.join(this.baseDir, dir, this.view.name));
                return file;
            }
            else {
                let split1 = split.slice(0, -1);
                fs.mkdirSync(path.join(this.baseDir, dir, split1.join('/')), { recursive: true });
                fs.renameSync(path.join(this.baseDir, dir, file), path.join(this.baseDir, dir, split.join('/')));
                return split[0];
            }
        }
        return file;
    }
    processStranger(dir, file) {
        const directoryPath = path.join(this.baseDir, dir, file);
        const isDirectory = fs.statSync(directoryPath).isDirectory();
        const chainPath = path.join(dir, file);
        if (isDirectory) {
            this.processDir(chainPath);
        }
        else {
            this.genStubFromTemplate(chainPath, file, this.view);
        }
    }
    genStubFromTemplate(seedPath, fileName, opts) {
        const readFilePath = path.join(this.baseDir, seedPath);
        const seed = fs.readFileSync(readFilePath).toString();
        const outPath = path.join(__dirname, '..', 'generate', seedPath);
        if (!fs.existsSync(outPath)) {
            fs.mkdirSync(path.dirname(outPath), { recursive: true });
        }
        if (not_text_files.includes(fileName)) {
            fs.copyFileSync(readFilePath, outPath);
        }
        else {
            const file = Mustache.render(seed, opts);
            fs.writeFileSync(outPath, file, 'utf8');
        }
        return outPath;
    }
}
exports.FileReader = FileReader;
var TYPE;
(function (TYPE) {
    TYPE["SPRING"] = "java/spring-boot";
    TYPE["QUARKUS"] = "java/quarkus";
    TYPE["NODEJS"] = "nodejs";
    TYPE["GO"] = "go";
})(TYPE = exports.TYPE || (exports.TYPE = {}));
