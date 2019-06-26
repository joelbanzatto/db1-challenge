import UIKit

class FeaturedQuotationCell: UITableViewCell {}

extension FeaturedQuotationCell: QuotationAdaptable {
    func bind(model: BitcoinQuotation) {
        // bind values to view components
    }
}

extension FeaturedQuotationCell: Identifiable {
    static var identifier: String {
        return "FeaturedQuotationCell"
    }
}
