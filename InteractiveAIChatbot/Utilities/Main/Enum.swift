//
//  Enum.swift
//  M4B
//
//  Created by Karim Amsha on 6/6/22.
//

import Foundation
import UIKit
import SwiftUI

enum FontWeight: String {
    case bold       = "Montserrat-Bold"
    case light      = "Montserrat-Light"
    case medium     = "Montserrat-Medium"
    case regular    = "Montserrat-Regular"
    case semiBold   = "Montserrat-SemiBold"
}

enum Page {
    case home
    case chat
    case add
    case notifications
    case profile
}

enum HomeTaps: String, Codable {
    case posts   = "Posts"
    case events   = "Events"
    case services   = "Services"
    
    var value : String {
        switch self {
        case .posts: return "Posts"
        case .events: return "Events"
        case .services: return "Services"
        }
    }
}

enum MapTaps: String, Codable {
    case user        = "User"
    case organization = "Organization"
    
    var value : String {
        switch self {
        case .user: return "User"
        case .organization: return "Organization"
        }
    }
}

enum UserType: String, Codable, Identifiable, CaseIterable {
    
//    case user, organization

    var id: String {
        value
    }

    case user   = "User"
    case organization   = "Organization"
    
    var value : String {
        switch self {
        case .user: return "User"
        case .organization: return "Organization"
        }
    }

    init(_ type:String) {
        switch type {
        case "User": self = .user
        case "Organization": self = .organization
        default:
            self = .user
        }
    }
}

enum OrganizationType: String, Codable, Identifiable, CaseIterable {
    
//    case mentor, organization, none

    var id: String {
        value
    }
    
    case mentor   = "Mentor (Non Profit)"
    case organization   = "Organization"
    case none   = "None"

    var value : String {
        switch self {
        case .mentor: return "Mentor (Non Profit)"
        case .organization: return "Organization"
        case .none: return "None"
        }
    }

    init(_ type:String) {
        switch type {
        case "Mentor (Non Profit)": self = .mentor
        case "Organization": self = .organization
        case "None": self = .none
        default:
            self = .none
        }
    }
}

enum GenderType: String, Codable {
    case male   = "Male"
    case female = "Female"
    case none = ""

    var value : String {
        switch self {
        case .male: return MALE
        case .female: return FEMALE
        case .none: return ""
        }
    }

    init(_ type: String) {
        switch type {
        case MALE: self = .male
        case FEMALE: self = .female
        case "": self = .none
        default:
            self = .none
        }
    }
}

enum PostType: String, Codable {
    case posts   = "Posts"
    case events = "Events"
    case services = "Services"
    case none = ""

    var value : String {
        switch self {
        case .posts: return "Posts"
        case .events: return "Events"
        case .services: return "Services"
        case .none: return ""
        }
    }

    init(_ type: String) {
        switch type {
        case "Posts": self = .posts
        case "Events": self = .events
        case "Services": self = .services
        case "": self = .none
        default:
            self = .none
        }
    }
}

enum SignupType: String, Codable {
    case normal = "Normal"
    case facebook = "Facebook"
    case google = "Google"
    case apple = "Apple"
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        switch label {
        case "Normal": self = .normal
        case "Facebook": self = .facebook
        case "Google": self = .google
        case "Apple": self = .apple
        default:
            self = .normal
        }
    }
    
    var value : String {
        switch self {
        case .normal: return "Normal"
        case .facebook: return "Facebook"
        case .google: return "Google"
        case .apple: return "Apple"
        }
    }
    
    init(_ type:String) {
        switch type {
        case "Normal": self = .normal
        case "Facebook": self = .facebook
        case "Google": self = .google
        case "Apple": self = .apple
        default: self = .normal
        }
    }
}

enum UserStatus: Int, Codable {
    case enable = 1
    case disable = 0
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(Int.self)
        switch label {
        case 0: self = .disable
        case 1: self = .enable
        default:
            self = .enable
        }
    }
    
    var value: Int {
        switch self {
        case .enable: return 1
        case .disable: return 0
        }
    }
    
    init(_ type:Int) {
        switch type {
        case 0: self = .disable
        case 1: self = .enable
        default:
            self = .enable
        }
    }
}

enum OnlineStatus: Int, Codable {
    case online = 1
    case offline = 0

    enum CodingKeys: String, CodingKey {
        case online
        case offline
    }
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(Int.self)
        switch label {
        case 0: self = .offline
        case 1: self = .online
        default:
            self = .offline
        }
    }
    
    var value: Int {
        switch self {
        case .online: return 1
        case .offline: return 0
        }
    }
    
    init(_ type: Int) {
        switch type {
        case 0: self = .offline
        case 1: self = .online
        default:
            self = .offline
        }
    }
}

enum ToastAction {
    case ok
    case cancel
    case nothing
    
    var value : String {
        switch self {
        case .ok: return "ok"
        case .cancel: return "cancel"
        case .nothing: return "nothing"
        }
    }
}

enum ToastType {
    case normal
    case withOk
    case withCancel
    case withOkCancel
}

enum MediaType: String, Codable {
    case Photo
    case Video
    case Multi
    case Media
    case Text
    case None
    
    init(_ type: String) {
        switch type {
        case "Photo" : self = .Photo
        case "Video": self = .Video
        case "Multi": self = .Multi
        case "Media": self = .Media
        case "Text": self = .Text
        case "None": self = .None
        default:
            self = .Text
        }
    }

    var value : String {
        switch self {
        case .Photo: return "Photo"
        case .Video: return "Video"
        case .Multi: return "Multi"
        case .Media: return "Media"
        case .Text: return "Text"
        case .None: return "None"
        }
    }

}

enum CommentType : String, Codable {
    case CommentOnly = "Comment"
    case PhotoOnly   = "Photo"
    case Both        = "Both"
    
    init(_ type: String) {
        switch type {
        case "Comment" : self = .CommentOnly
        case "Photo": self = .PhotoOnly
        case "Both": self = .Both
        default:
            self = .CommentOnly
        }
    }

}

enum NotifiType: String, Codable {
    case reading
    case post
    case like
    case comment
    case share
    case chat
    case story
    case request
    case review
    case friends
    case other
    
    var value : String {
        switch self {
        case .reading: return "reading"
        case .post: return "post"
        case .like: return "like"
        case .comment: return "comment"
        case .share: return "share"
        case .chat: return "chat"
        case .story: return "story"
        case .request: return "request"
        case .review: return "review"
        case .friends: return "friends"
        default: return ""
        }
    }
    
    init(_ type:String) {
        switch type {
        case "reading": self = .reading
        case "post": self = .post
        case "like": self = .like
        case "comment": self = .comment
        case "share": self = .share
        case "chat": self = .chat
        case "story": self = .story
        case "request": self = .request
        case "review": self = .review
        case "friends": self = .friends
        default: self = .other
        }
    }
}

enum e_MediaType: Codable {
    case text
    case photo
    case video

    enum CodingKeys: String, CodingKey {
        case text
        case photo
        case video
    }
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        switch label {
           case "Text": self = .text
           case "Photo": self = .photo
           case "Video": self = .video
           default: self = .text
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode("Text", forKey: .text)
        try container.encode("Photo", forKey: .photo)
        try container.encode("Video", forKey: .video)
    }
    
    init(_ type:String) {
        switch type {
        case "Text": self = .text
        case "Photo": self = .photo
        case "Video": self = .video
        default: self = .text
        }
    }
    
    var value : String {
        switch self {
        case .text: return "Text"
        case .photo: return "Photo"
        case .video: return "Video"
        }
    }
}

enum ProfileTaps: String {
    case myPost     = "myPost"
    case myPhoto = "myPhoto"
    case myVideo     = "myVideo"
    case myStory     = "myStory"
    case taged      = "taged"
}

enum SearchTaps: String, CaseIterable {
    case all = "All"
    case name   = "Name"
    case content   = "Content"

    init?(_ value: String) {
        switch value {
        case "All":
            self = .all
        case "Name":
            self = .name
        case "Content":
            self = .content
        default:
            return nil
        }
    }
    
    var value: String {
        switch self {
        case .all  : return ALL
        case .name  : return "Name"
        case .content : return "Content"
        }
    }
}

enum StoryType: String, Codable {
    case none = ""
    case storyOnly = "Story"
    case liveOnly = "Live"
    case both = "Both"
    
    var value: String {
        switch self {
        case .none: return ""
        case .storyOnly: return "Story"
        case .liveOnly: return "Live"
        case .both: return "Both"
        }
    }
}

enum Specialization: String, Codable {
    case none = ""
    case barbers = "Barbers"
    case massageTherapists = "Massage therapists"
    case tattooArtists = "Tattoo artists"
    case nailTechs = "Nail techs"

    var value: String {
        switch self {
        case .none: return ""
        case .barbers: return "Barbers"
        case .massageTherapists: return "Massage therapists"
        case .tattooArtists: return "Tattoo artists"
        case .nailTechs: return "Nail techs"
        }
    }
    
    init(_ value: String) {
        switch value {
        case "":
            self = .none
        case "Barbers":
            self = .barbers
        case "Massage therapists":
            self = .massageTherapists
        case "Tattoo artists":
            self = .tattooArtists
        case "Nail techs":
            self = .nailTechs
        default:
            self = .none
        }
    }
}

enum OrderStatus: String, Codable {
    case pending = "Pending"
    case accepted = "Accepted"
    case rejected = "Rejected"
    case inProcessing = "In processing"
    case finished = "Finished"
    case none = ""

    var value : String {
        switch self {
        case .pending: return "Pending"
        case .accepted: return "Accepted"
        case .rejected: return "Rejected"
        case .inProcessing: return "In processing"
        case .finished: return "Finished"
        case .none: return ""
        }
    }

    init(_ type: String) {
        switch type {
        case "Pending": self = .pending
        case "Accepted": self = .accepted
        case "Rejected" : self = .rejected
        case "In processing": self = .inProcessing
        case "Finished": self = .finished
        case "": self = .none
        default:
            self = .none
        }
    }
}

enum TabsType: String, Codable {
    case all, plumbing, building, paint, smith, carpentry, houseCleaning, glassesCleaning, house, glasses, cars, furniture, gardens
    
    init(_ type: String) {
        switch type {
        case "All" : self = .all
        case "Plumbing": self = .plumbing
        case "Building": self = .building
        case "Paint": self = .paint
        case "Smith": self = .smith
        case "Carpentry": self = .carpentry
        case "House Cleaning": self = .houseCleaning
        case "Glasses Cleaning": self = .glassesCleaning
        case "House": self = .house
        case "Glasses": self = .glasses
        case "Cars": self = .cars
        case "Furniture": self = .furniture
        case "Gardens": self = .gardens
        default:
            self = .all
        }
    }

    var value: String {
        switch self {
        case .all : return "All"
        case .plumbing  : return "Plumbing"
        case .building : return "Building"
        case .paint : return "Paint"
        case .smith : return "Smith"
        case .carpentry : return "Carpentry"
        case .houseCleaning : return "House Cleaning"
        case .glassesCleaning : return "Glasses Cleaning"
        case .house : return "House"
        case .glasses : return "Glasses"
        case .cars : return "Cars"
        case .furniture : return "Furniture"
        case .gardens : return "Gardens"
        }
    }
}

enum FileAction {
    case image
    case pdf
    case docs
    case share
    case sendEmail
    case rename
    case delete
    case none

    var value : String {
        switch self {
        case .image: return "image"
        case .pdf: return "pdf"
        case .docs: return "docs"
        case .share: return "share"
        case .sendEmail: return "sendEmail"
        case .rename: return "rename"
        case .delete: return "delete"
        case .none: return "none"
        }
    }
}

enum FileType {
    case pdf
    case docs
    case doc
    case txt
    case jpg
    case jpeg
    case png
    case none

    init(_ type: String) {
        switch type {
        case "pdf" : self = .pdf
        case "docs": self = .docs
        case "doc": self = .doc
        case "txt": self = .txt
        case "jpg": self = .jpg
        case "jpeg": self = .jpeg
        case "png": self = .png
        case "none": self = .none
        default:
            self = .none
        }
    }

    var value: String {
        switch self {
        case .pdf: return "pdf"
        case .docs: return "docs"
        case .doc: return "doc"
        case .txt: return "txt"
        case .jpg: return "jpg"
        case .jpeg: return "jpeg"
        case .png: return "png"
        case .none: return "none"
        }
    }
}

enum CurrentView {
    case welcome
    case signin
    case signup
    case forgotpassword
    case home
}

enum ProvidedServices: String, Codable {
    case plumbing = "Plumbing"
    case building = "Building"
    case paint = "Paint"
    case smith = "Smith"
    case carpentry = "Carpentry"
    case none = "none"

    init(_ type: String) {
        switch type {
        case "Plumbing" : self = .plumbing
        case "Building": self = .building
        case "Paint": self = .paint
        case "Smith": self = .smith
        case "Carpentry": self = .carpentry
        case "none": self = .none
        default:
            self = .none
        }
    }

    var value: String {
        switch self {
        case .plumbing: return "Plumbing"
        case .building: return "Building"
        case .paint: return "Paint"
        case .smith: return "Smith"
        case .carpentry: return "Carpentry"
        case .none: return "none"
        }
    }
}

enum ExampleTab: String, Equatable, Identifiable, CaseIterable {
  case red, green, blue

  var id: Self { self }

  var color: Color {
    switch self {
    case .red: return Color(.systemRed)
    case .green: return Color(.systemGreen)
    case .blue: return Color(.systemBlue)
    }
  }

  var title: String {
    switch self {
    case .red: return "Red"
    case .green: return "Green"
    case .blue: return "Blue"
    }
  }

  func systemImageName(selected isSelected: Bool) -> String {
    var components = [String]()
    switch self {
    case .red: components.append("r")
    case .green: components.append("g")
    case .blue: components.append("b")
    }
    components.append("square")
    if isSelected {
      components.append("fill")
    }
    return components.joined(separator: ".")
  }
}
