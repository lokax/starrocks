[sql]
select
    ps_partkey,
    sum(ps_supplycost * ps_availqty) as value
from
    partsupp,
    supplier,
    nation
where
    ps_suppkey = s_suppkey
  and s_nationkey = n_nationkey
  and n_name = 'PERU'
group by
    ps_partkey having
    sum(ps_supplycost * ps_availqty) > (
    select
    sum(ps_supplycost * ps_availqty) * 0.0001000000
    from
    partsupp,
    supplier,
    nation
    where
    ps_suppkey = s_suppkey
                  and s_nationkey = n_nationkey
                  and n_name = 'PERU'
    )
order by
    value desc ;
[plan-1]
TOP-N (order by [[21: sum DESC NULLS LAST]])
    TOP-N (order by [[21: sum DESC NULLS LAST]])
        CROSS JOIN (join-predicate [null] post-join-predicate [21: sum > 43: expr])
            AGGREGATE ([GLOBAL] aggregate [{21: sum=sum(20: expr)}] group by [[1: PS_PARTKEY]] having [null]
                INNER JOIN (join-predicate [2: PS_SUPPKEY = 7: S_SUPPKEY AND 15: N_NATIONKEY = 10: S_NATIONKEY] post-join-predicate [null])
                    CROSS JOIN (join-predicate [null] post-join-predicate [null])
                        SCAN (columns[1: PS_PARTKEY, 2: PS_SUPPKEY, 3: PS_AVAILQTY, 4: PS_SUPPLYCOST] predicate[null])
                        EXCHANGE BROADCAST
                            SCAN (columns[15: N_NATIONKEY, 16: N_NAME] predicate[16: N_NAME = PERU])
                    EXCHANGE BROADCAST
                        SCAN (columns[7: S_SUPPKEY, 10: S_NATIONKEY] predicate[null])
            EXCHANGE BROADCAST
                AGGREGATE ([GLOBAL] aggregate [{42: sum=sum(41: expr)}] group by [[]] having [null]
                    EXCHANGE GATHER
                        INNER JOIN (join-predicate [23: PS_SUPPKEY = 28: S_SUPPKEY AND 36: N_NATIONKEY = 31: S_NATIONKEY] post-join-predicate [null])
                            CROSS JOIN (join-predicate [null] post-join-predicate [null])
                                SCAN (columns[23: PS_SUPPKEY, 24: PS_AVAILQTY, 25: PS_SUPPLYCOST] predicate[null])
                                EXCHANGE BROADCAST
                                    SCAN (columns[36: N_NATIONKEY, 37: N_NAME] predicate[37: N_NAME = PERU])
                            EXCHANGE BROADCAST
                                SCAN (columns[28: S_SUPPKEY, 31: S_NATIONKEY] predicate[null])
[end]
[plan-2]
TOP-N (order by [[21: sum DESC NULLS LAST]])
    TOP-N (order by [[21: sum DESC NULLS LAST]])
        CROSS JOIN (join-predicate [null] post-join-predicate [21: sum > 43: expr])
            AGGREGATE ([GLOBAL] aggregate [{21: sum=sum(20: expr)}] group by [[1: PS_PARTKEY]] having [null]
                INNER JOIN (join-predicate [2: PS_SUPPKEY = 7: S_SUPPKEY] post-join-predicate [null])
                    SCAN (columns[1: PS_PARTKEY, 2: PS_SUPPKEY, 3: PS_AVAILQTY, 4: PS_SUPPLYCOST] predicate[null])
                    EXCHANGE BROADCAST
                        INNER JOIN (join-predicate [10: S_NATIONKEY = 15: N_NATIONKEY] post-join-predicate [null])
                            SCAN (columns[7: S_SUPPKEY, 10: S_NATIONKEY] predicate[null])
                            EXCHANGE BROADCAST
                                SCAN (columns[15: N_NATIONKEY, 16: N_NAME] predicate[16: N_NAME = PERU])
            EXCHANGE BROADCAST
                AGGREGATE ([GLOBAL] aggregate [{42: sum=sum(41: expr)}] group by [[]] having [null]
                    EXCHANGE GATHER
                        INNER JOIN (join-predicate [23: PS_SUPPKEY = 28: S_SUPPKEY AND 36: N_NATIONKEY = 31: S_NATIONKEY] post-join-predicate [null])
                            CROSS JOIN (join-predicate [null] post-join-predicate [null])
                                SCAN (columns[23: PS_SUPPKEY, 24: PS_AVAILQTY, 25: PS_SUPPLYCOST] predicate[null])
                                EXCHANGE BROADCAST
                                    SCAN (columns[36: N_NATIONKEY, 37: N_NAME] predicate[37: N_NAME = PERU])
                            EXCHANGE BROADCAST
                                SCAN (columns[28: S_SUPPKEY, 31: S_NATIONKEY] predicate[null])
[end]
[plan-3]
TOP-N (order by [[21: sum DESC NULLS LAST]])
    TOP-N (order by [[21: sum DESC NULLS LAST]])
        CROSS JOIN (join-predicate [null] post-join-predicate [21: sum > 43: expr])
            AGGREGATE ([GLOBAL] aggregate [{21: sum=sum(20: expr)}] group by [[1: PS_PARTKEY]] having [null]
                INNER JOIN (join-predicate [2: PS_SUPPKEY = 7: S_SUPPKEY AND 15: N_NATIONKEY = 10: S_NATIONKEY] post-join-predicate [null])
                    CROSS JOIN (join-predicate [null] post-join-predicate [null])
                        SCAN (columns[1: PS_PARTKEY, 2: PS_SUPPKEY, 3: PS_AVAILQTY, 4: PS_SUPPLYCOST] predicate[null])
                        EXCHANGE BROADCAST
                            SCAN (columns[15: N_NATIONKEY, 16: N_NAME] predicate[16: N_NAME = PERU])
                    EXCHANGE BROADCAST
                        SCAN (columns[7: S_SUPPKEY, 10: S_NATIONKEY] predicate[null])
            EXCHANGE BROADCAST
                AGGREGATE ([GLOBAL] aggregate [{42: sum=sum(41: expr)}] group by [[]] having [null]
                    EXCHANGE GATHER
                        INNER JOIN (join-predicate [23: PS_SUPPKEY = 28: S_SUPPKEY] post-join-predicate [null])
                            SCAN (columns[23: PS_SUPPKEY, 24: PS_AVAILQTY, 25: PS_SUPPLYCOST] predicate[null])
                            EXCHANGE BROADCAST
                                INNER JOIN (join-predicate [31: S_NATIONKEY = 36: N_NATIONKEY] post-join-predicate [null])
                                    SCAN (columns[28: S_SUPPKEY, 31: S_NATIONKEY] predicate[null])
                                    EXCHANGE BROADCAST
                                        SCAN (columns[36: N_NATIONKEY, 37: N_NAME] predicate[37: N_NAME = PERU])
[end]
[plan-4]
TOP-N (order by [[21: sum DESC NULLS LAST]])
    TOP-N (order by [[21: sum DESC NULLS LAST]])
        CROSS JOIN (join-predicate [null] post-join-predicate [21: sum > 43: expr])
            AGGREGATE ([GLOBAL] aggregate [{21: sum=sum(20: expr)}] group by [[1: PS_PARTKEY]] having [null]
                INNER JOIN (join-predicate [2: PS_SUPPKEY = 7: S_SUPPKEY] post-join-predicate [null])
                    SCAN (columns[1: PS_PARTKEY, 2: PS_SUPPKEY, 3: PS_AVAILQTY, 4: PS_SUPPLYCOST] predicate[null])
                    EXCHANGE BROADCAST
                        INNER JOIN (join-predicate [10: S_NATIONKEY = 15: N_NATIONKEY] post-join-predicate [null])
                            SCAN (columns[7: S_SUPPKEY, 10: S_NATIONKEY] predicate[null])
                            EXCHANGE BROADCAST
                                SCAN (columns[15: N_NATIONKEY, 16: N_NAME] predicate[16: N_NAME = PERU])
            EXCHANGE BROADCAST
                AGGREGATE ([GLOBAL] aggregate [{42: sum=sum(41: expr)}] group by [[]] having [null]
                    EXCHANGE GATHER
                        INNER JOIN (join-predicate [23: PS_SUPPKEY = 28: S_SUPPKEY] post-join-predicate [null])
                            SCAN (columns[23: PS_SUPPKEY, 24: PS_AVAILQTY, 25: PS_SUPPLYCOST] predicate[null])
                            EXCHANGE BROADCAST
                                INNER JOIN (join-predicate [31: S_NATIONKEY = 36: N_NATIONKEY] post-join-predicate [null])
                                    SCAN (columns[28: S_SUPPKEY, 31: S_NATIONKEY] predicate[null])
                                    EXCHANGE BROADCAST
                                        SCAN (columns[36: N_NATIONKEY, 37: N_NAME] predicate[37: N_NAME = PERU])
[end]
[plan-5]
TOP-N (order by [[21: sum DESC NULLS LAST]])
    TOP-N (order by [[21: sum DESC NULLS LAST]])
        CROSS JOIN (join-predicate [null] post-join-predicate [21: sum > 43: expr])
            AGGREGATE ([GLOBAL] aggregate [{21: sum=sum(20: expr)}] group by [[1: PS_PARTKEY]] having [null]
                INNER JOIN (join-predicate [2: PS_SUPPKEY = 7: S_SUPPKEY AND 15: N_NATIONKEY = 10: S_NATIONKEY] post-join-predicate [null])
                    CROSS JOIN (join-predicate [null] post-join-predicate [null])
                        SCAN (columns[1: PS_PARTKEY, 2: PS_SUPPKEY, 3: PS_AVAILQTY, 4: PS_SUPPLYCOST] predicate[null])
                        EXCHANGE BROADCAST
                            SCAN (columns[15: N_NATIONKEY, 16: N_NAME] predicate[16: N_NAME = PERU])
                    EXCHANGE BROADCAST
                        SCAN (columns[7: S_SUPPKEY, 10: S_NATIONKEY] predicate[null])
            EXCHANGE BROADCAST
                AGGREGATE ([GLOBAL] aggregate [{42: sum=sum(42: sum)}] group by [[]] having [null]
                    EXCHANGE GATHER
                        AGGREGATE ([LOCAL] aggregate [{42: sum=sum(41: expr)}] group by [[]] having [null]
                            INNER JOIN (join-predicate [23: PS_SUPPKEY = 28: S_SUPPKEY AND 36: N_NATIONKEY = 31: S_NATIONKEY] post-join-predicate [null])
                                CROSS JOIN (join-predicate [null] post-join-predicate [null])
                                    SCAN (columns[23: PS_SUPPKEY, 24: PS_AVAILQTY, 25: PS_SUPPLYCOST] predicate[null])
                                    EXCHANGE BROADCAST
                                        SCAN (columns[36: N_NATIONKEY, 37: N_NAME] predicate[37: N_NAME = PERU])
                                EXCHANGE BROADCAST
                                    SCAN (columns[28: S_SUPPKEY, 31: S_NATIONKEY] predicate[null])
[end]
[plan-6]
TOP-N (order by [[21: sum DESC NULLS LAST]])
    TOP-N (order by [[21: sum DESC NULLS LAST]])
        CROSS JOIN (join-predicate [null] post-join-predicate [21: sum > 43: expr])
            AGGREGATE ([GLOBAL] aggregate [{21: sum=sum(20: expr)}] group by [[1: PS_PARTKEY]] having [null]
                INNER JOIN (join-predicate [2: PS_SUPPKEY = 7: S_SUPPKEY] post-join-predicate [null])
                    SCAN (columns[1: PS_PARTKEY, 2: PS_SUPPKEY, 3: PS_AVAILQTY, 4: PS_SUPPLYCOST] predicate[null])
                    EXCHANGE BROADCAST
                        INNER JOIN (join-predicate [10: S_NATIONKEY = 15: N_NATIONKEY] post-join-predicate [null])
                            SCAN (columns[7: S_SUPPKEY, 10: S_NATIONKEY] predicate[null])
                            EXCHANGE BROADCAST
                                SCAN (columns[15: N_NATIONKEY, 16: N_NAME] predicate[16: N_NAME = PERU])
            EXCHANGE BROADCAST
                AGGREGATE ([GLOBAL] aggregate [{42: sum=sum(42: sum)}] group by [[]] having [null]
                    EXCHANGE GATHER
                        AGGREGATE ([LOCAL] aggregate [{42: sum=sum(41: expr)}] group by [[]] having [null]
                            INNER JOIN (join-predicate [23: PS_SUPPKEY = 28: S_SUPPKEY AND 36: N_NATIONKEY = 31: S_NATIONKEY] post-join-predicate [null])
                                CROSS JOIN (join-predicate [null] post-join-predicate [null])
                                    SCAN (columns[23: PS_SUPPKEY, 24: PS_AVAILQTY, 25: PS_SUPPLYCOST] predicate[null])
                                    EXCHANGE BROADCAST
                                        SCAN (columns[36: N_NATIONKEY, 37: N_NAME] predicate[37: N_NAME = PERU])
                                EXCHANGE BROADCAST
                                    SCAN (columns[28: S_SUPPKEY, 31: S_NATIONKEY] predicate[null])
[end]
[plan-7]
TOP-N (order by [[21: sum DESC NULLS LAST]])
    TOP-N (order by [[21: sum DESC NULLS LAST]])
        CROSS JOIN (join-predicate [null] post-join-predicate [21: sum > 43: expr])
            AGGREGATE ([GLOBAL] aggregate [{21: sum=sum(20: expr)}] group by [[1: PS_PARTKEY]] having [null]
                INNER JOIN (join-predicate [2: PS_SUPPKEY = 7: S_SUPPKEY AND 15: N_NATIONKEY = 10: S_NATIONKEY] post-join-predicate [null])
                    CROSS JOIN (join-predicate [null] post-join-predicate [null])
                        SCAN (columns[1: PS_PARTKEY, 2: PS_SUPPKEY, 3: PS_AVAILQTY, 4: PS_SUPPLYCOST] predicate[null])
                        EXCHANGE BROADCAST
                            SCAN (columns[15: N_NATIONKEY, 16: N_NAME] predicate[16: N_NAME = PERU])
                    EXCHANGE BROADCAST
                        SCAN (columns[7: S_SUPPKEY, 10: S_NATIONKEY] predicate[null])
            EXCHANGE BROADCAST
                AGGREGATE ([GLOBAL] aggregate [{42: sum=sum(42: sum)}] group by [[]] having [null]
                    EXCHANGE GATHER
                        AGGREGATE ([LOCAL] aggregate [{42: sum=sum(41: expr)}] group by [[]] having [null]
                            INNER JOIN (join-predicate [23: PS_SUPPKEY = 28: S_SUPPKEY] post-join-predicate [null])
                                SCAN (columns[23: PS_SUPPKEY, 24: PS_AVAILQTY, 25: PS_SUPPLYCOST] predicate[null])
                                EXCHANGE BROADCAST
                                    INNER JOIN (join-predicate [31: S_NATIONKEY = 36: N_NATIONKEY] post-join-predicate [null])
                                        SCAN (columns[28: S_SUPPKEY, 31: S_NATIONKEY] predicate[null])
                                        EXCHANGE BROADCAST
                                            SCAN (columns[36: N_NATIONKEY, 37: N_NAME] predicate[37: N_NAME = PERU])
[end]
[plan-8]
TOP-N (order by [[21: sum DESC NULLS LAST]])
    TOP-N (order by [[21: sum DESC NULLS LAST]])
        CROSS JOIN (join-predicate [null] post-join-predicate [21: sum > 43: expr])
            AGGREGATE ([GLOBAL] aggregate [{21: sum=sum(20: expr)}] group by [[1: PS_PARTKEY]] having [null]
                INNER JOIN (join-predicate [2: PS_SUPPKEY = 7: S_SUPPKEY] post-join-predicate [null])
                    SCAN (columns[1: PS_PARTKEY, 2: PS_SUPPKEY, 3: PS_AVAILQTY, 4: PS_SUPPLYCOST] predicate[null])
                    EXCHANGE BROADCAST
                        INNER JOIN (join-predicate [10: S_NATIONKEY = 15: N_NATIONKEY] post-join-predicate [null])
                            SCAN (columns[7: S_SUPPKEY, 10: S_NATIONKEY] predicate[null])
                            EXCHANGE BROADCAST
                                SCAN (columns[15: N_NATIONKEY, 16: N_NAME] predicate[16: N_NAME = PERU])
            EXCHANGE BROADCAST
                AGGREGATE ([GLOBAL] aggregate [{42: sum=sum(42: sum)}] group by [[]] having [null]
                    EXCHANGE GATHER
                        AGGREGATE ([LOCAL] aggregate [{42: sum=sum(41: expr)}] group by [[]] having [null]
                            INNER JOIN (join-predicate [23: PS_SUPPKEY = 28: S_SUPPKEY] post-join-predicate [null])
                                SCAN (columns[23: PS_SUPPKEY, 24: PS_AVAILQTY, 25: PS_SUPPLYCOST] predicate[null])
                                EXCHANGE BROADCAST
                                    INNER JOIN (join-predicate [31: S_NATIONKEY = 36: N_NATIONKEY] post-join-predicate [null])
                                        SCAN (columns[28: S_SUPPKEY, 31: S_NATIONKEY] predicate[null])
                                        EXCHANGE BROADCAST
                                            SCAN (columns[36: N_NATIONKEY, 37: N_NAME] predicate[37: N_NAME = PERU])
[end]