import Foundation

struct BitcoinQuotation: Decodable {
    public var name: String
    public var unit: String
    public var period: String
    public var description: String
    public var values: [QuotationValue]

    enum CodingKeys: String, CodingKey {
        case name, unit, period, description, values
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
