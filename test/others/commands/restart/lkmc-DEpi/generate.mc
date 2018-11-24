set T 600

proc material { x y z } {
        if { $x >6 } { return "Silicon" }
        return "Gas"
} 


set sizeX 50
set sizeY [expr sqrt(2.)*0.5431*10]
set sizeZ [expr sqrt(2.)*0.5431*10]

param set type=map<string,string>   key=MC/General/materials value="Silicon Si Gas Gas"
param set type=map<string,bool>     key=Silicon/Models/defined value={ }
param set type=array<string,string> key=Silicon/Models/interactions value={ }
param set type=array<string>        key=Silicon/Models/interaction.result value={ }
param set type=bool                 key=Silicon/Models/epitaxy value=true
param set type=bool                 key=Silicon/Epitaxy/model.simplified     value=false
param set type=map<string,float>    key=Silicon/Epitaxy/prefactor.etch       value=5.6e9  index=Si
param set type=map<string,float>    key=Silicon/Epitaxy/prefactor.mig        value=1.0e6  index=Si
param set type=map<string,float>    key=Silicon/Epitaxy/prefactor.dehydride1 value=4e12   index=Si
param set type=map<string,float>    key=Silicon/Epitaxy/prefactor.dehydride2 value=8e11   index=Si
param set type=map<string,float>    key=Silicon/Epitaxy/prefactor.dehydride3 value=1e1    index=Si
param set type=map<string,float>    key=Silicon/Epitaxy/barrier.precursor    value=1.85    index=Si
param set type=map<string,float>    key=Silicon/Epitaxy/barrier.dehydride1   value=2.4    index=Si
param set type=map<string,float>    key=Silicon/Epitaxy/barrier.dehydride2   value=1.9    index=Si
param set type=map<string,float>    key=Silicon/Epitaxy/barrier.dehydride3   value=0.1    index=Si
param set type=map<string,float>    key=Silicon/Epitaxy/barrier.etch         value=0.0    index=Si

param set type=float                key=MC/General/snapshot.events        value=10000
param set type=int                  key=MC/General/snapshot.time.decade   value=1


set waferorient "i 0 j 0 k 1"
set flatorient  "i 1 j 1 k 0"

param set type=map<string,float> key=Silicon/Lattice/wafer.orientation value="$waferorient"
param set type=map<string,float> key=Silicon/Lattice/flat.orientation  value="$flatorient"

proc snapshot { } { }
init minx=-20 miny=0 minz=0 maxx=$sizeX maxy=$sizeY maxz=$sizeZ material=material
				
anneal time=1.0 temp=$T epitaxy="Si 1."

set cove [extract ac.coverage]
restart save=dump

set time [extract time]
set dept [lindex [extract ac.mean] 0]
set roug [lindex [extract ac.stdev] 0]
lowmsg "1.- $time $dept $roug"

anneal time=0.5 temp=$T epitaxy="Si 1."

set cove [extract ac.coverage]
set time [extract time]
set dept [lindex [extract ac.mean] 0]
set roug [lindex [extract ac.stdev] 0]
lowmsg "2.- $time $dept $roug"

