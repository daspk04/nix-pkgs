{
  pkgs,
  keras,
  tensorflow,
  distutils,
  ...
}:
(keras.override {
  tensorflow = tensorflow;
}).overridePythonAttrs
  (oldAttrs: {
    dependencies = oldAttrs.dependencies or [ ] ++ [ distutils ];
  })
