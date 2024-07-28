//
//  PersonalInfoVM.swift
//  project-z
//
//  Created by Inyene Etoedia on 21/06/2024.
//

import Foundation
import Combine
import SwiftUI

class PersonalInfoVM: ObservableObject {
    @Published var personalities = [PersonalityModel]()
    @Published var interests = [InterestModel]()
    @Published var tripType = [TripTypeModel]()
    @Published var cities = [CitiesDTO]()
    @Published var filtercities = [CitiesDTO]()
    @Published var selectedCities = [CitiesDTO]()
    @Published var selectedTrip = TripTypeModel(image: "", name: "", ticketCount: 0, ticketType: "")
    @Published var budgetTypes = [BudgetType]()
    @Published var cards = [SelectionCard]()
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
        cards.append(contentsOf: SelectionCard.selections)
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
        self.selectedTrip = city
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
        }
    }
    
    func moveToBack(_ index: Int, isGetStarted: Bool) {
        let removedCard = cards.remove(at: index)
        let res =  SelectionCard( id: removedCard.id, image: removedCard.image, name: removedCard.name, color: .gray, progress: removedCard.progress)
               cards.append(res)
        if let firstCard = cards.first {
            let cardColor: Color
            if firstCard.name == "Personality" {
                cardColor = .white
            } else {
                cardColor = isGetStarted ? .gray : .white
            }
            
            cards[0] = SelectionCard(
                id: firstCard.id,
                image: firstCard.image,
                name: firstCard.name,
                color: cardColor,
                progress: firstCard.progress
            )
        }
       }
    
    
    func indexOfx(card : SelectionCard) -> Int {
        if let index = cards.firstIndex(where: { CCard in
            CCard.id == card.id
        }){
            return index
        }
        return 0
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
    var ticketCount: Int
    var ticketType: String
    
    static var tripType: [TripTypeModel] = [
        TripTypeModel(image: "solo", name: "Solo Adventure", ticketCount: 1, ticketType: "planeTicket"),
        TripTypeModel(image: "family", name: "Family Vacation", ticketCount: 3, ticketType: "planeTicket"),
        TripTypeModel(image: "drive", name: "Road Trip", ticketCount: 1, ticketType: "carTicket"),
        TripTypeModel(image: "date", name: "Baecation", ticketCount: 2, ticketType: "planeTicket"),
        TripTypeModel(image: "date", name: "Group travel", ticketCount: 3, ticketType: "planeTicket"),
        TripTypeModel(image: "date", name: "Girls' trip", ticketCount: 3, ticketType: "planeTicket"),
        TripTypeModel(image: "date", name: "Guys' trip", ticketCount: 3, ticketType: "planeTicket")
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


struct SelectionCard: Hashable{
    var id : Int
    var image: String
    var name: String
    var color: Color
    var progress: Int
    
   
    static var selections: [SelectionCard] = [
        SelectionCard( id: 0, image: "tight", name: "Personality", color: .white, progress: 20),
        SelectionCard(id: 1, image: "tight", name: "Interest", color: Color.gray, progress: 40),
        SelectionCard(id: 2, image: "tight", name: "Cities Visited", color: Color.gray, progress: 60),
        SelectionCard(id: 3, image: "tight", name: "Trip Type", color: Color.gray, progress: 80),
        SelectionCard(id: 4, image: "tight", name: "Season", color: Color.gray, progress: 100)
        
    ]
    
}


