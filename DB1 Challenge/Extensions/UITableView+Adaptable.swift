import UIKit.UITableView

extension UITableView {
    func setAdapter(_ adapter: QuotationAdapter?) {
        DispatchQueue.main.sync { [unowned self] in
            self.dataSource = adapter
            self.delegate = adapter
            self.reloadData()
        }
    }
}
