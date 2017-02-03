# Test automation engineer helper (GGRC project)
# *** For Linux systems

<p>dir/ggrc-core - cloned the GGRC project from git-hub (https://github.com/google/ggrc-core)
<p>dir/run - test automation helper tools
<p>
<p>dir/run_Quince/install_req.sh - auto install test environment (*** for Red Hat like systems)
<p>dir/run_Quince/run_ggrc_flask.sh - auto run wep-app GGRC (Flask) + virtual env
<p>dir/run_Quince/run_ggrc_gae.sh - auto run wep-app GGRC (GAE) + virtual env
<p>dir/run_Quince/run_git_update.sh - auto run git pull for dev and rebase onto local branch
<p>dir/run_Quince/run_tests_before_pull_request.sh - auto greate new test lcoal branch, squashed commites, run tests before make pull request, squashed last commite for make patch via IDE Pycharm
 <p>tests: (ggrc-dev: check_pylint_diff, check_flake8_diff, run_pytests; host: run_selenium) 
<p>
<p>dir/run_Quince/add - addition files for the project
<p>dir/run_Quince/temp - temp files for the project
<p>dir/run_Quince/tools - tools to run the core files(app.sh - for operations in virt env, git.sh - for git operations, helper - other useful operations)
