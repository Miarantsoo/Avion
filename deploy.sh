#!/bin/bash

# Enable error handling
set -e

# Get project directory
project="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
project_name=$(basename "$project")

# Define paths
webxml="$project/web.xml"
web="$project/web/"
src="$project/src/"
lib="$project/lib/"
assets="$project/assets/"
temp="$project/$project_name"
temp_src="$project/$project_name/temp_src"
webapps="/opt/tomcat/webapps/"  # Adjust this path as needed

# Cleanup previous temporary directories
if [ -d "$temp" ]; then
    rm -rf "$temp"
fi

# Create necessary directories
mkdir -p "$temp/WEB-INF/classes"
mkdir -p "$temp/WEB-INF/lib"
mkdir -p "$temp/WEB-INF/jsp"
mkdir -p "$temp/assets"
mkdir -p "$temp_src"

# Copy assets
cp -r "$assets/"* "$temp/assets/"

# Copy web resources
cp -r "$web/"* "$temp/WEB-INF/jsp/"

# Prepare Java source files
find "$src" -name "*.java" -exec cp {} "$temp_src/" \;

# Build classpath from lib directory
classpath=""
for jar in "$lib"/*.jar; do
    classpath="${classpath}:${jar}"
done

# Compile Java files
cd "$temp_src"
javac -d "$temp/WEB-INF/classes" -cp "$classpath" *.java

# Copy configuration files
cp "$src/application.properties" "$temp/WEB-INF/classes/" 2>/dev/null || true
cp "$webxml" "$temp/WEB-INF/" 2>/dev/null || true

# Remove temporary source directory
rm -rf "$temp_src"

# Copy library JARs
cp -r "$lib/"* "$temp/WEB-INF/lib/"

# Change to project directory
cd "$project"

# Remove existing WAR file if it exists
if [ -f "$webapps/$project_name.war" ]; then
    rm "$webapps/$project_name.war"
fi

# Create WAR file
cd "$temp"
jar -cvf "$project_name.war" .

# Deploy WAR
sudo cp "$project_name.war" "$webapps"

# Cleanup
rm -rf "$temp"

echo "Deployment completed successfully!"