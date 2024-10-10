import 'package:collegenius/domain/entities/auth_result.dart';

/// Data Transfer Object (DTO) representing user authentication success data.
/// 
/// This class is responsible for encapsulating the user data returned 
/// from the authentication service. It includes a method to convert 
/// this DTO into the corresponding entity in the domain layer, allowing 
/// for a clear separation of concerns between data representation and 
/// business logic.
class AuthResultModel {
  final bool isSuccess;

  AuthResultModel({required this.isSuccess});
  
  
  /// Converts this AuthSuccessModel instance to the corresponding 
  /// AuthResult entity.
  /// 
  /// This method maps the data contained in the AuthSuccessModel 
  /// to the AuthResult entity, facilitating the use of domain 
  /// logic while keeping the data source layer separate.
  AuthResult toEntity() {
    final message = isSuccess? '' : 'Authenticate failed, please check username and password';
    return AuthResult(isSuccess: isSuccess, message: message);
  }
}

