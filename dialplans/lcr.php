<?php

class dialplan_lcr {

    function main(&$obj) {
        $obj -> xmlw -> startElement('section');
        $obj -> xmlw -> writeAttribute('name', 'dialplan');
        $obj -> xmlw -> writeAttribute('description', 'FreeSWITCH Dialplan');
        $obj -> xmlw -> startElement('context');
        $obj -> xmlw -> writeAttribute('name', 'lcr');
        $obj -> xmlw -> startElement('extension');
        $obj -> xmlw -> startElement('condition');
        $applications = $this -> lcr_lookup($obj);
        $app_count = count($applications);
        
        $sets = array(
        'hangup_after_bridge'=>'true', 
        'continue_on_failure'=>'true'
        );
        foreach ($sets as $var=>$val) {
            $this -> xmlw -> startElement('action');
            $this -> xmlw -> writeAttribute('application', 'set');
            $this -> xmlw -> writeAttribute('data', "$var=$val");
            $this -> xmlw -> endElement();
        }
        for ($i=0; $i<$app_count; $i++) {
            $obj -> xmlw -> startElement($applications[$i]['type']);
            $obj -> xmlw -> writeAttribute('application', 'bridge');
            $obj -> xmlw -> writeAttribute('data', $applications[$i]['data']);
            $obj -> xmlw -> endElement();
        }
        $obj -> xmlw -> endElement(); //</condition>
        $obj -> xmlw -> endElement(); //</extension>
        $obj -> xmlw -> endElement(); //</context>
        $obj -> xmlw -> endElement(); //</section>

    }

    function lcr_lookup(&$obj) {
        $obj -> comment_array($obj -> request);
        $digitstr = $obj -> request['destination_number'];
        $digitlen = strlen($digitstr);
        $where_clause = '';
        for ($i=0; $i<$digitlen; $i++) {
            $where_clause .= sprintf("%s digits='%s' "
            , ($i==0?"WHERE":"OR")
            , substr($digitstr, 0, $i+1)
            );
        }
        $query = sprintf("SELECT l.digits, c.Carrier_Name, l.rate, cg.id, cg.gateway, cg.id AS gwid, l.lead_strip, l.trail_strip, l.prefix, l.suffix FROM lcr l JOIN carriers c ON l.carrier_id=c.id JOIN carrier_gateway cg ON c.id=cg.carrier_id %s ORDER BY length(digits) DESC, rate;", $where_clause);
        $res = $obj -> db -> query($query);
        $obj -> comment($query);
        if (FS_PDO::isError($res)) {
            $obj -> comment($query);
            $obj -> comment($this -> db  -> getMessage());
            $obj -> file_not_found();
        }
        $carriers = array();
        while ($row = $res -> fetchRow()) {
            $carrier_id = $row['gwid'];
            if (array_key_exists($carrier_id, $carriers)) {
                continue;
            }
            $carriers[$carrier_id] = true;
            $datastr = sprintf('sofia/gateway/%s/%s', $row['gateway'], $digitstr);
            $results[] = array('type'=>'action', 'data'=>$datastr);
        }
        return $results;
    }
}


?>
