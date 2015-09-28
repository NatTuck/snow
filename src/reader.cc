
#include <pcrecpp.h>
#include <sstream>
#include <fstream>

#include "standard.hh"
#include "reader.hh"

namespace snow {
    

Source::Source(string fpath)
{
  std::ifstream file(fpath);
  std::stringstream temp;
  temp << file.rdbuf();

  this->path = fpath;
  this->text = temp.str();
  this->tokenize();
}

Source::Source(string s_path, string s_text)
{
  this->path = s_path;
  this->text = s_text;
  this->tokenize();
}

void
Source::tokenize()
{
  



}


}
