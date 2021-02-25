### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 78df6c80-76f7-11eb-3995-05dedb662631
using JSON

# ╔═╡ bc1d042e-76f7-11eb-3d59-1160a17c3b52
biblios = JSON.parsefile("biblios.json")

# ╔═╡ fef7bb60-76f7-11eb-045f-ebd9fd79dd5b
gases = JSON.parsefile("gases.json")

# ╔═╡ 2078b280-76f8-11eb-34e1-83cea3808024
materials = JSON.parsefile("materials.json")

# ╔═╡ 09d5252e-76f9-11eb-02e3-ff05abff717d
isotherms = JSON.parsefile("isotherms.json")

# ╔═╡ 8f15156e-76f9-11eb-03fc-979d446be28a
begin
	temperature_tolerance = 3
	gas_keys = [gas["InChIKey"] for gas ∈ gases]
	gas_to_id = Dict([key => i for (i, key) ∈ enumerate(gas_keys)])
	gas_names = [gas["name"] for gas ∈ gases]
	matl_keys = [matl["hashkey"] for matl ∈ materials]
	matl_to_id = Dict([key => i for (i, key) ∈ enumerate(matl_keys)])
	material_gas_matrix = zeros(Int, length(matl_keys), length(gas_keys))
	for isotherm ∈ isotherms
		if length(isotherm["adsorbates"]) ≠ 1 # get only single-component isotherms
			continue
		end
		if isotherm["category"] ≠ "exp" # only take experimental isotherms
			continue
		end
		if isotherm["temperature"] > 298 + temperature_tolerance || isotherm["temperature"] < 298 - temperature_tolerance
			continue
		end
		row_id = matl_to_id[isotherm["adsorbent"]["hashkey"]]
		col_id = gas_to_id[isotherm["adsorbates"][1]["InChIKey"]]
		material_gas_matrix[row_id, col_id] = 1
	end
	sum(material_gas_matrix)
end

# ╔═╡ 6c4a7ff0-76fc-11eb-3e87-c71b75c8ebd3
begin
	initial_gas_candidate_ids = sortperm(sum(material_gas_matrix, dims=1)[:], rev=true)
	# names of gases that satisfy requirements, sorted by how many adsorbates they are isothermed in
	initial_gas_candidates = gas_names[initial_gas_candidate_ids]
end

# ╔═╡ 42f21322-7797-11eb-1846-3167865e5265
# water isn't a gas. propylene and ethane aren't that common in the lab.
disqualified_gas_ids = [i for i ∈ 1:length(gases) if gas_names[i] ∈ ["Water", "Ethane", "Propene"]]

# ╔═╡ a2f3f780-7787-11eb-0db1-19c417563a5d
# revise gas candidate id list
begin
	revised_gas_candidate_ids = [id for id ∈ initial_gas_candidate_ids if !(id ∈ disqualified_gas_ids)]
	revised_gas_candidates = gas_names[revised_gas_candidate_ids]
end

# ╔═╡ d91dada2-7797-11eb-3030-5b4bb8aad992
# let's consider all the gases up to CO (after that, they get weird)
begin
	CO_id = findfirst(g->g == "Carbon monoxide", revised_gas_candidates)
	gas_candidate_ids = revised_gas_candidate_ids[1:CO_id]
	gas_candidates = gas_names[gas_candidate_ids]
end

# ╔═╡ a81f6722-7788-11eb-3cc7-7f6d18a64d75
# materials that have isotherms for all candidate gases
material_candidates = [m for (i, m) ∈ enumerate(materials) if all(material_gas_matrix[i, gas_candidate_ids] .== 1)]

# ╔═╡ Cell order:
# ╠═78df6c80-76f7-11eb-3995-05dedb662631
# ╠═bc1d042e-76f7-11eb-3d59-1160a17c3b52
# ╠═fef7bb60-76f7-11eb-045f-ebd9fd79dd5b
# ╠═2078b280-76f8-11eb-34e1-83cea3808024
# ╠═09d5252e-76f9-11eb-02e3-ff05abff717d
# ╠═8f15156e-76f9-11eb-03fc-979d446be28a
# ╠═6c4a7ff0-76fc-11eb-3e87-c71b75c8ebd3
# ╠═42f21322-7797-11eb-1846-3167865e5265
# ╠═a2f3f780-7787-11eb-0db1-19c417563a5d
# ╠═d91dada2-7797-11eb-3030-5b4bb8aad992
# ╠═a81f6722-7788-11eb-3cc7-7f6d18a64d75
