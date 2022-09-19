## AWS Certified Solutions Architect - Associate

###### Certification

###### Notes based on

https://www.youtube.com/watch?v=Ia-UEYYR44s&ab_channel=freeCodeCamp.org

##### Simple Storage Service (S3)

01. Introduction to S3

Object-based storage service.
Serverless storage in the cloud.

What is Object Storage?

data storage architecture that manages data as objects, as opposed to other storage architectures:
- file systems which manages data as files and file hierarchi
- block storage which manages data as blocks within sectors and tracks

S3 Object

Objects contains your data, just like files.
May consist of:
Key: name of the object
Value: the data itself, made up of a sequence of byes
Version ID: if enabled.
Meta data:

You can store data from 0 Bytes to 5 Terrabytes in size.

S3 Bucket.

Buckets holds objects. Buckets can also have folders which in turn hold objects. S3 is a universal namespace so bucket names must be unique.

02. Storage Classes

Trade retrieval time, accessibility, durability for cheaper storage.

Standard

Intelligent Tiering

Standard Infrequently Accessed

One Zone IA

Glacier

Glacier Deep Archive

03. S3 Security

All new buckets are private when created by default.

Logging per request can be turned  on a bucket.
Log files are generated and saved in a different bucket.

Access control is configured using Bucket Policies and Access Control List

ACL
Legacy feature.
Simple way of granting access.

Bucket Policies
Use a policy to define complex rule access.


04. S3 Encryption 


Encryption in Transit.
When you are uploading files to S3 it by default uses SSL/TLS.

Server Side Encryption(SSE) - Encryption at Rest
Amazon help you encrypt the object data

Client-Side Encryption

05. Data Consistency

New Objects(PUTS)

Read After Write Consistency
When you upload a new S3 object you are able to read it immediatly after writing.

Overwrite(PUTS) or Delete Objects(DELETES)
Eventual Consistency
When you overwrite or delete an object it takes time for S3 to replicate versions to AZs.

If you read immedietly S3 may return an old copy.

06. Cross-Region Replication

When enabled, any object that us uploaded will be automatically replicated to another region. Provides higher durability and potential disaster recovery for objects.

You must have versioning turned on both on the source and destination buckets. You can have CRR replicate to another AWS account.

06. Versioning

Store all versions of an object in S3.
Once enabled, it cannot be disabled, only suspended on the bucket.
Fully integrated with S3 Lifecycle rules
MFA Delete feature provides extra protection agains deletion of your data.

Versioning can help keep track of data loss.

07. Lifecycle Management

Automates the process of moving objects to different Storage Classes or deleting objects all together.

Can be used together with versioning. Can be applied to both current and previous versions.

Bucket -> after 7 days move to Glacier -> Glacier -> After 365 days Permanently delete

08. Transfer Acceleration

Fast and secure transfer of files over long distance between your end users and an S3 bucket.

Utilizes Cloudfronts distributed Edge Locations.

Instead of uploading to your bucket, users use a distince url for an edge location.

As data arrives at the edge location it is automatically routed to S3 over speciallt optimized network path( Amazon backbone network).

Edge Location = data center that is as close to you as possible.

09. Presigned URLS

Generate a url which proviedes you temporary access to an object either upload or download object data. Commonly used to provide access to private objects. You can use AWS CLI or AWS SDK to generate Presigned Urls.

aws s3 presign ...

Use case: You have a app which allow users to download files from a password protected path. Your webapp generates presigned urls which expires after 5 seconds. The user downloads the file.

10. MFA Delete

MFA Delete ensures users cannot delete objects from a bucket unless they provide MFA COde.

MFA Delete can only be enabled under these conditions:
1. The AWS CLI must be used to turn on MFA
2. The bucket must have versioning turned on

Only the bucket owner logged in as root user can delete objects from bucket.

11. Follow along: Create and delete bucket.

31.52
