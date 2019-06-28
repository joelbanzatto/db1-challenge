import Quick
import Nimble

@testable import DB1_Challenge

class QuotationsViewControllerSpecs: QuickSpec {
    override func spec() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController: QuotationsViewController!

        describe("QuotationsViewController spec") {
            beforeEach {
                viewController = storyboard.instantiateViewController(withIdentifier: "QuotationsViewController") as? QuotationsViewController

                viewController.beginAppearanceTransition(true, animated: false)

                _ = viewController.tableView
            }

            context("when view is loaded") {
                it("has an empty tableview") {
                    expect(viewController.tableView.numberOfSections).to(equal(1))
                }
            
                it("has a 2 section tableview") {
                    expect(viewController.tableView.numberOfSections).toEventually(equal(2))
                }
            }
        }
    }
}


