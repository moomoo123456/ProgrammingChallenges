SELECT date, SUM(impressions) AS total_impressions
FROM marketing_performance
GROUP BY date
ORDER BY date;

SELECT state, SUM(revenue) AS total_revenue
FROM website_revenue
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 3;

SELECT c.name AS campaign_name,
       SUM(mp.cost) AS total_cost,
       SUM(mp.impressions) AS total_impressions,
       SUM(mp.clicks) AS total_clicks,
       SUM(wr.revenue) AS total_revenue
FROM campaign_info c
JOIN marketing_performance mp ON c.id = mp.campaign_id
JOIN website_revenue wr ON c.id = wr.campaign_id
GROUP BY c.name;

SELECT wr.state, SUM(mp.conversions) AS total_conversions
FROM marketing_performance mp
JOIN website_revenue wr ON mp.campaign_id = wr.campaign_id
WHERE mp.campaign_id = 'Campaign5'
GROUP BY wr.state
ORDER BY total_conversions DESC
LIMIT 1;

SELECT c.name AS campaign_name,
       SUM(wr.revenue) / SUM(mp.cost) AS efficiency
FROM campaign_info c
JOIN marketing_performance mp ON c.id = mp.campaign_id
JOIN website_revenue wr ON c.id = wr.campaign_id
GROUP BY c.name
ORDER BY efficiency DESC
LIMIT 1;

SELECT DATE_FORMAT(date, '%W') AS day_of_week,
       AVG(impressions) AS avg_impressions
FROM marketing_performance
GROUP BY day_of_week
ORDER BY avg_impressions DESC
LIMIT 1;
