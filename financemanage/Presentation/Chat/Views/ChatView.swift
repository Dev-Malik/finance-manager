import SwiftUI

struct ChatView: View {
    let conversationId: String

    var body: some View {
        VStack(spacing: 12) {
            Text("Chat")
                .font(.title.bold())
            Text("Conversation: \(conversationId)")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppPalette.screenBackground.ignoresSafeArea())
        .foregroundStyle(.white)
    }
}
