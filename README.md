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

## API Reference

### Navigation

The package supports both regular and animated navigation between screens. You can use the following attributes in your Rails views:

#### Regular Navigation

```html
<a
  href="/messages/new"
  data_frails_navigation='{"action":"push", "navigable":true}'
  >New Message</a
>
```

#### Animated Navigation

```html
<a
  href="/messages/new"
  data_frails_navigation='{
    "action": "push",
    "navigable": true,
    "animate": "circularReveal",
    "backgroundColor": "#111827",
    "leadingColor": "#111827",
    "title": "Message"
  }'
  >New Message</a
>
```

#### Navigation Options

1. **Regular Navigation Properties**:

   - `action`: "push" or "pop"
   - `navigable`: true/false

2. **Animated Navigation Properties**:

   - `action`: "push" or "pop"
   - `navigable`: true/false
   - `animate`: Animation type (see below)
   - `backgroundColor`: Background color of the new screen
   - `leadingColor`: Color of the leading widget (e.g., AppBar)
   - `title`: Title of the new screen

3. **Available Animation Types**:
   - `none`: No animation
   - `rotate`: Rotating transition
   - `scale`: Scaling transition
   - `right`: Slide from right
   - `left`: Slide from left
   - `downToUp`: Slide from bottom to top
   - `topToDown`: Slide from top to bottom
   - `circularReveal`: Circular reveal animation
   - `fade`: Fade transition

#### Example Usage

1. **Simple Push Navigation**:

```html
<a href="/products" data_frails_navigation='{"action":"push", "navigable":true}'
  >View Products</a
>
```

2. **Animated Push Navigation**:

```html
<a
  href="/products"
  data_frails_navigation='{
    "action": "push",
    "navigable": true,
    "animate": "fade",
    "backgroundColor": "#FFFFFF",
    "leadingColor": "#2196F3",
    "title": "Products"
  }'
  >View Products</a
>
```

3. **Pop Navigation with Animation**:

```html
<button
  data_frails_navigation='{
    "action": "pop",
    "navigable": true,
    "animate": "left"
  }'
>
  Go Back
</button>
```

### Navigation Best Practices

1. Always provide a fallback for non-Flutter environments
2. Use appropriate animation types based on the context
3. Keep navigation configurations consistent across your application
4. Test navigation on both iOS and Android
5. Consider the user experience when choosing animation types
6. Use semantic HTML elements for navigation links
7. Provide clear visual feedback for navigation actions

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

### Dialog Animations

The package provides various animation options for dialogs to enhance the user experience. Here's how to use them:

#### Basic Dialog with Animation

```javascript
const dialogConfig = {
  component: "dialog",
  title: "Custom Dialog",
  content: "This is a test message",
  animate: "scale", // Animation type
  actions: [
    {
      text: "OK",
      onPressed: () => console.log("OK pressed"),
    },
  ],
};
```

#### Available Dialog Animation Types

1. **rotate**: Rotating transition
2. **scale**: Scaling transition
3. **right**: Slide from right
4. **left**: Slide from left
5. **downToUp**: Slide from bottom to top
6. **topToDown**: Slide from top to bottom
7. **none**: No animation

#### Dialog Configuration Options

```javascript
const dialogConfig = {
  component: "dialog",
  title: "Dialog Title",
  content: "Dialog content",
  animate: "scale", // Animation type
  backgroundColor: "#FFFFFF", // Dialog background color
  elevation: 24.0, // Dialog elevation
  shape: "rounded", // Dialog shape
  borderRadius: 8.0, // Border radius
  titlePadding: "16.0,24.0,16.0,24.0", // Title padding
  contentPadding: "24.0,24.0,24.0,24.0", // Content padding
  actionsPadding: "8.0,8.0,8.0,8.0", // Actions padding
  buttonPadding: "8.0,16.0,8.0,16.0", // Button padding
  insetPadding: "40.0,40.0,40.0,40.0", // Dialog inset padding
  actions: [
    {
      text: "Cancel",
      onPressed: () => console.log("Cancel pressed"),
      style: {
        color: "#FF0000",
        fontSize: 16.0,
      },
    },
    {
      text: "Confirm",
      onPressed: () => console.log("Confirm pressed"),
      style: {
        color: "#2196F3",
        fontSize: 16.0,
      },
    },
  ],
};
```

#### Example Usage

1. **Simple Dialog with Scale Animation**:

```javascript
const simpleDialog = {
  component: "dialog",
  title: "Welcome",
  content: "Welcome to our app!",
  animate: "scale",
  actions: [
    {
      text: "Got it",
      onPressed: () => console.log("Got it pressed"),
    },
  ],
};
```

2. **Dialog with Custom Styling**:

```javascript
const styledDialog = {
  component: "dialog",
  title: "Delete Item",
  content: "Are you sure you want to delete this item?",
  animate: "downToUp",
  backgroundColor: "#FFFFFF",
  elevation: 24.0,
  borderRadius: 12.0,
  actions: [
    {
      text: "Cancel",
      onPressed: () => console.log("Cancel pressed"),
      style: {
        color: "#666666",
      },
    },
    {
      text: "Delete",
      onPressed: () => console.log("Delete pressed"),
      style: {
        color: "#FF0000",
      },
    },
  ],
};
```

3. **Dialog with Custom Padding**:

```javascript
const paddedDialog = {
  component: "dialog",
  title: "Settings",
  content: "Configure your settings",
  animate: "right",
  titlePadding: "16.0,24.0,16.0,24.0",
  contentPadding: "24.0,24.0,24.0,24.0",
  actionsPadding: "8.0,8.0,8.0,8.0",
  actions: [
    {
      text: "Save",
      onPressed: () => console.log("Save pressed"),
    },
  ],
};
```

4. **Programmatic Dialog Creation**:

```javascript
function showDialog(options) {
  if (window.flutter_on_rails) {
    const defaultOptions = {
      animate: "scale",
      backgroundColor: "#FFFFFF",
      elevation: 24.0,
    };

    const dialogConfig = {
      component: "dialog",
      ...defaultOptions,
      ...options,
    };

    window.flutter_on_rails.callHandler(
      "Flutter",
      JSON.stringify(dialogConfig)
    );
  }
}

// Usage
showDialog({
  title: "Custom Dialog",
  content: "This is a test message",
  animate: "rotate",
  actions: [
    {
      text: "OK",
      onPressed: () => console.log("OK pressed"),
    },
  ],
});
```

#### Dialog Best Practices

1. Choose appropriate animation types based on the dialog's purpose
2. Keep dialog content concise and clear
3. Use consistent styling across your application
4. Provide clear action buttons
5. Consider the user's context when choosing animation types
6. Test dialogs on both iOS and Android
7. Handle edge cases (e.g., long content, multiple actions)
8. Provide proper error handling for dialog actions
9. Consider accessibility when choosing colors and animations
10. Use appropriate padding and spacing for better readability

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
- HTTP Traffic Configuration:
  Android prioritizes data security by default. Using HTTP (which is not encrypted) can expose data to eavesdropping, especially over public Wi-Fi networks.

  For apps targeting API level 28 or higher (Android 9 Pie and later), cleartext HTTP traffic is disabled by default. If your app needs to use cleartext HTTP, you can enable it by:

  1. Adding to AndroidManifest.xml:

  ```xml
  <application
      android:usesCleartextTraffic="true"
      ...>
  ```

  2. Or configuring in network_security_config.xml:

  ```xml
  <?xml version="1.0" encoding="utf-8"?>
  <network-security-config>
      <base-config cleartextTrafficPermitted="true">
          <trust-anchors>
              <certificates src="system" />
          </trust-anchors>
      </base-config>
  </network-security-config>
  ```

  **Note**: It's recommended to use HTTPS whenever possible for secure communication.

## JavaScript API Integration

The Flutter on Rails package provides a powerful JavaScript API that allows you to communicate with your Flutter app from your Rails views. Here's how to use it:

### Basic Setup

1. Import the Stimulus controller in your Rails application:

```javascript
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // Initialize communication with Flutter
    if (window.flutter_on_rails) {
      window.flutter_on_rails.callHandler(
        "Flutter",
        JSON.stringify({
          // Your payload here
        })
      );
    }
  }
}
```

### Widget Parser API

The widget parser allows you to create Flutter widgets using JSON objects. Here's an example of creating an AppBar:

```javascript
const appBarConfig = {
  type: "AppBar",
  backgroundColor: "#4179AF",
  title: {
    type: "Text",
    data: "My App",
    style: {
      color: "#1B2834",
      fontSize: 20.0,
    },
  },
  actions: [
    {
      type: "Container",
      width: 40.0,
      height: 40.0,
      margin: "10.0,0,10.0,0",
      child: {
        type: "ElevatedButton",
        color: "ff2196f3",
        click_event: "route:/productDetail?goods_id=123",
        child: {
          type: "Icon",
          data: "list",
          size: 25.0,
        },
      },
    },
  ],
};
```

### Available Components

#### 1. Dialog

```javascript
const dialogConfig = {
  component: "dialog",
  title: "Flutter on Rails",
  content: "Welcome to Flutter on rails !!!",
  animate: "left", // Optional: none, rotate, scale, right, left, downToUp, topToDown
};
```

#### 2. Bottom Sheet

```javascript
const bottomSheetConfig = {
  component: "bottomsheet",
  title: "Bottomsheet",
  content: "My bottomsheet create with json object",
};
```

#### 3. License Dialog

```javascript
const licenseConfig = {
  component: "licence",
  title: "My mobile app",
  content: "Read the detail below about my application",
};
```

#### 4. Share

```javascript
const shareConfig = {
  component: "share",
  title: "Check my awesome app here",
  content: "Check my awesome app here https://www.github.com/AdamMusa",
};
```

#### 5. Snackbar

```javascript
const snackbarConfig = {
  component: "snackbar",
  title: "Login successfully",
  content: "My snackbar component from the web",
};
```

### Communication Methods

1. **Sending Data to Flutter**:

```javascript
sendDataToFlutter() {
  if (window.flutter_on_rails) {
    const payload = {
      // Your configuration here
    };
    window.flutter_on_rails.callHandler('Flutter', JSON.stringify(payload));
  }
}
```

2. **Receiving Data from Flutter**:

```javascript
receiveDataFromFlutter() {
  window.receiveDataFromFlutter = function (data) {
    // Handle the received data
    console.log(`Received from Flutter: ${data}`);
  };
}
```

### Widget Types

The widget parser supports various Flutter widgets:

1. **Container**
   - Properties: width, height, margin, padding, color, child
2. **Text**
   - Properties: data, style (color, fontSize)
3. **Icon**
   - Properties: data, size, color
4. **ElevatedButton**
   - Properties: color, click_event, child, padding
5. **AppBar**
   - Properties: backgroundColor, title, actions

### Supported Widgets

The widget parser supports a wide range of Flutter widgets. Here's a comprehensive list of supported widgets and their properties:

#### Layout Widgets

1. **Container**

```javascript
{
  type: "Container",
  width: 100.0,
  height: 100.0,
  margin: "10.0,10.0,10.0,10.0",
  padding: "10.0,10.0,10.0,10.0",
  color: "#FFFFFF",
  decoration: {
    borderRadius: 8.0,
    borderColor: "#000000",
    borderWidth: 1.0
  },
  child: {
    // Child widget configuration
  }
}
```

2. **Row & Column**

```javascript
{
  type: "Row", // or "Column"
  mainAxisAlignment: "start", // start, end, center, spaceBetween, spaceAround, spaceEvenly
  crossAxisAlignment: "center", // start, end, center, stretch, baseline
  mainAxisSize: "max", // min, max
  children: [
    // Array of child widgets
  ]
}
```

3. **Stack**

```javascript
{
  type: "Stack",
  alignment: "topLeft", // topLeft, topCenter, topRight, centerLeft, center, centerRight, bottomLeft, bottomCenter, bottomRight
  fit: "loose", // loose, expand, passthrough
  children: [
    // Array of child widgets
  ]
}
```

4. **Wrap**

```javascript
{
  type: "Wrap",
  direction: "horizontal", // horizontal, vertical
  alignment: "start", // start, end, center, spaceBetween, spaceAround, spaceEvenly
  spacing: 8.0,
  runSpacing: 8.0,
  children: [
    // Array of child widgets
  ]
}
```

#### Scrolling Widgets

1. **ListView**

```javascript
{
  type: "ListView",
  scrollDirection: "vertical", // vertical, horizontal
  padding: "10.0,10.0,10.0,10.0",
  children: [
    // Array of child widgets
  ]
}
```

2. **GridView**

```javascript
{
  type: "GridView",
  crossAxisCount: 2,
  mainAxisSpacing: 10.0,
  crossAxisSpacing: 10.0,
  childAspectRatio: 1.0,
  children: [
    // Array of child widgets
  ]
}
```

3. **SingleChildScrollView**

```javascript
{
  type: "SingleChildScrollView",
  scrollDirection: "vertical", // vertical, horizontal
  padding: "10.0,10.0,10.0,10.0",
  child: {
    // Child widget configuration
  }
}
```

4. **PageView**

```javascript
{
  type: "PageView",
  scrollDirection: "horizontal", // horizontal, vertical
  children: [
    // Array of child widgets
  ]
}
```

#### Basic Widgets

1. **Text**

```javascript
{
  type: "Text",
  data: "Hello World",
  style: {
    color: "#000000",
    fontSize: 16.0,
    fontWeight: "normal", // normal, bold, w100-w900
    fontStyle: "normal", // normal, italic
    textAlign: "left", // left, right, center, justify, start, end
    overflow: "clip" // clip, fade, ellipsis, visible
  }
}
```

2. **SelectableText**

```javascript
{
  type: "SelectableText",
  data: "Selectable Text",
  style: {
    color: "#000000",
    fontSize: 16.0
  }
}
```

3. **Icon**

```javascript
{
  type: "Icon",
  data: "home", // Material icon name
  size: 24.0,
  color: "#000000"
}
```

4. **Image**

```javascript
{
  type: "Image",
  src: "https://example.com/image.jpg",
  width: 100.0,
  height: 100.0,
  fit: "cover", // fill, contain, cover, fitWidth, fitHeight, none, scaleDown
  alignment: "center"
}
```

#### Layout Helpers

1. **Padding**

```javascript
{
  type: "Padding",
  padding: "10.0,10.0,10.0,10.0",
  child: {
    // Child widget configuration
  }
}
```

2. **Align**

```javascript
{
  type: "Align",
  alignment: "center", // topLeft, topCenter, topRight, centerLeft, center, centerRight, bottomLeft, bottomCenter, bottomRight
  child: {
    // Child widget configuration
  }
}
```

3. **Center**

```javascript
{
  type: "Center",
  child: {
    // Child widget configuration
  }
}
```

4. **Expanded**

```javascript
{
  type: "Expanded",
  flex: 1,
  child: {
    // Child widget configuration
  }
}
```

5. **SizedBox**

```javascript
{
  type: "SizedBox",
  width: 100.0,
  height: 100.0,
  child: {
    // Optional child widget configuration
  }
}
```

#### Special Widgets

1. **Card**

```javascript
{
  type: "Card",
  elevation: 2.0,
  margin: "10.0,10.0,10.0,10.0",
  shape: "rounded", // rounded, beveled, stadium
  color: "#FFFFFF",
  child: {
    // Child widget configuration
  }
}
```

2. **ListTile**

```javascript
{
  type: "ListTile",
  leading: {
    // Widget configuration for leading icon/button
  },
  title: {
    type: "Text",
    data: "Title"
  },
  subtitle: {
    type: "Text",
    data: "Subtitle"
  },
  trailing: {
    // Widget configuration for trailing icon/button
  }
}
```

3. **Divider**

```javascript
{
  type: "Divider",
  height: 1.0,
  color: "#BDBDBD",
  thickness: 1.0,
  indent: 0.0,
  endIndent: 0.0
}
```

4. **DropCapText**

```javascript
{
  type: "DropCapText",
  text: "Your text here",
  dropCap: {
    width: 50.0,
    height: 50.0,
    style: {
      fontSize: 30.0,
      color: "#000000"
    }
  }
}
```

#### Utility Widgets

1. **SafeArea**

```javascript
{
  type: "SafeArea",
  child: {
    // Child widget configuration
  }
}
```

2. **ClipRRect**

```javascript
{
  type: "ClipRRect",
  borderRadius: 8.0,
  child: {
    // Child widget configuration
  }
}
```

3. **Opacity**

```javascript
{
  type: "Opacity",
  opacity: 0.5,
  child: {
    // Child widget configuration
  }
}
```

4. **AspectRatio**

```javascript
{
  type: "AspectRatio",
  aspectRatio: 16.0 / 9.0,
  child: {
    // Child widget configuration
  }
}
```

### Widget Best Practices

1. Use appropriate widget types for specific use cases
2. Maintain consistent styling across your application
3. Consider platform-specific behaviors
4. Optimize widget trees for performance
5. Use proper padding and margins
6. Handle widget states appropriately
7. Consider accessibility requirements
8. Test widgets on different screen sizes
9. Use semantic widget names
10. Follow Flutter's widget composition patterns

### Error Handling

Always check for the availability of the Flutter handler:

```javascript
if (window.flutter_on_rails) {
  // Your code here
} else {
  console.error("Flutter InAppWebView handler not available");
}
```

### Best Practices

1. Always validate your JSON payload before sending
2. Use proper error handling
3. Keep your widget configurations modular and reusable
4. Test your configurations in both development and production environments
5. Use TypeScript for better type safety if possible

For more examples and detailed documentation, check out the [example directory](example/) in the repository.

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
