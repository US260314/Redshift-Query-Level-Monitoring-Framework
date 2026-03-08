SELECT
    convert_timezone('UTC', 'US/Eastern', swqs.wlm_start_time) AS start_us_east,
    swqs.state,
    (swqs.queue_time::numeric(18,0) / 1000000.00) AS wait_secs,
    ((swqs.queue_time::numeric(18,0) / 1000000.00) / 60.00) AS wait_mins,
    (swqs.exec_time::numeric(18,0) / 1000000.00) AS exec_secs,
    ((swqs.exec_time::numeric(18,0) / 1000000.00) / 60.00) AS exec_mins,
    si.userid,
    pu.usename,
    cc.name AS service_class_name,
    swqs.query_priority AS priority,
    swqs.slot_count,
    si.pid
FROM stv_wlm_query_state swqs
LEFT JOIN stv_inflight si
    ON swqs.query = si.query
LEFT JOIN pg_user pu
    ON si.userid = pu.usesysid
LEFT JOIN stv_wlm_service_class_config cc
    ON swqs.service_class = cc.service_class;