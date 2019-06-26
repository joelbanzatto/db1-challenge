import UIKit

protocol QuotationSectionModel {
    var count: Int { get }

    func cell(at: Int) -> UITableViewCell
}

class GenericSectionModel<Model, Cell>: QuotationSectionModel where Cell: UITableViewCell, Cell: QuotationAdaptable, Cell.Model == Model {
    typealias ModelCellClosure = (Model, Cell) -> ()

    private let items: [Model]
    private lazy var cells: [Cell] = self.createCells()

    var count: Int {
        return items.count
    }

    init(items: [Model]) {
        self.items = items
    }

    func cell(at: Int) -> UITableViewCell {
        return cells[at]
    }

    func createCells() -> [Cell] {
        return items.map { m in
            let c = Cell()
            c.bind(model: m)
            return c
        }
    }
}
