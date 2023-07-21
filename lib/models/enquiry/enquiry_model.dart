class Enq {
  final Enquiry enquirey;

  Enq({required this.enquirey});

  factory Enq.fromJson(Map<String, dynamic> json) =>
      Enq(enquirey: Enquiry.fromJson(json['enquiries']));
}

class Enquiry {
  final List<EnquiryModel> enq;

  Enquiry({required this.enq});

  factory Enquiry.fromJson(Map<String, dynamic> json) => Enquiry(
      enq: List<EnquiryModel>.from(
          (json['data'] as List).map((e) => EnquiryModel.fromJson(e))));
}

class EnquiryModel {
  int id;
  String enquiryNo;
  int franchiseId;
  int enquirySourceId;
  int enquirySubSourceId;
  String rcOwnerName;
  String rcOwnerPrimaryMobile;
  String rcOwnerSecondaryMobile;
  String rcOwnerAddress;
  String rcOwnerDistrict;
  String rcOwnerLocation;
  String name;
  String primaryMobile;
  String secondaryMobile;
  String address;
  String location;
  String district;
  int kms;

  EnquiryModel({
    required this.id,
    required this.enquiryNo,
    required this.franchiseId,
    required this.enquirySourceId,
    required this.enquirySubSourceId,
    required this.rcOwnerName,
    required this.rcOwnerPrimaryMobile,
    required this.rcOwnerSecondaryMobile,
    required this.rcOwnerAddress,
    required this.rcOwnerDistrict,
    required this.rcOwnerLocation,
    required this.name,
    required this.primaryMobile,
    required this.secondaryMobile,
    required this.address,
    required this.location,
    required this.district,
    required this.kms,
  });

  factory EnquiryModel.fromJson(Map<String, dynamic> json) => EnquiryModel(
        id: json['id'],
        enquiryNo: json['enquiry_no'],
        franchiseId: json['franchise_id'],
        enquirySourceId: json['enquiry_source_id'],
        enquirySubSourceId: json['enquiry_sub_source_id'],
        rcOwnerName: json['rc_owner_name'],
        rcOwnerPrimaryMobile: json['rc_owner_primary_mobile'],
        rcOwnerSecondaryMobile: json['rc_owner_secondary_mobile'],
        rcOwnerAddress: json['rc_owner_address'],
        rcOwnerDistrict: json['rc_owner_district'],
        rcOwnerLocation: json['rc_owner_location'],
        name: json['name'],
        primaryMobile: json['primary_mobile'],
        secondaryMobile: json['secondary_mobile'],
        address: json['address'],
        location: json['location'],
        district: json['district'],
        kms: json['kms'],
      );
}
