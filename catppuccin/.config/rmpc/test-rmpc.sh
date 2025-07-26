#!/bin/bash
# Test rmpc step by step to isolate ?69h issue

echo "=== RMPC ?69h Debug Test ==="

echo "1. Testing basic rmpc without config..."
timeout 3s rmpc --help > /dev/null 2>&1 && echo "✓ rmpc help works" || echo "✗ rmpc help failed"

echo "2. Testing with minimal config (no theme)..."
# Create minimal config
cat > /tmp/rmpc-minimal.ron << 'EOF'
#![enable(implicit_some)]
#![enable(unwrap_newtypes)]
#![enable(unwrap_variant_newtypes)]
(
    address: "127.0.0.1:6600",
    password: None,
    theme: None,
    enable_mouse: false,
    enable_config_hot_reload: false,
    max_fps: 15,
)
EOF

echo "3. Clearing all terminal escape sequences..."
printf '\e[?1000l\e[?1001l\e[?1002l\e[?1003l\e[?1004l\e[?1005l\e[?1006l\e[?1015l\e[?69l'
printf '\e[?25h\e[0m'

echo "4. Testing rmpc with minimal config..."
echo "If you see ?69h, press Ctrl+C immediately"
echo "Starting in 3 seconds..."
sleep 3

# Run with output capture
timeout 5s rmpc --config /tmp/rmpc-minimal.ron 2>&1 | head -10

echo "5. Cleaning up..."
printf '\e[?1000l\e[?1001l\e[?1002l\e[?1003l\e[?1004l\e[?1005l\e[?1006l\e[?1015l\e[?69l'
printf '\e[?25h\e[0m'

rm -f /tmp/rmpc-minimal.ron
echo "Test completed."