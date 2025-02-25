# =============================================================================
#
# Hook configuration for fnm.
#

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
        [.nvmrc, .node-version, package.json]
        | path exists
        | any {$in}
        | if $in {
          $env.PATH = (fnm env --shell bash --use-on-cd
            | lines | get 1 | split row "=" | get 1 | str trim --char '"'
            | append $env.PATH
          )
          fnm install
          fnm use
        }
      }
    })
  }
}

# =============================================================================
#
# Load env variables
#

load-env {
  FNM_MULTISHELL_PATH: "C:\\Users\\User\\AppData\\Local\\fnm_multishells\\18116_1740515787909",
  FNM_VERSION_FILE_STRATEGY: "local",
  FNM_DIR: "C:\\Users\\User\\AppData\\Roaming\\fnm",
  FNM_LOGLEVEL: "info",
  FNM_NODE_DIST_MIRROR: "https://nodejs.org/dist",
  FNM_COREPACK_ENABLED: "false",
  FNM_RESOLVE_ENGINES: "true",
  FNM_ARCH: "x64",
}

# =============================================================================
#
# Add this to your env file
# (find it by running `$nu.env-path` in Nushell):
#
#   fnm env --shell nushell --use-on-cd | save -f ~/.fnm.nu
#
# Now, add this to the end of your config file
# (find it by running `$nu.config-path` in Nushell):
#
#   source ~/.fnm.nu
