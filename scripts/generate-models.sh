#!/bin/bash

# Generate Dart models from JSON Schema definitions
# Requires: quicktype (npm install -g quicktype)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
SCHEMAS_DIR="$PROJECT_ROOT/schemas"
OUTPUT_DIR="$PROJECT_ROOT/lib/data/models/generated"

# Check if quicktype is installed
if ! command -v quicktype &> /dev/null; then
    echo "Error: quicktype is not installed"
    echo "Install with: npm install -g quicktype"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

echo "Generating Dart models from JSON schemas..."

# Generate Event model
echo "  - Generating event_generated.dart..."
quicktype \
    --src-lang schema \
    --lang dart \
    --out "$OUTPUT_DIR/event_generated.dart" \
    --top-level Event \
    --null-safety \
    --coders-in-class \
    "$SCHEMAS_DIR/event.schema.json"

# Generate Discipleship Course model
echo "  - Generating discipleship_course_generated.dart..."
quicktype \
    --src-lang schema \
    --lang dart \
    --out "$OUTPUT_DIR/discipleship_course_generated.dart" \
    --top-level DiscipleshipCourse \
    --null-safety \
    --coders-in-class \
    "$SCHEMAS_DIR/discipleship_course.schema.json"

echo ""
echo "✓ Generated models in $OUTPUT_DIR"
echo ""
echo "Note: Review generated code and adjust as needed."
echo "The generated files are a starting point - you may need to:"
echo "  - Add Firestore-specific serialization"
echo "  - Add custom business logic methods"
echo "  - Adjust naming conventions"
