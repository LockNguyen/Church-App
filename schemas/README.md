# JSON Schema Definitions

This directory contains JSON Schema definitions that serve as the single source of truth for data models in the VBC-WS Church App.

## Structure

- `event.schema.json` - Event model for calendar events
- `discipleship_course.schema.json` - Discipleship course with nested location and class types

## Schema Standard

All schemas follow [JSON Schema Draft 2020-12](https://json-schema.org/draft/2020-12/schema) specification.

## Usage

Run the code generation script to create Dart model classes from these schemas:

```bash
./scripts/generate-models.sh
```

Generated code is output to `lib/data/models/generated/`.

## Naming Conventions

- Schema files: `snake_case.schema.json`
- Generated Dart files: `{schema_name}_generated.dart`

## Adding New Schemas

1. Create a new `.schema.json` file in this directory
2. Follow JSON Schema Draft 2020-12 format
3. Define `$schema`, `$id`, `title`, `type`, `properties`, and `required` fields
4. Run the generate script to create Dart models
