# CI/CD Pipeline Guide for CPR Trainer

## 🚀 Overview

This project uses **GitHub Actions** for continuous integration and deployment. All pipelines are **free** for public repositories.

## 📋 Available Workflows

### 1. **Build and Test** (`build.yml`)
- **Trigger:** Push to `main` or `develop`, Pull Requests
- **Runtime:** ~5-8 minutes
- **Cost:** Free (public repo)

**What it does:**
- ✅ Compiles app for Fenix 7, Venu 2, Forerunner 955
- ✅ Runs code quality checks
- ✅ Validates documentation
- ✅ Uploads build artifacts (30 days)

**Artifacts:**
- `cpr-trainer-builds` - .prg files for testing

### 2. **Release** (`release.yml`)
- **Trigger:** Git tags with pattern `v*.*.*` (e.g., `v1.0.0`)
- **Runtime:** ~10-15 minutes
- **Cost:** Free (public repo)

**What it does:**
- ✅ Compiles for ALL 17+ supported devices
- ✅ Creates universal .iq file for Connect IQ Store
- ✅ Creates ZIP with all .prg files
- ✅ Generates SHA256 checksums
- ✅ Automatically creates GitHub Release with notes

**Release Assets:**
- `CPRTrainer-vX.X.X.iq` - For Connect IQ Store
- `CPRTrainer-AllDevices-vX.X.X.zip` - All .prg files
- `BUILD_INFO.txt` - Build information
- `SHA256SUMS.txt` - Checksums

### 3. **Pull Request Checks** (`pr-check.yml`)
- **Trigger:** Pull Requests (opened, synchronize, reopened)
- **Runtime:** ~3-5 minutes
- **Cost:** Free

**What it does:**
- ✅ Validates PR title (Conventional Commits)
- ✅ Checks for DISCLAIMER.md changes (warns)
- ✅ Checks manifest.xml version bump
- ✅ Searches for new TODO/FIXME comments
- ✅ Checks for large files (>1MB)
- ✅ Validates changed Monkey C files
- ✅ Test build for Fenix 7

### 4. **Nightly Build** (`nightly.yml`)
- **Trigger:** Daily at 2 AM UTC, or manual
- **Runtime:** ~15-20 minutes
- **Cost:** Free

**What it does:**
- ✅ Compiles for ALL supported devices
- ✅ Creates compatibility report
- ✅ Uploads build logs (7 days)
- ✅ Warns on failures

---

## 🎯 How to Use the Pipelines

### As Developer (During Development)

#### 1. Develop Feature
```bash
git checkout -b feature/my-new-feature
# ... write code ...
git add .
git commit -m "feat(sensor): add xyz"
git push origin feature/my-new-feature
```

#### 2. Create Pull Request
- Go to GitHub → Pull Requests → New Pull Request
- Fill out PR template
- **Automatically:** PR checks run
- Wait for green checkmark ✅

#### 3. After Merge to Main
- **Automatically:** Build & Test workflow runs
- **Automatically:** Artifacts created

### As Maintainer (Create Release)

#### 1. Prepare Version
```bash
# Increase version in manifest.xml
vim manifest.xml
# Change: version="1.0.0" → version="1.0.1"

git add manifest.xml
git commit -m "chore: bump version to 1.0.1"
git push origin main
```

#### 2. Create Git Tag
```bash
git tag v1.0.1
git push origin v1.0.1
```

#### 3. Release Workflow Starts Automatically
- Compiles for all devices
- Creates .iq and .zip files
- Creates GitHub Release
- Release notes generated

#### 4. Publish Release
- Go to GitHub → Releases
- Release automatically created (Draft = false)
- Edit release notes if needed
- Download links available

---

## 💰 Cost Overview

### GitHub Actions Free Tier (Public Repo)

| Feature | Free Tier | Your Usage |
|---------|-----------|------------|
| **Minutes/Month** | Unlimited | ~100-200 min/month |
| **Concurrent Jobs** | 20 | Max. 4 (workflows) |
| **Storage** | 500 MB | ~10-20 MB |
| **Artifact Retention** | 90 days | 7-30 days configured |

**Cost:** **$0 USD / Month** 🎉

### For Private Repositories

If you make the repo private:

| Account Type | Free Minutes | Price After |
|--------------|--------------|-------------|
| **Free** | 2000 min/month | $0.008/min |
| **Pro** | 3000 min/month | $0.008/min |
| **Team** | 3000 min/month | $0.008/min |

**Your usage:** ~100-200 min/month
→ **Fits easily in Free Tier!** ✅

---

## 🔧 Customize Configuration

### Change Connect IQ SDK Version

In all workflow files:
```yaml
# Change this URL:
wget https://developer.garmin.com/downloads/connect-iq/sdks/connectiq-sdk-lin-7.2.1.zip

# To newer version:
wget https://developer.garmin.com/downloads/connect-iq/sdks/connectiq-sdk-lin-7.3.0.zip
```

And update cache key:
```yaml
key: ${{ runner.os }}-connectiq-sdk-7.3.0  # Update version
```

### Change Artifact Retention

```yaml
- uses: actions/upload-artifact@v3
  with:
    retention-days: 30  # Change: 1-90 days
```

### Change Nightly Build Time

```yaml
schedule:
  - cron: '0 2 * * *'  # Format: Minute Hour Day Month Weekday
  # Examples:
  # '0 0 * * *'  = Midnight UTC
  # '0 12 * * *' = 12 PM UTC
  # '0 0 * * 1'  = Every Monday midnight
```

### Add More Devices

In `release.yml`:
```yaml
DEVICES=(
  "fenix7:Fenix7"
  "your_new_device:NewDevice"  # Add here
)
```

---

## 🐛 Troubleshooting

### Build fails: "monkeyc: command not found"

**Problem:** SDK not correctly installed

**Solution:**
```yaml
# Check SDK download URL
# Sometimes Garmin changes URLs
# Get latest URL from developer.garmin.com
```

### Release not created

**Problem:** Git tag not correct

**Solution:**
```bash
# Tag must start with 'v' and follow Semantic Versioning
git tag v1.0.0  # ✅ Correct
git tag 1.0.0   # ❌ Wrong (missing 'v')
git tag release-1.0.0  # ❌ Wrong (wrong pattern)
```

### Cache not used

**Problem:** Cache key changed

**Solution:**
```bash
# Delete old caches manually:
# GitHub Repo → Actions → Caches → Delete Cache

# Or wait 7 days (automatic deletion)
```

### Deprecated action versions

**Problem:** GitHub shows deprecation warnings

**Solution:**
```bash
# Check for updates regularly
# Run the versions-check workflow:
# GitHub Actions → versions-check → Run workflow

# Update to latest versions:
# - actions/checkout@v4 (latest)
# - actions/cache@v4 (latest)
# - actions/upload-artifact@v4 (latest)
# - softprops/action-gh-release@v2 (latest)
```

### Artifact upload fails

**Problem:** Too large or too many files

**Solution:**
```yaml
# Filter more precisely:
path: bin/*.prg  # Only .prg files
# Instead of:
path: bin/       # All files
```

### Workflow doesn't run

**Problem:** Workflow file syntax error

**Solution:**
```bash
# Validate YAML syntax online:
# https://www.yamllint.com/

# Or locally:
pip install yamllint
yamllint .github/workflows/build.yml
```

---

## 📊 Monitoring & Logs

### View Workflow Status

1. Go to: GitHub Repo → **Actions** tab
2. See all workflow runs
3. Click on a run for details
4. Click on a job for logs

### Download Artifacts

1. Go to: Actions → Workflow Run
2. Scroll down to "Artifacts"
3. Click artifact name to download

### Add Badges

In README.md:
```markdown
![Build Status](https://github.com/[username]/garmin-cpr/workflows/Build%20and%20Test/badge.svg)
![Release](https://github.com/[username]/garmin-cpr/workflows/Create%20Release/badge.svg)
```

---

## 🔐 Secrets & Permissions

### Required Secrets

**None!** 🎉

All workflows only use:
- `GITHUB_TOKEN` - Automatically available
- Public URLs (SDK download)

### Permissions

Workflows have read-only access, except:
- `release.yml` - Requires `contents: write` for releases

---

## 🚀 Best Practices

### 1. Branch Protection

Protect `main` branch:
```
Settings → Branches → Add Rule
- Branch name pattern: main
- ☑ Require status checks to pass before merging
  ☑ build / Build Connect IQ App
  ☑ pr-validation / Validate Pull Request
- ☑ Require branches to be up to date before merging
```

### 2. Conventional Commits

Use semantic commit messages:
```bash
feat(sensor): add heart rate monitoring
fix(ui): correct compression counter display
docs: update installation guide
chore: bump version to 1.0.1
```

### 3. Semantic Versioning

Follow SemVer for tags:
- `v1.0.0` → Major.Minor.Patch
- `v1.0.1` → Patch (bugfix)
- `v1.1.0` → Minor (new feature)
- `v2.0.0` → Major (breaking change)

### 4. Maintain Changelog

Create `CHANGELOG.md`:
```markdown
# Changelog

## [1.0.1] - 2026-02-16
### Fixed
- Improved depth sensor calibration

## [1.0.0] - 2026-02-15
### Added
- Initial release
- 110 BPM rhythm
- Depth measurement
```

---

## 📞 Support

For issues:
1. 📖 Read this guide
2. 🔍 Check [GitHub Actions Logs](https://github.com/[username]/garmin-cpr/actions)
3. 🐛 Create an [Issue](https://github.com/[username]/garmin-cpr/issues)
4. 💬 Ask in [Discussions](https://github.com/[username]/garmin-cpr/discussions)

---

## 📚 Further Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Garmin Connect IQ Developer Guide](https://developer.garmin.com/connect-iq/)
- [YAML Syntax](https://yaml.org/)
- [Semantic Versioning](https://semver.org/)

---

**Happy Building! 🚀**
