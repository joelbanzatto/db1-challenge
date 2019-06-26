import UIKit

class QuotationAdapter: NSObject {
    let sections: [QuotationSectionModel]

    init(sections: [QuotationSectionModel]) {
        self.sections = sections
    }
}

extension QuotationAdapter: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let cell = section.cell(at: indexPath.row)
        return cell
    }
}

protocol QuotationAdaptable {
    associatedtype Model

    func bind(model: Model)
}
