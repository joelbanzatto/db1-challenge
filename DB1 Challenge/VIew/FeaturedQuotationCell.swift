import UIKit

class FeaturedQuotationCell: UITableViewCell {

    @IBOutlet private var quotationValueLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var attributesView: UIStackView!

}

extension FeaturedQuotationCell: QuotationAdaptable {
    static var cellHeight: CGFloat = 224

    typealias Model = BitcoinQuotation

    func bind(model: BitcoinQuotation, at indexPath: IndexPath) {
        nameLabel.text = model.name
        descriptionLabel.text = model.description

        attributesView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        attributesView.addArrangedSubview(AttributeStackView(name: "Period", value: model.period))
        attributesView.addArrangedSubview(AttributeStackView(name: "Unit", value: model.unit))
        if let value = model.sortedValues.first {
            quotationValueLabel.text = value.y.asMoney()
            attributesView.addArrangedSubview(AttributeStackView(name: "Date", value: value.x.asDate(with: "dd/MM")))
        }
    }
}
