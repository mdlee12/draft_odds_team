#devtools::install_github("hadley/ggplot2")
#devtools::install_github("hadley/tidyr")
library(ggplot2)
library(tidyr)
library(RColorBrewer)
odds <- read.csv("odds_team.csv")
odds <- gather(odds, X)
odds[,2] <- substring(odds[,2], 2)
colnames(odds) <- c("Team","Pick","Probability")
odds$Pick <- as.numeric(odds$Pick)
odds$Team <- as.character(odds$Team)
odds$Selecting <- ifelse(odds$Team=="LAL" & odds$Pick > 3,"PHI",ifelse(odds$Team=="SAC" & odds$Pick > 10,"CHI",ifelse(odds$Team=="WAS" & odds$Pick > 3,"PHX",odds$Team)))
odds$Selecting <- factor(odds$Selecting, levels=c("PHI", "PHX",  "BOS", "LAL", "MIN", "NOP", "DEN","MIL", "SAC", "TOR", "ORL", "UTA", "CHI","WAS"))
odds$Pick <- factor(odds$Pick, levels = c(14:1))
odds$Probability <- ifelse(is.na(odds$Probability),0,odds$Probability)

g <- ggplot(odds, aes(Pick))
g <- g + geom_bar(aes(x = Pick, y = Probability, fill = Selecting),alpha=0.9,color="white",stat="identity")  
g <- g + scale_y_continuous(limits=c(0, 1), expand = c(0, 0),breaks = seq(0, 1, by = 0.1),1,name="Probability", labels=scales::percent) +
    labs(x=NULL, y=NULL, title="2016 NBA Draft Lottery Probabilities",
         subtitle = "Alternative, pick oriented view. After tiebreakers, pick trades, and swaps. Based on 100,000 simulations.",
         caption="Reproduced by: @mikeleeco                  Original: @dsparks                  Source: http://www.nba.com/celtics/news/sidebar/2016-draft-lottery-qa") +
    coord_flip() +
    scale_fill_manual(name="Pick",values = c("#006BB6", "#E56020","#008348", "#FDB927", "#C4CED3","#B4975A", "#4FA8FF","#F0EBD2", "#724C9F", "#061922","#007DC5", "#00471B", "#CE1141", "#002B5C"))
g  + theme(
  axis.text.x = element_text(size=14,margin=margin(b=5),color = "black"),
  axis.title.x = element_text(size=16),
  plot.title = element_text(size=30),
  plot.subtitle = element_text(size=14),
  plot.caption = element_text(size=16,face = "italic",hjust=.5,margin=margin(t=5)),
  axis.text.y = element_text(size=18,colour = "black"),
  axis.ticks.y=element_blank(),
  axis.ticks.x=element_blank(),
  panel.border=element_blank(),
  panel.grid.major.x=element_line(color="#2b2b2b", linetype="dotted", size=0.15),
  panel.grid.major.y=element_blank(),
  legend.text = element_text(size=14),
  legend.title = element_text(size=18),
  legend.key = element_blank(),
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  strip.background = element_blank(),
  panel.background = element_blank()
  )

