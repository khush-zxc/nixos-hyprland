# NixOS Hyprland

My personal declarative NixOS desktop configuration built around **Hyprland + Noctalia Shell**.

The goal of this project is to maintain a clean, reproducible and portable Linux desktop configuration that can be version-controlled and rebuilt whenever needed.

> **Status:** Active development

---

## ✨ Features

- ❄️ Declarative NixOS configuration
- 🪟 Hyprland Wayland compositor
- 🌙 Noctalia Shell
- 🚀 Automatic Noctalia startup through Hyprland's `hyprland.start` event
- 🎯 Lua-based Hyprland configuration
- 🖥️ Dual-monitor configuration
- 💻 Laptop + external monitor support
- 🔐 UEFI and legacy BIOS boot support
- 🧑‍💻 Development environment
- 🐍 Python
- ☕ Java
- 🧰 Common Linux utilities
- 📦 Reproducible package management
- 🔄 Git-based configuration management

---

## 🖥️ Hardware

Current primary machine:

| Component | Hardware |
|---|---|
| Laptop | HP OMEN 17 |
| CPU | Intel Core i7-13700HX |
| GPU | NVIDIA GeForce RTX 4060 Laptop GPU |
| Integrated GPU | Intel UHD |
| RAM | 16 GB |
| Internal Display | 2560×1440 @ 165 Hz |
| External Display | Samsung C27R50 |
| External Resolution | 1920×1080 @ 60 Hz |

### Monitor Layout

The laptop display is vertically centered relative to the  monitor.

---

## 🧱 Desktop Stack

```text
┌──────────────────────────────┐
│          Noctalia             │
│ Launcher / Dock / Widgets    │
├──────────────────────────────┤
│          Hyprland             │
│       Wayland Compositor      │
├──────────────────────────────┤
│           NixOS               │
│     Declarative System        │
└──────────────────────────────┘
```

### Hyprland

Hyprland handles:

- Window management
- Workspaces
- Keyboard shortcuts
- Monitor configuration
- Window rules
- Animations
- Wayland compositor functionality

The configuration uses **Lua** rather than a traditional `hyprland.conf`.

Configuration:

```text
home/khush/.config/hypr/hyprland.lua
```

---

## 🌙 Noctalia

Noctalia provides the graphical desktop shell.

It is responsible for things such as:

- Application launcher
- Dock
- Notifications
- Control center
- Audio controls
- Network controls
- Bluetooth controls
- Widgets
- Workspace interface

Noctalia is launched through Hyprland:

```lua
hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia")
end)
```

This is intentional.

Instead of relying on a separate systemd user service, Noctalia starts inside the Hyprland session and therefore receives the correct Wayland/session environment.

---

## 📁 Repository Structure

```text
nixos-hyprland/
│
├── hosts/
│   └── omen/
│       ├── configuration.nix
│       └── hardware-configuration.nix
│
├── home/
│   └── khush/
│       └── .config/
│           └── hypr/
│               └── hyprland.lua
│
├── modules/
│   ├── boot.nix
│   ├── desktop.nix
│   ├── development.nix
│   └── packages.nix
│
├── assets/
│   └── screenshots/
│
├── flake.nix
├── flake.lock
├── README.md
└── LICENSE
```

---

## 🚀 Installation

### 1. Clone

```bash
git clone https://github.com/khushkarangill681/nixos-hyprland.git
cd nixos-hyprland
```


---

### 2. Backup your existing configuration

```bash
sudo cp -r /etc/nixos /etc/nixos.backup
```

---

### 3. Copy the configuration

For a flake-based installation:

```bash
sudo cp -r . /etc/nixos/
```

Then rebuild:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#omen
```

---

## 🔄 Updating

Update the flake inputs:

```bash
sudo nix flake update
```

Then rebuild:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#omen
```

---

## 🛠️ Useful Commands

### Rebuild

```bash
sudo nixos-rebuild switch --flake /etc/nixos#omen
```

### Test without switching

```bash
sudo nixos-rebuild test --flake /etc/nixos#omen
```

### Build without activating

```bash
sudo nixos-rebuild build --flake /etc/nixos#omen
```

### Check the configuration

```bash
sudo nixos-rebuild dry-build --flake /etc/nixos#omen
```

### Roll back

```bash
sudo nixos-rebuild switch --rollback
```

---

## 🪟 Hyprland

Check monitors:

```bash
hyprctl monitors
```

Reload configuration:

```bash
hyprctl reload
```

Open Hyprland information:

```bash
hyprctl systeminfo
```

---

## 🌙 Noctalia

Check whether Noctalia is running:

```bash
pgrep -a noctalia
```

Start manually:

```bash
noctalia
```

The normal configuration starts it automatically when Hyprland starts.

---

## 🧑‍💻 Development Environment

The configuration is intended to provide a practical development environment rather than an enormous collection of packages.

Current development tooling includes:

- Python
- Java
- Git
- VS Code
- IntelliJ IDEA
- Shell utilities
- Build tools
- General Linux development utilities

Additional software should preferably be added declaratively through the Nix configuration instead of being manually installed.

---

## 🔐 Boot Configuration

This system is designed around a portable external NixOS installation.

The boot configuration supports both:

```text
UEFI
```

and:

```text
Legacy BIOS
```

This allows the installation to be moved between compatible machines without maintaining completely separate operating-system installations.

---

## 📌 Design Goals

This configuration follows a few principles:

### Declarative

System configuration should live in Nix files whenever possible.

### Reproducible

The system should be rebuildable from the repository.

### Portable

The configuration should not depend unnecessarily on one specific machine.

### Minimal

Only software that is actually useful should be included.

### Modular

Desktop, development, boot and package configuration should remain separated as the project grows.

### Version Controlled

Configuration changes should be tracked through Git.

---

## 🗺️ Roadmap

- [x] NixOS installation
- [x] Hyprland
- [x] Lua Hyprland configuration
- [x] Noctalia Shell
- [x] Automatic Noctalia startup
- [x] Dual-monitor configuration
- [x] Development environment
- [ ] Complete Flake migration
- [ ] Home Manager integration
- [ ] Better hardware abstraction
- [ ] Automatic installation script
- [ ] Portable machine profiles
- [ ] Laptop-specific modules
- [ ] Desktop-specific modules
- [ ] Custom themes
- [ ] More Noctalia customization
- [ ] Screenshots and documentation
- [ ] CI configuration validation

---

## ⚠️ Disclaimer

This configuration is primarily designed for my own hardware and workflow.

Do **not** blindly copy the hardware configuration to another machine.

In particular, review:

```text
hardware-configuration.nix
```

before rebuilding on another system.

Hardware configuration, disk identifiers, boot settings and GPU configuration may need to be changed.

---

## 📜 License

This configuration is provided under the MIT License.

See [LICENSE](LICENSE) for details.

---

## ⭐ If You Find It Useful

Feel free to fork the configuration, experiment with it, and adapt it to your own NixOS setup.

Linux is supposed to be fun.

```text
NixOS + Hyprland + Noctalia
        ↓
    customize
        ↓
      break
        ↓
      rebuild
        ↓
      repeat
```
