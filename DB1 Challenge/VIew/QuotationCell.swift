import UIKit

class QuotationCell: UITableViewCell {}

extension QuotationCell: QuotationAdaptable {
    func bind(model: QuotationValue) {
        // bind values to view components
    }
}

extension QuotationCell: Identifiable {
    static var identifier: String {
        return "QuotationCell"
    }
}
