#!/usr/bin/env bash
# =============================================================================
# setup-godot-project.sh
#
# Usage: Run from the root directory AFTER creating your Godot project in
#        a subdirectory via the Godot editor UI.
#
# Before running, you can optionally set the Godot SDK version to match
# your editor version. Check it via: Godot editor > Help > About
#
#   GODOT_SDK_VERSION=4.4.0 ./setup-godot-project.sh
#
# Result:
#   root/
#     ProjectName.sln
#     ProjectName.Game/
#       ProjectName.Game.csproj
#       project.godot
#       Code/
#       Scenes/
#
# Requirements: dotnet CLI, bash (Git Bash or WSL on Windows)
# =============================================================================

set -euo pipefail

# --- Locate project.godot (search one level deep) ---
GODOT_PROJECT_FILE=$(find . -maxdepth 2 -name "project.godot" | head -1)

if [[ -z "$GODOT_PROJECT_FILE" ]]; then
    echo "Error: No project.godot found in any subdirectory."
    echo "Please create your Godot project in a subdirectory first, then re-run this script."
    exit 1
fi

GAME_DIR=$(dirname "$GODOT_PROJECT_FILE")
GAME_DIR="${GAME_DIR#./}"  # strip leading ./

# --- Read project name from project.godot ---
PROJECT_NAME=$(sed -n 's/^config\/name="\(.*\)"/\1/p' "$GODOT_PROJECT_FILE")

if [[ -z "$PROJECT_NAME" ]]; then
    echo "Error: Could not read config/name from $GODOT_PROJECT_FILE."
    echo "Make sure the project.godot file contains a line like: config/name=\"MyProject\""
    exit 1
fi

echo "Project name: $PROJECT_NAME"

GAME_PROJECT_DIR="${PROJECT_NAME}.Game"
CSPROJ_FILENAME="${PROJECT_NAME}.Game.csproj"
SLN_FILENAME="${PROJECT_NAME}.sln"

# --- Rename game directory if needed ---
if [[ "$GAME_DIR" != "$GAME_PROJECT_DIR" ]]; then
    echo "Renaming '$GAME_DIR' -> '$GAME_PROJECT_DIR'"
    mv "$GAME_DIR" "$GAME_PROJECT_DIR"
else
    echo "Game directory already named correctly: $GAME_PROJECT_DIR"
fi

# --- Create Code/ and Scenes/ subdirectories ---
mkdir -p "$GAME_PROJECT_DIR/Code"
mkdir -p "$GAME_PROJECT_DIR/Scenes"
echo "Created Code/ and Scenes/ directories."

# --- Create .csproj ---
CSPROJ_PATH="$GAME_PROJECT_DIR/$CSPROJ_FILENAME"

if [[ -f "$CSPROJ_PATH" ]]; then
    echo "Skipping .csproj creation — already exists: $CSPROJ_PATH"
else
    # Default SDK version. Override via: GODOT_SDK_VERSION=4.x.x ./setup-godot-project.sh
    GODOT_SDK_VERSION="${GODOT_SDK_VERSION:-4.3.0}"

    cat > "$CSPROJ_PATH" << EOF
<Project Sdk="Godot.NET.Sdk/${GODOT_SDK_VERSION}">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <EnableDynamicLoading>true</EnableDynamicLoading>
    <RootNamespace>${PROJECT_NAME}</RootNamespace>
  </PropertyGroup>
</Project>
EOF
    echo "Created $CSPROJ_PATH (Godot.NET.Sdk/$GODOT_SDK_VERSION)"
fi

# --- Create .sln ---
if [[ -f "$SLN_FILENAME" ]]; then
    echo "Skipping .sln creation — already exists: $SLN_FILENAME"
else
    dotnet new sln -n "$PROJECT_NAME"
    echo "Created $SLN_FILENAME"
fi

# --- Add .csproj to .sln ---
dotnet sln "$SLN_FILENAME" add "$CSPROJ_PATH"
echo "Added $CSPROJ_FILENAME to $SLN_FILENAME"

# --- Done ---
echo ""
echo "Done! Final structure:"
echo "."
echo "├── $SLN_FILENAME"
echo "└── $GAME_PROJECT_DIR/"
echo "    ├── project.godot"
echo "    ├── $CSPROJ_FILENAME"
echo "    ├── Code/"
echo "    └── Scenes/"
echo ""
echo "NOTE: If your Godot version is not 4.3.0, update the SDK version in:"
echo "      $CSPROJ_PATH"
echo "      Or re-run with: GODOT_SDK_VERSION=4.x.x ./setup-godot-project.sh"
