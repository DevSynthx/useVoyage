//
//  PersonalInfoVM.swift
//  project-z
//
//  Created by Inyene Etoedia on 21/06/2024.
//

import Foundation
import Combine

class PersonalInfoVM: ObservableObject {
    @Published var personalities = [PersonalityModel]()
    @Published var interests = [InterestModel]()
    @Published var tripType = [TripTypeModel]()
    @Published var cities = [CitiesDTO]()
    @Published var filtercities = [CitiesDTO]()
    @Published var selectedCities = [CitiesDTO]()
    @Published var selectedTrip = [TripTypeModel]()
    @Published var budgetTypes = [BudgetType]()
    @Published var singleTrip: String = ""
    @Published var searchText : String = ""
    @Published var username : String = ""
    private var cancellable = Set<AnyCancellable>()
    init(){
        getPersonalInfo()
        fetchCities()
        searchSubscriber()
     
    }
    
    func enterName(name: String){
        self.username = name
    }
    
    func getPersonalInfo(){
        personalities.append(contentsOf: PersonalityModel.allpersonalities)
        interests.append(contentsOf: InterestModel.interests)
        tripType.append(contentsOf: TripTypeModel.tripType)
        budgetTypes.append(contentsOf: BudgetType.budgetType)
    }
    
    func selectPersonalities(name : String){
        if let index = personalities.firstIndex(where: { $0.name == name}){
            personalities[index].selected.toggle()
        }
    }
    func fetchCities(){
        self.cities = CitiesDTO.allCities
        self.filtercities = CitiesDTO.allCities
    }
    
    
    
    func searchSubscriber(){
         
         $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.filterCities(searchText: searchText)
            }
            .store(in: &cancellable)
     }
    
    func filterCities(searchText: String) {
       guard  !searchText.isEmpty  else {
            self.filtercities = cities
            return
        }
        filtercities =  cities.filter{$0.name.lowercased().contains(searchText.lowercased())}
        print(searchText)
    }
    
    //----------------> Selected trips implementation
    func selectTrip(city : TripTypeModel){
        self.singleTrip = city.name
    }
    
    // ----------------> Ends here
    
    //----------------> Selected Cities implementation
    func selectedCity(city : CitiesDTO){
        guard !selectedCities.contains(city)else {
            return
        }
        self.selectedCities.insert(city, at: 0)
    }
    
    func removeCity(city : CitiesDTO){
        if let index =  selectedCities.firstIndex(of: city){
            selectedCities.remove(at: index)
        }
    }
    // ----------------> Ends here
    
    func selectInterest(name : String){
        if let index = interests.firstIndex(where: { $0.name == name}){
            interests[index].selected.toggle()
            print( interests[index].selected)
        }
    }

}






struct PersonalityModel{
    var image: String
    var name: String
    var selected: Bool
    
    static var allpersonalities: [PersonalityModel] = [
      PersonalityModel(image: "p1", name: "Adventurous", selected: false),
      PersonalityModel(image: "foodie", name: "Foodie", selected: false),
      PersonalityModel(image: "p1", name: "Cultural", selected: false),
      PersonalityModel(image: "nature", name: "Nature lover", selected: false),
      PersonalityModel(image: "relax", name: "Relaxation seeker", selected: false),
      PersonalityModel(image: "explorer", name: "Explorer", selected: false),
      PersonalityModel(image: "art", name: "Art enthusiast", selected: false),
      PersonalityModel(image: "trendy", name: "Trendy", selected: false),
      PersonalityModel(image: "p1", name: "Spontaneous", selected: false)
    ]
    
}

/*
 History, Culinary, Adventure, Culture, Relaxation, Nature, Art, Beach, Shopping, Festivals, Photography, Sustainability, Wellness, Sports, Nightlife
 */
struct InterestModel{
    var image: String
    var name: String
    var selected: Bool
    
    static var interests: [InterestModel] = [
        InterestModel(image: "history", name: "History", selected: false),
        InterestModel(image: "culinary", name: "Culinary", selected: false),
        InterestModel(image: "relaxx", name: "Relaxation", selected: false),
        InterestModel(image: "natures", name: "Nature", selected: false),
        InterestModel(image: "paint", name: "Art", selected: false),
        InterestModel(image: "beach", name: "Beach", selected: false),
        InterestModel(image: "shopping", name: "Shopping", selected: false),
        InterestModel(image: "festival", name: "Festivals", selected: false),
        InterestModel(image: "culture", name: "Photography", selected: false),
        InterestModel(image: "sustainable", name: "Sustainability", selected: false),
        InterestModel(image: "wellness", name: "Wellness", selected: false),
        InterestModel(image: "sport", name: "Sports", selected: false),
        InterestModel(image: "wellness", name: "Nightlife", selected: false)
    ]
    
}

struct TripTypeModel: Hashable, Identifiable{
    var id: Self {self }
    var image: String
    var name: String
    
    static var tripType: [TripTypeModel] = [
        TripTypeModel(image: "solo", name: "Solo Adventure"),
        TripTypeModel(image: "family", name: "Family Vacation"),
        TripTypeModel(image: "drive", name: "Road Trip"),
        TripTypeModel(image: "date", name: "Baecation"),
        TripTypeModel(image: "date", name: "Group travel"),
        TripTypeModel(image: "date", name: "Girls' trip"),
        TripTypeModel(image: "date", name: "Guys' trip")
    ]
    
}

struct BudgetType: Hashable, Identifiable{
    var id: Self {self }
    var image: String
    var name: String
    
    static var budgetType: [BudgetType] = [
        BudgetType(image: "tight", name: "Budget between $0 - $190"),
        BudgetType(image: "mid-range", name: "Budget between $190 - $500"),
        BudgetType(image: "luxury", name: "Budget between $500 - Above")
        
    ]
    
}
