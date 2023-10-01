# Shelter Occupancy Docs
This files contantain docs blocks for Toronto Shelter Occupancy sources

# WHY DISTINCT? - 10/01/2023
- I used `DISTINCT` in my Dimension tables because there was no join, so I need 
  `DISTINCT` to return only unique for the dimension models.

## Unique Keys
This section contains unique keys that identifies each entries

{% docs toronto_shelter_idempotent_key %}
Unique identifier created for each row - Hashed from (_id + OCCUPANCY_DATE)
{% enddocs %}

{% docs toronto_shelter__id %}
Unique row identifier for each record
{% enddocs %}

{% docs toronto_shelter_occupancy_date %}
This date refers to the evening of the overnight period being reported. The occupancy data is retrieved at 4:00 am the following morning, so an OCCUPANCY_DATE of January 1, 2021 would refer to data collected at 4:00 am on January 2, 2021.
{% enddocs %}

## Organization Information
{% docs toronto_shelter_organization_id %}
Unique ID to consistently identify organizations even if the organization name changes
{% enddocs %}

{% docs toronto_shelter_organization_name %}
Name of the organization providing the overnight service
{% enddocs %}

{% docs toronto_shelter_organization_guid %}
Surrogate key created to uniquely identify organizations - harshed from `organization_id` and `organization_name`
{% enddocs %}

## Shelter Information
{% docs toronto_shelter_shelter_id %}
Unique ID to consistently identify the shelter group even if the shelter group name changes
{% enddocs %}

{% docs toronto_shelter_shelter_group %}
The shelter group to which the program belongs in the SMIS database. The shelter group is named for the lead shelter, but also includes satellite programs and hotel programs administered by the lead shelter.
{% enddocs %}

## Location Information
{% docs toronto_shelter_location_id %}
Unique ID to consistently identify locations even if the location name changes
{% enddocs %}

{% docs toronto_shelter_location_name %}
The name of the location of the program
{% enddocs %}

{% docs toronto_shelter_location_address %}
Street address of the location of the program
{% enddocs %}

{% docs toronto_shelter_location_postal_code %}
Postal code of the location of the program
{% enddocs %}

{% docs toronto_shelter_location_city %}
City of the location of the program
{% enddocs %}

{% docs toronto_shelter_location_province %}
Province of the location of the program
{% enddocs %}

{% docs toronto_shelter_location_guid %}
This is the unique identifier for the shelter location
{% enddocs %}

{% docs toronto_shelter_address %}
This is a concatenaton street, city, province, and postal code - a complete address
{% enddocs %}

## Program Information
{% docs toronto_shelter_program_id %}
Unique ID to consistently identify programs even if the program name changes.
{% enddocs %}

{% docs toronto_shelter_program_name %}
Name of the program
{% enddocs %}

{% docs toronto_shelter_program_model %}
A classification of shelter programs as either Emergency or Transitional. - We also have null which was renamed `Not Specified`
{% enddocs %}

{% docs toronto_shelter_program_area %}
Indicates whether the program is part of the base shelter and overnight services system, or is part of a temporary response program.
{% enddocs %}

{% docs toronto_shelter_program_guid %}
Surrogate key created to uniquely identify organizations - harshed from `organization_id` and `organization_name`
{% enddocs %}
## Sector Information
{% docs toronto_shelter_sector %}
A means of categorizing homeless shelters based on the gender, age and household size of the service user group(s) served at the shelter location. There are currently five shelter sectors in Toronto: adult men, adult women, mixed adult (co-ed or all gender), youth and family.
{% enddocs %}

## Overnight Service Type Information
{% docs toronto_shelter_overnight_service_type %}
Identifies the type of overnight service being provided. (Options are: Shelter, 24-Hour Respite, Motel/Hotel, Interim Housing, Warming Centre, 24-Hour Women's Drop-in, Isolation/Recovery Site)
{% enddocs %}

## Service User Information
{% docs toronto_shelter_service_user_count %}
Count of the number of service users staying in an overnight program as of the occupancy time and date. Programs with no service user occupancy will not be included in reporting for that day.
{% enddocs %}

## Capacity Information
{% docs toronto_shelter_capacity_type %}
Whether the capacity for this program is measured in rooms or beds. Family programs and hotel programs where rooms are not shared by people from different households are room-based. Bed Based Capacity, Room Based Capacity
{% enddocs %}

{% docs toronto_shelter_capacity_actual_bed %}
The number of beds showing as available for occupancy in the Shelter Management Information System.
{% enddocs %}

{% docs toronto_shelter_capacity_funding_bed %}
The number of beds that a program has been approved to provide.
{% enddocs %}

{% docs toronto_shelter_capacity_actual_room %}
The number of rooms showing as available for occupancy in the Shelter Management Information System for this program for this date.
{% enddocs %}

{% docs toronto_shelter_capacity_funding_room %}
The number of rooms that a program is has been approved to provide.
{% enddocs %}

## Occupancy Information
{% docs toronto_shelter_occupied_beds %}
The number of beds showing as occupied by a shelter user in the Shelter Management Information System for this program for this date.
{% enddocs %}

{% docs toronto_shelter_unoccupied_beds %}
The number of beds that are showing as available for occupancy that are not occupied as of the occupancy date. Beds may be held for a service user or may be vacant. Calculated as CAPACITYACTUALBED minus OCCUPIED_BEDS.
{% enddocs %}

{% docs toronto_shelter_unavailable_beds %}
The number of beds that are not currently available in a program. This can include temporarily out-of-service beds due to maintenance, repairs, renovations, outbreaks and pest control. Calculated as CAPACITYFUNDINGBED minus CAPACITYACTUALBED.
{% enddocs %}

{% docs toronto_shelter_occupied_rooms %}
The number of rooms showing as occupied by a shelter user in the Shelter Management Information System for this program for this date.
{% enddocs %}

{% docs toronto_shelter_unoccupied_rooms %}
The number of rooms that are showing as available for occupancy that are not occupied as of the occupancy date. Rooms may be held for service users or may be vacant. Calculated as CAPACITYACTUALROOM minus OCCUPIED_ROOMS.
{% enddocs %}

{% docs toronto_shelter_unavailable_rooms %}
The number of rooms that are showing as available for occupancy that are not occupied as of the occupancy date. Rooms may be held for service users or may be vacant. Calculated as CAPACITYACTUALROOM minus OCCUPIED_ROOMS.
{% enddocs %}

{% docs toronto_shelter_occupancy_rate_beds %}
The proportion of actual bed capacity that is occupied for the reporting date. Calculated as OCCUPIEDBEDS divided by CAPACITYACTUAL_BED.
{% enddocs %}

{% docs toronto_shelter_occupancy_rate_rooms %}
The proportion of actual room capacity that is occupied for the reporting date. Calculated as OCCUPIEDROOMS divided by CAPACITYACTUAL_ROOM.
{% enddocs %}