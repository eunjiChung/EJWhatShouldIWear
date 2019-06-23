//
//  EJCurrentWeather.swift
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 22/06/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class EJCurrentWeather: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let main = "main"
    static let name = "name"
    static let id = "id"
    static let coord = "coord"
    static let weather = "weather"
    static let clouds = "clouds"
    static let dt = "dt"
    static let base = "base"
    static let sys = "sys"
    static let timezone = "timezone"
    static let cod = "cod"
    static let wind = "wind"
  }

  // MARK: Properties
  public var main: EJMain?
  public var name: String?
  public var id: Int?
  public var coord: EJCoord?
  public var weather: [EJWeather]?
  public var clouds: EJClouds?
  public var dt: Int?
  public var base: String?
  public var sys: EJSys?
  public var timezone: Int?
  public var cod: Int?
  public var wind: EJWind?

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
    main = EJMain(json: json[SerializationKeys.main])
    name = json[SerializationKeys.name].string
    id = json[SerializationKeys.id].int
    coord = EJCoord(json: json[SerializationKeys.coord])
    if let items = json[SerializationKeys.weather].array { weather = items.map { EJWeather(json: $0) } }
    clouds = EJClouds(json: json[SerializationKeys.clouds])
    dt = json[SerializationKeys.dt].int
    base = json[SerializationKeys.base].string
    sys = EJSys(json: json[SerializationKeys.sys])
    timezone = json[SerializationKeys.timezone].int
    cod = json[SerializationKeys.cod].int
    wind = EJWind(json: json[SerializationKeys.wind])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = main { dictionary[SerializationKeys.main] = value.dictionaryRepresentation() }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = coord { dictionary[SerializationKeys.coord] = value.dictionaryRepresentation() }
    if let value = weather { dictionary[SerializationKeys.weather] = value.map { $0.dictionaryRepresentation() } }
    if let value = clouds { dictionary[SerializationKeys.clouds] = value.dictionaryRepresentation() }
    if let value = dt { dictionary[SerializationKeys.dt] = value }
    if let value = base { dictionary[SerializationKeys.base] = value }
    if let value = sys { dictionary[SerializationKeys.sys] = value.dictionaryRepresentation() }
    if let value = timezone { dictionary[SerializationKeys.timezone] = value }
    if let value = cod { dictionary[SerializationKeys.cod] = value }
    if let value = wind { dictionary[SerializationKeys.wind] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.main = aDecoder.decodeObject(forKey: SerializationKeys.main) as? EJMain
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.coord = aDecoder.decodeObject(forKey: SerializationKeys.coord) as? EJCoord
    self.weather = aDecoder.decodeObject(forKey: SerializationKeys.weather) as? [EJWeather]
    self.clouds = aDecoder.decodeObject(forKey: SerializationKeys.clouds) as? EJClouds
    self.dt = aDecoder.decodeObject(forKey: SerializationKeys.dt) as? Int
    self.base = aDecoder.decodeObject(forKey: SerializationKeys.base) as? String
    self.sys = aDecoder.decodeObject(forKey: SerializationKeys.sys) as? EJSys
    self.timezone = aDecoder.decodeObject(forKey: SerializationKeys.timezone) as? Int
    self.cod = aDecoder.decodeObject(forKey: SerializationKeys.cod) as? Int
    self.wind = aDecoder.decodeObject(forKey: SerializationKeys.wind) as? EJWind
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(main, forKey: SerializationKeys.main)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(coord, forKey: SerializationKeys.coord)
    aCoder.encode(weather, forKey: SerializationKeys.weather)
    aCoder.encode(clouds, forKey: SerializationKeys.clouds)
    aCoder.encode(dt, forKey: SerializationKeys.dt)
    aCoder.encode(base, forKey: SerializationKeys.base)
    aCoder.encode(sys, forKey: SerializationKeys.sys)
    aCoder.encode(timezone, forKey: SerializationKeys.timezone)
    aCoder.encode(cod, forKey: SerializationKeys.cod)
    aCoder.encode(wind, forKey: SerializationKeys.wind)
  }

}
