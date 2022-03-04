<form action="DownloadServlet" method="get" name="razorpayForm">   
    <input  type="hidden" name="fileName" value="<%= b.getFilePath() %>" />
</form>

<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
                            <script>
                            var options = {
                                "key": "<%= b.getNoteRazor() %>", // Enter the Key ID generated from the Dashboard
                                "amount": "<%= b.getNotePrice()*100 %>", // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise
                                "currency": "INR",
                                "name": "To <%= b.getUserName() %>",
                                "description": "Payment for <%= b.getNoteTitle() %> notes",
                                "image": "https://static.startuptalky.com/2020/03/razorpay-logo.png",
                                "handler": function (response){
                                    console.log(response);
                                    document.razorpayForm.submit();
                                    
                                },
                                        
                                "theme": {
                                    "color": "#6B9B8A"
                                }
                            };
                            var rzp1 = new Razorpay(options);
                            rzp1.on('payment.failed', function (response){
                                    alert(response.error.code);
                                    alert(response.error.description);
                                    alert(response.error.source);
                                    alert(response.error.step);
                                    alert(response.error.reason);
                                    alert(response.error.metadata.order_id);
                                    alert(response.error.metadata.payment_id);
                            });
                            document.getElementById('rzp-button1').onclick = function(e){
                                rzp1.open();
                                e.preventDefault();
                            }
                            

                            </script>
