//
//  SKHourlyHourly.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKHourlyHourly: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let sky = "sky"
    static let timeRelease = "timeRelease"
    static let grid = "grid"
    static let precipitation = "precipitation"
    static let humidity = "humidity"
    static let temperature = "temperature"
    static let wind = "wind"
    static let lightning = "lightning"
  }

  // MARK: Properties
  public var sky: SKHourlySky?
  public var timeRelease: String?
  public var grid: SKHourlyGrid?
  public var precipitation: SKHourlyPrecipitation?
  public var humidity: String?
  public var temperature: SKHourlyTemperature?
  public var wind: SKHourlyWind?
  public var lightning: String?

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
    sky = SKHourlySky(json: json[SerializationKeys.sky])
    timeRelease = json[SerializationKeys.timeRelease].string
    grid = SKHourlyGrid(json: json[SerializationKeys.grid])
    precipitation = SKHourlyPrecipitation(json: json[SerializationKeys.precipitation])
    humidity = json[SerializationKeys.humidity].string
    temperature = SKHourlyTemperature(json: json[SerializationKeys.temperature])
    wind = SKHourlyWind(json: json[SerializationKeys.wind])
    lightning = json[SerializationKeys.lightning].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = sky { dictionary[SerializationKeys.sky] = value.dictionaryRepresentation() }
    if let value = timeRelease { dictionary[SerializationKeys.timeRelease] = value }
    if let value = grid { dictionary[SerializationKeys.grid] = value.dictionaryRepresentation() }
    if let value = precipitation { dictionary[SerializationKeys.precipitation] = value.dictionaryRepresentation() }
    if let value = humidity { dictionary[SerializationKeys.humidity] = value }
    if let value = temperature { dictionary[SerializationKeys.temperature] = value.dictionaryRepresentation() }
    if let value = wind { dictionary[SerializationKeys.wind] = value.dictionaryRepresentation() }
    if let value = lightning { dictionary[SerializationKeys.lightning] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.sky = aDecoder.decodeObject(forKey: SerializationKeys.sky) as? SKHourlySky
    self.timeRelease = aDecoder.decodeObject(forKey: SerializationKeys.timeRelease) as? String
    self.grid = aDecoder.decodeObject(forKey: SerializationKeys.grid) as? SKHourlyGrid
    self.precipitation = aDecoder.decodeObject(forKey: SerializationKeys.precipitation) as? SKHourlyPrecipitation
    self.humidity = aDecoder.decodeObject(forKey: SerializationKeys.humidity) as? String
    self.temperature = aDecoder.decodeObject(forKey: SerializationKeys.temperature) as? SKHourlyTemperature
    self.wind = aDecoder.decodeObject(forKey: SerializationKeys.wind) as? SKHourlyWind
    self.lightning = aDecoder.decodeObject(forKey: SerializationKeys.lightning) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(sky, forKey: SerializationKeys.sky)
    aCoder.encode(timeRelease, forKey: SerializationKeys.timeRelease)
    aCoder.encode(grid, forKey: SerializationKeys.grid)
    aCoder.encode(precipitation, forKey: SerializationKeys.precipitation)
    aCoder.encode(humidity, forKey: SerializationKeys.humidity)
    aCoder.encode(temperature, forKey: SerializationKeys.temperature)
    aCoder.encode(wind, forKey: SerializationKeys.wind)
    aCoder.encode(lightning, forKey: SerializationKeys.lightning)
  }

}
