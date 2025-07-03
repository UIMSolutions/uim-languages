module uim.languages.javascript.error;

@safe:
import uim.languages.javascript;

auto  jsTryCatch(string tryContent, string catchContent) {
  return "try{%s}catch(error){%s}".format(tryContent, catchContent);
}