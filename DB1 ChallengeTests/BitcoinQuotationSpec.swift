import Quick
import Nimble

@testable import DB1_Challenge

class BitcoinQuotationSpec: QuickSpec {
    override func spec() {
        var bitcoinQuotation: BitcoinQuotation!
        let bitcoinQuotationJsonData: Data = "{\"status\":\"ok\",\"name\":\"Market Price (USD)\",\"unit\":\"USD\",\"period\":\"day\",\"description\":\"Average USD market price across major bitcoin exchanges.\",\"values\":[{\"x\":1530144000,\"y\":6107.8961538461535},{\"x\":1530230400,\"y\":5908.702499999999},{\"x\":1530316800,\"y\":6381.390833333334},{\"x\":1530403200,\"y\":6374.754166666667},{\"x\":1530489600,\"y\":6466.069166666667},{\"x\":1530576000,\"y\":6613.685833333333},{\"x\":1530662400,\"y\":6593.2891666666665}]}".data(using: .utf8)!
        let decoder = JSONDecoder()

        describe("model decodable spec") {
            beforeEach {
                bitcoinQuotation = try! decoder.decode(BitcoinQuotation.self, from: bitcoinQuotationJsonData)
            }

            context("when load json data") {
                it("quotation has correct attributes") {
                    expect(bitcoinQuotation.period).notTo(beEmpty())
                    expect(bitcoinQuotation.unit).notTo(beEmpty())
                    expect(bitcoinQuotation.description).notTo(beEmpty())
                    expect(bitcoinQuotation.name).notTo(beEmpty())
                }

                it("quotation has correct values array") {
                    expect(bitcoinQuotation.values.count).to(beGreaterThan(0))
                }

                it("some value has correct attributes") {
                    let randomValue = bitcoinQuotation.values.randomElement()!
                    expect(randomValue.x).to(beGreaterThan(0))
                    expect(randomValue.y).to(beGreaterThan(0))
                }

                it("sorts values properly") {
                    expect(bitcoinQuotation.sortedValues.count).to(beGreaterThan(0))
                }
            }
        }
    }
}

