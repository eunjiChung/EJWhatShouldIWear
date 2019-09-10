//
//  SKSixSky.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKSixSky: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let amName10day = "amName10day"
    static let pmName7day = "pmName7day"
    static let amName8day = "amName8day"
    static let pmCode9day = "pmCode9day"
    static let pmName6day = "pmName6day"
    static let pmCode2day = "pmCode2day"
    static let amCode10day = "amCode10day"
    static let amCode3day = "amCode3day"
    static let pmName9day = "pmName9day"
    static let pmCode7day = "pmCode7day"
    static let pmName10day = "pmName10day"
    static let pmCode8day = "pmCode8day"
    static let amName4day = "amName4day"
    static let pmCode10day = "pmCode10day"
    static let pmCode5day = "pmCode5day"
    static let amName3day = "amName3day"
    static let amName5day = "amName5day"
    static let amCode6day = "amCode6day"
    static let amName2day = "amName2day"
    static let amName7day = "amName7day"
    static let pmName2day = "pmName2day"
    static let amCode2day = "amCode2day"
    static let amName9day = "amName9day"
    static let amName6day = "amName6day"
    static let pmName3day = "pmName3day"
    static let amCode8day = "amCode8day"
    static let amCode9day = "amCode9day"
    static let amCode5day = "amCode5day"
    static let pmCode3day = "pmCode3day"
    static let amCode7day = "amCode7day"
    static let pmName8day = "pmName8day"
    static let pmName4day = "pmName4day"
    static let pmCode4day = "pmCode4day"
    static let pmName5day = "pmName5day"
    static let amCode4day = "amCode4day"
    static let pmCode6day = "pmCode6day"
  }

  // MARK: Properties
  public var amName10day: String?
  public var pmName7day: String?
  public var amName8day: String?
  public var pmCode9day: String?
  public var pmName6day: String?
  public var pmCode2day: String?
  public var amCode10day: String?
  public var amCode3day: String?
  public var pmName9day: String?
  public var pmCode7day: String?
  public var pmName10day: String?
  public var pmCode8day: String?
  public var amName4day: String?
  public var pmCode10day: String?
  public var pmCode5day: String?
  public var amName3day: String?
  public var amName5day: String?
  public var amCode6day: String?
  public var amName2day: String?
  public var amName7day: String?
  public var pmName2day: String?
  public var amCode2day: String?
  public var amName9day: String?
  public var amName6day: String?
  public var pmName3day: String?
  public var amCode8day: String?
  public var amCode9day: String?
  public var amCode5day: String?
  public var pmCode3day: String?
  public var amCode7day: String?
  public var pmName8day: String?
  public var pmName4day: String?
  public var pmCode4day: String?
  public var pmName5day: String?
  public var amCode4day: String?
  public var pmCode6day: String?

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
    amName10day = json[SerializationKeys.amName10day].string
    pmName7day = json[SerializationKeys.pmName7day].string
    amName8day = json[SerializationKeys.amName8day].string
    pmCode9day = json[SerializationKeys.pmCode9day].string
    pmName6day = json[SerializationKeys.pmName6day].string
    pmCode2day = json[SerializationKeys.pmCode2day].string
    amCode10day = json[SerializationKeys.amCode10day].string
    amCode3day = json[SerializationKeys.amCode3day].string
    pmName9day = json[SerializationKeys.pmName9day].string
    pmCode7day = json[SerializationKeys.pmCode7day].string
    pmName10day = json[SerializationKeys.pmName10day].string
    pmCode8day = json[SerializationKeys.pmCode8day].string
    amName4day = json[SerializationKeys.amName4day].string
    pmCode10day = json[SerializationKeys.pmCode10day].string
    pmCode5day = json[SerializationKeys.pmCode5day].string
    amName3day = json[SerializationKeys.amName3day].string
    amName5day = json[SerializationKeys.amName5day].string
    amCode6day = json[SerializationKeys.amCode6day].string
    amName2day = json[SerializationKeys.amName2day].string
    amName7day = json[SerializationKeys.amName7day].string
    pmName2day = json[SerializationKeys.pmName2day].string
    amCode2day = json[SerializationKeys.amCode2day].string
    amName9day = json[SerializationKeys.amName9day].string
    amName6day = json[SerializationKeys.amName6day].string
    pmName3day = json[SerializationKeys.pmName3day].string
    amCode8day = json[SerializationKeys.amCode8day].string
    amCode9day = json[SerializationKeys.amCode9day].string
    amCode5day = json[SerializationKeys.amCode5day].string
    pmCode3day = json[SerializationKeys.pmCode3day].string
    amCode7day = json[SerializationKeys.amCode7day].string
    pmName8day = json[SerializationKeys.pmName8day].string
    pmName4day = json[SerializationKeys.pmName4day].string
    pmCode4day = json[SerializationKeys.pmCode4day].string
    pmName5day = json[SerializationKeys.pmName5day].string
    amCode4day = json[SerializationKeys.amCode4day].string
    pmCode6day = json[SerializationKeys.pmCode6day].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = amName10day { dictionary[SerializationKeys.amName10day] = value }
    if let value = pmName7day { dictionary[SerializationKeys.pmName7day] = value }
    if let value = amName8day { dictionary[SerializationKeys.amName8day] = value }
    if let value = pmCode9day { dictionary[SerializationKeys.pmCode9day] = value }
    if let value = pmName6day { dictionary[SerializationKeys.pmName6day] = value }
    if let value = pmCode2day { dictionary[SerializationKeys.pmCode2day] = value }
    if let value = amCode10day { dictionary[SerializationKeys.amCode10day] = value }
    if let value = amCode3day { dictionary[SerializationKeys.amCode3day] = value }
    if let value = pmName9day { dictionary[SerializationKeys.pmName9day] = value }
    if let value = pmCode7day { dictionary[SerializationKeys.pmCode7day] = value }
    if let value = pmName10day { dictionary[SerializationKeys.pmName10day] = value }
    if let value = pmCode8day { dictionary[SerializationKeys.pmCode8day] = value }
    if let value = amName4day { dictionary[SerializationKeys.amName4day] = value }
    if let value = pmCode10day { dictionary[SerializationKeys.pmCode10day] = value }
    if let value = pmCode5day { dictionary[SerializationKeys.pmCode5day] = value }
    if let value = amName3day { dictionary[SerializationKeys.amName3day] = value }
    if let value = amName5day { dictionary[SerializationKeys.amName5day] = value }
    if let value = amCode6day { dictionary[SerializationKeys.amCode6day] = value }
    if let value = amName2day { dictionary[SerializationKeys.amName2day] = value }
    if let value = amName7day { dictionary[SerializationKeys.amName7day] = value }
    if let value = pmName2day { dictionary[SerializationKeys.pmName2day] = value }
    if let value = amCode2day { dictionary[SerializationKeys.amCode2day] = value }
    if let value = amName9day { dictionary[SerializationKeys.amName9day] = value }
    if let value = amName6day { dictionary[SerializationKeys.amName6day] = value }
    if let value = pmName3day { dictionary[SerializationKeys.pmName3day] = value }
    if let value = amCode8day { dictionary[SerializationKeys.amCode8day] = value }
    if let value = amCode9day { dictionary[SerializationKeys.amCode9day] = value }
    if let value = amCode5day { dictionary[SerializationKeys.amCode5day] = value }
    if let value = pmCode3day { dictionary[SerializationKeys.pmCode3day] = value }
    if let value = amCode7day { dictionary[SerializationKeys.amCode7day] = value }
    if let value = pmName8day { dictionary[SerializationKeys.pmName8day] = value }
    if let value = pmName4day { dictionary[SerializationKeys.pmName4day] = value }
    if let value = pmCode4day { dictionary[SerializationKeys.pmCode4day] = value }
    if let value = pmName5day { dictionary[SerializationKeys.pmName5day] = value }
    if let value = amCode4day { dictionary[SerializationKeys.amCode4day] = value }
    if let value = pmCode6day { dictionary[SerializationKeys.pmCode6day] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.amName10day = aDecoder.decodeObject(forKey: SerializationKeys.amName10day) as? String
    self.pmName7day = aDecoder.decodeObject(forKey: SerializationKeys.pmName7day) as? String
    self.amName8day = aDecoder.decodeObject(forKey: SerializationKeys.amName8day) as? String
    self.pmCode9day = aDecoder.decodeObject(forKey: SerializationKeys.pmCode9day) as? String
    self.pmName6day = aDecoder.decodeObject(forKey: SerializationKeys.pmName6day) as? String
    self.pmCode2day = aDecoder.decodeObject(forKey: SerializationKeys.pmCode2day) as? String
    self.amCode10day = aDecoder.decodeObject(forKey: SerializationKeys.amCode10day) as? String
    self.amCode3day = aDecoder.decodeObject(forKey: SerializationKeys.amCode3day) as? String
    self.pmName9day = aDecoder.decodeObject(forKey: SerializationKeys.pmName9day) as? String
    self.pmCode7day = aDecoder.decodeObject(forKey: SerializationKeys.pmCode7day) as? String
    self.pmName10day = aDecoder.decodeObject(forKey: SerializationKeys.pmName10day) as? String
    self.pmCode8day = aDecoder.decodeObject(forKey: SerializationKeys.pmCode8day) as? String
    self.amName4day = aDecoder.decodeObject(forKey: SerializationKeys.amName4day) as? String
    self.pmCode10day = aDecoder.decodeObject(forKey: SerializationKeys.pmCode10day) as? String
    self.pmCode5day = aDecoder.decodeObject(forKey: SerializationKeys.pmCode5day) as? String
    self.amName3day = aDecoder.decodeObject(forKey: SerializationKeys.amName3day) as? String
    self.amName5day = aDecoder.decodeObject(forKey: SerializationKeys.amName5day) as? String
    self.amCode6day = aDecoder.decodeObject(forKey: SerializationKeys.amCode6day) as? String
    self.amName2day = aDecoder.decodeObject(forKey: SerializationKeys.amName2day) as? String
    self.amName7day = aDecoder.decodeObject(forKey: SerializationKeys.amName7day) as? String
    self.pmName2day = aDecoder.decodeObject(forKey: SerializationKeys.pmName2day) as? String
    self.amCode2day = aDecoder.decodeObject(forKey: SerializationKeys.amCode2day) as? String
    self.amName9day = aDecoder.decodeObject(forKey: SerializationKeys.amName9day) as? String
    self.amName6day = aDecoder.decodeObject(forKey: SerializationKeys.amName6day) as? String
    self.pmName3day = aDecoder.decodeObject(forKey: SerializationKeys.pmName3day) as? String
    self.amCode8day = aDecoder.decodeObject(forKey: SerializationKeys.amCode8day) as? String
    self.amCode9day = aDecoder.decodeObject(forKey: SerializationKeys.amCode9day) as? String
    self.amCode5day = aDecoder.decodeObject(forKey: SerializationKeys.amCode5day) as? String
    self.pmCode3day = aDecoder.decodeObject(forKey: SerializationKeys.pmCode3day) as? String
    self.amCode7day = aDecoder.decodeObject(forKey: SerializationKeys.amCode7day) as? String
    self.pmName8day = aDecoder.decodeObject(forKey: SerializationKeys.pmName8day) as? String
    self.pmName4day = aDecoder.decodeObject(forKey: SerializationKeys.pmName4day) as? String
    self.pmCode4day = aDecoder.decodeObject(forKey: SerializationKeys.pmCode4day) as? String
    self.pmName5day = aDecoder.decodeObject(forKey: SerializationKeys.pmName5day) as? String
    self.amCode4day = aDecoder.decodeObject(forKey: SerializationKeys.amCode4day) as? String
    self.pmCode6day = aDecoder.decodeObject(forKey: SerializationKeys.pmCode6day) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(amName10day, forKey: SerializationKeys.amName10day)
    aCoder.encode(pmName7day, forKey: SerializationKeys.pmName7day)
    aCoder.encode(amName8day, forKey: SerializationKeys.amName8day)
    aCoder.encode(pmCode9day, forKey: SerializationKeys.pmCode9day)
    aCoder.encode(pmName6day, forKey: SerializationKeys.pmName6day)
    aCoder.encode(pmCode2day, forKey: SerializationKeys.pmCode2day)
    aCoder.encode(amCode10day, forKey: SerializationKeys.amCode10day)
    aCoder.encode(amCode3day, forKey: SerializationKeys.amCode3day)
    aCoder.encode(pmName9day, forKey: SerializationKeys.pmName9day)
    aCoder.encode(pmCode7day, forKey: SerializationKeys.pmCode7day)
    aCoder.encode(pmName10day, forKey: SerializationKeys.pmName10day)
    aCoder.encode(pmCode8day, forKey: SerializationKeys.pmCode8day)
    aCoder.encode(amName4day, forKey: SerializationKeys.amName4day)
    aCoder.encode(pmCode10day, forKey: SerializationKeys.pmCode10day)
    aCoder.encode(pmCode5day, forKey: SerializationKeys.pmCode5day)
    aCoder.encode(amName3day, forKey: SerializationKeys.amName3day)
    aCoder.encode(amName5day, forKey: SerializationKeys.amName5day)
    aCoder.encode(amCode6day, forKey: SerializationKeys.amCode6day)
    aCoder.encode(amName2day, forKey: SerializationKeys.amName2day)
    aCoder.encode(amName7day, forKey: SerializationKeys.amName7day)
    aCoder.encode(pmName2day, forKey: SerializationKeys.pmName2day)
    aCoder.encode(amCode2day, forKey: SerializationKeys.amCode2day)
    aCoder.encode(amName9day, forKey: SerializationKeys.amName9day)
    aCoder.encode(amName6day, forKey: SerializationKeys.amName6day)
    aCoder.encode(pmName3day, forKey: SerializationKeys.pmName3day)
    aCoder.encode(amCode8day, forKey: SerializationKeys.amCode8day)
    aCoder.encode(amCode9day, forKey: SerializationKeys.amCode9day)
    aCoder.encode(amCode5day, forKey: SerializationKeys.amCode5day)
    aCoder.encode(pmCode3day, forKey: SerializationKeys.pmCode3day)
    aCoder.encode(amCode7day, forKey: SerializationKeys.amCode7day)
    aCoder.encode(pmName8day, forKey: SerializationKeys.pmName8day)
    aCoder.encode(pmName4day, forKey: SerializationKeys.pmName4day)
    aCoder.encode(pmCode4day, forKey: SerializationKeys.pmCode4day)
    aCoder.encode(pmName5day, forKey: SerializationKeys.pmName5day)
    aCoder.encode(amCode4day, forKey: SerializationKeys.amCode4day)
    aCoder.encode(pmCode6day, forKey: SerializationKeys.pmCode6day)
  }

}
