import Quick
import Nimble

@testable import DB1_Challenge

class NetworkFeedbackSpecs: QuickSpec {
    override func spec() {
        describe("NetworkFeedback specs") {
            it("has to show network activity indicator") {
                NetworkFeedback.shared.startLoading()
                expect(UIApplication.shared.isNetworkActivityIndicatorVisible).toEventually(beTrue())
            }
            it("has to hide network activity indicator") {
                NetworkFeedback.shared.stopLoading()
                expect(UIApplication.shared.isNetworkActivityIndicatorVisible).toEventually(beFalse())
            }
        }
    }
}

