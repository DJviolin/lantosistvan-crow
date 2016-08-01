//#include <amalgamate/crow_all.h>
#include <crow/crow.h>

int main() {
  crow::SimpleApp app;

  CROW_ROUTE(app, "/")
  ([] { return "Hello, World!"; });

  app.port(8081).run();

  return 0;
}
