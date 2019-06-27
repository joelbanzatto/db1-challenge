import UIKit

class QuotationsViewController: UIViewController {

    @IBOutlet internal var tableView: UITableView!

    private var refreshControl = UIRefreshControl()
    private var adapter: QuotationAdapter = QuotationAdapter(sections: [])
    private var quotation: BitcoinQuotation! {
        willSet {
            self.tableView.setAdapter(QuotationAdapter(sections: []))
        }
        didSet {
            let featuredSection = GenericSectionModel<BitcoinQuotation, FeaturedQuotationCell>(items: [quotation])

            quotation.values.removeLast()
            let quotationsSection = GenericSectionModel<QuotationValue, QuotationCell>(items: quotation.sortedValues)

            self.adapter = QuotationAdapter(sections: [featuredSection, quotationsSection])
            self.tableView.setAdapter(self.adapter)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchQuotation()
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: "FeaturedQuotationCell", bundle: nil), forCellReuseIdentifier: FeaturedQuotationCell.reuseIdentifier)
        tableView.register(UINib(nibName: "QuotationCell", bundle: nil), forCellReuseIdentifier: QuotationCell.reuseIdentifier)

        refreshControl.addTarget(self, action: #selector(fetchQuotation), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    private func stopRefreshing() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }

    @objc private func fetchQuotation() {
        NetworkFeedback.shared.startLoading()
        ApiClient.shared.fetchQuotation { [unowned self] (remoteQuotation) in
            self.quotation = remoteQuotation
            NetworkFeedback.shared.stopLoading()
            self.stopRefreshing()
        }
    }

}

