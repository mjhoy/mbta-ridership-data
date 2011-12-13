(function (d3) {

  d3.json('monthtotals.min.json', function (data) {
    
    var w = 400,
        h = 200,
        margin = 20,
        y = d3.scale.linear().domain([0, 30000]).range([0 + margin, h - margin ]),
        x = d3.scale.linear().domain([0, data.length]).range([0 + margin, w - margin]);

    var vis = d3.select('#monthly')
      .append('svg:svg')
      .attr('width', w)
      .attr('height', h);

    var g = vis.append('svg:g');

      // PROBLEM... thousand-separator commas come in on the data
    console.log( y(data[0]["Total Month"]) );
    console.log( y(29139) );
    console.log(data[0]["Total Month"])

    var line = d3.svg.line()
      .x(function(d,i) {  return x(i); })
      .y(function(d) { return y(d["Total Month"]); });

    g.append('svg:path').attr('d', line(data));

  });

})(d3);
