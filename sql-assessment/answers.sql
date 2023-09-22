-- 1. Get the sum of impressions by day.
SELECT date, SUM(impressions) AS total_impressions
FROM marketing_data
GROUP BY date;

-- 2. Get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?
SELECT state, SUM(revenue) AS total_revenue
FROM website_revenue
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 3;

-- 3. Show total cost, impressions, clicks, and revenue of each campaign, including campaign name.
SELECT ci.name AS campaign_name,
       SUM(md.cost) AS total_cost,
       SUM(md.impressions) AS total_impressions,
       SUM(md.clicks) AS total_clicks,
       SUM(wr.revenue) AS total_revenue
FROM campaign_info ci
JOIN marketing_data md ON ci.campaign_id = md.campaign_id
JOIN website_revenue wr ON ci.campaign_id = wr.campaign_id
GROUP BY ci.name;

-- 4. Get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?
SELECT md.geo AS state,
       SUM(md.conversions) AS total_conversions
FROM marketing_data md
WHERE md.campaign_id = 'Campaign5'
GROUP BY md.geo
ORDER BY total_conversions DESC
LIMIT 1;

-- 5. Identify the most efficient campaign based on the revenue-to-cost ratio.
SELECT ci.name AS campaign_name,
       SUM(wr.revenue) / SUM(md.cost) AS efficiency
FROM campaign_info ci
JOIN marketing_data md ON ci.campaign_id = md.campaign_id
JOIN website_revenue wr ON ci.campaign_id = wr.campaign_id
GROUP BY ci.name
ORDER BY efficiency DESC
LIMIT 1;

-- Bonus: Find the best day of the week to run ads based on average impressions.
SELECT DATE_FORMAT(date, '%W') AS day_of_week,
       AVG(impressions) AS avg_impressions
FROM marketing_data
GROUP BY day_of_week
ORDER BY avg_impressions DESC
LIMIT 1;
