({	
	createGraph : function(component, event, helper) {
        var temp = [];
        var action = component.get("c.getLineChartMap");
              
        action.setCallback(this, function(response){        	    	    
            if(response.getState() === 'SUCCESS' && response.getReturnValue()){
                temp = JSON.parse(response.getReturnValue());
                helper.createLineGraph(component, temp);
            }            
        });  	
       $A.enqueueAction(action);
	}
})