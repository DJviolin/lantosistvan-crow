#include <amalgamate/crow_all.h>

//#define NOGDI  // Windows

int main() {
  crow::SimpleApp app;

  CROW_ROUTE(app, "/")
  ([] { return "Hello, World!"; });

  app.port(8081).run();

  return 0;
}
