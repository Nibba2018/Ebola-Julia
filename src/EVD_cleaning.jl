using DelimitedFiles
wikiEVD = DelimitedFiles.readdlm("data/wikiEVD.csv", ',')

using Dates
println(Dates.DateTime(wikiEVD[1, 1], "d u y"))

date_col = wikiEVD[:, 1]

for i in 1:length(date_col)
    date_col[i] = Dates.DateTime(date_col[i], "d u y")
end

println(Dates.datetime2rata(date_col[1]))

function dates2epidays(x)
    len = length(x)
    epidays = Array{Int64}(undef, len)
    for i in 1:len
        epidays[i] = Dates.datetime2rata(x[i]) - Dates.datetime2rata(x[len])
    end
    return epidays
end

wikiEVD[:, 1] = dates2epidays(date_col)
DelimitedFiles.writedlm("wikiEVD_clean.csv", wikiEVD, ',')
