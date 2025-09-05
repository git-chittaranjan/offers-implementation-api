
import React, { useEffect } from 'react';

function FetchOffers() {
    useEffect(() => {

        const token = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxNTkxNjgwNTAsInVzZXJuYW1lIjoiVzc5VVNXVSIsImV4cCI6MTc2ODU4MTY0NSwiZW1haWwiOiJiYW4yNjkyNjBAZXh0LmljaWNpYmFuay5jb20iLCJvcmlnX2lhdCI6MTczNzA0MTY0NSwiYWNjZXNzX21hc2siOjYyLCJwcm9ncmFtX2lkIjo1LCJleHBfbXMiOjE3Njg1ODE2NDUxNDMsInJvbGVfaWQiOjEwLCJhY2Nlc3NfbGV2ZWwiOiJQcm9ncmFtIiwiYXBpX2VuYWJsZWQiOnRydWUsInN5c191c2VyX2lkIjoxODV9.s3bdu2tD67o-B96gBDxkdXcg7_XH5x_IVxXfC7EL7k4cvPCI8foLataCV974HwS5wZ-LyeEmzpXeIs5BdEWBebuLiXSHwt-7F5rqxl1QTRt7XiKpbstDpNgQG2kOYSyNjQndixhvE1B8K3nzwubPgVJyslDPZn3bYehiYo4SfOThHiz0tPXxl6-kUvxzuwKDY_xJieozkKVP0lziSrd0LvSKRietyl-z_cWcL1aTt6Lljaq3H43vwG7_ei9buSAd51qb6mYBstSfldxRQDo_HNW2LuRyKXDbWxKWmp96fafj-5SgSyuZHlwu49bZm8BDHZl58TP9huj4CA4OiQr-b2ufozjWt39YjASPdL5bTX-aC5CQzh-JHq39Ku4PQUniZbEiHblbzlGj0N-QW35jfpa01fUoE3rC2skfQgBn1G_TUgcwrm-XmWDWvdLjH2EEvIMJDOZBoSHviRzdA8E-KOq4DJKvW2hsoy7IXoS5GASEqgwxPlBJSZT1rvxlMMSZ_bVT5J9u20Iabhx5s7o20P81Ui94LlahJamL5Zpg6cMt_1JKp3QgYZnOdOpOuwzsRrVY3Z3L8Q19a9JUvVIpn2tOD2mFUXposyjxSie_X8w-QfmysXBB_A2Yg39b7xmvLtVUcxccOQSb7MinZla6wlqvKJe4U7TmGFRqiRw1dkw';
        const fetchOffers = async () => {
            // Data to be send in the body of the POST request
            const data = {
                "channelName": "INSTA_B",
                "zoneName": "SES"
            };

            try {
                const response = await fetch('/api/v2/gravty/offersGet?fedId=4160563228&type=SES', {
                    method: 'POST',
                    headers: {
                        'apikey': 'qAUqNcGIgoWCUnehFr5pCKmcZOaR0CT9',
                        'token': token,
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(data) // Send the data as JSON string
                });

                if (!response.ok) {
                    console.log(`HTTP error! status: ${response.status}`)
                }

                //const result = await response.json();
                const result = await response.text();
                console.log("==========================================================")
                console.log('Success:', result);
                console.log("==========================================================");

            } catch (error) {
                console.error('Error:', error);
            }
        };

        fetchOffers(); // Call the async function
    }, []); // Empty dependency array to run once after component mounts

    return (
        <div>
            <h1>React API POST Request</h1>
        </div>
    );
}

export default FetchOffers;
