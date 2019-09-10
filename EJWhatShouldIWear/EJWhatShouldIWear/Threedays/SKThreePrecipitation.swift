//
//  SKThreePrecipitation.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKThreePrecipitation: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let type61hour = "type61hour"
    static let type49hour = "type49hour"
    static let prob7hour = "prob7hour"
    static let prob52hour = "prob52hour"
    static let type64hour = "type64hour"
    static let prob49hour = "prob49hour"
    static let type40hour = "type40hour"
    static let type46hour = "type46hour"
    static let type4hour = "type4hour"
    static let prob61hour = "prob61hour"
    static let type22hour = "type22hour"
    static let type25hour = "type25hour"
    static let prob46hour = "prob46hour"
    static let prob22hour = "prob22hour"
    static let type7hour = "type7hour"
    static let prob67hour = "prob67hour"
    static let type16hour = "type16hour"
    static let prob64hour = "prob64hour"
    static let type34hour = "type34hour"
    static let type10hour = "type10hour"
    static let prob25hour = "prob25hour"
    static let type31hour = "type31hour"
    static let prob19hour = "prob19hour"
    static let prob40hour = "prob40hour"
    static let type19hour = "type19hour"
    static let type43hour = "type43hour"
    static let prob16hour = "prob16hour"
    static let type13hour = "type13hour"
    static let prob4hour = "prob4hour"
    static let type28hour = "type28hour"
    static let type52hour = "type52hour"
    static let prob10hour = "prob10hour"
    static let type55hour = "type55hour"
    static let prob13hour = "prob13hour"
    static let prob28hour = "prob28hour"
    static let type58hour = "type58hour"
    static let prob37hour = "prob37hour"
    static let prob34hour = "prob34hour"
    static let type67hour = "type67hour"
    static let prob55hour = "prob55hour"
    static let prob58hour = "prob58hour"
    static let prob31hour = "prob31hour"
    static let type37hour = "type37hour"
    static let prob43hour = "prob43hour"
  }

  // MARK: Properties
  public var type61hour: String?
  public var type49hour: String?
  public var prob7hour: String?
  public var prob52hour: String?
  public var type64hour: String?
  public var prob49hour: String?
  public var type40hour: String?
  public var type46hour: String?
  public var type4hour: String?
  public var prob61hour: String?
  public var type22hour: String?
  public var type25hour: String?
  public var prob46hour: String?
  public var prob22hour: String?
  public var type7hour: String?
  public var prob67hour: String?
  public var type16hour: String?
  public var prob64hour: String?
  public var type34hour: String?
  public var type10hour: String?
  public var prob25hour: String?
  public var type31hour: String?
  public var prob19hour: String?
  public var prob40hour: String?
  public var type19hour: String?
  public var type43hour: String?
  public var prob16hour: String?
  public var type13hour: String?
  public var prob4hour: String?
  public var type28hour: String?
  public var type52hour: String?
  public var prob10hour: String?
  public var type55hour: String?
  public var prob13hour: String?
  public var prob28hour: String?
  public var type58hour: String?
  public var prob37hour: String?
  public var prob34hour: String?
  public var type67hour: String?
  public var prob55hour: String?
  public var prob58hour: String?
  public var prob31hour: String?
  public var type37hour: String?
  public var prob43hour: String?

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
    type61hour = json[SerializationKeys.type61hour].string
    type49hour = json[SerializationKeys.type49hour].string
    prob7hour = json[SerializationKeys.prob7hour].string
    prob52hour = json[SerializationKeys.prob52hour].string
    type64hour = json[SerializationKeys.type64hour].string
    prob49hour = json[SerializationKeys.prob49hour].string
    type40hour = json[SerializationKeys.type40hour].string
    type46hour = json[SerializationKeys.type46hour].string
    type4hour = json[SerializationKeys.type4hour].string
    prob61hour = json[SerializationKeys.prob61hour].string
    type22hour = json[SerializationKeys.type22hour].string
    type25hour = json[SerializationKeys.type25hour].string
    prob46hour = json[SerializationKeys.prob46hour].string
    prob22hour = json[SerializationKeys.prob22hour].string
    type7hour = json[SerializationKeys.type7hour].string
    prob67hour = json[SerializationKeys.prob67hour].string
    type16hour = json[SerializationKeys.type16hour].string
    prob64hour = json[SerializationKeys.prob64hour].string
    type34hour = json[SerializationKeys.type34hour].string
    type10hour = json[SerializationKeys.type10hour].string
    prob25hour = json[SerializationKeys.prob25hour].string
    type31hour = json[SerializationKeys.type31hour].string
    prob19hour = json[SerializationKeys.prob19hour].string
    prob40hour = json[SerializationKeys.prob40hour].string
    type19hour = json[SerializationKeys.type19hour].string
    type43hour = json[SerializationKeys.type43hour].string
    prob16hour = json[SerializationKeys.prob16hour].string
    type13hour = json[SerializationKeys.type13hour].string
    prob4hour = json[SerializationKeys.prob4hour].string
    type28hour = json[SerializationKeys.type28hour].string
    type52hour = json[SerializationKeys.type52hour].string
    prob10hour = json[SerializationKeys.prob10hour].string
    type55hour = json[SerializationKeys.type55hour].string
    prob13hour = json[SerializationKeys.prob13hour].string
    prob28hour = json[SerializationKeys.prob28hour].string
    type58hour = json[SerializationKeys.type58hour].string
    prob37hour = json[SerializationKeys.prob37hour].string
    prob34hour = json[SerializationKeys.prob34hour].string
    type67hour = json[SerializationKeys.type67hour].string
    prob55hour = json[SerializationKeys.prob55hour].string
    prob58hour = json[SerializationKeys.prob58hour].string
    prob31hour = json[SerializationKeys.prob31hour].string
    type37hour = json[SerializationKeys.type37hour].string
    prob43hour = json[SerializationKeys.prob43hour].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = type61hour { dictionary[SerializationKeys.type61hour] = value }
    if let value = type49hour { dictionary[SerializationKeys.type49hour] = value }
    if let value = prob7hour { dictionary[SerializationKeys.prob7hour] = value }
    if let value = prob52hour { dictionary[SerializationKeys.prob52hour] = value }
    if let value = type64hour { dictionary[SerializationKeys.type64hour] = value }
    if let value = prob49hour { dictionary[SerializationKeys.prob49hour] = value }
    if let value = type40hour { dictionary[SerializationKeys.type40hour] = value }
    if let value = type46hour { dictionary[SerializationKeys.type46hour] = value }
    if let value = type4hour { dictionary[SerializationKeys.type4hour] = value }
    if let value = prob61hour { dictionary[SerializationKeys.prob61hour] = value }
    if let value = type22hour { dictionary[SerializationKeys.type22hour] = value }
    if let value = type25hour { dictionary[SerializationKeys.type25hour] = value }
    if let value = prob46hour { dictionary[SerializationKeys.prob46hour] = value }
    if let value = prob22hour { dictionary[SerializationKeys.prob22hour] = value }
    if let value = type7hour { dictionary[SerializationKeys.type7hour] = value }
    if let value = prob67hour { dictionary[SerializationKeys.prob67hour] = value }
    if let value = type16hour { dictionary[SerializationKeys.type16hour] = value }
    if let value = prob64hour { dictionary[SerializationKeys.prob64hour] = value }
    if let value = type34hour { dictionary[SerializationKeys.type34hour] = value }
    if let value = type10hour { dictionary[SerializationKeys.type10hour] = value }
    if let value = prob25hour { dictionary[SerializationKeys.prob25hour] = value }
    if let value = type31hour { dictionary[SerializationKeys.type31hour] = value }
    if let value = prob19hour { dictionary[SerializationKeys.prob19hour] = value }
    if let value = prob40hour { dictionary[SerializationKeys.prob40hour] = value }
    if let value = type19hour { dictionary[SerializationKeys.type19hour] = value }
    if let value = type43hour { dictionary[SerializationKeys.type43hour] = value }
    if let value = prob16hour { dictionary[SerializationKeys.prob16hour] = value }
    if let value = type13hour { dictionary[SerializationKeys.type13hour] = value }
    if let value = prob4hour { dictionary[SerializationKeys.prob4hour] = value }
    if let value = type28hour { dictionary[SerializationKeys.type28hour] = value }
    if let value = type52hour { dictionary[SerializationKeys.type52hour] = value }
    if let value = prob10hour { dictionary[SerializationKeys.prob10hour] = value }
    if let value = type55hour { dictionary[SerializationKeys.type55hour] = value }
    if let value = prob13hour { dictionary[SerializationKeys.prob13hour] = value }
    if let value = prob28hour { dictionary[SerializationKeys.prob28hour] = value }
    if let value = type58hour { dictionary[SerializationKeys.type58hour] = value }
    if let value = prob37hour { dictionary[SerializationKeys.prob37hour] = value }
    if let value = prob34hour { dictionary[SerializationKeys.prob34hour] = value }
    if let value = type67hour { dictionary[SerializationKeys.type67hour] = value }
    if let value = prob55hour { dictionary[SerializationKeys.prob55hour] = value }
    if let value = prob58hour { dictionary[SerializationKeys.prob58hour] = value }
    if let value = prob31hour { dictionary[SerializationKeys.prob31hour] = value }
    if let value = type37hour { dictionary[SerializationKeys.type37hour] = value }
    if let value = prob43hour { dictionary[SerializationKeys.prob43hour] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.type61hour = aDecoder.decodeObject(forKey: SerializationKeys.type61hour) as? String
    self.type49hour = aDecoder.decodeObject(forKey: SerializationKeys.type49hour) as? String
    self.prob7hour = aDecoder.decodeObject(forKey: SerializationKeys.prob7hour) as? String
    self.prob52hour = aDecoder.decodeObject(forKey: SerializationKeys.prob52hour) as? String
    self.type64hour = aDecoder.decodeObject(forKey: SerializationKeys.type64hour) as? String
    self.prob49hour = aDecoder.decodeObject(forKey: SerializationKeys.prob49hour) as? String
    self.type40hour = aDecoder.decodeObject(forKey: SerializationKeys.type40hour) as? String
    self.type46hour = aDecoder.decodeObject(forKey: SerializationKeys.type46hour) as? String
    self.type4hour = aDecoder.decodeObject(forKey: SerializationKeys.type4hour) as? String
    self.prob61hour = aDecoder.decodeObject(forKey: SerializationKeys.prob61hour) as? String
    self.type22hour = aDecoder.decodeObject(forKey: SerializationKeys.type22hour) as? String
    self.type25hour = aDecoder.decodeObject(forKey: SerializationKeys.type25hour) as? String
    self.prob46hour = aDecoder.decodeObject(forKey: SerializationKeys.prob46hour) as? String
    self.prob22hour = aDecoder.decodeObject(forKey: SerializationKeys.prob22hour) as? String
    self.type7hour = aDecoder.decodeObject(forKey: SerializationKeys.type7hour) as? String
    self.prob67hour = aDecoder.decodeObject(forKey: SerializationKeys.prob67hour) as? String
    self.type16hour = aDecoder.decodeObject(forKey: SerializationKeys.type16hour) as? String
    self.prob64hour = aDecoder.decodeObject(forKey: SerializationKeys.prob64hour) as? String
    self.type34hour = aDecoder.decodeObject(forKey: SerializationKeys.type34hour) as? String
    self.type10hour = aDecoder.decodeObject(forKey: SerializationKeys.type10hour) as? String
    self.prob25hour = aDecoder.decodeObject(forKey: SerializationKeys.prob25hour) as? String
    self.type31hour = aDecoder.decodeObject(forKey: SerializationKeys.type31hour) as? String
    self.prob19hour = aDecoder.decodeObject(forKey: SerializationKeys.prob19hour) as? String
    self.prob40hour = aDecoder.decodeObject(forKey: SerializationKeys.prob40hour) as? String
    self.type19hour = aDecoder.decodeObject(forKey: SerializationKeys.type19hour) as? String
    self.type43hour = aDecoder.decodeObject(forKey: SerializationKeys.type43hour) as? String
    self.prob16hour = aDecoder.decodeObject(forKey: SerializationKeys.prob16hour) as? String
    self.type13hour = aDecoder.decodeObject(forKey: SerializationKeys.type13hour) as? String
    self.prob4hour = aDecoder.decodeObject(forKey: SerializationKeys.prob4hour) as? String
    self.type28hour = aDecoder.decodeObject(forKey: SerializationKeys.type28hour) as? String
    self.type52hour = aDecoder.decodeObject(forKey: SerializationKeys.type52hour) as? String
    self.prob10hour = aDecoder.decodeObject(forKey: SerializationKeys.prob10hour) as? String
    self.type55hour = aDecoder.decodeObject(forKey: SerializationKeys.type55hour) as? String
    self.prob13hour = aDecoder.decodeObject(forKey: SerializationKeys.prob13hour) as? String
    self.prob28hour = aDecoder.decodeObject(forKey: SerializationKeys.prob28hour) as? String
    self.type58hour = aDecoder.decodeObject(forKey: SerializationKeys.type58hour) as? String
    self.prob37hour = aDecoder.decodeObject(forKey: SerializationKeys.prob37hour) as? String
    self.prob34hour = aDecoder.decodeObject(forKey: SerializationKeys.prob34hour) as? String
    self.type67hour = aDecoder.decodeObject(forKey: SerializationKeys.type67hour) as? String
    self.prob55hour = aDecoder.decodeObject(forKey: SerializationKeys.prob55hour) as? String
    self.prob58hour = aDecoder.decodeObject(forKey: SerializationKeys.prob58hour) as? String
    self.prob31hour = aDecoder.decodeObject(forKey: SerializationKeys.prob31hour) as? String
    self.type37hour = aDecoder.decodeObject(forKey: SerializationKeys.type37hour) as? String
    self.prob43hour = aDecoder.decodeObject(forKey: SerializationKeys.prob43hour) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(type61hour, forKey: SerializationKeys.type61hour)
    aCoder.encode(type49hour, forKey: SerializationKeys.type49hour)
    aCoder.encode(prob7hour, forKey: SerializationKeys.prob7hour)
    aCoder.encode(prob52hour, forKey: SerializationKeys.prob52hour)
    aCoder.encode(type64hour, forKey: SerializationKeys.type64hour)
    aCoder.encode(prob49hour, forKey: SerializationKeys.prob49hour)
    aCoder.encode(type40hour, forKey: SerializationKeys.type40hour)
    aCoder.encode(type46hour, forKey: SerializationKeys.type46hour)
    aCoder.encode(type4hour, forKey: SerializationKeys.type4hour)
    aCoder.encode(prob61hour, forKey: SerializationKeys.prob61hour)
    aCoder.encode(type22hour, forKey: SerializationKeys.type22hour)
    aCoder.encode(type25hour, forKey: SerializationKeys.type25hour)
    aCoder.encode(prob46hour, forKey: SerializationKeys.prob46hour)
    aCoder.encode(prob22hour, forKey: SerializationKeys.prob22hour)
    aCoder.encode(type7hour, forKey: SerializationKeys.type7hour)
    aCoder.encode(prob67hour, forKey: SerializationKeys.prob67hour)
    aCoder.encode(type16hour, forKey: SerializationKeys.type16hour)
    aCoder.encode(prob64hour, forKey: SerializationKeys.prob64hour)
    aCoder.encode(type34hour, forKey: SerializationKeys.type34hour)
    aCoder.encode(type10hour, forKey: SerializationKeys.type10hour)
    aCoder.encode(prob25hour, forKey: SerializationKeys.prob25hour)
    aCoder.encode(type31hour, forKey: SerializationKeys.type31hour)
    aCoder.encode(prob19hour, forKey: SerializationKeys.prob19hour)
    aCoder.encode(prob40hour, forKey: SerializationKeys.prob40hour)
    aCoder.encode(type19hour, forKey: SerializationKeys.type19hour)
    aCoder.encode(type43hour, forKey: SerializationKeys.type43hour)
    aCoder.encode(prob16hour, forKey: SerializationKeys.prob16hour)
    aCoder.encode(type13hour, forKey: SerializationKeys.type13hour)
    aCoder.encode(prob4hour, forKey: SerializationKeys.prob4hour)
    aCoder.encode(type28hour, forKey: SerializationKeys.type28hour)
    aCoder.encode(type52hour, forKey: SerializationKeys.type52hour)
    aCoder.encode(prob10hour, forKey: SerializationKeys.prob10hour)
    aCoder.encode(type55hour, forKey: SerializationKeys.type55hour)
    aCoder.encode(prob13hour, forKey: SerializationKeys.prob13hour)
    aCoder.encode(prob28hour, forKey: SerializationKeys.prob28hour)
    aCoder.encode(type58hour, forKey: SerializationKeys.type58hour)
    aCoder.encode(prob37hour, forKey: SerializationKeys.prob37hour)
    aCoder.encode(prob34hour, forKey: SerializationKeys.prob34hour)
    aCoder.encode(type67hour, forKey: SerializationKeys.type67hour)
    aCoder.encode(prob55hour, forKey: SerializationKeys.prob55hour)
    aCoder.encode(prob58hour, forKey: SerializationKeys.prob58hour)
    aCoder.encode(prob31hour, forKey: SerializationKeys.prob31hour)
    aCoder.encode(type37hour, forKey: SerializationKeys.type37hour)
    aCoder.encode(prob43hour, forKey: SerializationKeys.prob43hour)
  }

}
