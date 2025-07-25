{
  lib,
  buildPythonPackage,
  fetchPypi,
  pythonAtLeast,
  pytestCheckHook,
  cheroot,
  legacy-cgi,
  dbutils,
  mysqlclient,
  pymysql,
  mysql-connector,
  psycopg2,
}:

buildPythonPackage rec {
  version = "0.62";
  format = "setuptools";
  pname = "web.py";

  src = fetchPypi {
    inherit pname version;
    sha256 = "5ce684caa240654cae5950da8b4b7bc178812031e08f990518d072bd44ab525e";
  };

  propagatedBuildInputs = [
    cheroot
  ]
  ++ lib.optional (pythonAtLeast "3.13") legacy-cgi;

  # requires multiple running databases
  doCheck = false;

  pythonImportsCheck = [ "web" ];

  nativeCheckInputs = [
    pytestCheckHook
    dbutils
    mysqlclient
    pymysql
    mysql-connector
    psycopg2
  ];

  meta = with lib; {
    description = "Makes web apps";
    longDescription = ''
      Think about the ideal way to write a web app.
      Write the code to make it happen.
    '';
    homepage = "https://webpy.org/";
    license = licenses.publicDomain;
    maintainers = with maintainers; [ layus ];
  };
}
