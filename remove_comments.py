import re
import sys
import os, shutil

def remove_comments(file_path, output_path):
    with open(file_path, 'r') as file:
        code = file.read()

    # Regex to remove single-line and multi-line comments

    # -- matches two dashes at start
    # \[\[ matches the opening [[ of multiline
    # [\s\S]* matches any character, including newlines
    #         * is lazy match, stops at first ]]
    # \]\] matches closing ]]
    no_comments = re.sub(r'--\[\[[\s\S]*?\]\]--', replace_with_empty_lines, code)

    # (?<!\[) negative lookbehind ensures -- is not preceded by [
    # -- matches two dashes at start
    # [^\[] matches any character that is NOT [
    # .* matches the rest of the line after --, up to end of line
    no_comments = re.sub(r'(?<!\[)--[^\[].*', '', no_comments)

    with open(output_path, 'w') as output_file:
        output_file.write(no_comments)

# Function to replace each match
def replace_with_empty_lines(match):
    comment = match.group(0)            # Extract the comment content
    line_count = comment.count('\n')    # Count lines in the comment block
    return '\n' * line_count            # Replace with that many newlines

if __name__ == "__main__":
    folder = './output'

    # Empty the output folder
    for filename in os.listdir(folder):
        file_path = os.path.join(folder, filename)
        try:
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                shutil.rmtree(file_path)
        except Exception as e:
            print('Failed to delete %s. Reason: %s' % (file_path, e))

    # Get arguments after current file
    files = sys.argv[1:]

    """
    files = [
        "file1.lua", "file1_out.lua",
        "file2.lua", "file2_out.lua",
        "file3.lua", "file3_out.lua",
        ...
    ]
    """

    # Clean up all files
    while len(files)!=0:
        file_in = files.pop(0)
        file_out = files.pop(0)
        remove_comments(file_in, f"./output/{file_out}")
