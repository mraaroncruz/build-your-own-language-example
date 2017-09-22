# Language output

## Top Level Data Structure
```json
{
    "rasa_nlu_data": {
        "common_examples": [],
        "regex_features" : [],
        "entity_synonyms": []
    }
}
```


## Common Example... Example

```json
{
  "text": "show me chinese restaurants",
  "intent": "restaurant_search",
  "entities": [
    {
      "start": 8,
      "end": 15,
      "value": "chinese",
      "entity": "cuisine"
    }
  ]
}
```

## Proposed Language Syntax

```

Examples

intent restaurant_search
show me chinese restaurants       // cuisine=chinese
tell me about chinese restaurants // cuisine=chinese
show me mexican restaurants       // cuisine=mexican
search for indonesian restaurants // cuisine=indonesian

intent "greet"
hello
hi
what's up
yo
```
