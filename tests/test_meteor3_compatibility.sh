#!/bin/bash
# Test script to validate the Meteor 3.x Docker image setup

set -e

echo "=== Testing Meteor 3.x Docker Image ==="

# Test Node.js version
echo "Testing Node.js version..."
docker run --rm --entrypoint="" otud/meteord3.x_imagemagick:base node --version | grep "v22.16.0" || {
    echo "ERROR: Expected Node.js v22.16.0"
    exit 1
}
echo "✓ Node.js version correct"

# Test ImageMagick availability
echo "Testing ImageMagick availability..."
docker run --rm --entrypoint="" otud/meteord3.x_imagemagick:base convert -version | grep "ImageMagick" || {
    echo "ERROR: ImageMagick not found"
    exit 1
}
echo "✓ ImageMagick available"

# Test Python3 availability
echo "Testing Python3 availability..."
docker run --rm --entrypoint="" otud/meteord3.x_imagemagick:base python3 --version | grep "Python 3" || {
    echo "ERROR: Python 3 not found"
    exit 1
}
echo "✓ Python 3 available"

echo "=== All tests passed! ==="
echo "The Docker image is ready for Meteor 3.x applications."
