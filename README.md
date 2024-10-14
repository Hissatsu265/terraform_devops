README.txt - AWS Infrastructure Testing using AWS CLI
### Mô tả: File này hướng dẫn kiểm tra các thành phần hạ tầng đã được triển khai trên AWS (VPC, Subnets, Internet Gateway, Route Tables, NAT Gateway, EC2 Instances, và Security Groups) bằng AWS CLI.

### 1. Kiểm tra VPC và Subnets
##### Test Case 1: Kiểm tra VPC đã được tạo đúng cách
```
aws ec2 describe-vpcs --vpc-ids vpc-xxxxxxxx
```
**Mô tả:** Kiểm tra VPC với vpc-id tương ứng.

**Kết quả mong đợi:**

- VPC có CIDR block chính xác.
- Trạng thái là "available".
#### Test Case 2: Kiểm tra Subnets trong VPC
```
aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-xxxxxxxx"
```
**Mô tả:** Liệt kê các Subnets thuộc VPC.
**Kết quả mong đợi:**
- Có một Public Subnet và một Private Subnet.
- Public Subnet có MapPublicIpOnLaunch là true.

### 2. Kiểm tra Internet Gateway

#### Test Case 3: Kiểm tra Internet Gateway kết nối với VPC
```
aws ec2 describe-internet-gateways --filters "Name=attachment.vpc-id,Values=vpc-xxxxxxxx"
```
**Mô tả:** Kiểm tra Internet Gateway được kết nối với VPC.
**Kết quả mong đợi:** Internet Gateway có trạng thái "available".

### 3. Kiểm tra Route Tables

#### Test Case 4: Kiểm tra Public Route Table
```
aws ec2 describe-route-tables --filters "Name=vpc-id,Values=vpc-xxxxxxxx"
```
**Mô tả:** Kiểm tra route của Public Subnet được định tuyến qua Internet Gateway.
**Kết quả mong đợi:** Có một route với DestinationCidrBlock: 0.0.0.0/0 và GatewayId: igw-xxxxxxxx.

#### Test Case 5: Kiểm tra Private Route Table
```
aws ec2 describe-route-tables --filters "Name=vpc-id,Values=vpc-xxxxxxxx"
```
**Mô tả:** Kiểm tra route của Private Subnet được định tuyến qua NAT Gateway.
**Kết quả mong đợi:** Có một route với DestinationCidrBlock: 0.0.0.0/0 và NatGatewayId: nat-xxxxxxxx.

### 4. Kiểm tra NAT Gateway

#### Test Case 6: Kiểm tra NAT Gateway
```
aws ec2 describe-nat-gateways --filter "Name=vpc-id,Values=vpc-xxxxxxxx"
```
**Mô tả:** Kiểm tra NAT Gateway đã được tạo và hoạt động đúng cách.
**Kết quả mong đợi:** Trạng thái của NAT Gateway là "available".

### 5. Kiểm tra EC2 Instances

#### Test Case 7: Kiểm tra Public EC2 Instance
```
aws ec2 describe-instances --filters "Name=vpc-id,Values=vpc-xxxxxxxx" "Name=subnet-id,Values=subnet-public-id"
```
**Mô tả:** Kiểm tra EC2 instance trong Public Subnet có thể truy cập Internet.
**Kết quả mong đợi:** EC2 instance có PublicIpAddress. Trạng thái "State.Name": "running".

#### Test Case 8: Kiểm tra Private EC2 Instance
```
aws ec2 describe-instances --filters "Name=vpc-id,Values=vpc-xxxxxxxx" "Name=subnet-id,Values=subnet-private-id"
```
**Mô tả:** Kiểm tra Private EC2 instance không có PublicIpAddress nhưng có thể kết nối từ Public EC2 qua SSH.
**Kết quả mong đợi:** Không có PublicIpAddress. Trạng thái "State.Name": "running".

### 6. Kiểm tra Security Groups

#### Test Case 9: Kiểm tra Public EC2 Security Group
```
aws ec2 describe-security-groups --group-ids sg-public-id
```
**Mô tả:** Kiểm tra Security Group của Public EC2 chỉ cho phép SSH (port 22) từ một IP cụ thể.
**Kết quả mong đợi:** Có rule "FromPort": 22 và "IpRanges": [{"CidrIp": "your-ip-address/32"}].

#### Test Case 10: Kiểm tra Private EC2 Security Group
```
aws ec2 describe-security-groups --group-ids sg-private-id
```
**Mô tả:** Kiểm tra Security Group của Private EC2 cho phép kết nối từ Public EC2 instance qua SSH.
**Kết quả mong đợi:** Có rule "FromPort": 22 và "UserIdGroupPairs" chỉ đến Security Group của Public EC2.
