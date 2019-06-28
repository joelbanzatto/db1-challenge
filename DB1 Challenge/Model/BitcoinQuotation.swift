import Foundation

struct BitcoinQuotation: Decodable {
    public var name: String
    public var unit: String
    public var period: String
    public var description: String
    public var values: [QuotationValue]
    public var sortedValues: [QuotationValue] {
        get {
            return self.values.sorted(by: { $0.x > $1.x })
        }
    }

    enum CodingKeys: String, CodingKey {
        case name, unit, period, description, values
    }

    init(name: String, unit: String, period: String, description: String, values: [QuotationValue]) {
        self.name = name
        self.unit = unit
        self.period = period
        self.description = description
        self.values = values
    }

    init(from decoder: Decoder) throws {
        let decodingValues = try decoder.container(keyedBy: CodingKeys.self)
        name = try decodingValues.decode(String.self, forKey: .name)
        unit = try decodingValues.decode(String.self, forKey: .unit)
        period = try decodingValues.decode(String.self, forKey: .period)
        description = try decodingValues.decode(String.self, forKey: .description)
        values = try decodingValues.decode([QuotationValue].self, forKey: .values)
    }
}
