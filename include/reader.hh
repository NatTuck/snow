#ifndef READER_HH
#define READER_HH

#include <gc_cpp.h>

#include "standard.hh"

namespace snow {

class Token : public gc {
 public:
  string  text;
  int     line;
  int     column;
};

class Source : public gc {
 public:
  Source(string fpath);
  Source(string s_path, string s_text);

  string path;
  string text;

  vector<Token> tokens;
};

}

#endif
