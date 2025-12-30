

/*
<script>
document.addEventListener("DOMContentLoaded", function() {
  const container = document.querySelector('[data-pre-init="chart"]');
  if (!container) return;

  const dataEl = container.querySelector("data");
  if (!dataEl) return;

  let chartData;
  try {
    chartData = JSON.parse(dataEl.textContent);
  } catch (e) {
    console.error("Failed to parse chart data JSON:", e);
    return;
  }

  const rawPoints = Array.isArray(chartData.points) ? chartData.points : [];
  const looksLikeLink = (val) => typeof val === "string" && (/^https?:\/\//i.test(val.trim()) || /^\//.test(val.trim()) || /^mailto:/i.test(val.trim()));

  const categories = [];
  const seriesNames = [];
  const seriesMap = {};

  rawPoints.forEach(pt => {
    if (!Array.isArray(pt)) return;
    const [seriesName, x, yRaw, linkRaw] = pt;
    const y = Number(yRaw) || 0;
    const link = looksLikeLink(linkRaw) ? linkRaw.trim() : null;

    if (!categories.includes(x)) categories.push(x);
    if (!seriesNames.includes(seriesName)) seriesNames.push(seriesName);

    if (!seriesMap[seriesName]) seriesMap[seriesName] = { data: {}, links: {} };
    seriesMap[seriesName].data[x] = y;
    if (link) seriesMap[seriesName].links[x] = link;
  });

  const series = seriesNames.map(name => ({
    name,
    data: categories.map(cat => seriesMap[name].data[cat] ?? null)
  }));

  const linksLookup = {};
  seriesNames.forEach((sName, sIdx) => {
    categories.forEach((cat, cIdx) => {
      const link = seriesMap[sName].links?.[cat];
      if (link) linksLookup[`${sIdx}:${cIdx}`] = link;
    });
  });

  const options = {
    chart: {
      type: chartData.type || "rangeBar",
      height: Number(chartData.height) || 250,
      toolbar: { show: false },
      animations: { enabled: true },
      events: {
        dataPointSelection: function(event, chartContext, config) {
          event.stopPropagation();
          const key = `${config.seriesIndex}:${config.dataPointIndex}`;
          const link = linksLookup[key];
          console.log("Clicked:", key, link);
          if (link) window.open(link, "_blank", "noopener");
        }
      }
    },
    series,
    xaxis: { categories },
    colors: chartData.colors || undefined,
    tooltip: { shared: false },
    plotOptions: {
      bar: {
        horizontal: chartData.horizontal || false,
        dataLabels: { position: "top" }
      }
    }
  };

  const chartContainer = container.querySelector("#chart-canvas");
  const spinnerWrap = container.querySelector(".spinner-wrapper");
  if (!chartContainer) return;

  const chart = new ApexCharts(chartContainer, options);
  chart.render().then(() => {
    if (spinnerWrap) spinnerWrap.remove();
  }).catch(err => console.error("ApexCharts render error:", err));
});
</script>

<script>
document.addEventListener("DOMContentLoaded", function() {
  const container = document.querySelector('[data-pre-init="chart"]');
  if (!container) return;

  const dataEl = container.querySelector("data");
  if (!dataEl) return;

  let chartData;
  try {
    chartData = JSON.parse(dataEl.textContent);
  } catch (e) {
    console.error("Failed to parse chart data JSON:", e);
    return;
  }

  const rawPoints = Array.isArray(chartData.points) ? chartData.points : [];
  const looksLikeLink = (val) =>
    typeof val === "string" &&
    (/(^https?:\/\/)/i.test(val.trim()) || /^\//.test(val.trim()) || /^mailto:/i.test(val.trim()));

  const categories = [];
  const seriesNames = [];
  const seriesMap = {};

  // Accept variable-length rows: [seriesName, x, y, maybeZ, maybeLink]
  rawPoints.forEach(pt => {
    if (!Array.isArray(pt) || pt.length < 3) return;

    const seriesName = pt[0];
    const x = pt[1];
    const yRaw = pt[2];
    const linkRaw = pt[pt.length - 1]; // last element is most likely the link

    const link = looksLikeLink(linkRaw) ? String(linkRaw).trim() : null;
    const y = (Array.isArray(yRaw) || typeof yRaw === "number" || typeof yRaw === "string") ? yRaw : null;

    if (!categories.includes(x)) categories.push(x);
    if (!seriesNames.includes(seriesName)) seriesNames.push(seriesName);

    if (!seriesMap[seriesName]) seriesMap[seriesName] = { data: {}, links: {} };
    seriesMap[seriesName].data[x] = y;
    if (link) seriesMap[seriesName].links[x] = link;
  });

  // Build ApexCharts-style series: data is array of { x, y } objects
  const series = seriesNames.map(name => ({
    name,
    data: categories.map(cat => {
      // keep y as-is (may be number or [start,end])
      const value = (seriesMap[name].data && (cat in seriesMap[name].data)) ? seriesMap[name].data[cat] : null;
      return { x: cat, y: value };
    })
  }));

  // Build lookup keyed by "seriesIndex:dataPointIndex"
  const linksLookup = {};
  series.forEach((s, sIdx) => {
    s.data.forEach((dObj, i) => {
      const linkForPoint = seriesMap[s.name].links?.[dObj.x];
      if (linkForPoint) linksLookup[`${sIdx}:${i}`] = linkForPoint;
    });
  });

  const options = {
    chart: {
      type: chartData.type || "rangeBar",
      height: Number(chartData.height) || 250,
      toolbar: { show: false },
      animations: { enabled: true },
      events: {
        dataPointSelection: function(event, chartContext, config) {
          // config.seriesIndex and config.dataPointIndex are the keys we used
          const key = `${config.seriesIndex}:${config.dataPointIndex}`;
          const link = linksLookup[key];
          if (!link) return;

          try {
            // Prefer opening in a new tab
            window.open(link, "_blank", "noopener");
          } catch (err) {
            // If popup blocked, navigate in the same tab
            window.location.href = link;
          }
        }
      }
    },
    series,
    // For rangeBar we prefer using the x inside each data point, but xaxis.categories is okay too
    xaxis: { type: "category" },
    colors: chartData.colors || undefined,
    tooltip: { shared: false },
    plotOptions: {
      bar: {
        horizontal: chartData.horizontal || false,
        dataLabels: { position: "top" }
      }
    }
  };

  const chartContainer = container.querySelector("#chart-canvas");
  const spinnerWrap = container.querySelector(".spinner-wrapper");
  if (!chartContainer) return;

  const chart = new ApexCharts(chartContainer, options);
  chart.render().then(() => {
    if (spinnerWrap) spinnerWrap.remove();
  }).catch(err => console.error("ApexCharts render error:", err));
});
</script>
*/