protocol Parkable {
    var plate: String { get }
}

struct Vehicle: Hashable, Parkable {
    let plate: String
    let model: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate.hashValue)
    }
    
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        lhs.plate == rhs.plate
    }
}

struct Parking {
    var vehicles: Set<Vehicle> = Set()
}
 

