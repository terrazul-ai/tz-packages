# Screenshot Catalog

Generate visual documentation of all app screens.

## Usage

```
/screenshot-catalog [options]
```

## Options

- `--section=<name>` - Catalog specific section only
- `--states=all` - Include empty/error/loading states

## Process

1. **Plan navigation**:
   - Define scope (all screens or section)
   - Determine which states to capture

2. **Launch app** and start from initial screen

3. **Systematic capture**:
   - Navigate to each screen
   - Wait for stable state
   - Capture screenshot with organized path
   - Capture state variations (empty, populated, error)

4. **Organize output**:
   ```
   screenshots/
   ├── auth/
   │   ├── login-default.png
   │   └── signup.png
   ├── home/
   │   ├── feed-default.png
   │   └── feed-empty.png
   └── settings/
       └── profile.png
   ```

5. **Generate catalog index**:
   - Summary table
   - Screenshots by section
   - State variations

## States to Capture

| State | Description |
|-------|-------------|
| Default | Normal loaded state |
| Empty | No data present |
| Loading | Data being fetched |
| Error | Network/server error |
| Populated | With realistic data |

## Output

- `catalog.md` - Main index with all screenshots
- Organized screenshot directories
- Summary of screens and states captured
