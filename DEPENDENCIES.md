# Dependencies & Versions

This document tracks all external dependencies used in the CPR Trainer project.

## GitHub Actions

All workflows use the latest stable versions as of February 2026:

| Action | Version | Purpose | Last Updated |
|--------|---------|---------|--------------|
| `actions/checkout` | v4 | Checkout repository code | Feb 2026 |
| `actions/cache` | v4 | Cache SDK downloads | Feb 2026 |
| `actions/upload-artifact` | v4 | Upload build artifacts | Feb 2026 |
| `softprops/action-gh-release` | v2 | Create GitHub releases | Feb 2026 |

### Update Schedule

- **Automatic Check:** Monthly via `versions-check.yml` workflow
- **Manual Check:** Run `versions-check` workflow anytime
- **Update Policy:** Update to latest stable versions quarterly

### Breaking Changes in v4

#### `actions/upload-artifact@v4`
- **Changed:** Artifacts are now scoped to workflow run
- **Migration:** No code changes needed for our use case
- **Docs:** https://github.com/actions/upload-artifact#v4-breaking-changes

#### `actions/cache@v4`
- **Changed:** Improved cache handling and compression
- **Migration:** No code changes needed
- **Docs:** https://github.com/actions/cache#v4-whats-new

## Connect IQ SDK

| Component | Version | Source |
|-----------|---------|--------|
| **SDK** | 7.2.1 | https://developer.garmin.com/connect-iq/sdk/ |
| **Minimum API Level** | 3.3.0 | Defined in manifest.xml |
| **Language** | Monkey C | Built-in |

### Update Policy
- Check quarterly for SDK updates
- Test thoroughly before upgrading
- Update SDK version in all workflow files

### SDK Update Locations
When updating SDK, change in these files:
- `.github/workflows/build.yml` (line ~25)
- `.github/workflows/release.yml` (line ~28)
- `.github/workflows/pr-check.yml` (line ~85)
- `.github/workflows/nightly.yml` (line ~18)

Update both:
1. Download URL: `connectiq-sdk-lin-7.X.X.zip`
2. Cache key: `${{ runner.os }}-connectiq-sdk-7.X.X`

## Python Dependencies (Optional)

For icon generation (`create_icon.py`):

| Package | Version | Purpose |
|---------|---------|---------|
| `Pillow` | ≥10.0.0 | Image manipulation |

Install with:
```bash
pip install pillow
```

## Development Tools (Recommended)

| Tool | Version | Purpose |
|------|---------|---------|
| Visual Studio Code | Latest | IDE |
| Monkey C Extension | Latest | Syntax highlighting & debugging |
| OpenSSL | 3.x | Generate developer keys |
| Git | 2.x | Version control |

## Runtime Dependencies

**None!** The app has no external runtime dependencies:
- ✅ No network calls
- ✅ No external APIs
- ✅ No cloud services
- ✅ Only uses built-in Garmin APIs

## Security

### Dependency Scanning
- **Manual:** Review dependencies before updates
- **Automated:** GitHub Dependabot (if enabled)
- **Policy:** Only use official GitHub Actions

### Trusted Sources
All dependencies come from:
- ✅ Official GitHub Actions (https://github.com/actions)
- ✅ Garmin Developer Portal (https://developer.garmin.com)
- ✅ Official Python Package Index (pypi.org)

## Version History

### February 2026
- ✅ Updated `actions/upload-artifact` from v3 to v4
- ✅ Updated `actions/cache` from v3 to v4
- ✅ Updated `softprops/action-gh-release` from v1 to v2
- ✅ All workflows now use latest stable versions

### January 2026
- Initial setup with GitHub Actions
- Connect IQ SDK 7.2.1

## Deprecation Notices

Watch for deprecation notices:
1. Check GitHub Actions tab regularly
2. Subscribe to GitHub Actions announcements
3. Run `versions-check` workflow monthly

### Current Deprecations
- ❌ None (all up to date as of Feb 2026)

### Previously Deprecated (Fixed)
- ~~`actions/upload-artifact@v3`~~ → Updated to v4
- ~~`actions/cache@v3`~~ → Updated to v4
- ~~`softprops/action-gh-release@v1`~~ → Updated to v2

## Checking for Updates

### Automated
```bash
# Run monthly version check workflow
# GitHub Actions → versions-check → Run workflow
```

### Manual
```bash
# Check GitHub Actions marketplace
# https://github.com/marketplace?type=actions

# Check Connect IQ SDK
# https://developer.garmin.com/connect-iq/sdk/

# Check for workflow warnings
# GitHub → Actions → Any workflow run
```

## Update Process

### For GitHub Actions
1. Check for new version in marketplace
2. Read changelog for breaking changes
3. Update version in workflow files
4. Test in PR
5. Merge after successful test

### For Connect IQ SDK
1. Download new SDK from Garmin
2. Test compilation locally
3. Update SDK version in workflows
4. Update cache keys
5. Test in PR
6. Update `manifest.xml` if needed

## Support

For dependency issues:
- 📖 Read official documentation
- 🐛 Check GitHub Issues
- 💬 Ask in Discussions
- 📧 Contact maintainers

---

**Last Updated:** February 2026
**Next Review:** May 2026
