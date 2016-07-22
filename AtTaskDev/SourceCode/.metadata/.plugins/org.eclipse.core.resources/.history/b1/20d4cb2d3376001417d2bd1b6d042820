public class GoogleDistance{
    public class Response{
        public String status {get;set;}
        public String[] destination_addresses {get;set;}
        public String[] origin_addresses {get;set;}
        public Row[] rows {get;set;}
        public String error_message {get;set;}
    }
    
    public class Row{
        public Element[] elements {get;set;}
    }
    
    public class Element{
        public String status {get;set;}
        public Node distance {get;set;}
        public Node duration {get;set;}
    }
    
    public class Node{
        public String text {get;set;} //This will return the text equivalent in imperial or metric (per requested)
        public Long value {get;set;}  //This always returns seconds for duration or meters for distance
    }
    
    public static Map<String, Map<String, Element>> getDistance(String[] origins, String[] destinations){
        Map<String, Map<String, Element>> responseMatrix = new Map<String, Map<String, Element>>();
        String origin = '';
        String destination = '';
        
        for(String s:origins){
            if(origin != ''){
                origin += '|';
            }
            origin += EncodingUtil.urlEncode(s, 'UTF-8');
        }
        
        for(String s:destinations){
            if(destination != ''){
                destination += '|';
            }
            destination += EncodingUtil.urlEncode(s, 'UTF-8');
        }
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://maps.googleapis.com/maps/api/distancematrix/json?origins=' + EncodingUtil.urlEncode(origin, 'UTF-8') + '&destinations=' + EncodingUtil.urlEncode(destination, 'UTF-8') + '&units=imperial');
        HttpResponse resp = http.send(req);
        if(resp.getStatusCode() == 200){
            Response distResp = (Response) JSON.deserialize(resp.getBody(), Response.class);
            System.debug(distResp.status);
            for(Integer i = 0; i < distResp.rows.size(); i++){
                Map<String, Element> destMap = new Map<String, Element>();
                for(Integer j = 0; j < distResp.rows[i].elements.size(); j++){
                    destMap.put(destinations[j], distResp.rows[i].elements[j]);
                }
                responseMatrix.put(origins[i], destMap);
            }
            return responseMatrix;
        }else{
            System.debug('There was an error in API request');
            System.debug(resp.getStatusCode());
            System.debug(resp.getStatus());
            System.debug(resp.getBody());
        }
        return null;
    }
}