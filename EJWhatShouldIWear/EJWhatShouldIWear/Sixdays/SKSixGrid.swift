//
//  SKSixGrid.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKSixGrid: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let city = "city"
    static let village = "village"
    static let county = "county"
  }

  // MARK: Properties
  public var city: String?
  public var village: String?
  public var county: String?

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
    city = json[SerializationKeys.city].string
    village = json[SerializationKeys.village].string
    county = json[SerializationKeys.county].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = city { dictionary[SerializationKeys.city] = value }
    if let value = village { dictionary[SerializationKeys.village] = value }
    if let value = county { dictionary[SerializationKeys.county] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.city = aDecoder.decodeObject(forKey: SerializationKeys.city) as? String
    self.village = aDecoder.decodeObject(forKey: SerializationKeys.village) as? String
    self.county = aDecoder.decodeObject(forKey: SerializationKeys.county) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(city, forKey: SerializationKeys.city)
    aCoder.encode(village, forKey: SerializationKeys.village)
    aCoder.encode(county, forKey: SerializationKeys.county)
  }

}
