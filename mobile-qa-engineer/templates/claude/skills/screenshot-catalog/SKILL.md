---
name: screenshot-catalog
description: Generate comprehensive visual documentation of all mobile app screens and states
---

# Screenshot Catalog Skill

Generates comprehensive visual documentation of a mobile application by systematically capturing screenshots of all screens, states, and UI variations.

## When to Use

- Creating visual documentation for stakeholders
- Generating design review materials
- Building baseline for visual regression
- Documenting app before/after changes
- Creating marketing or app store assets
- Onboarding new team members

## Capabilities

1. **Screen Navigation**: Systematically visit all screens
2. **State Capture**: Document loading, empty, populated, error states
3. **Organized Output**: Logical folder structure by feature
4. **Index Generation**: Markdown catalog with thumbnails
5. **Annotation Support**: Optional notes per screenshot

## Workflow

### Phase 1: Planning

1. **Define scope**:
   - All screens or specific section?
   - Which states to capture?
   - Both platforms or single?

2. **Create run directory**:
   ```
   [reportOutputDir]/[timestamp]-screenshots/
   ├── ios/
   │   ├── auth/
   │   ├── home/
   │   ├── settings/
   │   └── ...
   ├── android/
   │   ├── auth/
   │   ├── home/
   │   ├── settings/
   │   └── ...
   └── catalog.md
   ```

3. **Plan navigation path**:
   - Start from app launch
   - Define logical order (by feature, by user journey)
   - Note screens requiring special state

### Phase 2: State Preparation

For comprehensive documentation, capture these states:

#### Common States
| State | Description | How to Trigger |
|-------|-------------|----------------|
| Default | Normal loaded state | Navigate normally |
| Empty | No data present | New account or clear data |
| Loading | Data being fetched | Slow network or intercept |
| Error | Network/server error | Disable network |
| Populated | With realistic data | Use test account |

#### Form States
| State | Description |
|-------|-------------|
| Empty | No input yet |
| Focused | Input active |
| Filled | Valid data entered |
| Validation Error | Invalid input shown |
| Disabled | Non-interactive |

#### Interactive States
| State | Description |
|-------|-------------|
| Default | Normal appearance |
| Pressed/Highlighted | During interaction |
| Disabled | Non-interactive |
| Selected | Active state |

### Phase 3: Systematic Capture

For each screen:

1. **Navigate to screen**:
   ```
   Use mobile_click_on_screen_at_coordinates or mobile_open_url
   ```

2. **Wait for stable state**:
   - Allow animations to complete
   - Ensure data is loaded

3. **Capture screenshot**:
   ```
   Use mobile_save_screenshot with organized path:
   [platform]/[feature]/[screen-name]-[state].png
   ```

4. **Document in catalog**:
   ```markdown
   ### [Screen Name]

   **Path**: Home > Settings > Profile
   **States Captured**: default, empty, error

   | State | Screenshot |
   |-------|------------|
   | Default | ![](profile-default.png) |
   | Empty | ![](profile-empty.png) |
   | Error | ![](profile-error.png) |

   **Notes**: [Any observations]
   ```

5. **Capture variations**:
   - Scroll to reveal more content
   - Toggle states (switches, tabs)
   - Open modals/overlays

### Phase 4: Organization

#### Naming Convention
```
[feature]/[screen]-[state]-[variation].png

Examples:
auth/login-default.png
auth/login-error-invalid-email.png
home/feed-empty.png
home/feed-populated.png
home/feed-loading.png
settings/profile-editing.png
```

#### Folder Structure
```
screenshots/
├── auth/
│   ├── login-default.png
│   ├── login-error.png
│   ├── signup-step1.png
│   ├── signup-step2.png
│   └── forgot-password.png
├── home/
│   ├── feed-default.png
│   ├── feed-empty.png
│   └── feed-detail.png
├── settings/
│   ├── main.png
│   ├── profile.png
│   └── notifications.png
└── modals/
    ├── confirm-delete.png
    └── share-sheet.png
```

### Phase 5: Catalog Generation

Generate `catalog.md`:

```markdown
# Screenshot Catalog

**App**: [App Name]
**Version**: [Version]
**Date**: [Date]
**Platform**: [iOS/Android]
**Device**: [Device]

## Summary

| Category | Screens | Screenshots |
|----------|---------|-------------|
| Auth | 4 | 8 |
| Home | 3 | 12 |
| Settings | 5 | 10 |
| **Total** | **12** | **30** |

---

## Auth

### Login
![Login Default](auth/login-default.png)

| State | Screenshot |
|-------|------------|
| Default | [login-default.png](auth/login-default.png) |
| Error | [login-error.png](auth/login-error.png) |
| Loading | [login-loading.png](auth/login-loading.png) |

**Notes**: Login supports email and social auth

### Signup
![Signup Step 1](auth/signup-step1.png)

...

## Home

### Feed
![Feed Default](home/feed-default.png)

| State | Screenshot |
|-------|------------|
| Default | [feed-default.png](home/feed-default.png) |
| Empty | [feed-empty.png](home/feed-empty.png) |
| Loading | [feed-loading.png](home/feed-loading.png) |

...

## Index

### By Feature
- [Auth](#auth)
- [Home](#home)
- [Settings](#settings)

### By Screen
- [Login](#login)
- [Signup](#signup)
- [Feed](#feed)
- ...

### All Screenshots
1. auth/login-default.png
2. auth/login-error.png
3. ...
```

## Usage Examples

### Full Catalog
```
Use the screenshot-catalog skill to create a complete screenshot catalog of the app
```

### Feature-Specific
```
Use the screenshot-catalog skill to document all screens in the checkout flow
```

### State-Focused
```
Use the screenshot-catalog skill to capture empty states for all screens
```

### Cross-Platform
```
Use the screenshot-catalog skill to create screenshots for both iOS and Android
```

### Pre-Release Documentation
```
Use the screenshot-catalog skill to document the app for the v2.0 release
```

## Best Practices

1. **Consistent device**: Use same simulator/emulator throughout
2. **Clean state**: Clear notifications, status bar when possible
3. **Realistic data**: Use production-like content, not "test" or "Lorem ipsum"
4. **Time consistency**: Set system time if shown in UI
5. **Complete coverage**: Don't skip "boring" screens
6. **Capture variations**: Different user roles, data amounts
7. **Note changes**: Document what's new or changed since last catalog
8. **Version control**: Include app version in catalog metadata

## Output

The catalog generates:

- `catalog.md` - Main index with all screenshots
- `[feature]/` - Organized screenshot directories
- `README.md` - Run metadata and notes
- `manifest.json` - Machine-readable screenshot list (optional)
