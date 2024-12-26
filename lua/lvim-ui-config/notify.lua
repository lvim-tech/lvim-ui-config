local utils = require("lvim-ui-config.utils")

local M = {}

M.base_config = {
    error = {
        title = "ERROR",
        icon = " ",
        timeout = 3000,
        replace = nil,
    },
    warn = {
        title = "WARNING",
        icon = " ",
        timeout = 3000,
        replace = nil,
    },
    info = {
        title = "INFO",
        icon = " ",
        timeout = 3000,
        replace = nil,
    },
    debug = {
        title = "DEBUG",
        icon = " ",
        timeout = 3000,
        replace = nil,
    },
    trace = {
        title = "TRACE",
        icon = " ",
        timeout = 3000,
        replace = nil,
    },
}

M.error = function(message, config)
    local base_config = M.base_config.error
    if config ~= nil then
        base_config = utils.merge(M.base_config.error, config)
    end
    vim.notify(message, vim.log.levels.ERROR, base_config)
end

M.warning = function(message, config)
    local base_config = M.base_config.warn
    if config ~= nil then
        base_config = utils.merge(M.base_config.error, config)
    end
    vim.notify(message, vim.log.levels.WARN, base_config)
end

M.info = function(message, config)
    local base_config = M.base_config.warn
    if config ~= nil then
        base_config = utils.merge(M.base_config.info, config)
    end
    vim.notify(message, vim.log.levels.INFO, base_config)
end

M.debug = function(message, config)
    local base_config = M.base_config.debug
    if config ~= nil then
        base_config = utils.merge(M.base_config.debug, config)
    end
    vim.notify(message, vim.log.levels.DEBUG, base_config)
end

M.trace = function(message, config)
    local base_config = M.base_config.trace
    if config ~= nil then
        base_config = utils.merge(M.base_config.trace, config)
    end
    vim.notify(message, vim.log.levels.TRACE, base_config)
end

return M
