import UIKit

class QuotationsViewController: UIViewController {

    @IBOutlet internal var tableView: UITableView!

    internal var adapter: QuotationAdapter = QuotationAdapter(sections: [])
    internal var quotation: BitcoinQuotation! {
        didSet {
            let featuredSection = GenericSectionModel<BitcoinQuotation, FeaturedQuotationCell>(items: [quotation])
            let quotationsSection = GenericSectionModel<QuotationValue, QuotationCell>(items: quotation.values)
            self.adapter = QuotationAdapter(sections: [featuredSection, quotationsSection])
            self.tableView.setAdapter(self.adapter)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuotation()
    }

    internal func fetchQuotation() {
        NetworkFeedback.shared.startLoading()
        ApiClient.shared.fetchQuotation { [unowned self] (remoteQuotation) in
            self.quotation = remoteQuotation
            NetworkFeedback.shared.stopLoading()
        }
    }


}

