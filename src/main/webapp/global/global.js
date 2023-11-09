function getMain(){
  window.location.href = '/'
  }


  function getTokenAndCheckExpiration(){
    const accessToken = localStorage.getItem('accessToken');
    console.log(accessToken);
    const expirationTime = localStorage.getItem('accessTokenExpiration');

    if(accessToken!=null && expirationTime!=null && new Date().getTime() > expirationTime){
    localStorage.removeItem('accessToken');
    localStorage.removeItem('accessTokenExpiration');
    alert('세션이 만료되었습니다.');
    }
    return accessToken;
  }