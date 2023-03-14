# The basic representation of a metabolic network
Base.@kwdef struct MetNet{MT, VT} <: AbstractMetNet
    
    # Constraints data
    S::Union{Nothing, MT} = nothing                                          # Stoichiometric matrix M x N sparse
    b::Union{Nothing, VT} = nothing                                          # right hand side of equation  S ν = b 
    c::Union{Nothing, VT} = nothing                                          # obj linear coes
    # C::Union{Nothing, MT} = nothing                                          # obj quad coes
    lb::Union{Nothing, VT} = nothing                                         # fluxes lower bound M elements vector
    ub::Union{Nothing, VT} = nothing                                         # fluxes upper bound M elements vector 
    
    # Meta
    mets::Union{Nothing, Array{String,1}} = nothing                          # metabolites short-name M elements 
    rxns::Union{Nothing, Array{String,1}} = nothing                          # reactions short-name N elements
    
    # Relax types (avoid reading issues)
    genes = nothing # ::Union{Nothing, Array{String,1}}                      # gene names 
    rxnGeneMat = nothing # ::Union{Nothing, SparseMatrixCSC{Float64,Int}}    # 
    grRules = nothing # ::Union{Nothing, Array{String,1}}                    # gene-reaction rule N elements vector of strings (and / or allowed)
    metNames = nothing # ::Union{Nothing, Array{String,1}}                   # metabolites long-names M elements
    metFormulas = nothing # ::Union{Nothing, Array{String,1}}                # metabolites formula M elements
    rxnNames = nothing # ::Union{Nothing, Array{String,1}}                   # reactions long-names N elements
    subSystems = nothing # ::Union{Nothing, Array{String,1}}                 # cellular component of fluxes N elements

    # Extras
    extras::Dict{Any, Any} = Dict{Any, Any}()                                # to store temp data

    function MetNet(
            S, b, c, lb, ub, mets, rxns, 
            genes, rxnGeneMat, grRules, metNames, 
            metFormulas, rxnNames, subSystems, 
            extras
        ) 
            MT = typeof(S)
            VT = something(b, c, lb, ub, Some(nothing)) |> typeof

            # TODO: do some consistency checking here (types, dims, ect...)

            return new{MT, VT}(
                S, b, c, lb, ub, mets, rxns, 
                genes, rxnGeneMat, grRules, metNames, 
                metFormulas, rxnNames, subSystems, 
                extras
            )
    end 

end

"""
    Create a new MetNet from a template but overwriting the fields
    of the template with the given as kwargs.
    The returned MetNet will share the non-overwritten fields.
"""
function MetNet(template::MetNet; to_overwrite...)
    
    new_metnet_dict = Dict{Symbol, Any}(to_overwrite)

    for field in fieldnames(typeof(template))
        haskey(new_metnet_dict, field) && continue # avoid use the template version
        new_metnet_dict[field] = getfield(template, field)
    end
    
    return MetNet(;new_metnet_dict...)
end

function MetNet(template::MetNet, lep::LEPModel)
    return MetNet(template;
        S = lep.S,
        b = lep.b, 
        lb = lep.lb, 
        ub = lep.ub, 
        c = lep.c, 
        # C = lep.C # TODO: Add C to MetNet
    )
end
