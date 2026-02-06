import { readFileSync, existsSync } from "fs";
import { log } from "./shared.js";

interface SmartMergeConfig {
  enabled?: boolean;
  size_ratio_threshold?: number;
}

export function createSmartMergeEnforcerHook(config: SmartMergeConfig = {}) {
  const { enabled = true, size_ratio_threshold = 0.5 } = config;

  if (!enabled) return null;

  return {
    "tool.execute.before": async (
      input: { tool: string; callID: string },
      output: { args: Record<string, unknown> }
    ) => {
      if (input.tool !== "write") return;

      const filePath = output.args.filePath as string | undefined;
      const newContent = output.args.content as string | undefined;

      if (!filePath || !newContent) return;
      if (!filePath.endsWith(".md")) return;
      if (!existsSync(filePath)) return;

      const oldContent = readFileSync(filePath, "utf-8");
      const warnings: string[] = [];

      const sizeRatio = newContent.length / oldContent.length;
      if (sizeRatio < size_ratio_threshold) {
        const reduction = Math.round((1 - sizeRatio) * 100);
        warnings.push(
          `Content shrunk by ${reduction}% (${oldContent.length} → ${newContent.length} chars). Was this intentional?`
        );
      }

      const hasOldFrontmatter = oldContent.startsWith("---");
      const hasNewFrontmatter = newContent.startsWith("---");
      
      if (hasOldFrontmatter && !hasNewFrontmatter) {
        warnings.push("YAML frontmatter was removed. Was this intentional?");
      }

      if (warnings.length > 0) {
        const warningText = `[Smart-Merge Warning]\n${warnings.map(w => `  - ${w}`).join("\n")}`;
        log(warningText);
      }
    }
  };
}
