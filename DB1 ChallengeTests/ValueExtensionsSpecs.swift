import Quick
import Nimble

@testable import DB1_Challenge

class ValueExtensionsSpecs: QuickSpec {
    override func spec() {

        let dummyValue = QuotationValue(x: 1561740968, y: 12345.67)

        describe("value extensions spec") {

            it("attribute formats properly as MONEY") {
                expect(dummyValue.y.asMoney()).to(equal("$12,345.67"))
            }

            it("attribute formats properly as DATE") {
                expect(dummyValue.x.asDate()).notTo(beEmpty())
            }


            it("attribute formats properly as DATE using format") {
                expect(dummyValue.x.asDate(with: "dd/MM")).to(equal("28/06"))
            }

        }
    }
}

