# Updating dependencies

Dependencies are not updated via CI but needs to be done locally with the following steps:
- Clone the repository and checkout the current `main` branch.
- Update the file `dependencies.aggr` in the folder `depencencyTools`.
- Run the script `updateDependencies.sh` in the folder `depencencyTools`.
- Check that the script ran successfully and that the folder `m2Repo` contains the desired dependencies. The folder should generally also contain the currently deployed version of mdo-over which should not be affected by the update!
- Commit the changes and push them to the remote repository to make the new dependencies available to users of mdo-over.

