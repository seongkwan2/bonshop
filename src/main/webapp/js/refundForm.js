    //환불시 인증창 띄우기
    $('form[action="/rent/refund"]').submit(function(e) {
        e.preventDefault();

        const isConfirmed = confirm("정말로 환불하시겠습니까?");
        if (isConfirmed) {
            const popupWindow = window.open("refund_Check", "Member_Check", "width=600,height=350");
            popupWindow.focus();

            const self = this;
            popupWindow.onunload = function() {
                if (popupWindow.isVerified) {
                    self.submit();
                }
            };
        }
    });
