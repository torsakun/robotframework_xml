***Settings***
Library           RequestsLibrary
Library           XML
Library           OperatingSystem
Library           Collections
Library           String

***Variables***
${URL}    https://www.w3schools.com

***Test Cases***
Ex_001
    Create Session    Mysession   ${url}    verify=True     disable_warnings=1
    ${body}=  Convert To String     <?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"> <soap:Body> <FahrenheitToCelsius xmlns="https://www.w3schools.com/xml/"> <Fahrenheit>100</Fahrenheit> </FahrenheitToCelsius> </soap:Body></soap:Envelope>
    ${header}=      Create Dictionary    Content-Type=text/xml    SOAPAction=https://www.w3schools.com/xml/FahrenheitToCelsius
    ${response}=    Post Request    Mysession   /xml/tempconvert.asmx   data=${body}        headers=${header}
    ${string}    Convert To String    ${response.content}
    ${xml}    Parse XML    ${string}
    ${child_element}    Get Child Elements    ${xml}
    ${text}    Get Element Text    ${child_element}[0]
    Log To Console    Text ${text}

Ex_002
    Create Session    Mysession   http://api.worldbank.org    verify=True     disable_warnings=1
    #${body}=  Convert To String     <?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"> <soap:Body> <FahrenheitToCelsius xmlns="https://www.w3schools.com/xml/"> <Fahrenheit>100</Fahrenheit> </FahrenheitToCelsius> </soap:Body></soap:Envelope>
    ${header}=      Create Dictionary    Content-Type=text/xml    #SOAPAction=https://www.w3schools.com/xml/FahrenheitToCelsius
    ${response}=    Get Request    Mysession   /v2/country/THA/indicator/BM.KLT.DINV.CD.WD   headers=${header}    #data=${body}        headers=${header}
    ${string}    Convert To String    ${response.content}
    ${xml}    Parse XML    test.xml
    Log To Console    ${xml}
    ${string}    Convert To String    ${xml}
    Log To Console    ${string}

Ex_003
    ${xml}    Parse Xml    example.xml
    Log To Console   ${xml} 
    @{adjacencies}    Get Elements    ${xml}    isis-adjacency
    Log To Console    adjacencies ${adjacencies}
    ${state}    Set Variable    NOT FOUND
    FOR    ${adjacency}    IN    @{adjacencies}
        ${level}    Get Element Text    ${adjacency}    level
        Log To Console    level ${level}
    END


Ex_004
    Create Session    Mysession   http://api.worldbank.org    verify=True     disable_warnings=1
    ${header}=      Create Dictionary    Content-Type=text/xml    Accept=application/json;charset=utf-8
    ${response}=    Get Request    Mysession   /v2/country/THA/indicator/BM.KLT.DINV.CD.WD   headers=${header}   
    ${string}    Convert To String    ${response.text}
    #${xml}    Parse Xml    ${string}
    #Log To Console   ${string} 
    @{adjacencies}    Get Elements    ${string}    data
    #FOR    ${string}    IN    @{adjacencies}
    #    ${text}    Get Element Text    ${string}    date
    #    Log To Console    text ${text}
    #END
