//
//  EJFiveDaysCity.swift
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 22/06/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class EJFiveDaysCity: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let country = "country"
    static let name = "name"
    static let id = "id"
    static let timezone = "timezone"
    static let coord = "coord"
    static let population = "population"
  }

  // MARK: Properties
  public var country: String?
  public var name: String?
  public var id: Int?
  public var timezone: Int?
  public var coord: EJFiveDaysCoord?
  public var population: Int?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    country = json[SerializationKeys.country].string
    name = json[SerializationKeys.name].string
    id = json[SerializationKeys.id].int
    timezone = json[SerializationKeys.timezone].int
    coord = EJFiveDaysCoord(json: json[SerializationKeys.coord])
    population = json[SerializationKeys.population].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = country { dictionary[SerializationKeys.country] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = timezone { dictionary[SerializationKeys.timezone] = value }
    if let value = coord { dictionary[SerializationKeys.coord] = value.dictionaryRepresentation() }
    if let value = population { dictionary[SerializationKeys.population] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.country = aDecoder.decodeObject(forKey: SerializationKeys.country) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.timezone = aDecoder.decodeObject(forKey: SerializationKeys.timezone) as? Int
    self.coord = aDecoder.decodeObject(forKey: SerializationKeys.coord) as? EJFiveDaysCoord
    self.population = aDecoder.decodeObject(forKey: SerializationKeys.population) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(country, forKey: SerializationKeys.country)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(timezone, forKey: SerializationKeys.timezone)
    aCoder.encode(coord, forKey: SerializationKeys.coord)
    aCoder.encode(population, forKey: SerializationKeys.population)
  }

}
