# Project: Declarative NixOS Workstation Migration & Guided Learning

Primary Directive for Agent
Act as a technical mentor and educational guide. My primary goal is not just to achieve a working system, but to deeply understand the Nix ecosystem. Do not simply output the final code. Instead, walk me through the concepts (Nix Flakes, Home Manager, Lanzaboote, TPM2 binding), explain the "why" behind configuration choices, and guide me step-by-step so I can learn how to build, troubleshoot, and maintain this setup myself.

Additionally, the agent must adhere to the following constraints:
* The current environment in which the agent is running is not NixOS and does not have any Nix tools.
* The agent should not scaffold any files unless strictly asked (e.g., "I want you to ...").

## Current Infrastructure State

    Environment: Virtual Machine (Staging environment for future physical hardware deployment).

    Hardware Features: Secure Boot and emulated TPM2 module enabled (AMD GPUs on physical target hardware).

    Disk Layout: Successfully provisioned declaratively via disko. Single disk, 1GB EFI partition, and LUKS encryption taking the remainder.

    File System: BTRFS inside the LUKS container. Subvolumes are provisioned and mounted for / (root), /nix, /home, /var/log, /var/lib, /swap (containing an 8GB swapfile), and an empty /persist placeholder for future system impermanence.

    Version Control: Git repository is initialized and synced with the VM for managing .nix configuration files.

## Core Architecture Objectives

    Configuration Management: 100% reproducible multi-host system (targeting both Linux desktop/laptop and macOS) managed via Nix Flakes, Home Manager, nix-darwin, and flake-parts to maintain a modular and scalable structure. User-space configurations are split into a shared core (e.g., development tools, shell settings) and host-specific Home Manager modules (e.g., isolating desktop gaming/graphics concerns). System-level hardware support is configured for AMD GPUs, including hardware video acceleration (VA-API) and enabling proprietary codecs via unfree packages.

    Boot & Security: Implement Lanzaboote to replace the default bootloader for Secure Boot compatibility. Bind the LUKS encryption container to the TPM2 module using systemd-cryptenroll to enable auto-unlock, while retaining the passphrase in Slot 0 as a secure fallback.

    Development Workflow Integration: The host system configuration must be optimized for resource efficiency by prioritizing native toolchains. A primary goal is configuring Podman and Devbox natively to manage isolated environments, effectively replacing heavy compute-resource virtualization like VS Code Devcontainers.

    Target Development Stack: The system will serve as a primary workstation for .NET 8 development (including standalone script-based installations of .NET Aspire) and mobile application development pipelines (Expo/EAS).

    Application Sandboxing: Enable Flatpak support to run proprietary/social GUI applications (e.g., Spotify, Discord) in a sandboxed environment, keeping them isolated from the core development workstation settings, with the option to manage them declaratively.

    Memory Optimization: Configure zswap with zstd compression and z3fold allocator to act as a compressed cache in front of the physical swapfile, reducing SSD wear and improving responsiveness under load.

    Future Goal - Impermanence: Later migrate the physical hosts to a fully impermanent system (wiping root BTRFS subvolume on boot) by leveraging the `preservation` module to declaratively manage persistent files and directories over the `/persist` subvolume.

## Next Immediate Steps for the Agent

    Flake Foundation: Guide me through scaffolding the base flake.nix and configuration.nix files, explaining how inputs and outputs connect.

    Disko Integration: Show me how to properly import and integrate my existing disko.nix into the new flake structure.

    Home Manager Introduction: Explain the foundational concepts of Home Manager and help me construct my first basic user configuration.

    Secure Boot Implementation: Walk me through configuring Lanzaboote, ensuring I understand how it takes over from the standard systemd-boot to sign the binaries for the UEFI.