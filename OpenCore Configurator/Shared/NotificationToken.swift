//  Original code from https://oleb.net/blog/2018/01/notificationcenter-removeobserver/

import Foundation

/// Wraps the notification token received from `NotificationCenter.addObserver(forName:object:queue:using:)`, and unregisters it in `deinit`.
final class NotificationToken<Observer: AnyObject>: NSObject {
    let notificationCenter: NotificationCenter
    let token: Any
    weak var observer: Observer?

    init(notificationCenter: NotificationCenter = .default, token: Any, observer: Observer? = nil) {
        self.notificationCenter = notificationCenter
        self.token = token
        self.observer = observer
    }

    deinit {
        notificationCenter.removeObserver(token)
    }
}

extension NotificationCenter {
    /// Convenience wrapper for `addObserver(forName:object:queue:using:)` that returns `NotificationToken`.
    func observe<Observer: AnyObject>(name: NSNotification.Name, object obj: Observer? = nil, queue: OperationQueue? = nil, using block: @escaping (Notification) -> Void) -> NotificationToken<Observer> {
        let token = addObserver(forName: name, object: obj, queue: queue, using: block)
        return NotificationToken(notificationCenter: self, token: token, observer: obj)
    }
}
