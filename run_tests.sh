#!/bin/bash
# Test suite for vmanage

set -e

# Setup test directory
TEST_DIR="test_run"
rm -rf "$TEST_DIR"
mkdir "$TEST_DIR"
cd "$TEST_DIR"

# Link vmanage to test directory
VMANAGE="../../vmanage"
if [ ! -f "$VMANAGE" ]; then
    VMANAGE="../vmanage"
fi
chmod +x "$VMANAGE"

echo "--- Testing init ---"
"$VMANAGE" init -version 1.23
if [ ! -f VersionNum ]; then
    echo "Error: VersionNum not created"
    exit 1
fi
grep -q "Module_MajorVersion             \"1.23\"" VersionNum
grep -q "Module_Version                  123" VersionNum

echo "--- Testing update with multiple files ---"
touch VersionAsm
touch VersionBas,ffb
touch VersionFortran
touch VersionD
touch VersionRust
"$VMANAGE" update

echo "Checking VersionNum..."
grep -q "Module_MajorVersion             \"1.23\"" VersionNum

echo "Checking VersionAsm..."
grep -q "Module_MajorVersion       SETS   \"1.23\"" VersionAsm
grep -q "Module_Version            SETA   123" VersionAsm

echo "Checking VersionBas..."
# Basic file is binary, but we can check if it's non-empty
if [ ! -s VersionBas,ffb ]; then
    echo "Error: VersionBas,ffb is empty"
    exit 1
fi

echo "Checking VersionFortran..."
grep -q "Module_MajorVersion = \"1.23\"" VersionFortran
grep -q "integer, parameter :: Module_Version = 123" VersionFortran

echo "Checking VersionD..."
grep -q "enum string Module_MajorVersion = \"1.23\";" VersionD
grep -q "enum int Module_Version = 123;" VersionD

echo "Checking VersionRust..."
grep -q "pub const Module_MajorVersion: &str = \"1.23\";" VersionRust
grep -q "pub const Module_Version: i32 = 123;" VersionRust

echo "--- Testing increment ---"
"$VMANAGE" inc
grep -q "Module_MajorVersion             \"1.24\"" VersionNum
grep -q "Module_MajorVersion       SETS   \"1.24\"" VersionAsm
grep -q "Module_MajorVersion = \"1.24\"" VersionFortran
grep -q "enum string Module_MajorVersion = \"1.24\";" VersionD
grep -q "pub const Module_MajorVersion: &str = \"1.24\";" VersionRust

echo "--- Testing set ---"
"$VMANAGE" set 2.05
grep -q "Module_MajorVersion             \"2.05\"" VersionNum
grep -q "Module_MajorVersion       SETS   \"2.05\"" VersionAsm
grep -q "Module_MajorVersion = \"2.05\"" VersionFortran
grep -q "enum string Module_MajorVersion = \"2.05\";" VersionD
grep -q "pub const Module_MajorVersion: &str = \"2.05\";" VersionRust

echo "--- All tests passed successfully ---"
cd ..
rm -rf "$TEST_DIR"
