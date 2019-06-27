import UIKit

protocol QuotationSectionModel {
    var count: Int { get }
    var height: CGFloat { get }

    func cell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell
}

class GenericSectionModel<Model, Cell: UITableViewCell>: QuotationSectionModel where Cell: QuotationAdaptable, Cell.Model == Model {

    private let items: [Model]

    internal var count: Int {
        return items.count
    }

    internal var height: CGFloat {
        return Cell.cellHeight
    }

    init(items: [Model]) {
        self.items = items
    }

    public func cell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else { return UITableViewCell() }
        let item = items[indexPath.row]
        cell.bind(model: item, at: indexPath)
        return cell
    }
}
