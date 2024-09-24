*** Settings ***
Library           RequestsLibrary

*** Keywords ***
GET plus JSON
    [Arguments]    ${num1}    ${num2}
    ${resp}=     GET    http://localhost:8081/plus/${num1}/${num2}
    Should Be Equal    ${resp.status_code}    ${200}
    RETURN    ${resp.json()}


*** Test Cases ***
Test Plus Numbers 4 and 2
    ${json_resp}=    GET plus JSON    4    2
    Should Be Equal    ${json_resp['result']}    ${6}

Test Plus Numbers 8.4 and 4
    ${json_resp}=    GET plus JSON    8.4    4
    Should Be Equal    ${json_resp['result']}    ${12.4}

Test Plus Numbers 8.4 and 4.6
    ${json_resp}=    GET plus JSON    8.4    4.6
    Should Be Equal    ${json_resp['result']}    ${13.0}

Test Plus Numbers -5 and -6
    ${json_resp}=    GET plus JSON    -5    -6
    Should Be Equal    ${json_resp['result']}    ${-11}

Test Plus Numbers -5 and 6
    ${json_resp}=    GET plus JSON    -5    6
    Should Be Equal    ${json_resp['result']}    ${1}

Test Plus Numbers 0 and 0
    ${json_resp}=    GET plus JSON    0    0
    Should Be Equal    ${json_resp['result']}    ${0}

Test Plus Numbers 8 and zero
    ${json_resp}=    GET plus JSON    ${8}    "zero"
    Should Be Equal    ${json_resp['error_msg']}    inputs must be numbers

Test Plust Numbers Eight and Four
    ${json_resp}=    GET plus JSON    "Eight"    "Four"
    Should Be Equal    ${json_resp['error_msg']}    inputs must be numbers