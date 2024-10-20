# mark_knopfler_guitars_api

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
[![Powered by Dart Frog](https://img.shields.io/endpoint?url=https://tinyurl.com/dartfrog-badge)](https://dartfrog.vgv.dev)

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis

A small Backend based on RestAPI written in Dart using Frog framework. By making requests to the server you can obtain informations in json format about Mark Knopfler's guitars 🎸

![dart_frog_logo_black](https://github.com/user-attachments/assets/746b1dc0-8ec4-4e24-b823-f59b94e68d56)


## How to use it
First, check [Dart Frog Docs](https://dartfrog.vgv.dev/docs/overview) to install Dart Frog.
Once you have finished run:
```bash
# 🏁 Start the dev server
dart_frog dev
```
in order to start the server on your localhost

Eventually you can get access to Mark's Guitar information by making GET request at
```
http://localhost:8080/guitar/guitars
```
Or get single guitar information by
```
http://localhost:8080/guitar/1988%20Pensa-Suhr%20Custom
```
