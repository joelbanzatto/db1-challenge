import UIKit

public protocol IdentifiableCell {
    static var reuseIdentifier: String { get }
    static var cellHeight: CGFloat { get }
}

public extension IdentifiableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
