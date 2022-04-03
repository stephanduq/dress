pragma solidity ^0.8.0;

// SPDX-License-Identifier: MIT

import "@manifoldxyz/creator-core-solidity/contracts/ERC721Creator.sol";

import "@openzeppelin/contracts/utils/Strings.sol"; 
import "https://github.com/bokkypoobah/BokkyPooBahsDateTimeLibrary/blob/master/contracts/BokkyPooBahsDateTimeLibrary.sol";

contract MyContract is ERC721Creator  {

    uint256 public createTime;


    uint framecount=48;
   
    uint sunUpDec = ((8 * 60) + 45 ) * 60; // 31500
    uint sunUpJun = ((4 * 60) + 20 ) * 60; // 19200
       
    uint sunDownDec = ((16 * 60) + 30 ) * 60; //59400
    uint sunDownJun = ((21 * 60) + 4 ) * 60; // 79440


    uint[32][12] public weather;

         



   struct weatherData {
            uint maxdays;
            uint sunDownToday;
            uint sunUpToday;
            bool leapyear;
        }
        
    constructor() ERC721Creator ("MyContract", "MC") {
            weather[0] = [1042,1041,1028,1018,1006,999,1016,1026,1015,1027,1023,1017,1029,1035,1029,1010,998,1011,1027,1027,1025,1028,1030,1027,1025,1037,1049,1042,1043,1031,1021,1016];  // jan
            weather[1] = [1016,1010,1022,1026,1030,1030,1029,1035,1033,1026,1024,1028,1031,1030,1032,1026,1020,1020,1007,1011,1025,1028,1018,1015,1017,1004,994,994,994,998];  // feb
            weather[2] = [998,1011,1021,1025,1019,1014,1010,1014,995,1002,995,993,1000,997,995,999,1006,1008,1016,1019,1015,1016,1011,1010,1012,1011,1009,1014,1015,1012,1017,1024];  // mar
            weather[3] = [1024,1014,1020,1016,1004,1013,1009,1015,1009,998,996,1011,1016,1011,1010,1010,1014,1014,1014,1012,1009,1016,1013,1012,1017,1017,1016,1008,1005,1004,1006];  // apr
            weather[4] = [1006,1004,1016,1024,1026,1020,1017,1019,1028,1028,1023,1023,1025,1026,1025,1022,1022,1019,1014,1011,1012,1013,1015,1014,1017,1020,1024,1026,1022,1019,1016,1018];  // may
            weather[5] = [1018,1020,1019,1015,1012,1007,1008,1011,1013,1012,1011,1013,1013,1011,1009,1011,1008,1010,1016,1023,1025,1027,1027,1024,1016,1014,1011,1010,1009,1009,1014];  // jun
            weather[6] = [1014,1019,1024,1023,1015,1016,1022,1022,1019,1018,1019,1019,1020,1023,1018,1014,1017,1015,1022,1022,1020,1016,1010,1012,1017,1017,1015,1015,1015,1012,1017,1014];  // jul
            weather[7] = [1014,1013,1008,1008,1010,1018,1019,1017,1016,1014,1016,1024,1026,1023,1019,1018,1020,1015,1014,1015,1019,1014,1010,1014,1012,1005,1008,998,999,999,1020,1020];  // aug
            weather[8] = [1020,1011,1008,1018,1018,1010,1007,1014,1015,1007,1016,1023,1027,1023,1024,1024,1028,1022,1013,1017,1020,1018,1014,1007,1007,1009,1008,1011,1011,1010,1008];  // sep
            weather[9] = [1008,1004,1009,997,995,1011,1021,1026,1024,1027,1029,1022,1012,1013,999,1009,1016,1018,1022,1023,1013,1012,1019,1022,1023,1027,1021,1020,1007,1000,996,998];  // oct
            weather[10] = [998,999,1008,1012,997,999,1009,1014,1020,1022,1007,994,987,997,1005,1008,1019,1025,1009,1014,1023,1023,1009,1008,1011,997,999,1005,1013,1022,1027]; // nov
            weather[11] = [1027,1033,1031,1026,1020,1013,1016,1020,1025,1038,1045,1045,1038,1032,1029,1027,1030,1029,1021,1025,1028,1031,1030,1031,1027,1023,1013,1002,993,1018,1032,1042]; // dec

            // 987 - 1027
    }

    function tokenURI(uint256 tokenId) view public override returns (string memory) {
        uint year;
        uint month;
        uint day;
        uint hour;
        uint minute;
        uint second;
        uint isDay;
        uint frame;
        uint weathertype = 0;

        (year, month, day, hour, minute, second) =  BokkyPooBahsDateTimeLibrary.timestampToDateTime(block.timestamp + 3600);

        

        (frame, isDay) = isItDayTime(year,month,day,hour,minute);
   
        weathertype = weatherType(month,day,hour,minute,isDay);

        if(isDay == 0){
            month = 13;
        
        }
        

        //return(Strings.toString(month));

        //return  string(abi.encodePacked('data:application/json;utf8,{"title": "Title", "name": "Title", "type": "object", "imageUrl": "ipfs://QmVAtuPzqLNEWmfmUGKLJ9mP9H47TfPcRjxpoMKxSnP3j9/',Strings.toString(month),'_',Strings.toString(weathertype),'_',Strings.toString(frame),'.jpg"}'));
        return  string(abi.encodePacked('data:application/json;utf8,{"title": "Title", "name": "Title", "type": "object", "imageUrl": "ipfs://QmdzUoetsbktEKd52W7EL8Q4R5DCdx2vYeKc71yRr1k4CF/',Strings.toString(month),'_',Strings.toString(weathertype),'_',Strings.toString(frame),'.jpg", "description": "description", "attributes": [{"trait_type": "Creator", "value": "Stephan Duquesnoy"}], "properties": {"name": {"type": "string", "description": "title"}, "description": {"type": "string", "description": "description"}, "preview_media_file": {"type": "string", "description": "https://ipfsgateway.makersplace.com/ipfs/QmRKQz7gpkgTb9jumzW98cp5cRCaTZC2zx4HiYNzHQZhbD"}, "preview_media_file_type": {"type": "string", "description": "jpg"}, "created_at": {"type": "datetime", "description": "2021-09-25T11:26:56.801050+00:00"}, "total_supply": {"type": "int", "description": 1}, "digital_media_signature_type": {"type": "string", "description": "SHA-256"}, "digital_media_signature": {"type": "string", "description": "a82791deca62050ee7f90967383bb04ce29b9f4f6fea10e64be649e3d2cbdc56"}}, "available_for_purchase_at": "2022-10-05T11:26:56.801050+00:00"}'));

    }


    function isItDayTime(uint year, uint month, uint day, uint hour, uint minute) view public returns (uint, uint){


        weatherData memory weather;
    
        uint frame = 0;
        uint currentdays = BokkyPooBahsDateTimeLibrary._daysFromDate(year,month,day);
        uint targetdays = BokkyPooBahsDateTimeLibrary._daysFromDate(year,6,21);
        uint datediff = 0;
        uint secondsToday = ((hour * 60) + minute) * 60;
        
        if( targetdays >= currentdays){
           
            weather.maxdays = 182;

            weather.leapyear= BokkyPooBahsDateTimeLibrary._isLeapYear(year);
            if(weather.leapyear){
                weather.maxdays++;

            }
            datediff = (targetdays - currentdays);
            weather.sunDownToday = (((sunDownJun-sunDownDec) * ( weather.maxdays - datediff)) / weather.maxdays) + sunDownDec ;
            
            weather.sunUpToday = (((sunUpDec-sunUpJun) *datediff) / weather.maxdays) + sunUpJun ;


            // pablo vroeg hierom


        }else{
            
            targetdays = BokkyPooBahsDateTimeLibrary._daysFromDate(year,12,21);
            if( targetdays >= currentdays){
                weather.maxdays = 183;
                datediff = (targetdays - currentdays);
                weather.sunDownToday = (((sunDownJun-sunDownDec) * datediff ) / weather.maxdays) + sunDownDec ;
                
                weather.sunUpToday = (((sunUpDec-sunUpJun) *  ( weather.maxdays - datediff)) / weather.maxdays) + sunUpJun ;

            }else{
                // 181
                targetdays = BokkyPooBahsDateTimeLibrary._daysFromDate(year+1,6,21);
                weather.maxdays = 182;

                weather.leapyear= BokkyPooBahsDateTimeLibrary._isLeapYear(year+1);
                if(weather.leapyear){
                 weather.maxdays++;

                }
                datediff = (targetdays - currentdays);
                weather.sunDownToday = (((sunDownJun-sunDownDec) * ( weather.maxdays - datediff)) / weather.maxdays) + sunDownDec ;
            
                weather.sunUpToday = (((sunUpDec-sunUpJun) *datediff) / weather.maxdays) + sunUpJun ;


            }

        } 
        uint isDay = 0;
        
         if(secondsToday > weather.sunUpToday && secondsToday < weather.sunDownToday){
            frame = ((secondsToday - weather.sunUpToday) * framecount / (weather.sunDownToday-weather.sunUpToday));
            isDay = 1;
            
        }else{

            if(secondsToday <=weather.sunUpToday){
                frame = ((secondsToday) * (framecount / 2 ) / (weather.sunUpToday)) + (framecount / 2);
            }else{
                frame = ((secondsToday - weather.sunDownToday) * (framecount / 2 ) / ((24 * 60 * 60) - weather.sunDownToday));
            }
        }
        return (frame + 1, isDay); 
      

    }


    function weatherType(uint month, uint day, uint hour, uint minute, uint isDay) view public returns (uint){

        minute = ((((minute * 1000) / 60) * 4)) / 1000;
        minute *= 5;
        minute += hour * 60;
        minute += day * 24 * 60;
        minute *= month;

        uint randomHash = uint(keccak256(abi.encode(Strings.toString(minute))));



        uint pressureNext = weather[month-1][day];
        uint pressureCurrent = weather[month-1][day-1];
        uint diff = 0;
        if( pressureNext >pressureCurrent){
            diff = pressureNext - pressureCurrent;
        }else{
            diff = pressureCurrent - pressureNext;
            
        }

        uint pressure =  pressureCurrent - diff  + (randomHash %  (diff * 2));
        
        uint weathertype = ((pressure - 967) * 1000);
        weathertype = weathertype /  (1047 - 967);

        if(isDay==0){
            weathertype *=1;
        }else{
            weathertype *=3;
        }
        weathertype = weathertype / 1000;
        return weathertype;


    }

 
    

}
