//
//  SpaceXSatilliteModel.swift
//  ARProject
//
//  Created by Руслан Осмаев on 30.03.2022.
//

import Foundation

// MARK: - SpaceXSatilliteModelElement
struct SpaceXSatilliteModelElement: Codable {
    let spaceTrack: SpaceTrack?
    let version: String?
    let launch: String?
    let longitude: Double?
    let latitude: Double?
    let heightKm: Double?
    let velocityKms: Double?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case spaceTrack = "spaceTrack"
        case version = "version"
        case launch = "launch"
        case longitude = "longitude"
        case latitude = "latitude"
        case heightKm = "height_km"
        case velocityKms = "velocity_kms"
        case id = "id"
    }
    
    static let placeholder = SpaceXSatilliteModelElement(spaceTrack: nil,
                                                         version: nil,
                                                         launch: nil,
                                                         longitude: nil,
                                                         latitude: nil,
                                                         heightKm: nil,
                                                         velocityKms: nil,
                                                         id: nil)
}

// MARK: - SpaceTrack
struct SpaceTrack: Codable {
    let ccsdsOmmVers: String?
    let comment: String?
    let creationDate: String?
    let originator: String?
    let objectName: String?
    let objectId: String?
    let centerName: String?
    let refFrame: String?
    let timeSystem: String?
    let meanElementTheory: String?
    let epoch: String?
    let meanMotion: Double?
    let eccentricity: Double?
    let inclination: Double?
    let raOfAscNode: Double?
    let argOfPericenter: Double?
    let meanAnomaly: Double?
    let ephemerisType: Int?
    let classificationType: String?
    let noradCatId: Int?
    let elementSetNo: Int?
    let revAtEpoch: Int?
    let bstar: Double?
    let meanMotionDot: Double?
    let meanMotionDdot: Double?
    let semimajorAxis: Double?
    let period: Double?
    let apoapsis: Double?
    let periapsis: Double?
    let objectType: String?
    let rcsSize: String?
    let countryCode: String?
    let launchDate: String?
    let site: String?
    let decayDate: String?
    let decayed: Int?
    let file: Int?
    let gpId: Int?
    let tleLine0: String?
    let tleLine1: String?
    let tleLine2: String?

    enum CodingKeys: String, CodingKey {
        case ccsdsOmmVers = "CCSDS_OMM_VERS"
        case comment = "COMMENT"
        case creationDate = "CREATION_DATE"
        case originator = "ORIGINATOR"
        case objectName = "OBJECT_NAME"
        case objectId = "OBJECT_ID"
        case centerName = "CENTER_NAME"
        case refFrame = "REF_FRAME"
        case timeSystem = "TIME_SYSTEM"
        case meanElementTheory = "MEAN_ELEMENT_THEORY"
        case epoch = "EPOCH"
        case meanMotion = "MEAN_MOTION"
        case eccentricity = "ECCENTRICITY"
        case inclination = "INCLINATION"
        case raOfAscNode = "RA_OF_ASC_NODE"
        case argOfPericenter = "ARG_OF_PERICENTER"
        case meanAnomaly = "MEAN_ANOMALY"
        case ephemerisType = "EPHEMERIS_TYPE"
        case classificationType = "CLASSIFICATION_TYPE"
        case noradCatId = "NORAD_CAT_ID"
        case elementSetNo = "ELEMENT_SET_NO"
        case revAtEpoch = "REV_AT_EPOCH"
        case bstar = "BSTAR"
        case meanMotionDot = "MEAN_MOTION_DOT"
        case meanMotionDdot = "MEAN_MOTION_DDOT"
        case semimajorAxis = "SEMIMAJOR_AXIS"
        case period = "PERIOD"
        case apoapsis = "APOAPSIS"
        case periapsis = "PERIAPSIS"
        case objectType = "OBJECT_TYPE"
        case rcsSize = "RCS_SIZE"
        case countryCode = "COUNTRY_CODE"
        case launchDate = "LAUNCH_DATE"
        case site = "SITE"
        case decayDate = "DECAY_DATE"
        case decayed = "DECAYED"
        case file = "FILE"
        case gpId = "GP_ID"
        case tleLine0 = "TLE_LINE0"
        case tleLine1 = "TLE_LINE1"
        case tleLine2 = "TLE_LINE2"
    }
}

typealias SpaceXSatilliteModel = [SpaceXSatilliteModelElement]
