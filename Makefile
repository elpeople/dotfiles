# Dotfiles Makefile for GNU Stow management

.PHONY: help install uninstall reinstall list status clean check

# Default target
help:
	@echo "Dotfiles management using GNU Stow"
	@echo ""
	@echo "Available targets:"
	@echo "  install     - Install all packages"
	@echo "  uninstall   - Uninstall all packages"
	@echo "  reinstall   - Reinstall all packages"
	@echo "  list        - List available packages"
	@echo "  status      - Show current stow status"
	@echo "  check       - Check for conflicts"
	@echo "  clean       - Clean up broken symlinks"
	@echo "  help        - Show this help message"
	@echo ""
	@echo "Package-specific targets:"
	@echo "  install-<package>   - Install specific package"
	@echo "  uninstall-<package> - Uninstall specific package"
	@echo ""
	@echo "Examples:"
	@echo "  make install-zsh    - Install zsh configuration"
	@echo "  make install        - Install all packages"

# Available packages
PACKAGES := bash zsh vim tmux i3 ranger wezterm lazygit local_bin w3m nvim screen

# Check if stow is installed
check-stow:
	@which stow > /dev/null || (echo "Error: GNU Stow is not installed" && exit 1)

# Install all packages
install: check-stow
	@echo "Installing all packages..."
	@for package in $(PACKAGES); do \
		if [ -d "$$package" ]; then \
			echo "Installing $$package..."; \
			stow $$package || echo "Failed to install $$package"; \
		else \
			echo "Package $$package not found, skipping..."; \
		fi; \
	done
	@echo "Installation complete!"

# Uninstall all packages
uninstall: check-stow
	@echo "Uninstalling all packages..."
	@for package in $(PACKAGES); do \
		if [ -d "$$package" ]; then \
			echo "Uninstalling $$package..."; \
			stow -D $$package || echo "Failed to uninstall $$package"; \
		fi; \
	done
	@echo "Uninstallation complete!"

# Reinstall all packages
reinstall: uninstall install

# List available packages
list:
	@echo "Available packages:"
	@for package in $(PACKAGES); do \
		if [ -d "$$package" ]; then \
			echo "  ✓ $$package"; \
		else \
			echo "  ✗ $$package (not found)"; \
		fi; \
	done

# Show current status
status: check-stow
	@echo "Current stow status:"
	@for package in $(PACKAGES); do \
		if [ -d "$$package" ]; then \
			printf "  $$package: "; \
			if stow -n $$package 2>&1 | grep -q "WARNING"; then \
				echo "installed"; \
			else \
				echo "not installed"; \
			fi; \
		fi; \
	done

# Check for conflicts
check: check-stow
	@echo "Checking for conflicts..."
	@for package in $(PACKAGES); do \
		if [ -d "$$package" ]; then \
			echo "Checking $$package..."; \
			stow -n $$package || true; \
		fi; \
	done

# Clean up broken symlinks
clean:
	@echo "Cleaning up broken symlinks in home directory..."
	@find ~ -maxdepth 1 -type l ! -exec test -e {} \; -print -delete 2>/dev/null || true
	@find ~/.config -maxdepth 1 -type l ! -exec test -e {} \; -print -delete 2>/dev/null || true
	@echo "Cleanup complete!"

# Package-specific install targets
$(addprefix install-,$(PACKAGES)): install-%: check-stow
	@if [ -d "$*" ]; then \
		echo "Installing $*..."; \
		stow $*; \
	else \
		echo "Package $* not found"; \
		exit 1; \
	fi

# Package-specific uninstall targets
$(addprefix uninstall-,$(PACKAGES)): uninstall-%: check-stow
	@if [ -d "$*" ]; then \
		echo "Uninstalling $*..."; \
		stow -D $*; \
	else \
		echo "Package $* not found"; \
		exit 1; \
	fi

# Package-specific reinstall targets
$(addprefix reinstall-,$(PACKAGES)): reinstall-%: uninstall-% install-%