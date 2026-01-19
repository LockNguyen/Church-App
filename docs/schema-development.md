# Schema-Driven Development Guide

This document explains how to use JSON Schema definitions as the single source of truth for data models in the VBC-WS Church App.

## Overview

We use JSON Schema definitions to:
1. Define data models in a language-agnostic format
2. Generate Dart model classes automatically
3. Maintain consistency between frontend and backend
4. Document data structures with validation rules

## Schema Location

All schema files are located in `/schemas/` at the project root.

## How to Define New Schemas

### 1. Create the Schema File

Create a new `.schema.json` file in the `/schemas/` directory:

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "https://vbc-ws.app/schemas/your_model.schema.json",
  "title": "YourModel",
  "description": "Description of the model",
  "type": "object",
  "properties": {
    "id": {
      "type": "string",
      "description": "Unique identifier"
    },
    "name": {
      "type": "string",
      "description": "Display name"
    },
    "optionalField": {
      "type": ["string", "null"],
      "description": "An optional field"
    }
  },
  "required": ["id", "name"]
}
```

### 2. Define Nested Types

For complex models with nested objects, use `$defs`:

```json
{
  "$defs": {
    "NestedType": {
      "title": "NestedType",
      "type": "object",
      "properties": {
        "id": { "type": "string" }
      }
    }
  },
  "properties": {
    "items": {
      "type": "array",
      "items": { "$ref": "#/$defs/NestedType" }
    }
  }
}
```

### 3. Common Field Types

| Dart Type | JSON Schema Type |
|-----------|------------------|
| `String` | `"type": "string"` |
| `String?` | `"type": ["string", "null"]` |
| `int` | `"type": "integer"` |
| `double` | `"type": "number"` |
| `bool` | `"type": "boolean"` |
| `DateTime` | `"type": "string", "format": "date-time"` |
| `List<T>` | `"type": "array", "items": {...}` |

## Running Code Generators

### Prerequisites

Install quicktype globally:

```bash
npm install -g quicktype
```

### Generate Dart Models

Run the generation script:

```bash
./scripts/generate-models.sh
```

This generates Dart files in `lib/data/models/generated/`.

### What Gets Generated

- Class definitions with null-safe types
- `fromJson()` factory constructor
- `toJson()` method
- Nested classes for complex types

## Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Schema files | `snake_case.schema.json` | `event.schema.json` |
| Generated Dart files | `{schema}_generated.dart` | `event_generated.dart` |
| Class names | `PascalCase` | `Event`, `DiscipleshipCourse` |
| Properties | `camelCase` | `startDateTime`, `heroImageUrl` |

## Extending Generated Models

The generated models provide a base. For Firestore-specific logic:

1. Keep generated files as-is (they will be overwritten)
2. Create extension files that add Firestore serialization:

```dart
// lib/data/models/event_model.dart
import 'generated/event_generated.dart';

extension EventFirestore on Event {
  static Event fromFirestore(DocumentSnapshot doc) {
    // Custom Firestore deserialization
  }
  
  Map<String, dynamic> toFirestore() {
    // Custom Firestore serialization
  }
}
```

## Future Enhancements

- TypeScript code generation for web admin portal
- Firestore security rules generation
- Schema validation in CI/CD pipeline
- Schema versioning and migration tools
