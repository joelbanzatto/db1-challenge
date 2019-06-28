import Foundation

struct QuotationValue: Decodable {
    let x: Int
    let y: Double

    init(_ dictionary: [String: Any]) {
        self.x = dictionary["x"] as? Int ?? 0
        self.y = dictionary["y"] as? Double ?? 0
    }

    enum CodingKeys: String, CodingKey {
        case x, y
    }

    init(x: Int, y: Double) {
        self.x = x
        self.y = y
    }

    init(from decoder: Decoder) throws {
        let decodingValues = try decoder.container(keyedBy: CodingKeys.self)
        x = try decodingValues.decode(Int.self, forKey: .x)
        y = try decodingValues.decode(Double.self, forKey: .y)
    }
}
