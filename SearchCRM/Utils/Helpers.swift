import SwiftUI

struct Helpers {
    static func doFeedback(type: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
    }
    
    static func doNotificationFeedback(type: UINotificationFeedbackGenerator.FeedbackType) {
        let notification = UINotificationFeedbackGenerator()
        notification.notificationOccurred(type)
    }
}
