//const Web3 = require('web3');

//let web3 = new Web3('http://localhost:8545');


 currenturl = "";

function getimageurl(){
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

  const address =  "0x7561bef49d1f88b7885f7127649ca0af3f5bbba0";
  const options = [{}];

  const contract = new web3.eth.Contract(abi, address, options);   // options = {from: account, value: 100000 }

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

        $('.img').attr('src', url).on('load', function(){
          //this.width;   // Note: $(this).width() will not work for in memory images
      
      });
    //  $('<img />').attr('src',url).appendTo('body').hide();
 
}

function formaturl(url){
  
  url = url.substring(53)
  
  url = "https://storageapi2.fleek.co/6c5d9a4e-b682-471b-8f88-c350d01587e3-bucket/thedress" + url;

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