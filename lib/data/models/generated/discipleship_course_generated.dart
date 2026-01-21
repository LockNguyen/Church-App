import 'dart:convert';


///A discipleship course with multiple locations and classes
class DiscipleshipCourse {
    
    ///Optional description of the course
    String? description;
    
    ///Unique identifier for the course
    String id;
    
    ///List of locations where this course is taught
    List<DiscipleshipLocation> locations;
    
    ///Display name of the course
    String name;

    DiscipleshipCourse({
        this.description,
        required this.id,
        required this.locations,
        required this.name,
    });

    factory DiscipleshipCourse.fromRawJson(String str) => DiscipleshipCourse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DiscipleshipCourse.fromJson(Map<String, dynamic> json) => DiscipleshipCourse(
        description: json["description"],
        id: json["id"],
        locations: List<DiscipleshipLocation>.from(json["locations"].map((x) => DiscipleshipLocation.fromJson(x))),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "id": id,
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "name": name,
    };
}


///A location where discipleship classes are held
class DiscipleshipLocation {
    
    ///List of classes at this location
    List<DiscipleshipClass> classes;
    
    ///Unique identifier for the location
    String id;
    
    ///Display name of the location
    String name;
    
    ///URL to the thumbnail image for this location
    String? thumbnailImageUrl;

    DiscipleshipLocation({
        required this.classes,
        required this.id,
        required this.name,
        this.thumbnailImageUrl,
    });

    factory DiscipleshipLocation.fromRawJson(String str) => DiscipleshipLocation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DiscipleshipLocation.fromJson(Map<String, dynamic> json) => DiscipleshipLocation(
        classes: List<DiscipleshipClass>.from(json["classes"].map((x) => DiscipleshipClass.fromJson(x))),
        id: json["id"],
        name: json["name"],
        thumbnailImageUrl: json["thumbnailImageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "classes": List<dynamic>.from(classes.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "thumbnailImageUrl": thumbnailImageUrl,
    };
}


///A single discipleship class session
class DiscipleshipClass {
    
    ///Contact information (phone or email) for the class
    String? contact;
    
    ///Class end date and time in ISO 8601 format
    DateTime endTime;
    
    ///Unique identifier for the class
    String id;
    
    ///Bible passage or topic for the class
    String? passage;
    
    ///Class start date and time in ISO 8601 format
    DateTime startTime;

    DiscipleshipClass({
        this.contact,
        required this.endTime,
        required this.id,
        this.passage,
        required this.startTime,
    });

    factory DiscipleshipClass.fromRawJson(String str) => DiscipleshipClass.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DiscipleshipClass.fromJson(Map<String, dynamic> json) => DiscipleshipClass(
        contact: json["contact"],
        endTime: DateTime.parse(json["endTime"]),
        id: json["id"],
        passage: json["passage"],
        startTime: DateTime.parse(json["startTime"]),
    );

    Map<String, dynamic> toJson() => {
        "contact": contact,
        "endTime": endTime.toIso8601String(),
        "id": id,
        "passage": passage,
        "startTime": startTime.toIso8601String(),
    };
}
