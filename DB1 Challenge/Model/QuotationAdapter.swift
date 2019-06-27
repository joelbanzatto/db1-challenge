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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].height
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let cell = section.cell(at: indexPath, in: tableView)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

protocol QuotationAdaptable: IdentifiableCell {
    associatedtype Model

    func bind(model: Model, at indexPath: IndexPath)
}
