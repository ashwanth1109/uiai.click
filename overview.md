
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

## Technology Stack

### Frontend
- **Framework**: Next.js 14+ with App Router
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Package Manager**: pnpm

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