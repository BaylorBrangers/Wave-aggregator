#!/bin/bash

curl -s -X POST https://gobii.ai/api/v1/tasks/browser-use/ \
  -H "X-Api-Key: $GOBII_API_KEY" \
  -H "Content-Type: application/json" \
  -d @<(cat <<EOF
{
  "prompt": "Go to $BOOK_URL and return the book title and price as JSON",
  "output_schema": {
    "type": "object",
    "properties": {
      "title":  { "type": "string" },
      "price":  { "type": "string" }
    },
    "required": ["title", "price"],
    "additionalProperties": false
  },
  "wait": 300
}
EOF
) > "$OUTPUT_FILE"

gsutil cp "$OUTPUT_FILE" "gs://$GCP_BUCKET/$GCP_OBJECT"
