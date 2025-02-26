# Initialize hook to switch version based on current project setup
export-env {
  $env.config = (
    $env.config?
    | default {}
    | upsert hooks { default {} }
    | upsert hooks.env_change { default {} }
    | upsert hooks.env_change.PWD { default [] }
  )

  $env.config.hooks.env_change.PWD
  | any { try { get __fnm_hook } catch { false } }
  | if not $in {
    $env.config.hooks.env_change.PWD = ($env.config.hooks.env_change.PWD | append {
      __fnm_hook: true,
      code: {|_, dir|
        ".nvmrc"
        | path exists
        | if $in {
          open .nvmrc | lines | get 0 | nvm use $in | ignore
        }
      }
    })
  }
}
