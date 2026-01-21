import 'dart:convert';


///A calendar event for the VBC-WS church app
class Event {
    
    ///Timestamp when the event was created
    DateTime createdAt;
    
    ///Human-readable date/time string for display
    String? dateDisplay;
    
    ///Event end date and time in ISO 8601 format
    DateTime? endDateTime;
    
    ///URL to the hero/banner image (Firebase Storage or asset path)
    String? heroImageUrl;
    
    ///Unique identifier for the event
    String id;
    
    ///Whether the event is currently active/visible
    bool isActive;
    
    ///Event location/venue
    String? location;
    
    ///Additional notes or description for the event
    String? notes;
    
    ///Display order for sorting events
    int order;
    
    ///Event start date and time in ISO 8601 format
    DateTime? startDateTime;
    
    ///Optional subtitle or tagline for the event
    String? subtitle;
    
    ///URL to the thumbnail image (Firebase Storage or asset path)
    String? thumbnailImageUrl;
    
    ///Display title of the event
    String title;
    
    ///Timestamp when the event was last updated
    DateTime updatedAt;

    Event({
        required this.createdAt,
        this.dateDisplay,
        this.endDateTime,
        this.heroImageUrl,
        required this.id,
        required this.isActive,
        this.location,
        this.notes,
        required this.order,
        this.startDateTime,
        this.subtitle,
        this.thumbnailImageUrl,
        required this.title,
        required this.updatedAt,
    });

    factory Event.fromRawJson(String str) => Event.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        createdAt: DateTime.parse(json["createdAt"]),
        dateDisplay: json["dateDisplay"],
        endDateTime: json["endDateTime"] == null ? null : DateTime.parse(json["endDateTime"]),
        heroImageUrl: json["heroImageUrl"],
        id: json["id"],
        isActive: json["isActive"],
        location: json["location"],
        notes: json["notes"],
        order: json["order"],
        startDateTime: json["startDateTime"] == null ? null : DateTime.parse(json["startDateTime"]),
        subtitle: json["subtitle"],
        thumbnailImageUrl: json["thumbnailImageUrl"],
        title: json["title"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "dateDisplay": dateDisplay,
        "endDateTime": endDateTime?.toIso8601String(),
        "heroImageUrl": heroImageUrl,
        "id": id,
        "isActive": isActive,
        "location": location,
        "notes": notes,
        "order": order,
        "startDateTime": startDateTime?.toIso8601String(),
        "subtitle": subtitle,
        "thumbnailImageUrl": thumbnailImageUrl,
        "title": title,
        "updatedAt": updatedAt.toIso8601String(),
    };
}
