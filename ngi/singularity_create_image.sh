#!/bin/bash

# Get hostname
HOSTNAME=$(hostname)

# Check if hostname starts with "builder"
if [[ "$HOSTNAME" != builder* ]]
then
    echo "ERROR: Hostname does not start with 'builder'."
    exit 1
fi

# Set default value for OUTPUT_PATH
OUTPUT_PATH=""

# Loop through input arguments and retrieve the value of the parameter that has not been filled
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -o|--output)
        OUTPUT_PATH="$2"
        shift
        shift
        ;;
        *)
        shift
        ;;
    esac
done

# Check if OUTPUT_PATH has been filled
if [ -z "$OUTPUT_PATH" ]
then
    echo "ERROR: Please specify an output path using the -o or --output parameter."
    exit 1
fi

# Check if output folder already exists
if [ -d "$OUTPUT_PATH" ]
then
    echo "ERROR: Output folder already exists. Please choose a different path."
    exit 1
fi

# Setting up the Singularity environment

BASE_PATH="/storage/brno2/home/$LOGNAME"
NGC_PATH="$BASE_PATH/ngc"

echo "INFO: NGC_PATH is $NGC_PATH"

export SINGULARITY_CACHEDIR="$BASE_PATH/.singularity"

# Check if singularity cache dir exists
if [ -d "$SINGULARITY_CACHEDIR" ]
then
    echo "INFO: Singularity cache dir: $SINGULARITY_CACHEDIR"
else
    # If folder does not exist, create it and print its path
    mkdir -p "$SINGULARITY_CACHEDIR"
    echo "INFO: Created singularity cache dir: $SINGULARITY_CACHEDIR"
fi
