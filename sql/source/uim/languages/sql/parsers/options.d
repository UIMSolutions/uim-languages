/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.optionsx;

import uim.languages.sql;

@safe:
final class Options {

  private Json _options;

  const string CONSISTENT_SUB_TREES = "consistent_sub_trees";
  const string ANSI_QUOTES = "ansi_quotes";

  this(Json someOptions) {
    _options =  someOptions;
  }

  bool hasConsistentSubtrees() {
    return (_options.isSet(CONSISTENT_SUB_TREES) && !_options[CONSISTENT_SUB_TREES]).isEmpty;
  }

  bool hasANSIQuotes() {
    return (_options.isSet(this.ANSI_QUOTES) && !_options[this.ANSI_QUOTES].isEmpty);
  }
}
