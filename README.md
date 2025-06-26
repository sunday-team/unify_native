# Unify Native

A modern, cross-platform UI framework for Swift that provides a SwiftUI-like declarative syntax while targeting native platform UI components.

## Overview

Unify Native is a UI framework that allows you to write declarative UI code once and render it using native components on each platform. The framework provides a familiar SwiftUI-like syntax while abstracting away platform-specific implementation details.

## Current Status

The project is in its early stages with the following components implemented:

### Core Architecture
- ✅ `App` protocol for application lifecycle management
- ✅ `View` protocol for component hierarchy
- ✅ Basic application lifecycle management
- ✅ SwiftUI-like declarative syntax
- ✅ MainActor isolation for thread safety

### UI Components
Currently implemented components:
- ✅ `VStack`: Vertical stack layout
- ✅ `Text`: Basic text display with font and padding support
- ✅ `Button`: Basic button with click handler

### Example Usage

```swift
import UnifyNativeKit

@main
struct MyApp: App {
    var body: ContentView {
        ContentView()
    }
}

struct ContentView: View {
    var body: VStack {
        VStack {
            Text("Hello, Unify Native!").padding(10).font(.title)
            Button("Click Me") {
                print("Button clicked")
            }
        }
    }
}
```

## Project Goals

1. **Native Performance**: Use platform-specific UI components for optimal performance and native feel
2. **Cross-Platform**: Support multiple platforms while maintaining a single codebase
   - Windows: [SwiftCrossUI](https://github.com/stackotter/swift-cross-ui)
   - Linux: [SwiftCrossUI](https://github.com/stackotter/swift-cross-ui)
   - macOS: [SwiftUI](https://developer.apple.com/documentation/swiftui)
   - iOS: [SwiftUI](https://developer.apple.com/documentation/swiftui)
   - Android : Standalone Kotlin app without any prebuilt build tools, using C and Swift Interop
   - (Future) Web: WebAssembly in Swift

3. **Modern Swift Features**:
   - Leverage Swift's modern C++ interoperability
   - Use Swift concurrency and actor model
   - Type-safe, declarative UI

## Roadmap

### Short Term
- [ ] Platform-specific window creation
- [ ] Basic rendering pipeline
- [ ] Layout engine
- [ ] More UI components (HStack, ZStack, Image, etc.)
- [ ] Component styling system

### Medium Term
- [ ] Platform-specific renderers
- [ ] State management system
- [ ] Animation system
- [ ] Gesture recognition
- [ ] Accessibility support

### Long Term
- [ ] Hot reload support
- [ ] Developer tools
- [ ] Component library
- [ ] Theme system
- [ ] Web platform support

## Architecture

The framework is structured in layers:

1. **Core Layer** (`Sources/UnifyNativeKit/Core/`)
   - `App.swift`: Application lifecycle
   - `View.swift`: View protocol
   - `ApplicationLifecycle.swift`: Runtime management

2. **Component Layer** (`Sources/UnifyNativeKit/Components/`)
   - `UnifyComponents.swift`: UI component implementations
   - More components to come

3. **Platform Layer** (Coming Soon)
   - Platform-specific rendering implementations
   - Native component bridges

## Building

```bash
# Build the project
swift build

# Run the example app
swift run
```

## Requirements

- Swift 6.1 or later
- Platform-specific requirements (coming soon)

## Contributing

The project is in early development. Contributions are welcome! Areas where help is needed:
1. Additional UI components
2. Platform-specific rendering implementations
3. Documentation
4. Testing infrastructure
5. Example applications

## License

License.md

## Credits

Created by [Priam/Sunday_Team]
