module uim.languages.sql.parsers.processors.replace;

import uim.languages.sql;

@safe:

// This class processes the REPLACE statements. 
class ReplaceProcessor : InsertProcessor {

  Json process(mytokenList, string aTokenCategory = "REPLACE") {
    return super.process(mytokenList, aTokenCategory);
  }

}
