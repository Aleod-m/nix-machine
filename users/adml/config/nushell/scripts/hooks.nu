export def main [] { 
  {
    pre_prompt: [{
      code: "
        let direnv = (direnv export json | from json)
        let direnv = if ($direnv | length) == 1 {$direnv} else {{}}
        $direnv | load-env
      "
    }]
  }
}
