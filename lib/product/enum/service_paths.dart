enum ServicePaths {
  imageGenerator("/v1/images/generations");

  final String path;
  const ServicePaths(this.path);
}
