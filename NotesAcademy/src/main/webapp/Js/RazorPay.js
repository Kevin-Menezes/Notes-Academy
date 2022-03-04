function razorPopup(price,razorid,filepath,uname,ntitle,curruname,curruemail)
{
    console.log(filepath);
    var filename = filepath.slice(0, 13) + "\\" + filepath.slice(13);
    console.log(filename);
    
//    // Start by creating an empty `<script />` tag element
//    var scriptTag = document.createElement("script");
//
//    // Set the src attribute, note it won't start loading yet.
//    scriptTag.src = "ttps://checkout.razorpay.com/v1/checkout.js";
//
//    // In order for it to become part of the page, you need to attach it
//    // to the DOM, to keep things clean, we will append it to the page's
//    // <head /> tag.
//    document.head.appendChild(scriptTag);

    var options = {
                                "key": razorid, // Enter the Key ID generated from the Dashboard
                                "amount": price*100, // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise
                                "currency": "INR",
                                "name": "To "+uname,
                                "description": "Payment for "+ntitle+" notes",
                                "image": "https://static.startuptalky.com/2020/03/razorpay-logo.png",
                                "handler": function (response){
                                    console.log(response);
//                                    document.razorpayForm.submit();
                                    location.replace("DownloadServlet?fileName="+filename);
                                },
                                
                                "prefill": {
                                    "name": curruname,
                                    "email": curruemail
                                },

                                "theme": {
                                    "color": "#6B9B8A"
                                }
                            };
                            var rzp1 = new Razorpay(options);
                            rzp1.open();
                            rzp1.on('payment.failed', function (response){
                                    alert(response.error.code);
                                    alert(response.error.description);
                                    alert(response.error.source);
                                    alert(response.error.step);
                                    alert(response.error.reason);
                                    alert(response.error.metadata.order_id);
                                    alert(response.error.metadata.payment_id);
                            });

}


