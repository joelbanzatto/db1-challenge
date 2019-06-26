import UIKit

class QuotationsViewController: UIViewController {

    @IBOutlet internal var tableView: UITableView!

    internal var quotation: BitcoinQuotation! {
        didSet {
            let featuredSection = GenericSectionModel<BitcoinQuotation, FeaturedQuotationCell>(items: [quotation])
            let quotationsSection = GenericSectionModel<QuotationValue, QuotationCell>(items: quotation.values)
            let adapter = QuotationAdapter(sections: [featuredSection, quotationsSection])
            tableView.setAdapter(adapter)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchQuotation()
    }

    internal func fetchQuotation() {
        ApiClient.shared.fetchQuotation { [unowned self] (remoteQuotation) in
            self.quotation = remoteQuotation
        }
    }


}

