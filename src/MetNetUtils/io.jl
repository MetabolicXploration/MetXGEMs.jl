_format_single_subSystems(subi::Array) = join(string.(subi), ";")
_format_single_subSystems(subi) = string(subi)

function _format_subSystems(sub0::Matrix)
    isempty(sub0) && return  nothing 
    return vec(_format_single_subSystems.(sub0))
end

function _net_from_Dict(mat_dict::Dict{String, Any})

    new_dict::Dict = Dict()

    # ----------------- Typed -----------------
    # String vectors
    for k in ["metNames", "metFormulas", 
            "rxnNames", "genes", 
            "grRules", "mets", "rxns"]
        haskey(mat_dict, k)  || continue
        new_dict[Symbol(k)] = string.(vec(mat_dict[k]))
    end

    
    # Float vectors
    for k in ["b", "lb", "ub", "c"]
        haskey(mat_dict, k)  || continue
        new_dict[Symbol(k)] = Float64.(vec(mat_dict[k]))
    end

    # S
    for k in ["S"]
        haskey(mat_dict, k)  || continue
        new_dict[Symbol(k)] = Matrix{Float64}(mat_dict[k])
    end
    
    # ----------------- Type free -----------------
    # Matrices
    for k in ["rxnGeneMat"]
        haskey(mat_dict, k)  || continue
        new_dict[Symbol(k)] = deepcopy(mat_dict[k])
    end
    
    # Vectors
    for k in ["subSystems"]
        haskey(mat_dict, k)  || continue
        new_dict[Symbol(k)] = _format_subSystems(mat_dict[k])
    end

    return MetNet(;new_dict...)
end

function _load_from_MAT(fn::AbstractString, k = nothing)
    mat_dict = MAT.matread(fn)
    k = isnothing(k) ? first(keys(mat_dict)) : k
    return _net_from_Dict(mat_dict[k])
end


# addapted from `COBREXA.jl`
# TODO: make a pull request to COBREXA (DONE: waiting merge)
function _COBREXA_load_model(file_name::String, type)

    if type == ".json"
        net = COBREXA.load_json_model(file_name)
    elseif type == ".xml"
        net = COBREXA.load_sbml_model(file_name)
    elseif type == ".mat"
        net = COBREXA.load_mat_model(file_name)
    elseif type == ".h5"
        net = COBREXA.load_h5_model(file_name)
    else
        throw(DomainError(type, "Unknown file extension"))
    end

    return convert(COBREXA.StandardModel, net)
end

export load_net
function load_net(
        mfile::AbstractString;
        ext = last(splitext(mfile))
    )

    if ext == ".jls"
        net = deserializa(mfile)
    elseif ext == ".mat"
        net = _load_from_MAT(mfile)
    else
        net = _COBREXA_load_model(mfile, ext)
    end
    
    return convert(MetNet, net)
end