import type { Plugin } from "@opencode-ai/plugin";
import { createSmartMergeEnforcerHook } from "./smart-merge-enforcer.js";
import { log } from "./shared.js";
import { readFileSync, existsSync } from "fs";
import { join } from "path";

interface HooksConfig {
  "smart-merge"?: {
    enabled?: boolean;
    size_ratio_threshold?: number;
  };
}

interface ThothHooksConfig {
  hooks?: HooksConfig;
}

const ThothHooksPlugin: Plugin = async (ctx) => {
  let config: ThothHooksConfig = {
    hooks: {
      "smart-merge": { enabled: true },
    },
  };

  const configPath = join(ctx.directory, ".opencode", "thoth-hooks.json");
  if (existsSync(configPath)) {
    try {
      const userConfig = JSON.parse(readFileSync(configPath, "utf-8"));
      config = { ...config, hooks: { ...config.hooks, ...userConfig.hooks } };
      log("Loaded config from .opencode/thoth-hooks.json");
    } catch (err) {
      log("Failed to load config:", err);
    }
  }

  const smartMerge = createSmartMergeEnforcerHook({
    enabled: config.hooks?.["smart-merge"]?.enabled,
    size_ratio_threshold: config.hooks?.["smart-merge"]?.size_ratio_threshold,
  });

  return {
    "tool.execute.before": async (input, output) => {
      await smartMerge?.["tool.execute.before"]?.(input as any, output as any);
    },
  };
};

export default ThothHooksPlugin;
