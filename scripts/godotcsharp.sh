#!/bin/bash

# Usage:
#------------------------------------------------------------------------------
# First, create a new Godot project using the Godot editor with whatever settings you like. Then, in a terminal, navigate to the root directory of that project and run this script.

# Description:
#------------------------------------------------------------------------------
# This script creates the following project structure:
# root/
#   .git/
#   ProjectName.sln
#   ProjectName/
#     ProjectName.csproj
#     project.godot
#     Code/
#     Scenes/
#   ProjectName.Tests/
#  
# Finally, it initializes a git repository if one doesn't already exist and replaces the .gitignore file with a more complete one.

# Check if this has been updated:
# https://forum.godotengine.org/t/c-multi-project-setup/56057
# https://github.com/godotengine/godot/pull/106031

set -euo pipefail

echo "***Creating dotnet solution and projects..."

GODOT_PROJECT_NAME=$(basename "$PWD")

rm -f .gitignore # A fuller gitignore will be created by the ghinit script at the end of this script
mkdir Code
mkdir Code/"$GODOT_PROJECT_NAME"
mkdir Scenes

# Update project.godot file to add solution directory property
# sed -i '/^project\/assembly_name=/a project/solution_directory="Code"' project.godot

dotnet new sln -n "$GODOT_PROJECT_NAME"
dotnet new classlib -n "$GODOT_PROJECT_NAME"
rm "$GODOT_PROJECT_NAME"/Class1.cs
dotnet sln add "$GODOT_PROJECT_NAME".csproj

dotnet new xunit --output Code --name "$GODOT_PROJECT_NAME".Tests
dotnet sln add Code/"$GODOT_PROJECT_NAME".Tests/"$GODOT_PROJECT_NAME".Tests.csproj
dotnet add Code/"$GODOT_PROJECT_NAME".Tests reference "$GODOT_PROJECT_NAME"/"$GODOT_PROJECT_NAME".csproj

# Path to files and templates
echo "***Getting file templates for project generation..."

SOLUTION_FILE="${GODOT_PROJECT_NAME}.sln"
GAME_CSPROJ_FILE="${GODOT_PROJECT_NAME}/${GODOT_PROJECT_NAME}.csproj"
SOLUTION_TEMPLATE_FILE="${BASH_SOURCE[0]%/*}/godotcsharp_Resources/SolutionConfigSectionTemplate.txt"
CSPROJ_TEMPLATE_FILE="${BASH_SOURCE[0]%/*}/godotcsharp_Resources/GameProject.csproj"
EXAMPLE_NODE_FILE="${BASH_SOURCE[0]%/*}/godotcsharp_Resources/ExampleNode.cs"

# Check template files exist
if [ ! -f "$SOLUTION_TEMPLATE_FILE" ]; then
    echo "Error: Solution template file not found at $SOLUTION_TEMPLATE_FILE"
    exit 1
fi

if [ ! -f "$CSPROJ_TEMPLATE_FILE" ]; then
    echo "Error: .csproj template file not found at $CSPROJ_TEMPLATE_FILE"
    exit 1
fi

if [ ! -f "$EXAMPLE_NODE_FILE" ]; then
    echo "Error: ExampleNode.cs file not found at $EXAMPLE_NODE_FILE"
    exit 1
fi

echo "***Updating solution file with project GUIDS and runtimes and game project with Godot SDK..."

# Replace game project .csproj and example class with Godot templates
sed "s/%ProjectName%/$GODOT_PROJECT_NAME/g" "$CSPROJ_TEMPLATE_FILE" > "$GAME_CSPROJ_FILE"
sed "s/%ProjectName%/$GODOT_PROJECT_NAME/g" "$EXAMPLE_NODE_FILE" > "Code/${GODOT_PROJECT_NAME}/ExampleNode.cs"

# Extract project GUIDs
GAME_PROJECT_GUID=""
TEST_PROJECT_GUID=""

while IFS= read -r line; do
    if [[ $line =~ Project.*=.*\"([^\"]+)\".*\"([^\"]+)\".*\"\{([^}]+)\}\" ]]; then
        PROJECT_NAME="${BASH_REMATCH[1]}"
        PROJECT_GUID="${BASH_REMATCH[3]}"
        
        if [[ $PROJECT_NAME == *.Tests ]]; then
            TEST_PROJECT_GUID="$PROJECT_GUID"
        else
            GAME_PROJECT_GUID="$PROJECT_GUID"
        fi
    fi
done < "$SOLUTION_FILE"

if [ -z "$GAME_PROJECT_GUID" ] || [ -z "$TEST_PROJECT_GUID" ]; then
    echo "Error: Could not find both game and test project GUIDs"
    exit 1
fi

# Read solution template and replace tokens
TEMPLATE_CONTENT=$(cat "$SOLUTION_TEMPLATE_FILE")
TEMPLATE_CONTENT="${TEMPLATE_CONTENT//%GameProjectGuid%/$GAME_PROJECT_GUID}"
TEMPLATE_CONTENT="${TEMPLATE_CONTENT//%TestProjectGuid%/$TEST_PROJECT_GUID}"

# Replace Global section in solution file
sed -n '/^Global$/q;p' "$SOLUTION_FILE" > "${SOLUTION_FILE}.tmp"
echo "$TEMPLATE_CONTENT" >> "${SOLUTION_FILE}.tmp"
mv "${SOLUTION_FILE}.tmp" "$SOLUTION_FILE"

# Initialize git
echo "***Initializing git repository and creating .gitignore..."
ghinit --localOnly || { echo "Error: ghinit failed to initialize repository"; exit 1; }

echo "***Finished. Godot C# project structure created successfully"