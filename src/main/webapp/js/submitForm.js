function submitForm(c_id) {
    var form = document.createElement("form");
    form.method = "post";
    form.action = "/rent/rentOK";

    var input = document.createElement("input");
    input.type = "hidden";
    input.name = "c_id";
    input.value = c_id;
    form.appendChild(input);

    document.body.appendChild(form);
    form.submit();
}
