//
//  SKThreeGrid.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKThreeGrid: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let latitude = "latitude"
    static let city = "city"
    static let longitude = "longitude"
    static let county = "county"
    static let village = "village"
  }

  // MARK: Properties
  public var latitude: String?
  public var city: String?
  public var longitude: String?
  public var county: String?
  public var village: String?

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
    latitude = json[SerializationKeys.latitude].string
    city = json[SerializationKeys.city].string
    longitude = json[SerializationKeys.longitude].string
    county = json[SerializationKeys.county].string
    village = json[SerializationKeys.village].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = city { dictionary[SerializationKeys.city] = value }
    if let value = longitude { dictionary[SerializationKeys.longitude] = value }
    if let value = county { dictionary[SerializationKeys.county] = value }
    if let value = village { dictionary[SerializationKeys.village] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? String
    self.city = aDecoder.decodeObject(forKey: SerializationKeys.city) as? String
    self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? String
    self.county = aDecoder.decodeObject(forKey: SerializationKeys.county) as? String
    self.village = aDecoder.decodeObject(forKey: SerializationKeys.village) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(latitude, forKey: SerializationKeys.latitude)
    aCoder.encode(city, forKey: SerializationKeys.city)
    aCoder.encode(longitude, forKey: SerializationKeys.longitude)
    aCoder.encode(county, forKey: SerializationKeys.county)
    aCoder.encode(village, forKey: SerializationKeys.village)
  }

}
