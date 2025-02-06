import json

def format_json_file(input_file, output_file):
    try:
        # Read the raw JSON data from the input file
        with open(input_file, 'r') as infile:
            raw_json = infile.read()
        
        # Parse the string into a Python dictionary
        parsed_json = json.loads(raw_json)
        
        # Format it back to a pretty-printed JSON string
        formatted_json = json.dumps(parsed_json, indent=4, separators=(",", ": "))
        
        # Save the formatted JSON to the output file
        with open(output_file, 'w') as outfile:
            outfile.write(formatted_json)
        
        print(f"Formatted JSON has been saved to {output_file}")
    
    except ValueError as e:
        print(f"Invalid JSON in {input_file}: {e}")
    except FileNotFoundError as e:
        print(f"File not found: {e}")

# Example usage
input_json_file = 'react_set_unclean.json'
output_json_file = 'react_set.json'
format_json_file(input_json_file, output_json_file)
