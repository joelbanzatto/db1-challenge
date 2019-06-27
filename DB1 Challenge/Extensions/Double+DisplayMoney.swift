import Foundation

extension Double {
    public func asMoney() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            return formattedTipAmount
        } else {
            return "$\(self)"
        }
    }
}
