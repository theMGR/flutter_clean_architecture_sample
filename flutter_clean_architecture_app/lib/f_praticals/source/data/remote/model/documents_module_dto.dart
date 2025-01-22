import 'dart:io';

class DocumentsDTO {
  int? documentId;
  String? documentName;
  int? documentTypeId;
  String? filePath;
  String? fileName;
  String? documentType;
  String? fileExtension;
  File? fileCompressed;
  String? s3FilePath;
  bool? isMandatory;

  // local
  bool isServerImage = false;
  String? s3PdfUrl;
  bool? mandatory;
  bool isUploaded = false;

  DocumentsDTO(
      {this.documentId,
      this.documentName,
      this.documentTypeId,
      this.filePath,
      this.fileName,
      this.documentType,
      this.fileExtension,
      this.fileCompressed,
      this.mandatory,
      this.s3FilePath,
      this.isMandatory,
      this.s3PdfUrl});

  DocumentsDTO.fromJson(dynamic json) {
    documentId = json["documentId"];
    documentName = json["documentName"];
    documentTypeId = json["documentTypeId"];
    filePath = json["filePath"];
    fileName = json["fileName"];
    documentType = json["documentType"];
    fileExtension = json["fileExtension"];
    s3FilePath = json["s3FilePath"];
    isMandatory = json["isMandatory"];
    s3PdfUrl = json["s3PdfUrl"];

    if (filePath != null) { // filepath -> image url
      isServerImage = true;
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    if(documentId != null) {
      map["documentId"] = documentId;
    }
    if(documentName != null) {
      map["documentName"] = documentName;
    }
    if(documentTypeId != null) {
      map["documentTypeId"] = documentTypeId;
    }
    if(filePath != null) {
      map["filePath"] = filePath;
    }
    if(fileName != null) {
      map["fileName"] = fileName;
    }
    if(documentType != null) {
      map["documentType"] = documentType;
    }
    if(fileExtension != null) {
      map["fileExtension"] = fileExtension;
    }
    if(s3FilePath != null) {
      map["s3FilePath"] = s3FilePath;
    }
/*    if(isMandatory != null) {
      map["isMandatory"] = isMandatory;
    }*/

/*    if(s3PdfUrl != null) {
      map["s3PdfUrl"] = s3PdfUrl;
    }*/

    return map;
  }
}

class DocumentsMasterDTO {
  List<DocumentsDTO?>? documentsDTO;
  int? driverVehicleId;
  String? loginUserID;
  int? statusId;
  String? userId;

  DocumentsMasterDTO(
      {this.documentsDTO,
      this.driverVehicleId,
      this.loginUserID,
      this.statusId,
      this.userId});

  DocumentsMasterDTO.fromJson(dynamic json) {
    driverVehicleId = json["driverVehicleId"];
    loginUserID = json["loginUserID"];
    statusId = json["statusId"];
    userId = json["userId"];

    if (json['documentsDTO'] != null) {
      documentsDTO = [];
      json['documentsDTO'].forEach((v) {
        documentsDTO!.add(DocumentsDTO.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    if(driverVehicleId != null) {
      map["driverVehicleId"] = driverVehicleId;
    }
    if(loginUserID != null) {
      map["loginUserID"] = loginUserID;
    }
    if(statusId != null) {
      map["statusId"] = statusId;
    }
    if(userId != null) {
      map["userId"] = userId;
    }

    if (documentsDTO != null) {
      map['documentsDTO'] = documentsDTO!.map((v) => v!.toJson()).toList();
    }

    return map;
  }
}

class DocumentUploadResponseDTO {
  //http common response
  int statusCode = 0;
  String statusText = "";
  bool hasError = false;
  bool isNoInternet = false;

  int? status;
  String? message;

  DocumentUploadResponseDTO(
      {this.statusCode = 0,
      this.statusText = "",
      this.hasError = false,
      this.isNoInternet = false,
      this.status,
      this.message});

  DocumentUploadResponseDTO.fromJson(dynamic json) {
    status = json["status"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    map["status"] = status;
    map["message"] = message;

    return map;
  }
}

