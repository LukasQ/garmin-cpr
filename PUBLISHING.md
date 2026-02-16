# CPR Trainer - Publishing to Connect IQ Store

This guide shows you how to publish the CPR Trainer app in the Garmin Connect IQ Store, making it available to millions of Garmin users worldwide.

## Preparation

### 1. Create Garmin Developer Account

1. Go to: https://developer.garmin.com/
2. Click "Sign In" and create an account
3. Accept the Developer Agreement

**Important:** The account is free!

### 2. Test App Thoroughly

Before publishing:
- [ ] Test on real devices (not just simulator)
- [ ] Test all functions (start, stop, compression feedback)
- [ ] Check vibrations and tones
- [ ] Test on different watch models (if possible)
- [ ] Check battery consumption (shouldn't be too high)
- [ ] Test edge cases (e.g., incoming call during use)

### 3. Prepare App Metadata

You'll need:

#### Screenshots (Required)
- **2-5 screenshots** of the app on different devices
- Recommended sizes:
  - 240x240 (round displays)
  - 260x260
  - 390x390 (larger displays)
- Show: Start screen, active CPR session, different phases

#### App Icon (Required)
- **80x80 pixels** PNG
- Should be recognizable at 40x40
- Simple & clear (e.g., heart symbol with pulse line)

#### Marketing Images (Optional but recommended)
- **1280x720 pixels** banner
- Shows app in context

#### App Description

**English:**
```
CPR Trainer - Your Personal Resuscitation Assistant

Based on ERC Guidelines 2025, this app helps you perform correct CPR (Cardiopulmonary Resuscitation):

✓ 110 compressions per minute (optimal for adults)
✓ 30:2 rhythm (30 compressions, 2 rescue breaths)
✓ Visual feedback in clockwise direction
✓ Acoustic signals (vibrations + tones)
✓ Compression depth measurement via accelerometer
✓ Real-time feedback ("Deeper!", "Good!", "Shallower!")
✓ Cycle tracking

Perfect for:
• First aid courses
• CPR skills refresher
• First responder training
• Driver's license first aid training

IMPORTANT: This app does not replace professional first aid training and is intended as a training tool only. Always call emergency services (911/112) in real emergencies!
```

## Publishing Process

### Step 1: Upload App to Connect IQ Store Manager

1. Go to: https://apps.garmin.com/developer/
2. Click "Apps" → "Upload an App"
3. Select "Watch App" as app type

### Step 2: Enter App Information

#### Basic Information
- **App Name:** CPR Trainer
- **Version:** 1.0.0
- **Summary:** CPR training app based on ERC Guidelines 2025
- **Category:** Health & Fitness
- **Subcategory:** Training
- **Languages:** English, German (optional)

#### Detailed Information
- Add the prepared description above
- **Keywords:** CPR, cardiopulmonary resuscitation, first aid, chest compression, resuscitation, ERC, training, emergency
- **Support Email:** [your email]
- **Privacy Policy URL:** (optional but recommended)
- **Website URL:** (optional)

#### Pricing
- **Free** (recommended for first version)
- Alternative: Paid ($1.99 - $4.99)

### Step 3: Upload App Binary

1. Click "Upload Binary"
2. Select compiled `.iq` file (not `.prg`!)

**Important:** For the store you need a `.iq` file:
```bash
# Compile for store release
monkeyc -o bin/CPRTrainer.iq -f monkey.jungle -y developer_key.der -r
```

The `-r` flag creates a release build.

### Step 4: Upload Screenshots

1. Upload 2-5 screenshots
2. Arrange in desired order
3. Add descriptions (optional)

### Step 5: Select Device Compatibility

- Select all devices listed in your `manifest.xml`
- Recommendation: Test on at least 2-3 devices before release

### Step 6: Beta Testing (Optional but recommended)

1. Enable "Beta Testing"
2. Choose "Closed Beta" or "Open Beta"
3. Share beta link with testers
4. Collect feedback for 1-2 weeks
5. Fix bugs based on feedback

### Step 7: Submit for Review

1. Review all information
2. Accept Store Agreement
3. Click "Submit for Review"

## Review Process

### What Garmin checks:
- ✓ App starts without crashes
- ✓ App functions as described
- ✓ No policy violations
- ✓ Reasonable resource usage (battery, memory)
- ✓ User-friendliness

### Duration:
- Usually **3-7 business days**
- If issues: Garmin sends feedback with improvement suggestions

### Common rejection reasons:
- App crashes during testing
- Description doesn't match functionality
- Insufficient screenshots
- Too high battery consumption
- Medical claims without disclaimer

## After Publication

### App is live! 🎉

Your app is now available at:
```
https://apps.garmin.com/apps/[APP_ID]
```

### Promotion

**Free methods:**
1. **Social Media:** Share link on Twitter, LinkedIn, Facebook
2. **Forums:** Post in Garmin forums and first aid communities
3. **Reddit:** r/Garmin, r/firstaid
4. **YouTube:** Create tutorial video
5. **First Aid Organizations:** Contact Red Cross, St. John Ambulance, etc.

**Paid Promotion (optional):**
- Google Ads for "CPR Training App"
- Facebook/Instagram Ads
- Influencer Marketing (first aid trainers)

### Publish Updates

#### Version Numbering:
- **1.0.1** - Bugfixes
- **1.1.0** - New features
- **2.0.0** - Major changes

#### Update Process:
1. Increase version in `manifest.xml`
2. Compile new `.iq` file
3. Go to App Manager → "Upload New Version"
4. Add release notes
5. Submit for Review

### Analytics & Feedback

**In Connect IQ App Manager:**
- Download numbers
- Active users
- Ratings & reviews
- Crash reports

**Respond to Feedback:**
- Answer reviews
- Fix reported bugs quickly
- Implement feature requests

## Legal Notes

### Disclaimer (important!)

**Always clarify in app description:**
```
DISCLAIMER: This app is a training tool only and does not replace
professional first aid training. Always call emergency services
(911/112) in real emergencies! No liability for medical consequences.
```

### Privacy

If you collect personal data:
- Create a Privacy Policy
- Comply with GDPR (EU) / CCPA (USA)
- Be transparent about data usage

This app collects **no** personal data.

### Medical Device Approval

This app is **NOT a medical device** because it:
- Is intended for training only
- Makes no medical diagnoses
- Is not used for treatment

If you change this, you may need CE marking (EU) or FDA approval (USA)!

## Support & Community

### Offer Support

**Create support email:**
- support@[your-domain].com
- Or use GitHub Issues

**Create FAQ:**
- How do I start the app?
- Does it work on my device?
- How do I update?

### Build Community

- GitHub: Allow contributions
- Discord/Slack: Community channel
- Newsletter: Updates & tips

## Monetization (optional)

### Free with Donations
- "Buy me a coffee" link
- PayPal Donate
- Ko-fi

### Paid App
- One-time payment ($1.99 - $4.99)
- No in-app purchases possible with Garmin

### Premium Features
- Basic version free
- Separate "Pro" version with extended features:
  - Different CPR modes (infant, child, adult)
  - Detailed statistics
  - Export function

## Success Metrics

**After 1 month:**
- [ ] 100+ downloads
- [ ] 10+ reviews
- [ ] Average 4+ stars

**After 6 months:**
- [ ] 1000+ downloads
- [ ] 50+ reviews
- [ ] Featured in "Health & Fitness"

**After 1 year:**
- [ ] 5000+ downloads
- [ ] Partnerships with first aid organizations
- [ ] Version 2.0 with extended features

## Further Resources

- **Garmin Developer Forum:** https://forums.garmin.com/developer/
- **Connect IQ Documentation:** https://developer.garmin.com/connect-iq/
- **Monkey C API Docs:** https://developer.garmin.com/connect-iq/api-docs/
- **Best Practices:** https://developer.garmin.com/connect-iq/connect-iq-basics/

---

**Good luck with publication! 🚀**

For questions or issues: Open an issue on GitHub or contact the Garmin Developer Community.
