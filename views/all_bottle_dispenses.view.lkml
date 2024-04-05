view: all_bottle_dispenses {
  derived_table: {
    sql:
      SELECT

        bottle_dispenses.created_at AS `created`,
        users.gender as `gender`,
        COUNT(bottle_dispenses.id) AS `count_orders`
      FROM demo_db.orders AS bottle_dispenses
      LEFT JOIN demo_db.users AS users
      ON bottle_dispenses.user_id = users.id
      WHERE {% incrementcondition %} bottle_dispenses.created_at {% endincrementcondition %}
      GROUP BY  bottle_dispenses.created_at,
        users.gender;;

    datagroup_trigger: 15minute_all_bottle_dispenses

    indexes: ["id", "created_at"]

      increment_key: "created_minute15"
      increment_offset: 4
      }
      }
