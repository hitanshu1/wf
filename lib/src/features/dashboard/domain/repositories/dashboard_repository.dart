import 'package:kuick_workflow/src/features/dashboard/data/models/response_models/create_node_response_model.dart';
import 'package:kuick_workflow/src/features/dashboard/data/models/response_models/fetch_node_data_response_model.dart';

import '../../data/models/response_models/fatch_metadata_res_model.dart';
import '../entities/dashboard_data.dart';

abstract class DashboardRepository {
  Future<DashboardData> getDashboardData();

  Future<CreateNodeResponseModel> addNodeData({required Map<String, dynamic> body,required String projectId});

  Future<FetchNodeFlowResponseModel> fetchNodeFlowData({required Map<String, dynamic> body,required String projectId});

  Future<FetchMetaDataResponseModel> fetchMetaData({required Map<String, dynamic> body,required String projectId});
}
