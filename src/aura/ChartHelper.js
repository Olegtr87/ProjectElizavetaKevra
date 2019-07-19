({
    createLineGraph : function(cmp, temp) {
        
        var dateLabel = [];
        var usd = [];
        var eur = [];
        var rub = [];
        
        for(var a=0; a< temp.length; a++){
            dateLabel.push(temp[a]["dateForLabel"]);
            usd.push(temp[a]["usd"]);
            eur.push(temp[a]["eur"]); 
            rub.push(temp[a]["rub"]);
        }  
            
        var el = cmp.find('lineChart').getElement();
        var ctx = el.getContext('2d');
        
        new Chart(ctx, {
            type: 'line',
            data: {
                    labels: dateLabel,
                datasets: [
                {
                    label:'USD',
                    data: usd,
                    borderColor:'#4682B4',
                    fill: false,                    
                	pointBorderWidth: 4,
                	pointHoverRadius: 5,
                	pointRadius: 3,
                	bezierCurve: true,
                	pointHitRadius: 10
                },
                {
                    label:'EUR',
                    data: eur,
                    borderColor:'#FFF5EE',
                    fill: false,                    
                    pointBorderWidth: 4,
                	pointHoverRadius: 5,
                	pointRadius: 3,
                	bezierCurve: true,
                	pointHitRadius: 10
                },
        		{
                    label:'RUB(100)',
                    data: rub,
                    borderColor:'#778899',
                    fill: false,            
                    pointBorderWidth: 4,
                	pointHoverRadius: 5,
                	pointRadius: 3,
                	bezierCurve: true,
                	pointHitRadius: 10
                }
            ]                  
           }
        });        
	}    
})