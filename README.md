# For developers:#
We have three main branches.
## Branch: master ##
Master branch deals with things that are app related. If the commit is too large, always take the safe route and branch from master please.

* **IMPORTANT!**: if we have production push, it should be based on separate production branch. **NEVER assume master = production. *Master is HEAD.* **

## Branch: CSS ##
CSS branch deals with asset/stylesheets and some partials related to this. Subbranches from this focus on different problems.

## Branch: FB_auth ##
This branch is to have toy-authentication from Facebook done. It requires use of devise gem, which would unlock links to LinkedIn, Twitter, and any service covered by OAuth. Subbranches try to integrate other authentication methods and also work with backend pertaining to the authentication.

# For users and production personnel: #
Section coming soon.