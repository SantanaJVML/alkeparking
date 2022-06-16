import UIKit

var vehiclesList: Set<Vehicle> = [Vehicle(plate: "AAA", vehicleType: VehicleType.car, checkInTime: Date(), discountCard: nil), Vehicle(plate: "BBB", vehicleType: VehicleType.car, checkInTime:  Date(), discountCard: nil), Vehicle(plate: "AAA", vehicleType: VehicleType.car, checkInTime:  Date(), discountCard: nil), Vehicle(plate: "CCC", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil), Vehicle(plate: "CCD", vehicleType: VehicleType.bus, checkInTime: Date(), discountCard: nil)]

//var vehiclesList: Set<Vehicle> = []

enum VehicleType {
    case car, motorcycle, microbus, bus
    
    var tarifa: Int {
        switch self {
            case .car: return 20
            case .motorcycle: return 15
            case .microbus: return 25
            case .bus: return 30
        }
    }
}

protocol Parkable {
    var plate: String { get }
    var vehicleType: VehicleType { get }
    var discountCard: String? { get set }
    var checkInTime: Date { get }
    var parkedTime: Int { get }
}

struct Vehicle: Parkable, Hashable {
    let plate: String
    let vehicleType: VehicleType
    let checkInTime: Date
    var discountCard: String?
    var parkedTime: Int {
        get { Calendar.current.dateComponents([.minute], from: checkInTime, to: Date()).minute ?? 0 }
    }
    
    //Hashtable
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate.hashValue)
    }
    
    //Equatable
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        lhs.plate == rhs.plate
    }
}

struct Parking{
    let maxVehicles: Int
    var vehicles: Set<Vehicle> = Set()
    
    
    mutating func checkInVehicle(_ vehicle: Vehicle, onFinish:
                                 (Bool) -> Void) {
        
        guard (vehicles.count < maxVehicles) && !vehicles.contains(vehicle) else {
            return onFinish(false)
        }
        
        onFinish(vehicles.insert(vehicle).inserted)
    
    }
    
}


//vehiclesList.insert(Vehicle(plate: "AAA", vehicleType: VehicleType.car, checkInTime: Date(), discountCard: nil))
//print(vehiclesList)

// MARK: - Verificador de quantidade máxima e print mensagem

var alkeParking = Parking(maxVehicles: 2)

var counter = 0
for vehicleList in vehiclesList {
    if counter < alkeParking.maxVehicles{
        alkeParking.checkInVehicle(vehicleList){_ in
            print("Welcome to AlkeParking!")}
        counter += 1
    }else{
        print("Sorry,the check-in failed")
    }
}


