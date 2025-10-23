export const nushellDir = ($nu.config-path | path parse).parent
export const configDir = ($nushellDir | path parse).parent
export const aliases = ([$nushellDir, aliases.nu] | path join)
export const modules = ([$nushellDir, modules] | path join)
export const localVendor = [$nushellDir, vendor, autoload] | path join
