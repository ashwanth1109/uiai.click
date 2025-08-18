# Deployment Guide

## Full Stack Deployment Process

### 1. Deploy Infrastructure (Backend + Frontend)
```bash
cd backend
sam build --profile uiai
sam deploy --guided --profile uiai
```

### 2. Deploy Frontend Application
```bash
cd scripts
./deploy-frontend.sh
```

## What Gets Deployed

### Infrastructure (SAM Template)
- **AppSync GraphQL API** with API key authentication
- **DynamoDB table** with partition/sort key structure
- **S3 bucket** for static website hosting with versioning
- **CloudFront distribution** with global CDN
- **Origin Access Control** for secure S3 access
- **Security headers policy** (HSTS, frame options, etc.)
- **Optimized caching policies** for static assets vs HTML

### Frontend Assets
- **Next.js static export** optimized for production
- **Environment variables** injected from stack outputs
- **Cache headers** optimized for performance
- **SPA routing support** with 404 → index.html redirects

## Security Features

- S3 bucket blocks all public access (CloudFront-only)
- Origin Access Control (modern replacement for OAI)
- HTTPS-only with security headers
- Proper CORS configuration
- IAM least privilege principles

## Performance Optimizations

- Global CloudFront edge locations
- Optimized cache policies:
  - Static assets: 1 year cache
  - HTML files: No cache (for SPA routing)
- Compression enabled (gzip/brotli)
- HTTP/2 and HTTP/3 support

## Environment Variables

The deployment script automatically injects:
- `NEXT_PUBLIC_API_ENDPOINT` - GraphQL API URL
- `NEXT_PUBLIC_API_KEY` - API key for authentication

## Troubleshooting

- If deployment fails, check AWS CLI profile configuration
- For CloudFront issues, wait 10-15 minutes for propagation
- Check CloudFormation events in AWS console for detailed errors
- Verify IAM permissions for your deployment user