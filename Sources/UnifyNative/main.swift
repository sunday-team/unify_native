import UnifyNativeKit

@main
@MainActor
struct mainApp: App {
    init() {}
    
    var body: ContentView {
        ContentView()
    }
}

@MainActor
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