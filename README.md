# Code Challenge
Code Challenge is a tool built on .NET MVC 4.0 for a user who wants to host the code contest, follows the ACM format but simpler.
For more information, please see my article on my blog.
Because I just spend about 24 hours to this built, so it may have some bugs although we have used fine in our Code Challenge last year. Please throw me any bug you can find, I would like to update.
## Installation
- Create a database CodeChallenge with appropriate login
- Update the DBConnectionString at line 12 by appropriate data, CodeChallenges\DBDeploy_MSBuild.proj
- Update the connectionStrings at line 15, 16 by appropriate data, CodeChallenges\Web.config
- Build the solution by Visual Studio
- Default account: admin / 123456
