import * as fs from 'fs';
import * as path from 'path';

import * as Mustache from 'mustache';
import prompts from "prompts";
import text = prompts.prompts.text;

const not_text_files = ['gradle-wrapper.jar', 'mariadb-java-client-2.6.0.jar']

export class FileReader {

  private readonly baseDir: string;
  private readonly view: any;

  constructor(baseDir: TYPE, view: any) {
    this.baseDir = path.join(__dirname, '..', 'template', baseDir.toString());
    this.view = view;
    this.view.package = this.view.name.replace('-', '.')
  }

  run() {
    this.processDir("");

    fs.copyFileSync(path.join(this.baseDir, '.gitignore'), path.join(__dirname, '..', 'generate','.gitignore'))
  }

  processDir(dir: string) {
    const directoryPath = path.join(this.baseDir, dir);

    fs.readdirSync(directoryPath)
      .forEach((file) => {
        let rightFileName = this.replaceProjectName(dir, file);
        this.processStranger(dir, rightFileName);
      });
  }

  replaceProjectName(dir: string, file: string) {
    if (file == 'project-name') {
      let split = this.view.name.split('-');
      if (split.length === 1) {
        fs.renameSync(path.join(this.baseDir, dir, file), path.join(this.baseDir, dir, this.view.name))
        return file;
      } else {
        let split1 = split.slice(0, -1);
        fs.mkdirSync(path.join(this.baseDir, dir, split1.join('/')), {recursive: true})
        fs.renameSync(path.join(this.baseDir, dir, file), path.join(this.baseDir, dir, split.join('/')))
        return split[0];
      }
    }
    return file;
  }

  processStranger(dir: string, file: string) {
    const directoryPath = path.join(this.baseDir, dir, file);

    const isDirectory = fs.statSync(directoryPath).isDirectory();
    const chainPath = path.join(dir, file);
    if (isDirectory) {
      this.processDir(chainPath);
    } else {
      this.genStubFromTemplate(chainPath, file, this.view);
    }
  }


  public genStubFromTemplate(seedPath: string, fileName: string, opts: any) {
    const readFilePath = path.join(this.baseDir, seedPath);
    const seed = fs.readFileSync(readFilePath).toString();

    const outPath = path.join(__dirname, '..', 'generate', seedPath);
    if (!fs.existsSync(outPath)) {
      fs.mkdirSync(path.dirname(outPath), {recursive: true});
    }

    if (not_text_files.includes(fileName)) {
      fs.copyFileSync(readFilePath, outPath);
    } else {
      const file = Mustache.render(seed, opts);
      fs.writeFileSync(outPath, file, 'utf8');
    }

    return outPath;
  }

}

export enum TYPE {
    SPRING ='java/spring-boot',
    QUARKUS = 'java/quarkus',
    NODEJS = 'nodejs',
    GO = 'go'
}
