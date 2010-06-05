{application, pasteme,
 [{description, "pasteme"},
  {vsn, "0.01"},
  {modules, [
    pasteme,
    pasteme_app,
    pasteme_sup,
    pasteme_web,
    pasteme_deps
  ]},
  {registered, []},
  {mod, {pasteme_app, []}},
  {env, []},
  {applications, [kernel, stdlib, crypto]}]}.
