import * as path from "path";
import * as os from "os";

export function log(message: string, ...args: unknown[]) {
  console.log(`[Thoth Hooks] ${message}`, ...args);
}

export function expandPath(filePath: string): string {
  if (filePath.startsWith("~")) {
    return path.join(os.homedir(), filePath.slice(1));
  }
  return filePath;
}
