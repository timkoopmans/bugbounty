import * as cdk from '@aws-cdk/core';
import * as ec2 from "@aws-cdk/aws-ec2";
import * as ecs from "@aws-cdk/aws-ecs";
import * as ecs_patterns from "@aws-cdk/aws-ecs-patterns";
import * as events from "@aws-cdk/aws-events";


export class SubfinderStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const vpc = new ec2.Vpc(this, "MyVpc", {
      maxAzs: 3 // Default is all AZs in region
    });

    const cluster = new ecs.Cluster(this, "MyCluster", {
      vpc: vpc
    });

    // Create a load-balanced Fargate service and make it public
    // new ecs_patterns.ApplicationLoadBalancedFargateService(this, "MyFargateService", {
    //   cluster: cluster, // Required
    //   cpu: 512, // Default is 256
    //   desiredCount: 1, // Default is 1
    //   taskImageOptions: { image: ecs.ContainerImage.fromRegistry("amazon/amazon-ecs-sample") },
    //   memoryLimitMiB: 2048, // Default is 512
    //   publicLoadBalancer: false // Default is false
    // });

    const ecsScheduledTask = new ecs_patterns.ScheduledEc2Task(this, 'ScheduledTask', {
      cluster,
      scheduledEc2TaskImageOptions: {
        image: ecs.ContainerImage.fromRegistry('amazon/amazon-ecs-sample'),
        memoryLimitMiB: 256,
        environment: { name: 'TRIGGER', value: 'CloudWatch Events' },
      },
      schedule: events.Schedule.expression('rate(1 minute)')
    });
  }
}
