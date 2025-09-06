return {
  {
    "chomosuke/typst-preview.nvim",
    -- file opened by pdf viewer
    output_file = function()
      local core = require("core")
      return core.file.root_path() .. "/output.pdf"
    end,
    -- how to redirect output files
    redirect_output = function(original_file, output_file)
      vim.cmd(string.format("silent !ln -s %s %s", original_file, output_file))
    end,
    -- how to preview the pdf file
    preview = function(output_file)
      local core = require("core")
      core.job.spawn("mimeopen", {
        output_file,
      }, {}, function() end, function() end, function() end)
    end,
    -- whether to clean all pdf files on VimLeave
    clean_temp_pdf = true,
  },
}
