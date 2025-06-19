@_exported import Foundation

public enum UnifyComponents {
    @MainActor
    public struct VStack: View {
        private let content: [any View]
        
        public init(@ViewBuilder content: () -> any View) {
            self.content = [content()]
        }
        
        public var body: some View {
            self
        }
    }
    
    @MainActor
    public struct Text: View {
        private let text: String
        private var padding: Int = 0
        private var font: Font = .body
        
        public init(_ text: String) {
            self.text = text
        }
        
        public func padding(_ value: Int) -> Text {
            var copy = self
            copy.padding = value
            return copy
        }
        
        public func font(_ font: Font) -> Text {
            var copy = self
            copy.font = font
            return copy
        }
        
        public var body: some View {
            self
        }
    }
    
    @MainActor
    public struct Button: View {
        private let title: String
        private let action: () -> Void
        
        public init(_ title: String, action: @escaping () -> Void) {
            self.title = title
            self.action = action
        }
        
        public var body: some View {
            self
        }
    }
    
    public enum Font {
        case title
        case body
    }
} 