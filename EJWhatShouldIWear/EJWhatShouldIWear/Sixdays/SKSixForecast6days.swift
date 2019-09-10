//
//  SKSixForecast6days.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKSixForecast6days: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let timeRelease = "timeRelease"
    static let sky = "sky"
    static let temperature = "temperature"
    static let location = "location"
    static let grid = "grid"
  }

  // MARK: Properties
  public var timeRelease: String?
  public var sky: SKSixSky?
  public var temperature: SKSixTemperature?
  public var location: SKSixLocation?
  public var grid: SKSixGrid?

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
    timeRelease = json[SerializationKeys.timeRelease].string
    sky = SKSixSky(json: json[SerializationKeys.sky])
    temperature = SKSixTemperature(json: json[SerializationKeys.temperature])
    location = SKSixLocation(json: json[SerializationKeys.location])
    grid = SKSixGrid(json: json[SerializationKeys.grid])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = timeRelease { dictionary[SerializationKeys.timeRelease] = value }
    if let value = sky { dictionary[SerializationKeys.sky] = value.dictionaryRepresentation() }
    if let value = temperature { dictionary[SerializationKeys.temperature] = value.dictionaryRepresentation() }
    if let value = location { dictionary[SerializationKeys.location] = value.dictionaryRepresentation() }
    if let value = grid { dictionary[SerializationKeys.grid] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.timeRelease = aDecoder.decodeObject(forKey: SerializationKeys.timeRelease) as? String
    self.sky = aDecoder.decodeObject(forKey: SerializationKeys.sky) as? SKSixSky
    self.temperature = aDecoder.decodeObject(forKey: SerializationKeys.temperature) as? SKSixTemperature
    self.location = aDecoder.decodeObject(forKey: SerializationKeys.location) as? SKSixLocation
    self.grid = aDecoder.decodeObject(forKey: SerializationKeys.grid) as? SKSixGrid
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(timeRelease, forKey: SerializationKeys.timeRelease)
    aCoder.encode(sky, forKey: SerializationKeys.sky)
    aCoder.encode(temperature, forKey: SerializationKeys.temperature)
    aCoder.encode(location, forKey: SerializationKeys.location)
    aCoder.encode(grid, forKey: SerializationKeys.grid)
  }

}
