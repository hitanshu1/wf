import '../../data/models/response_models/create_node_response_model.dart';
import '../../data/models/response_models/fatch_metadata_res_model.dart';
import '../../data/models/response_models/fetch_node_data_response_model.dart';
import '../entities/dashboard_data.dart';
import '../repositories/dashboard_repository.dart';

class GetDashboardDataUseCase {
  final DashboardRepository repository;

  GetDashboardDataUseCase({required this.repository});

  Future<DashboardData> call() async => repository.getDashboardData();
}


class CreateNodeDataUseCase {
  final DashboardRepository repository;

  CreateNodeDataUseCase({required this.repository});

  Future<CreateNodeResponseModel> call({required Map<String, dynamic> body,required String projectId}) async => repository.addNodeData(body: body,projectId: projectId);
}
class FetchNodeFlowDataUseCase {
  final DashboardRepository repository;

  FetchNodeFlowDataUseCase({required this.repository});

  Future<FetchNodeFlowResponseModel> call({required Map<String, dynamic> body,required String projectId}) async => repository.fetchNodeFlowData(body: body,projectId: projectId);
}
class FetchMetaDataUseCase {
  final DashboardRepository repository;

  FetchMetaDataUseCase({required this.repository});

  Future<FetchMetaDataResponseModel> call({required Map<String, dynamic> body,required String projectId}) async => repository.fetchMetaData(body: body,projectId: projectId);
}
