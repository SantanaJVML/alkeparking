protocol Parkable {
    var plate: String { get }
    var vehicleType: Int { get }
    var discountCard: String { get }
    var totalTime: Double { get }
    
}

struct Vehicle: Parkable, Hashable {
    var plate: String
    var vehicleType: Int
    var discountCard: String
    var totalTime: Double
    
    //Hashtable
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate.hashValue)
    }
    
    //Equatable
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool{
        lhs.plate == rhs.plate
    }
    
}
struct Parking{
    
    var vehicles: Set<Vehicle> = Set()
}

let alkeParking: Parking = Parking()
