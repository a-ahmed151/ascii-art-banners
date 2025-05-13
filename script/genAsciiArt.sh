#!/bin/bash
if [ "$#" -ne 1 ]; then 
  echo "Usage: wants [banner.flf]"
  exit 1
fi
if [[ "$1" != *".flf" ]]; then
  echo "the banner file '$1' must be in .flf format"
  exit 1
fi
# variables
banner_font="$1"
output_file="../${banner_font%.flf}.txt"
# Check if figlet is installed
if ! command -v figlet &> /dev/null
then
    echo "figlet is not installed. Please install it (e.g., sudo apt-get install figlet) and try again."
    exit 1
fi

# Clear the output file if it exists
> "$output_file"

# Add a newline at the beginning of the file
echo "" >> "$output_file"

for i in $(seq 32 126); do
    # Convert ASCII code to character
    char=$(printf "\\$(printf '%03o' $i)")

    figlet -f $banner_font "$char" >> "$output_file"
    if (( i != 126 )); then
    echo "" >> "$output_file"
    fi
    echo "Processed character: $char"
done

echo "FIGlet output written to $output_file using banner $banner_font"
