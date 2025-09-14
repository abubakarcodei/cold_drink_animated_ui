# Cold Drink Animated UI

A Flutter application showcasing animated UI for cold drinks.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## CI/CD Pipeline

This project uses GitHub Actions for continuous integration and deployment. The pipeline includes:

### Workflow Triggers
- Push to `main` branch
- Pull requests to `main` branch

### CI Process
1. **Code Quality**
   - Flutter format verification
   - Static code analysis with strict rules

2. **Testing**
   - Unit tests with coverage reporting
   - Coverage reports uploaded to Codecov

3. **Building**
   - Android APK build
   - iOS build (without code signing)
   - Artifacts uploaded for each platform

### CD Process (on main branch only)
1. **Deployment**
   - APK deployed to Firebase App Distribution for testers
   - Google Play Store deployment (configured but disabled by default)

### Required Secrets
To use the deployment features, add these secrets to your GitHub repository:

- `FIREBASE_APP_ID`: Your Firebase application ID
- `FIREBASE_SERVICE_ACCOUNT`: Firebase service account credentials JSON
- `PLAY_STORE_SERVICE_ACCOUNT_JSON`: Google Play Store service account JSON (for Play Store deployment)

### Workflow Efficiency
- Caching of Flutter SDK
- Caching of Pub dependencies
- Caching of build outputs

To view the workflow configuration, see the `.github/workflows/flutter-ci.yml` file.
