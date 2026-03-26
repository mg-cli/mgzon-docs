#!/bin/bash
# Export all Mermaid diagrams to PNG and SVG

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

DIAGRAMS_DIR=".."
OUTPUT_DIR="../assets/images/diagrams"

mkdir -p "$OUTPUT_DIR/png"
mkdir -p "$OUTPUT_DIR/svg"

echo "========================================="
echo "Exporting Mermaid Diagrams"
echo "========================================="

# Use local mmdc from node_modules
MMDC="../node_modules/.bin/mmdc"

if [ ! -f "$MMDC" ]; then
    echo "ERROR: mmdc not found. Run: npm install @mermaid-js/mermaid-cli"
    exit 1
fi

echo "Using mmdc from: $MMDC"
echo ""

COUNT=0
FAILED=0

for mmd in $(find "$DIAGRAMS_DIR" -name "*.mmd" -type f); do
    filename=$(basename "$mmd" .mmd)
    echo "Processing: $filename"
    
    if $MMDC -i "$mmd" -o "$OUTPUT_DIR/png/$filename.png" 2>/dev/null; then
        echo "  ✓ PNG exported"
    else
        echo "  ✗ PNG export failed"
        ((FAILED++))
    fi
    
    if $MMDC -i "$mmd" -o "$OUTPUT_DIR/svg/$filename.svg" 2>/dev/null; then
        echo "  ✓ SVG exported"
    else
        echo "  ✗ SVG export failed"
        ((FAILED++))
    fi
    
    ((COUNT++))
    echo ""
done

echo "========================================="
echo "Summary: $COUNT files processed, $FAILED failures"
echo "PNG: $OUTPUT_DIR/png/"
echo "SVG: $OUTPUT_DIR/svg/"
echo "========================================="
