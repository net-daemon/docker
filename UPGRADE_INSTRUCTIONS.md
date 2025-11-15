# Upgrading to a New .NET Version

## For Humans 👤
**Use an AI assistant (like GitHub Copilot) to perform this upgrade.**
Simply provide this instruction file to your AI assistant and ask it to upgrade to the next .NET version.

## For AI Agents 🤖
This guide provides structured instructions for upgrading NetDaemon Docker images to a new .NET version (e.g., from .NET 10 to .NET 11).

## AI Agent Instructions

When upgrading to a new .NET version, create and modify the following files systematically:

### 1. Create New Dockerfiles

**ACTION:** Create two new Dockerfile files by copying from the previous version.

**File 1:** `base/Dockerfile{NEW_VERSION}`
- Source: Copy from `base/Dockerfile{PREVIOUS_VERSION}`
- Required change: Line 2 must be updated
- FROM clause pattern: `FROM mcr.microsoft.com/dotnet/sdk:{NEW_VERSION}.0`
- Example: For .NET 11, use `FROM mcr.microsoft.com/dotnet/sdk:11.0`

**File 2:** `addon_base/Dockerfile{NEW_VERSION}`
- Source: Copy from `addon_base/Dockerfile{PREVIOUS_VERSION}`  
- Required change: Line 2 must be updated
- FROM clause pattern: `FROM ghcr.io/net-daemon/netdaemon_base:{NEW_VERSION}`
- Example: For .NET 11, use `FROM ghcr.io/net-daemon/netdaemon_base:11`

### 2. Create New GitHub Workflow Files

**ACTION:** Create two new workflow YAML files by copying from the previous version.

**File 1:** `.github/workflows/build.base{NEW_VERSION}.yaml`
- Source: Copy from `.github/workflows/build.base{PREVIOUS_VERSION}.yaml`
- Required changes:
  - Line ~2: Update workflow name: `name: 📦 Deploy to netdaemon_base .NET {NEW_VERSION}`
  - Line ~8: Update job name: `name: 📦 Deploy to netdaemon_base .NET {NEW_VERSION}`
  - Line ~36: Update Dockerfile path: `--file ./base/Dockerfile{NEW_VERSION} . \`
  - Lines ~38-39: Update image tags to `:{NEW_VERSION}` in both tag lines

**File 2:** `.github/workflows/build.addonbase{NEW_VERSION}.yaml`
- Source: Copy from `.github/workflows/build.addonbase{PREVIOUS_VERSION}.yaml`
- Required changes:
  - Line ~2: Update workflow name: `name: 📦 Deploy to netdaemon_addonbase .NET {NEW_VERSION}`
  - Line ~36: Update Dockerfile path: `--file ./addon_base/Dockerfile{NEW_VERSION} . \`
  - Lines ~38-39: Update image tags to `:{NEW_VERSION}` in both tag lines

## AI Agent Execution Checklist

Execute these tasks in order:

- [ ] Create `base/Dockerfile{NEW_VERSION}` from previous version
- [ ] Update FROM line in `base/Dockerfile{NEW_VERSION}` to use SDK version `{NEW_VERSION}.0`
- [ ] Create `addon_base/Dockerfile{NEW_VERSION}` from previous version
- [ ] Update FROM line in `addon_base/Dockerfile{NEW_VERSION}` to reference base image `:{NEW_VERSION}`
- [ ] Create `.github/workflows/build.base{NEW_VERSION}.yaml` from previous version
- [ ] Update workflow name, job name, Dockerfile path, and both image tags in base workflow
- [ ] Create `.github/workflows/build.addonbase{NEW_VERSION}.yaml` from previous version
- [ ] Update workflow name, Dockerfile path, and both image tags in addonbase workflow

## Summary for AI Agents

**Total files to create:** 4
- 2 Dockerfiles (base and addon_base)
- 2 GitHub workflow files (build.base and build.addonbase)

**Pattern matching rule:** Replace all occurrences of the previous version number with the new version number in filenames and file contents, paying special attention to:
- Dockerfile FROM statements
- Workflow file paths
- Docker image tags
- Workflow names and job names

## Testing Locally

Before deploying, test the new Dockerfiles locally:

```bash
# Build the base image
docker build -f base/Dockerfile{VERSION} -t netdaemon_base:{VERSION} .

# Build the addon base image
docker build -f addon_base/Dockerfile{VERSION} -t netdaemon_addonbase:{VERSION} .
```

## Reference: Current Version Pattern

Repository structure follows this consistent pattern across versions:
- .NET 7: `Dockerfile7`, `build.base7.yaml`, `build.addonbase7.yaml`
- .NET 8: `Dockerfile8`, `build.base8.yaml`, `build.addonbase8.yaml` (if exists)
- .NET 9: `Dockerfile9`, `build.base9.yaml`, `build.addonbase9.yaml`
- .NET 10: `Dockerfile10`, `build.base10.yaml`, `build.addonbase10.yaml`

**AI Agent Note:** Always use the highest numbered version as the template for creating the next version.

## Example AI Prompt for Humans

To upgrade this repository to .NET 11, use this prompt with your AI assistant:

```
Please upgrade the NetDaemon Docker repository to .NET 11 following the 
UPGRADE_INSTRUCTIONS.md file. Create all necessary Dockerfiles and workflow 
files based on the .NET 10 versions.
```
