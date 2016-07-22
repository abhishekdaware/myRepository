public class GoogleDirections {
    
    public class Response{
        public String status {get;set;}
        public Route[] routes {get;set;}
    }
    
    public class Route{
        public String summary {get;set;}
        public Leg[] legs {get;set;}
        public Integer[] waypoint_order {get;set;}
        public Points overview_polyline {get;set;}
        public Bounds bounds {get;set;}
        public String copyrights {get;set;}
        public String[] warnings {get;set;}
    }
    
    public class Leg{
        public Step[] steps {get;set;}
        public Element distance {get;set;}
        public Element duration {get;set;}
        public Element duration_in_traffic {get;set;}
        public Element arrival_time {get;set;}
        public Element departure_time {get;set;}
        public Location start_location {get;set;}
        public Location end_location {get;set;}
        public String start_address {get;set;}
        public String end_address {get;set;}
        public String[] via_waypoint {get;set;}
    }
    
    public class Step{
        public String html_instructions {get;set;}
        public Element distance {get;set;}
        public Element duration {get;set;}
        public Location start_location {get;set;}
        public Location end_location {get;set;}
        public Points polyline {get;set;}
        public Step[] steps {get;set;}
        public Transit transit_details {get;set;}
        public String travel_mode {get;set;}
        public String maneuver {get;set;}
    }
    
    public class Element{
        public Integer value {get;set;}
        public String text {get;set;}
        public String time_zone {get;set;}
    }
    
    public class Location{
        public String lat {get;set;}
        public String lng {get;set;}
    }
    
    public class Bounds{
        public Location southwest {get;set;}
    	public Location northeast {get;set;}
    }

    public class Points{
        public String points {get;set;}
	}
    
    public class Transit{
        public Stop arrival_stop {get;set;}
        public Stop departure_stop {get;set;}
        public Element arrival_time {get;set;}
        public Element depature_time {get;set;}
        public String headsign {get;set;}
        public Integer headway {get;set;}
        public Integer num_stops {get;set;}
        public Line line {get;set;}
    }
    
    public class Stop{
        public String name {get;set;}
        public Location location {get;set;}
    }

    public class Line{
        public String name {get;set;}
        public String short_name {get;set;}
        public String color {get;set;}
        public Agency[] agencies {get;set;}
        public String url {get;set;}
        public String icon {get;set;}
        public String text_color {get;set;}
        public Vehicle vehicle {get;set;}
            
    }
    
    public class Agency {
        public String name {get;set;}
        public String url {get;set;}
        public String phone {get;set;}
    }
    
    public class Vehicle {
        public String name {get;set;}
        public String type {get;set;}
        public String icon {get;set;}
    }
    
	public static Map<String, Map<String, Element>> getDirections(String origin, String[] waypoints, String destination){
        origin = EncodingUtil.urlEncode(origin, 'UTF-8');
        String waypoint = '';
        destination = EncodingUtil.urlEncode(destination, 'UTF-8');
        
        for(String s:waypoints){
            if(waypoint != ''){
                waypoint += '|';
            }
            waypoint += EncodingUtil.urlEncode(s, 'UTF-8');
        }
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://maps.googleapis.com/maps/api/directions/json?origin=' + EncodingUtil.urlEncode(origin, 'UTF-8') + '&destination=' + EncodingUtil.urlEncode(destination, 'UTF-8') + '&waypoints=' + waypoint + '&units=imperial');
        HttpResponse resp = http.send(req);
        if(resp.getStatusCode() == 200){
            System.debug(resp.getBody());
            Response directResp = (Response) JSON.deserialize(resp.getBody(), Response.class);
            System.debug(directResp.status);
            
        }else{
            System.debug('There was an error in API request');
            System.debug(resp.getStatusCode());
            System.debug(resp.getStatus());
            System.debug(resp.getBody());
        }
        return null;
    }
}