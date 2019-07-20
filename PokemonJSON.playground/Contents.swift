import UIKit


struct Move: Codable {
  let moveName: String
  let levelLearnedAt: Int
  let moveLearnMethodName: String
  let versionGroupName: String
  
  enum CodingKeys: String, CodingKey {
    case move
    case versionGroupDetails = "version_group_details"
    
    case name
    
    case levelLearnedAt = "level_learned_at"
    case moveLearnMethod = "move_learn_method"
    case versionGroup = "version_group"
    
  }
  /*
  enum MoveCodingKeys: String, CodingKey {
    case moveName = "name"
  }
  
  enum VersionGroupDetailsCodingKeys: String, CodingKey {
    case levelLearnedAt = "level_learned_at"
    case moveLearnMethod = "move_learn_method"
    case versionGroup = "version_group"
  }
  
  enum MoveLearnMethodCodingKeys: String, CodingKey {
    case moveLearnMethodName = "name"
  }
  
  enum VersionGroupCodingKeys: String, CodingKey {
    case versionGroupName = "name"
  }
  */
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
//    let moveContainer = try container.nestedContainer(keyedBy: MoveCodingKeys.self, forKey: .move)
//    let versionGroupDetailsContainer = try container.nestedContainer(keyedBy: VersionGroupDetailsCodingKeys.self, forKey: .versionGroupDetails)
//    let moveLearnMethodContainer = try versionGroupDetailsContainer.nestedContainer(keyedBy: MoveLearnMethodCodingKeys.self, forKey: .moveLearnMethod)
//    let versionGroupContainer = try versionGroupDetailsContainer.nestedContainer(keyedBy: VersionGroupCodingKeys.self, forKey: .versionGroup)
    let moveContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .move)
    let versionGroupDetailsContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .versionGroupDetails)
    let moveLearnMethodContainer = try versionGroupDetailsContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .moveLearnMethod)
    let versionGroupContainer = try versionGroupDetailsContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .versionGroup)
    
    self.moveName = try moveContainer.decode(String.self, forKey: .name)
    self.levelLearnedAt = try versionGroupDetailsContainer.decode(Int.self, forKey: .levelLearnedAt)
    self.moveLearnMethodName = try moveLearnMethodContainer.decode(String.self, forKey: .name)
    self.versionGroupName = try versionGroupContainer.decode(String.self, forKey: .name)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
//    var moveContainer = container.nestedContainer(keyedBy: MoveCodingKeys.self, forKey: .move)
//    var versionGroupDetailsContainer = container.nestedContainer(keyedBy: VersionGroupDetailsCodingKeys.self, forKey: .versionGroupDetails)
//    var moveLearnMethodContainer = versionGroupDetailsContainer.nestedContainer(keyedBy: MoveLearnMethodCodingKeys.self, forKey: .moveLearnMethod)
//    var versionGroupContainer = versionGroupDetailsContainer.nestedContainer(keyedBy: VersionGroupCodingKeys.self, forKey: .versionGroup)
    var moveContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .move)
    var versionGroupDetailsContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .versionGroupDetails)
    var moveLearnMethodContainer = versionGroupDetailsContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .moveLearnMethod)
    var versionGroupContainer = versionGroupDetailsContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .versionGroup)
    
    try moveContainer.encode(self.moveName, forKey: .name)
    try versionGroupDetailsContainer.encode(self.levelLearnedAt, forKey: .levelLearnedAt)
    try moveLearnMethodContainer.encode(self.moveLearnMethodName, forKey: .name)
    try versionGroupContainer.encode(self.versionGroupName, forKey: .name)
  }
}

struct Ability: Codable {
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case ability
  }
  
  enum AbilityCodingKeys: String, CodingKey {
    case name
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let abilityContainer = try container.nestedContainer(keyedBy: AbilityCodingKeys.self, forKey: .ability)
    self.name = try abilityContainer.decode(String.self, forKey: .name)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    var abilityContainer = container.nestedContainer(keyedBy: AbilityCodingKeys.self, forKey: .ability)
    try abilityContainer.encode(self.name, forKey: .name)
  }
}

struct Form: Codable {
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case name
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.name, forKey: .name)
  }
}

struct GameIndex: Codable {
  let gameIndex: Int
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case gameIndex = "game_index"
    case version
  }
  
  enum VersionCodingKeys: String, CodingKey {
    case name
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let versionContainer = try container.nestedContainer(keyedBy: VersionCodingKeys.self, forKey: .version)
    self.gameIndex = try container.decode(Int.self, forKey: .gameIndex)
    self.name = try versionContainer.decode(String.self, forKey: .name)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    var versionContainer = container.nestedContainer(keyedBy: VersionCodingKeys.self, forKey: .version)
    try versionContainer.encode(self.name, forKey: .name)
    try container.encode(self.gameIndex, forKey: .gameIndex)
  }
}

struct Species: Codable {
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case name
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.name, forKey: .name)
  }
}

struct Sprites: Codable {
  let backDefault: URL?
  let backFemale: URL?
  let backShiny: URL?
  let backShinyFemale: URL?
  let frontDefault: URL?
  let frontFemale: URL?
  let frontShiny: URL?
  let frontShinyFemale: URL?
  
  enum CodingKeys: String, CodingKey {
    case backDefault = "back_default"
    case backFemale = "back_female"
    case backShiny = "back_shiny"
    case backShinyFemale = "back_shiny_female"
    case frontDefault = "front_default"
    case frontFemale = "front_female"
    case frontShiny = "front_shiny"
    case frontShinyFemale = "front_shiny_female"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.backDefault = try container.decode(URL?.self, forKey: .backDefault)
    self.backFemale = try container.decode(URL?.self, forKey: .backFemale)
    self.backShiny = try container.decode(URL?.self, forKey: .backShiny)
    self.backShinyFemale = try container.decode(URL?.self, forKey: .backShinyFemale )
    self.frontDefault = try container.decode(URL?.self, forKey: .frontDefault)
    self.frontFemale = try container.decode(URL?.self, forKey: .frontFemale)
    self.frontShiny = try container.decode(URL?.self, forKey: .frontShiny)
    self.frontShinyFemale = try container.decode(URL?.self, forKey: .frontShinyFemale)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.backDefault, forKey: .backDefault)
    try container.encode(self.backFemale, forKey: .backFemale)
    try container.encode(self.backShiny, forKey: .backShiny)
    try container.encode(self.backShinyFemale, forKey: .backShinyFemale)
    try container.encode(self.frontDefault, forKey: .frontDefault)
    try container.encode(self.frontFemale, forKey: .frontFemale)
    try container.encode(self.frontShiny, forKey: .frontShiny)
    try container.encode(self.frontShinyFemale, forKey: .frontShinyFemale)
  }
}

struct Stat: Codable {
  let baseStat: Int
  let effort: Int
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case baseStat = "base_stat"
    case effort
    case stat
  }
  
  enum StatCodingKeys: String, CodingKey {
    case name
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let statContainer = try container.nestedContainer(keyedBy: StatCodingKeys.self, forKey: .stat)
    self.baseStat = try container.decode(Int.self, forKey: .baseStat)
    self.effort = try container.decode(Int.self, forKey: .effort)
    self.name = try statContainer.decode(String.self, forKey: .name)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    var statContainer = container.nestedContainer(keyedBy: StatCodingKeys.self, forKey: .stat)
    try container.encode(self.baseStat, forKey: .baseStat)
    try container.encode(self.effort, forKey: .effort)
    try statContainer.encode(self.name, forKey: .name)
  }
}

struct Type: Codable {
  let slot: Int
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case slot
    case type
  }
  
  enum TypeCodingKeys: String, CodingKey {
    case name
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let typeContainer = try container.nestedContainer(keyedBy: TypeCodingKeys.self, forKey: .type)
    self.slot = try container.decode(Int.self, forKey: .slot)
    self.name = try typeContainer.decode(String.self, forKey: .name)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    var typeContainer = container.nestedContainer(keyedBy: TypeCodingKeys.self, forKey: .type)
    try container.encode(self.slot, forKey: .slot)
    try typeContainer.encode(self.name, forKey: .name)
    
  }
  
  
}

struct Pokemon: Codable {
  let name: String
  let moves: [Move]
  let isDefault: Bool
  let abilities: [Ability]
  let baseExperience: Int
  let forms: [Form]
  let gameIndices: [GameIndex]
  let height: Int
//  let held_items: [Item]
  let id: Int
  let locationAreaEncounters: URL
  let order: Int
  let species: Species
  let sprites: Sprites
  let stats: [Stat]
  let types: [Type]
  let weight: Int
  
  enum CodingKeys: String, CodingKey {
    case name
    case moves
    case isDefault = "is_default"
    case abilities
    case baseExperience = "base_experience"
    case forms
    case gameIndices = "game_indices"
    case height
    case id
    case locationAreaEncounters = "location_area_encounters"
    case order
    case species
    case sprites
    case stats
    case types
    case weight
  }
}


if let jsonURL = Bundle.main.url(forResource: "PokemonExample", withExtension: "json"),
  let jsonData = try? Data(contentsOf: jsonURL) {
    let pokemon = try? JSONDecoder().decode(Pokemon.self, from: jsonData)
    print(pokemon)
} else {
  print("Something went horribly wrong.")
}
