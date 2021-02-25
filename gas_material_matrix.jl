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
# names of gases that satisfy requirements, sorted by how many adsorbates they are isothermed in
gas_names[sortperm(sum(material_gas_matrix, dims=1)[:], rev=true)]

# ╔═╡ Cell order:
# ╠═78df6c80-76f7-11eb-3995-05dedb662631
# ╠═bc1d042e-76f7-11eb-3d59-1160a17c3b52
# ╠═fef7bb60-76f7-11eb-045f-ebd9fd79dd5b
# ╠═2078b280-76f8-11eb-34e1-83cea3808024
# ╠═09d5252e-76f9-11eb-02e3-ff05abff717d
# ╠═8f15156e-76f9-11eb-03fc-979d446be28a
# ╠═6c4a7ff0-76fc-11eb-3e87-c71b75c8ebd3
