import os

# Load environment variables
domain = os.getenv("DOMAIN")
admin_users = os.getenv("JUPYTERHUB_ADMINS", "").split()
jupyter_image = os.getenv("JUPYTER_IMAGE", "jupyterhub/singleuser")
base_url = os.getenv("BASE_URL", "/")

c = get_config()
c.JupyterHub.base_url = base_url
c.JupyterHub.confirm_no_ssl = True

# Configure JupyterHub to authenticate against Carina
c.JupyterHub.authenticator_class = "jupyterhub_carina.CarinaAuthenticator"
c.CarinaAuthenticator.admin_users = admin_users
c.CarinaAuthenticator.oauth_callback_url = "https://{}{}/hub/oauth_callback".format(domain, base_url)

# Configure JupyterHub to spawn user servers on Carina
c.JupyterHub.hub_ip = "0.0.0.0"
c.JupyterHub.spawner_class = "jupyterhub_carina.CarinaSpawner"
c.CarinaSpawner.hub_ip_connect = domain
c.CarinaSpawner.container_image = jupyter_image

# Save data outside of the JupyterHub directory to survive between rebuilds
c.JupyterHub.cookie_secret_file = "/etc/jupyterhub/cookie_secret"
c.JupyterHub.db_url = "/etc/jupyterhub/jupyterhub.sqlite"
