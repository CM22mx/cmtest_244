view: all_bottle_dispenses {
  derived_table: {
    sql:
      SELECT
        bottle_dispenses.id AS `id`,
        bottle_dispenses.created_at AS `created`,
        users.gender as `gender`
      FROM demo_db.orders AS bottle_dispenses
      LEFT JOIN demo_db.users AS users
      ON bottle_dispenses.user_id = users.id
      WHERE {% incrementcondition %} bottle_dispenses.created_at {% endincrementcondition %};;

    datagroup_trigger: 15minute_all_bottle_dispenses

    indexes: ["id", "created"]

      increment_key: "created_week"
      increment_offset: 4
      }

  dimension: id {
    primary_key: yes
    hidden: yes
    label: "Primary Key"
    description: "Primary Key for this table"
    type: number
    value_format_name: id
    sql: ${TABLE}.id ;;
  }

      dimension: gender  {
        type: string
        sql: ${TABLE}.gender ;;

      }

      dimension_group: date {
        type: time
        timeframes: [time, date, week, month, raw]
        sql: ${TABLE}.created ;;

      }

      dimension: created_week {
        type: date_time
        sql: ${date_week} ;;
      }

      measure: quantity {
        type: count
       # drill_fields: [detail*]
      }
      }
