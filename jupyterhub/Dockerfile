FROM jupyter/jupyterhub:0.5.0

MAINTAINER Carolyn Van Slyck <me@carolynvanslyck.com>

# Install jupyterhub-carina plugin
COPY requirements.txt /tmp
RUN pip install -U -r /tmp/requirements.txt

# Perform one-time setup if needed, then start JupyterHub
COPY run.sh /
CMD ["/run.sh"]
