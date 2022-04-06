//const Web3 = require('web3');

//let web3 = new Web3('http://localhost:8545');


 currenturl = "";

 const web3 = new Web3('wss://rinkeby.infura.io/ws/v3/6bce9102f840475db7e291f4124d7951'); //http://localhost:8545/ net::ERR_CONNECTION_REFUSED 
 //const web3 = new Web3(window.ethereum); //http://localhost:8545/ net::ERR_CONNECTION_REFUSED 
 window.web3 = new Web3(window.ethereum);
 //console.log(web3.providers);

 //web3.setProvider('ws://localhost:8546');

 const abi = [{
     "type":"function",
     "name":"tokenURI",
     "constant":false,
     "payable":false,
     "stateMutability":"nonpayable",
     "inputs":[{"name":"tokenId","type":"uint256"}],
     "outputs":[{"name":"","type":"string"}]
   }];

 const address =  "0xa901be23102f1a34c894155b329e3edebb6db95c";
 const options = [{}];

 const contract = new web3.eth.Contract(abi, address, options);   // options = {from: account, value: 100000 }

function getimageurl(){
 

  // smartcontract read method
  contract.methods.tokenURI(1).call().then((res) => {
    res = res.substring(27);
    
  
    const obj = JSON.parse(res);
    formaturl(obj["imageUrl"]);

    

    

  }).catch((err) => {
    console.log(err);
  });


}

// write method
//contract.methods.mint(tokenURI, tokenId).send({ from: web3.eth.defaultAccount }).then((res) => {
//  console.log(res);
//}).catch((err) => {
//  console.log(err);
//});



function preload(url) {
  
  var newSrc =url,
        image = new Image();    

     //   $('.img').attr('src', url).on('load', function(){
       //   //this.width;   // Note: $(this).width() will not work for in memory images
      //     $(this).fadeIn();
      //});

      


      $(".img_new").fadeTo(1,0, function() {
        $(".img_new").attr("src",url);
    }).fadeTo(5000,1,function(){$(".img_current").attr("src",url);});
    
}

function formaturl(url){
  
  url = url.substring(7)
  //console.log(url);
  
  url = "https://stephanduq.mypinata.cloud/ipfs/" + url;

  if(url!=currenturl){

    preload(url);
    currenturl = url;
    console.log(url);
  }
  } 

  

  

getimageurl();

var interval = setInterval(function () { getimageurl(); }, 1000 * 60 * 5);



// get token data
// replace imageurl with gateway
// download image
// replace current image with current image
// do again in 5 minutes