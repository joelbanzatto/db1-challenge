import Quick
import Nimble

@testable import DB1_Challenge

class QuotationDataProviderSpecs: QuickSpec {
    override func spec() {
        var result: BitcoinQuotation?
        describe("QuotationDataProvider specs") {
            context("remote or local data fetching") {
                it("has to be successful both local OR remote call") {
                    QuotationDataProvider.shared.fetchQuotation { value in
                        result = value
                    }
                    expect(result).toEventuallyNot(beNil())
                }

                it("local database exists") {
                    expect(QuotationDataProvider.shared.database).toEventuallyNot(beNil())
                }
            }
        }
    }
}

