//환불포함보기, 환불제외보기 스크립트
$(document).ready(function() {
    $('input[name="filter"]').change(function() {
        const value = $(this).val();
        if (value === "all") {
            $('.box').show();
        } else if (value === "notRefunded") {
            $('.box').each(function() {
                const paymentStatus = $(this).find('span[style="color: blue;"], span[style="color: red;"]').text().trim();
                if (paymentStatus === "환불완료") {
                    $(this).hide();
                } else {
                    $(this).show();
                }
            });
        }
    });
});