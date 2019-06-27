import Foundation

extension Int {
    public func asDate(with format: String = "MMM dd,yyyy") -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return dateFormatterPrint.string(from: date)
    }
}
