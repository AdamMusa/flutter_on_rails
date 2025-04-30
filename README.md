# Flutter on Rails

![Flutter on Rails Logo](https://raw.githubusercontent.com/AdamMusa/flutter_on_rails_cli/dev/assets/icon/logo.png)

A powerful integration between Flutter and Ruby on Rails that enables seamless communication between web and mobile applications.

![Flutter on Rails](https://raw.githubusercontent.com/AdamMusa/flutter_on_rails_cli/main/assets/splash.png)

## Features

- 🔄 **Bi-directional Communication**: Seamless communication between Flutter and Rails
- 📱 **Cross-Platform**: Works on iOS, Android, and desktop
- 🎨 **Customizable UI**: Platform-specific dialogs,navigation and animations
- 🔌 **Easy Integration**: Simple setup and configuration
- 🚀 **Performance Optimized**: Efficient WebView handling and state management

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_on_rails: ^0.0.3.alpha
```

## Quick Start

1. Initialize the WebView in your Flutter app:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_on_rails/flutter_on_rails.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MaterialApp(home: MainScreen()));
}
```

2. Add navigation attributes to your Rails views:

```html
<a
  href="/messages/new"
  data_frails_navigation='{"action":"push", "navigable":true, "animate":"circularReveal","backgroundColor": "#111827","leadingColor": "#111827","title": "Message" }'
  >New Message</a
>
```

### Dialog Animations

```dart
DialogAnimation.openDialog(
  context,
  {
    'title': 'Custom Dialog',
    'content': 'This is a test message',
    'animate': 'scale', // Available options: none, rotate, scale, right, left, downToUp, topToDown
    'actions': [
      {
        'text': 'OK',
        'onPressed': () => print('OK pressed')
      }
    ]
  },
);
```

## API Reference

### Navigation

- `data-frails-navigation`: Attribute for handling navigation in Rails views
- `data-frails-action`: Attribute for custom actions

### Dialog Options

```dart
{
  'title': String,           // Dialog title
  'content': String,         // Dialog content
  'animate': String,         // Animation type
  'actions': List<Map>,      // Dialog actions
  'backgroundColor': Color,  // Dialog background color
  'elevation': double,       // Dialog elevation
  'shape': ShapeBorder,      // Dialog shape
  'borderRadius': double,    // Dialog border radius
  'titlePadding': EdgeInsets,// Title padding
  'contentPadding': EdgeInsets,// Content padding
  'actionsPadding': EdgeInsets,// Actions padding
  'buttonPadding': EdgeInsets,// Button padding
  'insetPadding': EdgeInsets,// Dialog inset padding
}
```

## Platform-Specific Features

### iOS

- Custom keyboard handling
- Native dialog support
- Gesture navigation
- Pull-to-refresh functionality

### Android

- Custom WebView settings
- Native dialog support
- Pull-to-refresh functionality

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, email adammusaaly@gmail.com or join our Slack channel.

## Acknowledgments

- Flutter team for the amazing framework
- Ruby on Rails community
- All contributors who have helped shape this project

---

Made with ❤️ by [Adam Moussa Ali]

<!-- Android displays the "cleartext HTTP traffic not permitted" error because it defaults to preventing apps from using unencrypted, cleartext HTTP connections, especially for apps targeting API level 28 or higher. This is a security measure to protect sensitive data from being intercepted.
Here's a more detailed explanation:
Security:
Android prioritizes data security by default. Using HTTP (which is not encrypted) can expose data to eavesdropping, especially over public Wi-Fi networks.
API Level 28 and Above:
Apps targeting API level 28 or higher (Android 9 Pie and later) are automatically configured to disallow cleartext traffic.
Using usesCleartextTraffic:
If your app needs to use cleartext HTTP, you can enable it by adding the android:usesCleartextTraffic="true" attribute to the <application> tag in your AndroidManifest.xml file, or by explicitly configuring it in a network_security_config.xml file.
Alternatives:
Whenever possible, it's recommended to use HTTPS, which encrypts the communication and provides a secure channe -->
