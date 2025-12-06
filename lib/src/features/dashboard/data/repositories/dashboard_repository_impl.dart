import '../../domain/entities/dashboard_data.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../data_sources/dashboard_api_service.dart';
import '../data_sources/dashboard_local_data_source.dart';
import '../models/response_models/create_node_response_model.dart';
import '../models/response_models/fatch_metadata_res_model.dart';
import '../models/response_models/fetch_node_data_response_model.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardApiService apiService;
  final DashboardLocalDataSource localDataSource;

  DashboardRepositoryImpl({
    required this.apiService,
    required this.localDataSource,
  });

  @override
  Future<DashboardData> getDashboardData() async {
    final cached = localDataSource.getData();
    if (cached != null) return cached;

    final apiData = await apiService.fetchDashboardData();
    localDataSource.saveData(apiData);
    return apiData;
  }

  @override
  Future<CreateNodeResponseModel> addNodeData({required Map<String, dynamic> body,required String projectId}) async {
    final apiData = await apiService.addNodeData(body: body,projectId: projectId);

    return apiData;
  }

  @override
  Future<FetchNodeFlowResponseModel> fetchNodeFlowData({required Map<String, dynamic> body,required String projectId}) async {
    final apiData = await apiService.fetchNodeFlowData(body: body,projectId: projectId);

    return apiData;
  }

  @override
  Future<FetchMetaDataResponseModel> fetchMetaData({required Map<String, dynamic> body,required String projectId}) async {
    final apiData = await apiService.fetchMetaData(body: body, projectId: projectId);

    return apiData;
  }
}
