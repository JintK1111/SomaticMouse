def calculate_value(input_string):
    values = {'D': -1, 'I': 1, 'M': 0, 'N': 0, 'F': 0}

    total_value = 0
    i = 0

    while i < len(input_string):
        current_char = input_string[i]
        count_str = ''
        i += 1

        while i < len(input_string) and input_string[i].isdigit():
            count_str += input_string[i]
            i += 1

        count = int(count_str) if count_str else 1

        if current_char in values:
            total_value += count * values[current_char]

    return total_value

def process_input_file(file_path):
    with open(file_path, 'r') as file:
        for line in file:
            input_string = line.strip()
            value = calculate_value(input_string)
            print(f"Value for input string '{input_string}' is {value}")

if __name__ == "__main__":
    input_file_path = 'cigar_strings.txt'  # Path to the extracted CIGAR strings file
    process_input_file(input_file_path)