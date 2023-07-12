import Combine
import Foundation

/// Update content 0.3s after the user stops entering.
class ContentUpdater: ObservableObject {
    /// Send all the changes from raw text
    private var relay = PassthroughSubject<String, Never>()
    
    /// A publisher to notify MarkdownView to update its content.
    var textUpdater: AnyPublisher<String, Never>
    
    init() {
        // Replace 0.3 by 0.01 to update continously in stream response mode
        textUpdater = relay
            .debounce(for: .seconds(0.01), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func push(_ text: String) {
        relay.send(text)
    }
}

class MarkdownTextStorage: ObservableObject {
    static var `default` = MarkdownTextStorage()
    @Published var text: String? = nil
}
