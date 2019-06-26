import UIKit.UITableView

extension UITableView {
    func setAdapter(_ adapter: QuotationAdapter) {
        dataSource = adapter
        delegate = adapter
        reloadData()
    }
}
