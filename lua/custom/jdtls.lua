local home = vim.fn.stdpath 'data'
local jdtls_path = home .. '/mason/packages/jdtls'
local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)

if root_dir == '' then
  return
end

local workspace_dir = home .. '/java/workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    jdtls_path .. '/plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.2.1200.v20240924-2302.jar',
    '-configuration',
    jdtls_path .. '/config_linux',
    '-data',
    workspace_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {},
  },
}

return config
