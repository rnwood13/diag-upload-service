resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-dashboard"

  dashboard_body = <<EOF
{
    "widgets": [
        {
            "height": 6,
            "width": 4,
            "y": 2,
            "x": 0,
            "type": "metric",
            "properties": {
                "region": "${var.vpc_region}",
                "title": "CPU Utilization",
                "legend": {
                    "position": "bottom"
                },
                "timezone": "Local",
                "metrics": [
                    [ { "id": "expr1m0", "label": "${var.project_name}-service", "expression": "mm1m0 * 100 / mm0m0", "stat": "Average" } ],
                    [ "ECS/ContainerInsights", "CpuReserved", "ClusterName", "${var.project_name}", "ServiceName", "${var.project_name}-service", { "id": "mm0m0", "visible": false, "stat": "Sum" } ],
                    [ ".", "CpuUtilized", ".", ".", ".", ".", { "id": "mm1m0", "visible": false, "stat": "Sum" } ]
                ],
                "liveData": false,
                "period": 60,
                "yAxis": {
                    "left": {
                        "min": 0,
                        "showUnits": false,
                        "label": "Percent"
                    }
                }
            }
        },
        {
            "height": 6,
            "width": 4,
            "y": 2,
            "x": 4,
            "type": "metric",
            "properties": {
                "region": "${var.vpc_region}",
                "title": "Memory Utilization",
                "legend": {
                    "position": "bottom"
                },
                "timezone": "Local",
                "metrics": [
                    [ { "id": "expr1m0", "label": "${var.project_name}-service", "expression": "mm1m0 * 100 / mm0m0", "stat": "Average" } ],
                    [ "ECS/ContainerInsights", "MemoryReserved", "ClusterName", "${var.project_name}", "ServiceName", "${var.project_name}-service", { "id": "mm0m0", "visible": false, "stat": "Sum" } ],
                    [ ".", "MemoryUtilized", ".", ".", ".", ".", { "id": "mm1m0", "visible": false, "stat": "Sum" } ]
                ],
                "liveData": false,
                "period": 60,
                "yAxis": {
                    "left": {
                        "min": 0,
                        "showUnits": false,
                        "label": "Percent"
                    }
                }
            }
        },
        {
            "height": 6,
            "width": 4,
            "y": 2,
            "x": 8,
            "type": "metric",
            "properties": {
                "region": "${var.vpc_region}",
                "title": "Network TX",
                "legend": {
                    "position": "bottom"
                },
                "timezone": "Local",
                "metrics": [
                    [ { "id": "expr1m0", "label": "${var.project_name}-service", "expression": "mm0m0", "stat": "Average" } ],
                    [ "ECS/ContainerInsights", "NetworkTxBytes", "ClusterName", "${var.project_name}", "ServiceName", "${var.project_name}-service", { "id": "mm0m0", "visible": false, "stat": "Average" } ]
                ],
                "liveData": false,
                "period": 60,
                "yAxis": {
                    "left": {
                        "showUnits": false,
                        "label": "Bytes/Second"
                    }
                }
            }
        },
        {
            "height": 6,
            "width": 4,
            "y": 2,
            "x": 12,
            "type": "metric",
            "properties": {
                "region": "${var.vpc_region}",
                "title": "Network RX",
                "legend": {
                    "position": "bottom"
                },
                "timezone": "Local",
                "metrics": [
                    [ { "id": "expr1m0", "label": "${var.project_name}-service", "expression": "mm0m0", "stat": "Average" } ],
                    [ "ECS/ContainerInsights", "NetworkRxBytes", "ClusterName", "${var.project_name}", "ServiceName", "${var.project_name}-service", { "id": "mm0m0", "visible": false, "stat": "Average" } ]
                ],
                "liveData": false,
                "period": 60,
                "yAxis": {
                    "left": {
                        "showUnits": false,
                        "label": "Bytes/Second"
                    }
                }
            }
        },
        {
            "height": 6,
            "width": 4,
            "y": 2,
            "x": 16,
            "type": "metric",
            "properties": {
                "region": "${var.vpc_region}",
                "title": "Number of Desired Tasks",
                "legend": {
                    "position": "bottom"
                },
                "timezone": "Local",
                "metrics": [
                    [ "ECS/ContainerInsights", "DesiredTaskCount", "ClusterName", "${var.project_name}", "ServiceName", "${var.project_name}-service", { "stat": "Average" } ]
                ],
                "liveData": false,
                "period": 60
            }
        },
        {
            "height": 6,
            "width": 4,
            "y": 2,
            "x": 20,
            "type": "metric",
            "properties": {
                "region": "${var.vpc_region}",
                "title": "Number of Running Tasks",
                "legend": {
                    "position": "bottom"
                },
                "timezone": "Local",
                "metrics": [
                    [ "ECS/ContainerInsights", "RunningTaskCount", "ClusterName", "${var.project_name}", "ServiceName", "${var.project_name}-service", { "stat": "Average" } ]
                ],
                "liveData": false,
                "period": 60
            }
        },
        {
            "height": 6,
            "width": 4,
            "y": 8,
            "x": 0,
            "type": "metric",
            "properties": {
                "region": "${var.vpc_region}",
                "title": "Number of Pending Tasks",
                "legend": {
                    "position": "bottom"
                },
                "timezone": "Local",
                "metrics": [
                    [ "ECS/ContainerInsights", "PendingTaskCount", "ClusterName", "${var.project_name}", "ServiceName", "${var.project_name}-service", { "stat": "Average" } ]
                ],
                "liveData": false,
                "period": 60
            }
        },
        {
            "height": 6,
            "width": 4,
            "y": 8,
            "x": 4,
            "type": "metric",
            "properties": {
                "region": "${var.vpc_region}",
                "title": "Number of Task Sets",
                "legend": {
                    "position": "bottom"
                },
                "timezone": "Local",
                "metrics": [
                    [ "ECS/ContainerInsights", "TaskSetCount", "ClusterName", "${var.project_name}", "ServiceName", "${var.project_name}-service", { "stat": "Average" } ]
                ],
                "liveData": false,
                "period": 60
            }
        },
        {
            "height": 6,
            "width": 4,
            "y": 8,
            "x": 8,
            "type": "metric",
            "properties": {
                "region": "${var.vpc_region}",
                "title": "Number of Deployments",
                "legend": {
                    "position": "bottom"
                },
                "timezone": "Local",
                "metrics": [
                    [ "ECS/ContainerInsights", "DeploymentCount", "ClusterName", "${var.project_name}", "ServiceName", "${var.project_name}-service", { "stat": "Average" } ]
                ],
                "liveData": false,
                "period": 60
            }
        },
        {
            "height": 6,
            "width": 24,
            "y": 14,
            "x": 0,
            "type": "log",
            "properties": {
                "query": "SOURCE '/ecs/${var.project_name}' | fields @timestamp, @message\n| sort @timestamp desc\n| limit 20",
                "region": "${var.vpc_region}",
                "title": "Log group: /ecs/${var.project_name}",
                "view": "table"
            }
        },
        {
            "height": 2,
            "width": 12,
            "y": 0,
            "x": 0,
            "type": "alarm",
            "properties": {
                "title": "ALB Alarms",
                "alarms": [
                    "arn:aws:cloudwatch:${var.vpc_region}:885971397149:alarm:ApplicationInsights/ApplicationInsights-ContainerInsights-ECS_CLUSTER-${var.project_name}/AWS/ApplicationELB/HTTPCode_Target_4XX_Count/${module.alb.lb_arn_suffix}/"
                ]
            }
        },
        {
            "height": 2,
            "width": 12,
            "y": 0,
            "x": 12,
            "type": "alarm",
            "properties": {
                "title": "ECS Alarms",
                "alarms": [
                    "arn:aws:cloudwatch:${var.vpc_region}:885971397149:alarm:ApplicationInsights/ApplicationInsights-ContainerInsights-ECS_CLUSTER-${var.project_name}/ECS/ContainerInsights/CpuUtilized/${var.project_name}/",
                    "arn:aws:cloudwatch:${var.vpc_region}:885971397149:alarm:ApplicationInsights/ApplicationInsights-ContainerInsights-ECS_CLUSTER-${var.project_name}/ECS/ContainerInsights/MemoryUtilized/${var.project_name}/"
                ]
            }
        }
    ]
}
EOF
}
