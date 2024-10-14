# AWS Infrastructure Testing using AWS CLI

## Mô tả:
File này hướng dẫn cách kiểm tra các thành phần hạ tầng đã được triển khai trên AWS, bao gồm **VPC**, **Subnets**, **Internet Gateway**, **Route Tables**, **NAT Gateway**, **EC2 Instances**, và **Security Groups** bằng **AWS CLI**. Mỗi test case sẽ cung cấp lệnh cụ thể, mô tả mục đích kiểm tra và kết quả mong đợi.

---

## 1. Kiểm tra VPC và Subnets

### Test Case 1: Kiểm tra VPC
- **Lệnh:**
  ```bash
  aws ec2 describe-vpcs --vpc-ids vpc-xxxxxxxx
