-- Schema-aware YAML: recognizes docker-compose and (if you add the playbook path pattern
-- yourself later) Ansible files, so it stops complaining about valid Ansible/compose syntax.
return {
  settings = {
    yaml = {
      keyOrdering = false,
      schemas = {
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.{yml,yaml}",
      },
    },
  },
}
