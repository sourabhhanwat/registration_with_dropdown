<?php
    include "conn.php";

    $q = $connect->query(" select DISTINCT service_type from serviceprovider");
    $result = array();

    while($fetchData = $q->fetch_assoc()){
        $result[] = $fetchData;
    }
    echo json_encode($result);
?>
