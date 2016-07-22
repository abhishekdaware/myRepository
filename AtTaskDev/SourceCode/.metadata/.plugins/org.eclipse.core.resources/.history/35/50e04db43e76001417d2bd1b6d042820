public class JWT{
    private class JWTHeader{
        String alg {get;set;}
        String typ {get;set;}
    }
    
    private class JWTClaimSet{
        String iss {get;set;}
        String scope {get;set;}
        String aud {get;set;}
        Long exp {get;set;}
        Long iat {get;set;}
    }
    
    
    public static void buildJWT(){
        JWTHeader head = new JWTHeader();
        head.alg = 'RS256';
        head.typ = 'JWT';
        
        JWTClaimSet claim = new JWTClaimSet();
        claim.iss = '788882387104-tjucas7bdka00t66p4lrfih4ddspetle@developer.gserviceaccount.com';
        claim.scope = 'https://www.googleapis.com/auth/dfp';
        claim.aud = 'https://accounts.google.com/o/oauth2/token';
        claim.iat = DateTime.now().getTime() / 1000;
        claim.exp = claim.iat + 3600;
        
        System.debug(JSON.serialize(head));
        System.debug(JSON.serialize(claim));
        
        String key = 'MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALPbfLFo2uW/JEXqQtWYmL8+SvX3PE6hPDVHjzZhpH4zaA6MDDsz+wRqBaQl9UR9JTbovReAeeCGG6pgclNSfX6OX72ZjKc6UMFidM/QjSjJpaJBtfLx5VB+pmcTn1PVAPRcrnGqeIFBQ2eIf8Oo+kmhMt39afzsMs4L7/XbYs/DAgMBAAECgYB+SCqp6gRf8bAHQu9AR89f394EC16VmtHKWv8r4Kz9SxzRsfVYkCu8MrDZSymFuBSsFAfIe5WXVrIQE33SEQY46b8Oyj1T9V78G+5rThweSlrxOALpgywGVaO7yyzLThJvEawb1359slzT+7qBhzQl1Vh2dgo0jZ4lab2ldrPEuQJBAO54S/f7VztOM8pqn6lh5qoN+yawrEPhawwQf+x9U/urnh1I/kqmP7gHuUX7hUpt87jYnDvzen2neq/sX9+5Kt8CQQDBFC0cT/VFE2boDidLChkim0EwmEIfczS+oZ9kGryLLK8wbgP1TuALNqv1hC/C7jOBoNRne3gAXNq2S+z4chudAkEA7iZS79cg+YgSrr4mrvinbALEY5IipzOyPP0pU9qhiX+NSv+/fHtkvPtxqpMSPQ9rS5l/BVwVYvFj09bCtGFujwJAfppZPhBb9nBTcOQe9cBoXN3KsC+WZALp2fomhsBVUzj4otvwsoCGvjOaLAICQ2Jn2Z74x+YY+LvqGdDNUNeZrQJBAIG0aKBRtN1YVK9H2Kv3+A4yaAan9PgOQ48mXFdp/C/+R+X+6+abyJMpiHeatyo6YZPL5+tu5B/hFfED43anhZ8=';
        String base = EncodingUtil.urlEncode(EncodingUtil.base64Encode(Blob.valueOf(JSON.serialize(head))), 'UTF-8') + '.' + EncodingUtil.urlEncode(EncodingUtil.base64Encode(Blob.valueOf(JSON.serialize(claim))), 'UTF-8');
        String sig = EncodingUtil.base64Encode(Crypto.sign('RSA-SHA256', Blob.valueOf(base), EncodingUtil.base64Decode(key)));
        String body = base + '.' + sig;
        System.debug(body);
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://accounts.google.com/o/oauth2/token');
        req.setBody('grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer&assertion=' + body);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setMethod('POST');
        System.debug(req);
        HttpResponse resp = http.send(req);
        
        System.debug(resp.getStatusCode());
        System.debug(resp.getStatus());
        System.debug(resp.getBody());
    }    
    
}