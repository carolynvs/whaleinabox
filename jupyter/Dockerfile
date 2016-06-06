# Whale in a Box - Default Jupyter server image for users
#
# You may either:
# * Use this image directly, it will automatically include any files in the materials directory.
# * Create your own Dockerfile, start it with FROM jupyter/whaleinabox-jupyter then add any additional commands
# * Copy and edit this Dockerfile, changing the FROM to use a different Jupyter Stack.

# 1. Select a notebook type from https://github.com/jupyter/docker-stacks#a-visual-overview-of-stacks
FROM jupyter/minimal-notebook

MAINTAINER Carolyn Van Slyck <me@carolynvanslyck.com>

# Workaround for https://github.com/getcarina/feedback/issues/31#issuecomment-185523037
USER root

# Use the JupyterHub-friendly startup script
CMD ["/usr/local/bin/start-singleuser.sh"]

# 2. Install additional dependencies
# RUN apt-get update && apt-get install -y <package>
# RUN pip install <package>

# 3. Add support materials such as Jupyter notebooks and files
ONBUILD COPY materials/* /home/jovyan/work/
