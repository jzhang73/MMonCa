/*
 * Author: ignacio.martin@imdea.org
 *
 * Copyright 2014 IMDEA Materials Institute, Getafe, Madrid, Spain
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef KMCNUTCREATOR_H
#define KMCNUTCREATOR_H

#include "Coordinates.h"
#include <vector>

namespace Kernel
{
class Domain;

class NUTCreator
{
public:
    NUTCreator(const Domain *, Coordinates &m, Coordinates &M);
    ~NUTCreator();
    const std::vector<float> & getLines(int dim) const  { return _lines[dim];  }
private:
    float _delta[3];
    std::vector<float> _lines[3];
};
}

#endif
