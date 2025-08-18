#!/bin/bash

# Frontend Deployment Script for AWS S3 + CloudFront
# Deploys Next.js build output to S3 and invalidates CloudFront

set -e  # Exit on any error

# Configuration
PROFILE="uiai"
STACK_NAME="uiai-click-backend"
FRONTEND_DIR="../frontend"

echo "🚀 Starting frontend deployment..."

# Check if AWS profile exists
if ! aws sts get-caller-identity --profile $PROFILE >/dev/null 2>&1; then
    echo "❌ Error: AWS profile '$PROFILE' not found or not configured"
    echo "Please run: aws configure --profile $PROFILE"
    exit 1
fi

# Get stack outputs
echo "📋 Getting stack outputs..."
BUCKET_NAME=$(aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --profile $PROFILE \
    --query 'Stacks[0].Outputs[?OutputKey==`FrontendBucketName`].OutputValue' \
    --output text 2>/dev/null)

DISTRIBUTION_ID=$(aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --profile $PROFILE \
    --query 'Stacks[0].Outputs[?OutputKey==`CloudFrontDistributionId`].OutputValue' \
    --output text 2>/dev/null)

WEBSITE_URL=$(aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --profile $PROFILE \
    --query 'Stacks[0].Outputs[?OutputKey==`WebsiteUrl`].OutputValue' \
    --output text 2>/dev/null)

if [ -z "$BUCKET_NAME" ] || [ "$BUCKET_NAME" = "None" ]; then
    echo "❌ Error: Could not get S3 bucket name from stack outputs"
    echo "Make sure the stack '$STACK_NAME' is deployed successfully"
    exit 1
fi

echo "📦 S3 Bucket: $BUCKET_NAME"
echo "🌐 CloudFront Distribution: $DISTRIBUTION_ID"

# Build frontend
echo "🔨 Building Next.js application..."
cd $FRONTEND_DIR

# Set environment variables for build
export NEXT_PUBLIC_API_ENDPOINT=$(aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --profile $PROFILE \
    --query 'Stacks[0].Outputs[?OutputKey==`GraphQLApiEndpoint`].OutputValue' \
    --output text 2>/dev/null)

export NEXT_PUBLIC_API_KEY=$(aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --profile $PROFILE \
    --query 'Stacks[0].Outputs[?OutputKey==`GraphQLApiKey`].OutputValue' \
    --output text 2>/dev/null)

echo "🔗 API Endpoint: $NEXT_PUBLIC_API_ENDPOINT"

# Run build
npm run build

if [ $? -ne 0 ]; then
    echo "❌ Error: Frontend build failed"
    exit 1
fi

echo "✅ Build completed successfully"

# Sync to S3 with optimized cache headers
echo "📤 Syncing to S3..."

# Sync HTML files with no-cache headers (for SPA routing)
aws s3 sync out/ s3://$BUCKET_NAME/ \
    --profile $PROFILE \
    --delete \
    --exclude "*" \
    --include "*.html" \
    --cache-control "no-cache, no-store, must-revalidate" \
    --metadata-directive REPLACE

# Sync static assets with long cache headers
aws s3 sync out/ s3://$BUCKET_NAME/ \
    --profile $PROFILE \
    --delete \
    --exclude "*.html" \
    --cache-control "public, max-age=31536000, immutable" \
    --metadata-directive REPLACE

echo "✅ S3 sync completed"

# Invalidate CloudFront distribution
if [ -n "$DISTRIBUTION_ID" ] && [ "$DISTRIBUTION_ID" != "None" ]; then
    echo "🔄 Invalidating CloudFront cache..."
    INVALIDATION_ID=$(aws cloudfront create-invalidation \
        --distribution-id $DISTRIBUTION_ID \
        --paths "/*" \
        --profile $PROFILE \
        --query 'Invalidation.Id' \
        --output text)
    
    echo "🔄 Invalidation started: $INVALIDATION_ID"
    echo "⏳ Cache invalidation in progress (may take 10-15 minutes)"
else
    echo "⚠️  Warning: Could not invalidate CloudFront - distribution ID not found"
fi

# Success message
echo ""
echo "🎉 Frontend deployment completed!"
echo "🌐 Website URL: $WEBSITE_URL"
echo ""
echo "Next steps:"
echo "1. Wait for CloudFront invalidation to complete (~10-15 minutes)"
echo "2. Visit $WEBSITE_URL to see your deployed site"
echo ""