
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class Add_edit_employeeRepositoryImp implements Add_edit_employeeRepository{

        final Add_edit_employeeRemoteDataSource remoteDataSource;
        Add_edit_employeeRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    