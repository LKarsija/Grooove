# Platform Target

## Supported iOS Versions

Grooove officially targets:

- **iOS 8**
- **iOS 9**
- **iOS 10**

**Minimum deployment target:** iOS 8.0

## Out of Scope

**iOS 7 is not supported.** Reasons:

1. **Toolchain complications** — iOS 7 requires older Xcode versions and workarounds that are difficult to maintain in 2026.
2. **Modern Xcode support** — Current Xcode releases do not provide iOS 7 simulators or straightforward device deployment.
3. **No test hardware** — We do not own an iOS 7 device for real-world QA.

## Development Guidelines

- Use **Objective-C + UIKit** for broad compatibility across iOS 8–10.
- Avoid APIs introduced after iOS 10 unless guarded with `@available` checks (prefer APIs available on iOS 8+).
- Test on real hardware running iOS 8, 9, and 10 before release milestones.

## Representative Devices

| OS | Example devices |
|----|-----------------|
| iOS 8 | iPhone 4s, iPhone 5, iPad 2, iPad mini |
| iOS 9 | iPhone 5s, iPhone 6, iPad Air |
| iOS 10 | iPhone 5, iPhone 6s, iPad Air 2 |
