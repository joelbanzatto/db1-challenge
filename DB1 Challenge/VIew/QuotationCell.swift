import UIKit

class QuotationCell: UITableViewCell, QuotationAdaptable {
    static var cellHeight: CGFloat = 44

    typealias Model = QuotationValue

    @IBOutlet private var dateLabel: UILabel?
    @IBOutlet private var valueLabel: UILabel?

    func bind(model: QuotationValue, at indexPath: IndexPath) {
        dateLabel?.text = "\(model.x.asDate())"
        valueLabel?.text = "\(model.y.asMoney())"
    }
}
