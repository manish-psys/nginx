#!/bin/bash
# Setup script for the nginx ansible role project
# This script creates a virtual environment and installs dependencies

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="${PROJECT_ROOT}/venv"

echo "Setting up Python virtual environment for nginx ansible role..."

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is required but not found"
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment..."
    python3 -m venv "$VENV_DIR"
fi

# Activate virtual environment
echo "Activating virtual environment..."
source "$VENV_DIR/bin/activate"

# Upgrade pip
echo "Upgrading pip..."
pip install --upgrade pip

# Install requirements
if [ -f "$PROJECT_ROOT/requirements.txt" ]; then
    echo "Installing Python requirements..."
    pip install -r "$PROJECT_ROOT/requirements.txt"
fi

# Install ansible collections
if [ -f "$PROJECT_ROOT/requirements.yml" ]; then
    echo "Installing Ansible collections..."
    ansible-galaxy collection install -r "$PROJECT_ROOT/requirements.yml"
fi

echo "Setup completed successfully!"
echo ""
echo "To activate the virtual environment manually, run:"
echo "  source venv/bin/activate"
echo ""
echo "To run molecule tests:"
echo "  source venv/bin/activate"
echo "  cd roles/nginx"
echo "  molecule test"
