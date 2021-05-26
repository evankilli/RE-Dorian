---
layout: page
title: RE- Spatial-temporal and content analysis of Twitter Data
---


**Replication of**
# Spatial, temporal and content analysis of Twitter data

Original study *by* Wang, Z., X. Ye, and M. H. Tsou. 2016. Spatial, temporal, and content analysis of Twitter for wildfire hazards. *Natural Hazards* 83 (1):523–540. DOI:[10.1007/s11069-016-2329-6](https://doi.org/10.1007/s11069-016-2329-6).
and
First replication study by Holler, J. 2021 (in preparation). Hurricane Dorian vs Sharpie Pen: an empirical test of social amplification of risk on social media.

Replication Author:
Evan Killion

Replication Materials Available at: [RP-Kang](https://github.com/evankilli/RP-Kang)

Created: `DD Month YYYY`
Revised: `DD Month YYYY`

## Abstract

Why study the spatial distribution of Twitter data?

Wang et al (2016) analyzed Twitter data for wildfires in California, finding that the social media activity lined up closely with wildfire events, both temporally and spatially, with clustering both around disruptions created by wildfires and in the hours and day after wildfire events - users are less likely to tweet at the exact moment of such events due to the time needed for information to disseminate and the fact that those disrupted by such events may need to take more pressing actions (e.g. evacuation) before tweeting. Additionally, the study found that that certain "opinion leaders" play important roles in the social media coverage, with tweets from reporters and local governments being extensively retweeted by users.

Holler (2021) is studying Twitter data for Hurricane Dorian on the Atlantic coast, finding that in spite of tending news and social media content regarding a false narrative of risk, original Tweets still clustered significantly along the real hurricane track, and only along the hurricane track.

Reproducing and replicating spatial research of social media coverage of certain events - be they disasters, elections, or celebration - continues to be relevant because the use of social media and other "crowd-sourced" sources of high-resolution Volunteered Geographic Information (VGI) in geosciences represents a paradigm-shifting innovation in the field. Access to data and data resolution have always been issues in the geosciences, and the ever-increasing growth of such sources of data and increasing use of such data opens important doors for geoscientists towards incredibly fine-grained analyses of events, globalized or localized.

In this replication study, I will explore twitter coverage of the Cinco de Mayo holiday on the US East Coast, and will be paying close attention to how results compare to the distribution of Latinx - specifically Mexican-American - populations in the region.



## Original Study Information

**summarize Wang et al (2016) similar to the Holler (2021) summary below**

Wang et al (2016)'s original study investigated the temporal and spatial distributions, content, and network "geography" of Twitter activity surrounding the May 2014 California wildfires, specifically the San Marcos and Bernardo wildfires. Wang et al (2016) collected these tweets using spatial and temporal buffers, limiting their search to a window from May 13-22, 2014 - coinciding with the first report of wildfires and the date of near total containment, and within a 40 mi radius of downtown San Diego - which encompassed most of San Diego County.

Wang et al used the `tm` package in `R 3.1.2` to preprocess the collected tweets, removing "noise" like URLs from the tweets, and going on to text-mine tweet content to identify significant terms and clusters of terms within tweets, picking up on important terms like "update" and "evacuate". This information allowed the authors to conclude that geographic awareness during such events was strong - locations like Carlsbad were tweeted about often - and that users were interested in information surrounding fire damage and responses.

Using the `igraph` package with the same data, Wang et al were able to map connections between users within the same network, with results supporting the authors' idea of "opinion leaders". They found that a few important "leaders" like a collection of local news networks and the San Diego County government forming a a collection of core nodes of retweets.

In their analysis of spatial relationships, the authors used a dual kernel density estimate to vizualize the relative prevalence of tweets within the study region, with this technique producing maps which showed a spatial distibution of tweets in the areas around fire locations, as well as certain population centers, like downtown San Diego.


Holler (2021) losely replicated the methods of Wang et al (2016) for the case of Hurricane Dorian's landfall on the U.S. mainland during the 2019 Atlantic Hurricane season. Holler modified Wang et al's methods by not searching for retweets for network analysis, focusing instead on original Tweet content with keywords hurricane, Dorian, or sharpiegate (a trending hashtag referring to the storm). Holler modified the methodology for normalizing tweet data by creating a normalized Tweet difference index and extended teh methodology to test for spatial cluserting with the local Getis-Ord statistic. The study tested a hypothesis that false narratives of hurricane risk promulgated at the highest levels of the United States government would significantly distort the geographic distribution of Twitter activity related to the hurricane and its impacts, finding that original Twitter data still clustered only in the affected areas of the Atlantic coast in spite of false narratives about risk of a westward track through Alabama. The replication study by Holler (2021) used R, including the `rtweet`, `rehydratoR`, `igraph`, `sf`, and `spdep` packages for analysis.

## Materials and Procedure

In querying Twitter's API, a simple query of "Cinco de Mayo" was found to be sufficient and produced a suitable mass of tweets for analysis, as well as a general query searching for all tweets within the study period, which was set as the period of April 29th through May 6th. An original query for April 28th through May 5th was also made, but was overwritten, requiring the analysis to be redone on May 6th with the data queried on that day.

A file containing status_id's for the Cinco de Mayo query are available [here](https://github.com/evankilli/RE-Dorian/blob/main/data/derived/public/cincoids.txt), and the tweets queried for baseline twitter activity for the study period - for use in normalizing studied tweets - are available [here](https://github.com/evankilli/RE-Dorian/blob/main/data/derived/public/currentids.txt).

The procedure used to conduct this analysis generally followed the workflows of both Wang et al and Holler, however a kernel density analysis was not used for this study, instead finding Getis-Ord G scores for the counties within the study region and then mapping those scores as relative "cold" and "hot" spots, with low and high relative densities of tweets relating to Cindo de Mayo. Additionally, network analysis was not conducted, following the methods used by Holler in his study of Hurrican Dorian. Code run in RStudio to conduct the analysis (with '_cinco' appended to the end of the file name) is provided [here](https://github.com/evankilli/RE-Dorian/tree/main/procedure/code).

## Replication Results

### Temporal analysis



- temporal analysis graph
- content analysis graph
- map of twitter activity
- hot spot analysis

## Unplanned Deviations from the Protocol

Summarize changes and uncertainties between
- your expectation of a reproduction workflow based on the reading and Dorian analysis
- your final workflow after completing the lab

## Discussion

Provide a summary and interpretation of your key findings in relation to your research question. Mention if findings confirm or contradict patterns observed by Wang et al (2016) or by Holler (2

## Conclusion

Restate the key findings and discuss their broader societal implications or contributions to theory.
Do the research findings suggest a need for any future research?

## References

Include any referenced studies or materials in the [AAG Style of author-date referencing](https://www.tandf.co.uk//journals/authors/style/reference/tf_USChicagoB.pdf).

####  Report Template References & License

This template was developed by Peter Kedron and Joseph Holler with funding support from HEGS-2049837. This template is an adaptation of the ReScience Article Template Developed by N.P Rougier, released under a GPL version 3 license and available here: https://github.com/ReScience/template. Copyright © Nicolas Rougier and coauthors. It also draws inspiration from the pre-registration protocol of the Open Science Framework and the replication studies of Camerer et al. (2016, 2018). See https://osf.io/pfdyw/ and https://osf.io/bzm54/

Camerer, C. F., A. Dreber, E. Forsell, T.-H. Ho, J. Huber, M. Johannesson, M. Kirchler, J. Almenberg, A. Altmejd, T. Chan, E. Heikensten, F. Holzmeister, T. Imai, S. Isaksson, G. Nave, T. Pfeiffer, M. Razen, and H. Wu. 2016. Evaluating replicability of laboratory experiments in economics. Science 351 (6280):1433–1436. https://www.sciencemag.org/lookup/doi/10.1126/science.aaf0918.

Camerer, C. F., A. Dreber, F. Holzmeister, T.-H. Ho, J. Huber, M. Johannesson, M. Kirchler, G. Nave, B. A. Nosek, T. Pfeiffer, A. Altmejd, N. Buttrick, T. Chan, Y. Chen, E. Forsell, A. Gampa, E. Heikensten, L. Hummer, T. Imai, S. Isaksson, D. Manfredi, J. Rose, E.-J. Wagenmakers, and H. Wu. 2018. Evaluating the replicability of social science experiments in Nature and Science between 2010 and 2015. Nature Human Behaviour 2 (9):637–644. http://www.nature.com/articles/s41562-018-0399-z.
