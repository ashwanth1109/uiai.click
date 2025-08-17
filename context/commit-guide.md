# Git Commit and Push Guide

## Standard Commit Process

1. **Check Status**: Always run `git status` and `git diff` to see changes
2. **Stage Changes**: Use `git add .` or specific files as needed
3. **Commit Message Format**:
   ```bash
   git commit -m "$(cat <<'EOF'
   Brief summary of changes (50 chars or less)

   - Detailed bullet points explaining what was done
   - Use present tense verbs (add, update, fix, remove)
   - Focus on what and why, not how

   🤖 Generated with [Claude Code](https://claude.ai/code)

   Co-Authored-By: Claude <noreply@anthropic.com>
   EOF
   )"
   ```

## Commit Message Guidelines

- Use imperative mood: "Add feature" not "Added feature"
- Keep first line under 50 characters
- Leave blank line between summary and body
- Use bullet points for multiple changes
- Be specific about what was changed

## When to Commit

- After completing a logical unit of work
- Before switching to a different task
- When explicitly asked by the user
- After implementing a feature or fixing a bug

## When to Push

- Always push when user asks you to commit unless explicitly requested by the user to commit but not push

## Example Commit Messages

```bash
# Feature addition
Add user authentication with JWT tokens

- Implement login/logout endpoints
- Add JWT middleware for protected routes
- Create user session management

# Bug fix
Fix pagination component infinite scroll issue

- Resolve race condition in useEffect hook
- Add proper cleanup for scroll listeners
- Update component tests

# Refactoring
Refactor API client to use TypeScript generics

- Convert all API methods to use generic types
- Improve type safety for request/response handling
- Remove redundant type assertions
```