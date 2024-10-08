# TODO: Integrate http://bigg.ucsd.edu/data_access data tools

module MetXGEMs

    import COBREXA
    import AbstractFBCModels
    import MATFBCModels
    import JSONFBCModels
    import SBMLFBCModels

    using MetXBase
    using MetXBase.MassExport
    using Serialization
    using MAT    
    using Serialization
    using LinearAlgebra
    using SparseArrays
    using Statistics
    using StringRepFilter

    #! include .
    
    #! include Types
    include("Types/0_AbstractMetNets.jl")
    include("Types/1_MetNets.jl")
    
    #! include AbstractMetNetUtils
    include("AbstractMetNetUtils/base.jl")
    include("AbstractMetNetUtils/extras_interface.jl")
    include("AbstractMetNetUtils/ider_interface.jl")
    include("AbstractMetNetUtils/lep_interface.jl")
    include("AbstractMetNetUtils/net_interface.jl")
    include("AbstractMetNetUtils/posdef.jl")
    
    #! include MetNetUtils
    include("MetNetUtils/balance_str.jl")
    include("MetNetUtils/base.jl")
    include("MetNetUtils/boundutils.jl")
    include("MetNetUtils/check_dims.jl")
    include("MetNetUtils/connectome.jl")
    include("MetNetUtils/convert.jl")
    include("MetNetUtils/dense.jl")
    include("MetNetUtils/empty_interface.jl")
    include("MetNetUtils/io.jl")
    include("MetNetUtils/net_interface.jl")
    include("MetNetUtils/queries.jl")
    include("MetNetUtils/reindex.jl")
    include("MetNetUtils/resize.jl")
    include("MetNetUtils/rxn_str.jl")
    include("MetNetUtils/search.jl")
    include("MetNetUtils/set_constraint.jl")
    include("MetNetUtils/summary.jl")
    include("MetNetUtils/toy_model.jl")

    # exports
    @exportall_non_underscore()
    
end