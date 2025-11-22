import { z } from 'zod';

/**
 * Combined schema for comprehensive project analysis.
 * Merges tech stack, build system, debugging tools, and project structure analysis.
 */
export const ProjectAnalysisSchema = z.object({
  // Tech Stack Analysis (optional - Claude may not always determine all tech stack details)
  techStack: z.object({
    languages: z.array(z.string()),
    frameworks: z.array(z.string()),
    packageManager: z.string(),
    buildTools: z.array(z.string()),
    testFrameworks: z.array(z.string()),
    databases: z.array(z.string()),
    infrastructure: z.array(z.string()),
    confidence: z.enum(['high', 'medium', 'low']),
  }).optional(),

  // Build System Analysis (optional - Claude may not find build system configuration)
  buildSystem: z.object({
    runCommands: z.array(z.string()).optional(),
    buildCommands: z.array(z.string()).optional(),
    testCommands: z.array(z.string()).optional(),
    lintCommands: z.array(z.string()).optional(),
    otherCommands: z.record(z.string(), z.string()).optional(),
    devServer: z
      .object({
        url: z.string().nullable(),
        port: z.number().nullable(),
      })
      .optional()
      .nullable(),
    notes: z.string().optional(),
  }).optional(),

  // Debugging Tools Analysis (optional - Claude may not find debugging configuration)
  debuggingTools: z.object({
    debuggerConfig: z.object({
      available: z.boolean(),
      type: z.string().optional(),
      instructions: z.string().optional(),
    }),
    logging: z
      .object({
        library: z.string(),
        levels: z.array(z.string()),
        location: z.string().optional(),
      })
      .optional(),
    errorTracking: z
      .object({
        service: z.string(),
        configured: z.boolean(),
      })
      .optional(),
    profiling: z
      .object({
        available: z.boolean(),
        tools: z.array(z.string()),
      })
      .optional(),
    commonIssues: z.array(z.string()),
    tips: z.array(z.string()),
  }).optional(),

  // Project Structure (markdown string) - optional as minimal/empty projects may not have meaningful structure
  projectStructure: z.string().optional(),
});

export default ProjectAnalysisSchema;
