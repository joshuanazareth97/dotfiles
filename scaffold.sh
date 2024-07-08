#! /usr/bin/env bash

os_type=$(uname -s)

case "$os_type" in
    Linux)
        echo "This is Linux."
        ;;
    Darwin)
        echo "This is macOS."
        ;;
    *)
        echo "This is neither Linux nor macOS."
        ;;
esac