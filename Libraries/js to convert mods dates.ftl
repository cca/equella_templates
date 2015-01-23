<script type="text/javascript">
//JAVASCRIPT TO CONVERT MODS DATES
var dd = document.getElementsByTagName("dd"); //find all dd
for (var i=0; i < dd.length; i++) //loop through all dd
{
    if (dd[i].className=="date") {
     var dates = dd[i].innerHTML;
            if (dates != null){

                dates = dates.split(": ", 2);
                dates[1] = dates[1].replace(/\D/g,'');
                var year = dates[1].substr(0,4); //grab the year
                var month = dates[1].substr(4,2);  //grab the month
                var day = dates[1].substr(6,2);  //grab the day

                // convert the month from number to word
                if (month == 1){
                month = "January";
                } else if (month == 2){
                month = "February";
                } else if (month == 3){
                month = "March";
                } else if (month == 4){
                month = "April";
                } else if (month == 5){
                month = "May";
                } else if (month == 6){
                month = "June";
                } else if (month == 7){
                month = "July";
                } else if (month == 8){
                month = "August";
                } else if (month == 9){
                month = "September";
                } else if (month == 10){
                month = "October";
                } else if (month == 11){
                month = "November";
                } else if (month == 12){
                month = "December";
                }

                // parse different displays depending on which variables are present
                var newdate;
                if (month != "" && month!=null){
                newdate = month + " ";
                }
                if (day != "" && day!=null){
                newdate+=day + ", ";
                }
                if (year != "" && year!=null){
                newdate+=year;
                }
                if (month!=""&&month!=null){
                dd[i].innerHTML= dates[0] + ": " + newdate;
                }
                newdate="";

            }

    }

}
</script>
