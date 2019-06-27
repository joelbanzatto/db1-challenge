import UIKit

class AttributeStackView: UIStackView {

    private var name: String!
    private let value: String!

    private func setup() {
        alignment = .center
        distribution = .fillEqually
        axis = .vertical
        generateViews().forEach { view in
            self.addArrangedSubview(view)
        }
    }

    init(name: String, value: String) {
        self.name = name
        self.value = value
        super.init(frame: .zero)
        self.setup()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func generateViews() -> [UIView] {
        let label1 = UILabel()
        label1.textAlignment = .center
        label1.text = value
        label1.font = UIFont.boldSystemFont(ofSize: 14)

        let label2 = UILabel()
        label2.textAlignment = .center
        label2.text = name
        label2.font = UIFont.systemFont(ofSize: 14)

        return [label1, label2]
    }

    override func awakeFromNib() {

    }

}
