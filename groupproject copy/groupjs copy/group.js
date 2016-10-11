function mytimer() {
  mydate = new Date();
  var x = mydate.getMonth();
  x += 1;
  var d = mydate.getDate();
  var dd = mydate.getDay();
  switch (dd) {
    case 1:
      dd = "ㄧ";
      break;
    case 2:
      dd = "二";
      break;
    case 3:
      dd = "三";
      break;
    case 4:
      dd = "四";
      break;
    case 5:
      dd = "五";
      break;
    case 6:
      dd = "六";
      break;
    case 7:
      dd = "日";
      break;
  }
  var h = mydate.getHours();
  if (h < 10) {
    h = "0" + h;
  }
  var m = mydate.getMinutes();
  if (m < 10) {
    m = "0" + m;
  }
  var s = mydate.getSeconds();
  if (s < 10) {
    s = "0" + s;
  }
  var ms = mydate.getMilliseconds();
  var now = h + ":" + m + ":" + s;
  document.getElementById("time").innerHTML = x + '月' + d + '日&nbsp星期' + dd + '<br>' + '現在時刻&nbsp:&nbsp' + now;
  setTimeout("mytimer()", 1000);
}
mytimer();