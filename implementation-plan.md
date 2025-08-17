# Personal Website Implementation Plan

## Architecture Overview

- **Monorepo structure** with clear separation of concerns
- **Frontend**: Next.js 14+ with App Router, TypeScript, Tailwind CSS
- **Backend**: AWS AppSync + Lambda + DynamoDB serverless stack
- **Shared**: Common TypeScript types and utilities

## Key Design Principles

1. **Type Safety**: Full TypeScript coverage with shared API contracts
2. **Infrastructure as Code**: SAM template for reproducible deployments  
3. **Security**: IAM least privilege, environment variables, CORS
4. **Scalability**: Serverless auto-scaling, DynamoDB on-demand
5. **Developer Experience**: ESLint, Prettier, pre-commit hooks
6. **Observability**: CloudWatch logging and monitoring

## Project Structure

```
/
├── frontend/          # Next.js application
├── backend/           # SAM template + Lambda functions  
├── shared/            # Shared TypeScript types
├── .github/           # CI/CD workflows
└── scripts/           # Deployment and utility scripts
```

## Implementation Tasks

### Phase 1: Project Setup
1. Set up project structure with monorepo layout (frontend/, backend/, shared/)
2. Initialize Next.js 14+ frontend with TypeScript, App Router, Tailwind CSS
3. Create minimal frontend with Hello World h1 element
4. Set up AWS SAM template with AppSync GraphQL API configuration
5. Create Lambda function for health check endpoint
6. Configure DynamoDB table with proper indexing strategy

### Phase 2: Development Experience
7. Set up shared TypeScript types package for API contracts
8. Configure ESLint, Prettier, and pre-commit hooks for code quality
9. Set up environment configuration and secrets management
10. Create deployment scripts and CI/CD pipeline configuration

## Initial Minimal Implementation

- **Frontend**: Single page with "Hello World!" h1
- **Backend**: AppSync schema with health check query
- **Infrastructure**: Basic SAM template with minimal resources

## Technology Stack

### Frontend
- **Framework**: Next.js 14+ with App Router
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Package Manager**: npm/yarn

### Backend
- **API Gateway**: AWS AppSync (GraphQL)
- **Compute**: AWS Lambda (Node.js/TypeScript)
- **Database**: DynamoDB
- **Infrastructure**: AWS SAM

### DevOps
- **Code Quality**: ESLint, Prettier, Husky
- **CI/CD**: GitHub Actions
- **Deployment**: AWS SAM CLI
- **Monitoring**: CloudWatch

This approach emphasizes clean architecture, type safety, and modern AWS serverless patterns.