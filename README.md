## Getting started

Coming soon



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