import Foundation
import SQLite

typealias SuccessHandlerType = (BitcoinQuotation) -> Void
typealias FailHandlerType = (Error?) -> Void

enum ProviderError: Error {
    case emptyData
    case unknown
}

final class QuotationDataProvider {

    static let shared = QuotationDataProvider()
    private var database: Connection!

    struct BitcointQuotationFields {
        static let shared = BitcointQuotationFields()
        public let description = Expression<String>("description")
        public let period = Expression<String>("period")
        public let unit = Expression<String>("unit")
        public let name = Expression<String>("name")
    }

    struct QuotationValueFields {
        static let shared = QuotationValueFields()
        public let x = Expression<Int>("x")
        public let y = Expression<Double>("y")
    }

    public func fetchQuotation(_ success: @escaping SuccessHandlerType) {
        fetchOnline(success) { [unowned self] _ in
            self.fetchOffline(success)
        }
    }

    private func fetchOnline(_ success: @escaping SuccessHandlerType, _ fail: @escaping FailHandlerType) {
        ApiClient.shared.fetchQuotation(success: { quotation in
            self.saveResult(quotation)
            success(quotation)
        }, fail: { error in fail(error) })
    }

    private func fetchOffline(_ success: SuccessHandlerType) {
        do {
            let quotations = try database.prepare("SELECT name, unit, period, description FROM quotation ").map { row in
                return BitcoinQuotation(
                    name: "\(row[0] ?? "")",
                    unit: "\(row[1] ?? "")",
                    period: "\(row[2] ?? "")",
                    description: "\(row[3] ?? "")",
                    values: []
                )
            }

            if var quotation = quotations.first {
                let values = try database.prepare("SELECT x, y FROM quotation_values ").map { row in
                    return QuotationValue(x: Int("\(row[0] ?? "0")") ?? 0, y: Double("\(row[1] ?? "0")") ?? 0)
                }

                quotation.values = values

                success(quotation)
            } else {
                throw ProviderError.emptyData
            }
        } catch (let error) {
            print(error)
        }
    }


    init() {
        setupDB()
    }

    private func setupDB() {
        if let dbPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            do {
                database = try Connection(dbPath.appendingPathComponent("db.sqlite").absoluteString)

                let quotationTable = Table("quotation")
                try database?.run(quotationTable.create { t in
                        t.column(BitcointQuotationFields.shared.description)
                        t.column(BitcointQuotationFields.shared.period)
                        t.column(BitcointQuotationFields.shared.unit)
                        t.column(BitcointQuotationFields.shared.name)
                    })

                let valuesTable = Table("quotation_values")
                try database?.run(valuesTable.create { t in
                    t.column(QuotationValueFields.shared.x)
                    t.column(QuotationValueFields.shared.y)
                })
            } catch(let error) {
                print(error)
            }

        }
    }

    private func saveResult(_ quotation: BitcoinQuotation) {
        guard let db = self.database else { return }
        do {
            try db.transaction {
                try db.prepare("DELETE FROM quotation").run()
                try db.prepare("DELETE FROM quotation_values").run()
                try db.prepare("INSERT INTO quotation (name, unit, period, description) VALUES (?, ?, ?, ?)").run([quotation.name, quotation.unit, quotation.period, quotation.description])

                let stmt = try db.prepare("INSERT INTO quotation_values (x, y) VALUES (?, ?)")
                for value in quotation.values {
                    try stmt.run([value.x, value.y])
                }
            }
        } catch (let error) {
            print(error)
        }
    }
}
