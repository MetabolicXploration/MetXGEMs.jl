module MetXGEMs

    import COBREXA
    using MetXBase
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
    include("Types/2_EchelonMetNet.jl")
    
    #! include AbstractMetNetUtils
    include("AbstractMetNetUtils/lep_interface.jl")
    include("AbstractMetNetUtils/net_interface.jl")
    
    #! include MetNetUtils
    include("MetNetUtils/balance_str.jl")
    include("MetNetUtils/base.jl")
    include("MetNetUtils/boundutils.jl")
    include("MetNetUtils/check_dims.jl")
    include("MetNetUtils/connectome.jl")
    include("MetNetUtils/convert.jl")
    include("MetNetUtils/dense.jl")
    include("MetNetUtils/echelonize.jl")
    include("MetNetUtils/empty_stuf.jl")
    include("MetNetUtils/fixxed_reduction.jl")
    include("MetNetUtils/getter.jl")
    include("MetNetUtils/ider_interface.jl")
    include("MetNetUtils/interfaces.jl")
    include("MetNetUtils/io.jl")
    include("MetNetUtils/net_interface.jl")
    include("MetNetUtils/queries.jl")
    include("MetNetUtils/reindex.jl")
    include("MetNetUtils/resize.jl")
    include("MetNetUtils/rxn_str.jl")
    include("MetNetUtils/search.jl")
    include("MetNetUtils/setter.jl")
    include("MetNetUtils/summary.jl")
    include("MetNetUtils/toy_model.jl")
    
    #! include EchelonMetNetUtils
    include("EchelonMetNetUtils/base.jl")
    include("EchelonMetNetUtils/net_interface.jl")
    include("EchelonMetNetUtils/span.jl")
    include("EchelonMetNetUtils/summary.jl")
    
end