using DelimitedFiles
EVD_clean = DelimitedFiles.readdlm("data/wikiEVD_clean.csv", ',')
epidays = EVD_clean[:, 1]
allcases = EVD_clean[:, 2]

using Plots
gr()
plot(
    epidays,
    allcases,
    title = "Ebola Epidemic Vs Total Cases",
    xlabel = "Days since 22 March 2014",
    ylabel = "Total cases to date",
    marker = (:diamond, 4),
    line = (:path, "gray"),
    legend = false,
    grid = false
)
savefig("plots/EVD_plot.png")

cases_by_country = EVD_clean[:, [4, 6, 8]]
plot(
    epidays,
    cases_by_country,
    legend = :topleft,
    marker = ([:octagon :star7 :square], 4),
    label = ["Guinea" "Liberia" "Sierra Leone"],
    title = "Ebola cases by country",
    xlabel = "Days since 22 March 2014",
    ylabel = "Total cases to date",
    line = (:path)
)
savefig("plots/EVD_country_plot.png")