# Hackintosh Lifeboat

Hackintosh Lifeboat is a lightweight TUI (Text User Interface) utility for macOS designed to create bit-perfect, compressed recovery images.

![Hackintosh Lifeboat Demo](assets/hackintosh-lifeboat.gif)

## Features

- **Bit-Perfect Backups**: Captures the entire physical disk, including hidden EFI partitions.
- **Universal Format**: Saves as `.img.gz`, compatible with Rufus and balenaEtcher.
- **TUI Interface**: Professional terminal interface with real-time progress.

## Installation

**Clone the repo**:

```bash
git clone https://github.com/your-repo/Hackintosh-Lifeboat
cd Hackintosh-Lifeboat
```

**Make it executable**:

```bash
chmod +x Hackintosh-Lifeboat.command
```

**Install Dependencies (Optional)**:

```bash
brew install pv
```

## Usage

Simply double-click `Hackintosh-Lifeboat.command` or run it from your terminal:

```bash
./Hackintosh-Lifeboat.command
```

## How to Restore

**Windows**: Use Rufus and select the `.img.gz` file.

**Mac/Linux**: Use balenaEtcher or `dd`.

## Contributing

Built with ❤️ by Rich Knowles and the Hackintosh community.
