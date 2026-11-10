# Initialize the PWD hook as an empty list if it doesn't exist
$env.config.hooks.env_change.PWD = $env.config.hooks.env_change.PWD? | default []

$env.config.hooks.env_change.PWD ++= [
    {||
        if (which direnv | is-empty) {
            # If direnv isn't installed, do nothing
            return
        }

        direnv export json | from json | default {} | load-env
    }
]
