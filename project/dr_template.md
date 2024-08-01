# Infrastructure

## AWS Zones
Identify your zones here
- Region 1 (Primary): us-east-1
    - Zone 1: us-east-1a
    - Zone 2: us-east-1b

- Region 2 (Secondary/DR): us-west-2
    - Zone 1: us-west-2a
    - Zone 2: us-west-2b

## Servers and Clusters
### Table 1.1 Summary
| Asset      | Purpose           | Size                                                                   | Qty                                                             | DR                                                                                                           |
|------------|-------------------|------------------------------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| Asset name | Brief description | AWS size eg. t3.micro (if applicable, not all assets will have a size) | Number of nodes/replicas or just how many of a particular asset | Identify if this asset is deployed to DR, replicated, created in multiple locations or just stored elsewhere |
| VM Instances | Compute resources | t3.medium | 3 | Deployed in multiple AZs within the primary region and replicated in the DR region
| Kubernetes Nodes | Container orchestration |  m5.large | 2 | Nodes in multiple AZs within the primary region and replicated in the DR region
| VPC | Network isolation | n/a | 1 | Configured with subnets in multiple AZs in both primary and DR regions
| Application Load Balancer | Traffic distribution | n/a | 1 | Deployed in each region
| SQL Cluster | Primary and secondary nodes | db.r5.large | 2 | Primary in zone1, secondary in zone2, with replication to another cluster in the DR region

### Descriptions
More detailed descriptions of each asset identified above.
- VM Instances:
Each VM runs on t3.medium instances and is distributed across multiple availability zones within the primary region. This ensures redundancy and high availability. Replicas of these instances are also set up in the DR region.

- Kubernetes Nodes:
Kubernetes nodes are deployed using m5.large instances to provide adequate resources for container orchestration. These nodes are spread across different AZs within the primary region for fault tolerance and are mirrored in the DR region.

- VPC:
A single VPC is configured with multiple subnets in each AZ of both regions. This setup ensures network isolation and segmentation, providing a secure and scalable network environment for the resources.

- Application Load Balancer (ALB):
ALBs are set up in each region to manage and distribute incoming application traffic across multiple targets, ensuring availability and load balancing.

- SQL Cluster:
The SQL cluster is composed of two db.r5.large instances (primary and secondary). The primary node is deployed in us-east-1a, and the secondary node is in us-east-1b. This setup ensures high availability within the primary region. Additionally, replication is configured to a similar cluster in the DR region (us-west-2).

## DR Plan
### Pre-Steps:
List steps you would perform to setup the infrastructure in the other region. It doesn't have to be super detailed, but high-level should suffice.

- Set Up VMs:
Deploy VM instances in the DR region (us-west-2a and us-west-2b).
Configure these instances to mirror the setup in the primary region.

- Kubernetes Cluster:
Set up a Kubernetes cluster in the DR region with the same node configuration (m5.large instances).

- Network Configuration:
Create VPC subnets in multiple AZs within the DR region.
Ensure proper routing and security group configurations to match the primary region.

- Deploy Application Load Balancer:
Set up ALBs in the DR region to distribute traffic across the nodes.

- SQL Cluster Setup:
Deploy SQL instances in the DR region with primary and secondary configurations.
Set up replication from the primary region to the DR region.

- Backup and Restore:
Ensure backup retention window is configured to 5 days.
Regularly test backup and restore procedures.

## Steps:
You won't actually perform these steps, but write out what you would do to "fail-over" your application and database cluster to the other region. Think about all the pieces that were setup and how you would use those in the other region

- Initiate Failover:
Announce the failover event and communicate with all stakeholders.
Verify the health and readiness of the DR infrastructure.

- Database Failover:
Promote the secondary SQL cluster in the DR region to primary.
Update DNS entries to point to the new primary database endpoint in the DR region.

- Application Traffic:
Re-route application traffic to the DR region using the Application Load Balancer.
Verify that traffic is being correctly distributed and handled by the DR nodes.

- Service Verification:
Validate that all services are operational in the DR region.
Conduct thorough testing to ensure all applications and databases are functioning correctly.

- Monitoring and Alerts:
Monitor the DR region for any issues or anomalies.
Ensure alerts and logging are capturing relevant information.

- Post-Failover Review:
Conduct a review meeting to analyze the failover process.
Identify any gaps or areas for improvement in the DR plan.

By following this architecture and DR plan, the business can ensure high availability and disaster recovery readiness, minimizing downtime and maintaining service continuity.