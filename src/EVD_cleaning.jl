using DelimitedFiles
using Dates

function dates2epidays(x)
    for i in 1:length(date_col)
        date_col[i] = Dates.DateTime(date_col[i], "d u y")
    end
    len = length(x)
    epidays = Array{Int64}(undef, len)
    for i in 1:len
        epidays[i] = Dates.datetime2rata(x[i]) - Dates.datetime2rata(x[len])
    end
    return epidays
end

function imputeZero(data)
    rows, cols = size(data)
    for j in 1:cols
        for i in 1:rows
            if !isdigit(string(data[i, j])[1])
                data[i, j] = 0
            end
        end
    end
end

wikiEVD = DelimitedFiles.readdlm("data/wikiEVD.csv", ',')
date_col = wikiEVD[:, 1]
wikiEVD[:, 1] = dates2epidays(date_col)
imputeZero(wikiEVD)
DelimitedFiles.writedlm("data/wikiEVD_clean.csv", wikiEVD, ',')
