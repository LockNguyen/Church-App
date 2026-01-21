# PRD: Church App Enhancements - i18n & Schema-Driven Development

## Introduction/Overview

This PRD combines two major enhancements for the VBC-WS Church App:

1. **Flutter Internationalization (i18n)** - Add English/Vietnamese language support based on device locale
2. **Schema-Driven Development** - Create a single source of truth for data models with automated code generation

Together, these features improve both user experience (language accessibility) and developer experience (reduced duplication, type-safe code generation).

## Goals

- Enable automatic language detection (English or Vietnamese) based on device settings
- Translate all static UI elements while preserving dynamic Firebase content
- Create JSON Schema definitions for all data models
- Generate Dart model classes automatically from schemas
- Establish infrastructure for future TypeScript and Firestore rules generation
- Document the schema-driven development workflow

## User Stories

### Part 1: Flutter Internationalization (i18n)

---

### US-001: Add Flutter Localization Dependencies
**Description:** As a developer, I need to add the required localization packages so the app can support multiple languages.

**Acceptance Criteria:**
- [ ] Add `flutter_localizations` to pubspec.yaml dependencies
- [ ] Verify `intl: ^0.19.0` is already present (it is)
- [ ] Run `flutter pub get` successfully
- [ ] Flutter analyze passes with no errors

---

### US-002: Configure Flutter Localization in MaterialApp
**Description:** As a developer, I need to configure the MaterialApp to support localization delegates and supported locales.

**Acceptance Criteria:**
- [ ] Update `lib/main.dart` to add `localizationsDelegates`
- [ ] Add `supportedLocales` for English (en) and Vietnamese (vi)
- [ ] Configure `localeResolutionCallback` to default to English if locale not supported
- [ ] App builds and runs without errors
- [ ] Flutter analyze passes

---

### US-003: Create ARB File Structure and Generate Localization Classes
**Description:** As a developer, I need to set up the ARB translation files and configure code generation for localized strings.

**Acceptance Criteria:**
- [ ] Create `lib/l10n/` directory
- [ ] Create `app_en.arb` with initial translatable strings (app title, navigation labels)
- [ ] Create `app_vi.arb` with Vietnamese translations
- [ ] Add `generate: true` and l10n configuration to `pubspec.yaml`
- [ ] Create `l10n.yaml` configuration file
- [ ] Run `flutter gen-l10n` successfully
- [ ] Flutter analyze passes

---

### US-004: Translate Navigation and AppBar Labels
**Description:** As a user, I want navigation labels and AppBar titles to display in my device's language.

**Acceptance Criteria:**
- [ ] Add all navigation labels to ARB files (Home, Events, Discipleship, Prayer, Giving)
- [ ] Add Vietnamese translations (Trang Chủ, Sự Kiện, Môn Đồ Hóa, Cầu Nguyện, Dâng Hiến)
- [ ] Update `bottom_nav_bar.dart` to use `AppLocalizations.of(context)!`
- [ ] Update page AppBar titles to use localized strings
- [ ] Verify in app that language changes with device locale
- [ ] Flutter analyze passes

---

### US-005: Translate Button and Action Labels
**Description:** As a user, I want button text and action labels to display in my device's language.

**Acceptance Criteria:**
- [ ] Add button labels to ARB files (Share, Add to Calendar, Cancel, Save, Delete)
- [ ] Add Vietnamese translations (Chia Sẻ, Thêm vào Lịch, Hủy, Lưu, Xóa)
- [ ] Update event detail buttons to use localized strings
- [ ] Update any confirmation dialogs to use localized strings
- [ ] Flutter analyze passes

---

### US-006: Translate Section Headers and Empty States
**Description:** As a user, I want section headers and empty state messages to display in my device's language.

**Acceptance Criteria:**
- [ ] Add section headers to ARB files (Classes, Location, Upcoming Events, etc.)
- [ ] Add Vietnamese translations (Các Lớp Học, Địa Điểm, Sự Kiện Sắp Tới)
- [ ] Add empty state messages (No events yet, No classes available)
- [ ] Add Vietnamese empty states (Chưa có sự kiện nào, Chưa có lớp học)
- [ ] Update relevant widgets to use localized strings
- [ ] Flutter analyze passes

---

### US-007: Translate Error Messages
**Description:** As a user, I want error messages to display in my device's language so I understand what went wrong.

**Acceptance Criteria:**
- [ ] Add common error messages to ARB files (An error occurred, Please try again, No internet connection)
- [ ] Add Vietnamese translations (Đã xảy ra lỗi, Vui lòng thử lại, Không có kết nối internet)
- [ ] Update error handling widgets/snackbars to use localized strings
- [ ] Flutter analyze passes

---

### US-008: Add Date/Time Locale Formatting
**Description:** As a user, I want dates and times to display in my locale's format.

**Acceptance Criteria:**
- [ ] Use `DateFormat` from intl package with locale parameter
- [ ] Update event date displays to use `Localizations.localeOf(context)`
- [ ] Vietnamese dates show Vietnamese day names (Thứ 2, Thứ 3, etc.)
- [ ] English dates show English format (Mon, Tue, etc.)
- [ ] Flutter analyze passes

---

### Part 2: Schema-Driven Development

---

### US-009: Create Schemas Directory Structure
**Description:** As a developer, I need a dedicated directory for JSON schema definitions.

**Acceptance Criteria:**
- [ ] Create `/schemas` directory at project root
- [ ] Create placeholder README.md explaining the schema structure
- [ ] Flutter analyze passes (no impact on Flutter code)

---

### US-010: Define Event JSON Schema
**Description:** As a developer, I need a JSON Schema definition for the Event model to serve as the single source of truth.

**Acceptance Criteria:**
- [ ] Create `schemas/event.schema.json`
- [ ] Schema follows JSON Schema Draft 2020-12 specification
- [ ] Schema includes all Event fields: id, name, date, location, description, imageUrl, etc.
- [ ] Schema defines required vs optional fields
- [ ] Schema includes field types and validation rules
- [ ] Schema validates successfully with a JSON Schema validator

---

### US-011: Define Discipleship Course JSON Schemas
**Description:** As a developer, I need JSON Schema definitions for Discipleship-related models (Course, Location, Class).

**Acceptance Criteria:**
- [ ] Create `schemas/discipleship_course.schema.json`
- [ ] Schema includes Course model fields (id, name, isActive, etc.)
- [ ] Schema includes nested Location type
- [ ] Schema includes nested Class type (classNumber, passage, date, notes)
- [ ] Schema defines required vs optional fields
- [ ] Schema validates successfully

---

### US-012: Add Code Generation Scripts and Documentation
**Description:** As a developer, I need scripts to generate Dart code from schemas and documentation on how to use them.

**Acceptance Criteria:**
- [ ] Create `scripts/generate-models.sh` script
- [ ] Script uses quicktype or similar to generate Dart from JSON Schema
- [ ] Create `docs/schema-development.md` with:
  - How to define new schemas
  - How to run code generators
  - Naming conventions
- [ ] Update project README to reference schema documentation
- [ ] Shell script is executable (`chmod +x`)

---

### US-013: Generate Base Dart Models from Schemas
**Description:** As a developer, I want Dart model classes generated from JSON schemas so I don't maintain them manually.

**Acceptance Criteria:**
- [ ] Create `lib/data/models/generated/` directory
- [ ] Running generate script creates `event_generated.dart`
- [ ] Running generate script creates `discipleship_course_generated.dart`
- [ ] Generated classes include `fromJson()` and `toJson()` methods
- [ ] Generated classes have null-safe types based on schema required fields
- [ ] Flutter analyze passes on generated code

---

### US-014: Integrate Generated Models with Existing Code
**Description:** As a developer, I want existing model classes to extend or use the generated base classes.

**Acceptance Criteria:**
- [ ] Update `lib/data/models/event.dart` to use generated base or verify compatibility
- [ ] Update `lib/data/models/discipleship_data.dart` to use generated types
- [ ] Ensure Firestore serialization still works correctly
- [ ] All existing functionality continues to work
- [ ] Flutter analyze passes
- [ ] Existing tests pass (if any)

---

## Functional Requirements

### i18n Requirements
- FR-1: App detects device locale on startup and displays matching language
- FR-2: Supported locales are English (en) and Vietnamese (vi)
- FR-3: Default to English if device locale is not Vietnamese
- FR-4: All static UI text is externalized to ARB files
- FR-5: Dynamic content from Firebase remains in its original language
- FR-6: Date/time formatting respects device locale

### Schema Requirements
- FR-7: All data models have corresponding JSON Schema definitions in `/schemas`
- FR-8: Schemas follow JSON Schema Draft 2020-12 specification
- FR-9: A single command generates Dart models from schemas
- FR-10: Generated models include JSON serialization methods
- FR-11: Developer documentation explains the schema workflow

## Non-Goals (Out of Scope)

- In-app language picker (device settings only for now)
- TypeScript code generation (future - for web admin portal)
- Firestore security rules generation (future phase)
- Schema versioning and migration tools (future phase)
- CI/CD integration for schema validation (future phase)
- RTL language support

## Technical Considerations

### i18n
- Use official `flutter_localizations` package
- ARB file keys follow convention: `pageName_elementName_purpose`
- Existing `intl: ^0.19.0` package already included for date formatting

### Schema-Driven Development
- Use JSON Schema Draft 2020-12
- Use quicktype.io CLI for initial Dart generation
- Generated code goes to `lib/data/models/generated/`
- Hand-written extensions/customizations go in separate files

## Success Metrics

- App correctly displays in Vietnamese when device is set to Vietnamese
- App correctly displays in English for all other locales
- All hardcoded Vietnamese strings are externalized
- JSON schemas exist for all major data models
- Running `./scripts/generate-models.sh` produces valid Dart code
- Flutter analyze passes with zero warnings on generated code

## Open Questions

1. Should we add a language override option in app settings (future feature)?
2. Should generated models completely replace existing models or extend them?
3. What tool should be used for JSON Schema to Dart generation? (quicktype recommended)
