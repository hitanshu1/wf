const String flowUpdateJson = r'''
{
  "status": "success",
  "msg": "Node updated successfully",
  "flow_type": [],
  "data": {
    "pageId": "6989",
    "work_flow": {
      "1755356852766772": {
        "metadata": {
          "flowId": "main",
          "serverId": 5,
          "serverParentId": 0,
          "trigger": "manual",
          "projectId": "3038",
          "order": 0,
          "pageId": "6989",
          "widgetId": "1755356852766772",
          "title": "Main",
          "parentId": null,
          "selectedTrigger": null
        },
        "flowData": {
          "actions": [
            {
              "id": 1,
              "type": "chatMessage",
              "label": "Chat Message",
              "subTitle": "When Received",
              "position": {"dx": 200, "dy": 150}
            },
            {
              "id": 2,
              "type": "aiAgent",
              "label": "AI Agent",
              "subTitle": "Process with AI",
              "position": {"dx": 200, "dy": 300}
            },
            {
              "id": 3,
              "type": "httpRequest",
              "label": "HTTP Request",
              "subTitle": "Call API",
              "position": {"dx": 200, "dy": 450}
            },
            {
              "id": 4,
              "type": "database",
              "label": "Database",
              "subTitle": "Store Data",
              "position": {"dx": 200, "dy": 600}
            },
            {
              "id": 5,
              "type": "email",
              "label": "Email",
              "subTitle": "Send Email",
              "position": {"dx": 200, "dy": 750}
            },
            {
              "id": 6,
              "type": "condition",
              "label": "Condition",
              "subTitle": "If/Else logic",
              "position": {"dx": 200, "dy": 900}
            },
            {
              "id": 7,
              "type": "success",
              "label": "Success",
              "subTitle": "Workflow Complete",
              "position": {"dx": 200, "dy": 1050}
            },
            {
              "id": 8,
              "type": "failure",
              "label": "Failure",
              "subTitle": "Error Handling",
              "position": {"dx": 200, "dy": 1200}
            }
          ]
        }
      }
    }
  }
}
''';
