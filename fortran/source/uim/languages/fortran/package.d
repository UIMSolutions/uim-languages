/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.fortran;

public { // Importing all necessary modules for the Fortran language support
  import uim.language;
  // Importing the Fortran language module
  import uim.languages.fortran.classes;
  import uim.languages.fortran.exceptions;
  import uim.languages.fortran.helpers;
  import uim.languages.fortran.interfaces;
  import uim.languages.fortran.lexers;
  import uim.languages.fortran.mixins;
  import uim.languages.fortran.parsers;
  import uim.languages.fortran.tests;
  import uim.languages.fortran.tokens;
}
