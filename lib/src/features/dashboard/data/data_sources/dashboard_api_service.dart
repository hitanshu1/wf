import 'package:kuick_workflow/src/config/constants/end_points.dart';

import '../../../../core/network/network_info.dart';
import '../models/response_models/create_node_response_model.dart';
import '../models/dashboard_model.dart';
import '../models/response_models/fatch_metadata_res_model.dart';
import '../models/response_models/fetch_node_data_response_model.dart';

class DashboardApiService {
  final NetworkCalls networkCalls;

  DashboardApiService({required this.networkCalls});

  Future<DashboardModel> fetchDashboardData() async {
    final res = await networkCalls.performGet('/dashboard');
    return DashboardModel.fromJson(res);
  }

  Future<CreateNodeResponseModel> addNodeData({required Map<String, dynamic> body,required String projectId}) async {
    final res = await networkCalls.performPost(EndPoints.createNode,body,headers: {"prj" : projectId});
    return CreateNodeResponseModel.fromJson(res);
  }

  Future<FetchNodeFlowResponseModel> fetchNodeFlowData({required Map<String, dynamic> body,required String projectId}) async {
    final res = await networkCalls.performPost(EndPoints.fetchNodeFlow,body,headers: {"prj" : projectId});
    return FetchNodeFlowResponseModel.fromJson(res);
  }

  Future<FetchMetaDataResponseModel> fetchMetaData({required Map<String, dynamic> body,required String projectId}) async {
    final res = await networkCalls.performPost(EndPoints.fetchMetaData,body,headers: {"prj" : projectId});
    return FetchMetaDataResponseModel.fromJson(res);
  }
}
