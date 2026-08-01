# Description:
#
# This script creates the following project structure:
# ProjectName/
#   .git/
#   .gitignore
#   ProjectName.sln
#   ProjectName/
#     ProjectName.Game.csproj
#     project.godot
#     Code/
#     Scenes/
#   ProjectName.Game.Tests/
#
# It also initializes a git repository if one doesn't already exist and replaces the .gitignore file with a more complete one.
#
# Usage:
#
# 1. Create a new Godot project
# 2. In the editor, run Project > Tools > C# > Create C# solution
# 3. Run this script from the root directory

set -euo pipefail

# Get value between quotes after config/name= in project.godot
GODOT_PROJECT_NAME=$(sed -n 's/^config\/name="\(.*\)"/\1/p' project.godot)

if [[ -z "$GODOT_PROJECT_NAME" ]]; then
    echo "Error: Could not read config/name from project.godot. Make sure you are running this script from the Godot project directory."
    exit 1
fi

# A fuller gitignore will be created by the ghinit script at the end of this, so remove the default one created by Godot
rm -f .gitignore

echo "***Moving + renaming Godot csproj and updating sln..."

GAME_DIR="${GODOT_PROJECT_NAME}.Game"
OLD_CSPROJ_FILE="${GODOT_PROJECT_NAME}.csproj"
NEW_CSPROJ_FILE="${GODOT_PROJECT_NAME}.Game.csproj"
SLN_FILE="${GODOT_PROJECT_NAME}.sln"

# Move csproj and project.godot into its own folder; rename the .csproj
mkdir "$GAME_DIR"
mv "$OLD_CSPROJ_FILE" "$GAME_DIR/$NEW_CSPROJ_FILE"
mv project.godot "$GAME_DIR/"

# Update the .sln with the new path + name for the csproj
sed -i "s|\"${OLD_CSPROJ_FILE}\"|\"${GAME_DIR}/${NEW_CSPROJ_FILE}\"|g" "$SLN_FILE"

# Update the project display name in the .sln to match the new csproj name
sed -i "s|= \"${GODOT_PROJECT_NAME}\", |= \"${GODOT_PROJECT_NAME}.Game\", |g" "$SLN_FILE"


# Create an xUnit test project with the same name as the Godot project but with ".Tests" on the end
echo "***Adding test project..."

TESTS_DIR="${GODOT_PROJECT_NAME}.Game.Tests"
dotnet new xunit -n "$TESTS_DIR" -o "$TESTS_DIR"
dotnet sln "$SLN_FILE" add "$TESTS_DIR/$TESTS_DIR.csproj"
dotnet add "$TESTS_DIR/$TESTS_DIR.csproj" reference "$GAME_DIR/$NEW_CSPROJ_FILE"
touch "$TESTS_DIR/.gdignore"

# Initialize git
echo "***Initializing git repository and creating .gitignore..."
ghinit --localOnly

echo "***Finished. Godot C# project structure created successfully"