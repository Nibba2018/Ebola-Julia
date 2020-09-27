using DelimitedFiles
EVD_clean = DelimitedFiles.readdlm("data/wikiEVD_clean.csv", ',')
epidays = EVD_clean[:, 1]
allcases = EVD_clean[:, 2]

using Plots
gr()
plot(epidays, allcases)
plot(epidays, allcases, linetype=:scatter, marker=:diamond)
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
