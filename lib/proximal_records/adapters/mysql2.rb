module ProximalRecords
  module Adapters
    module Mysql2
      def proximal_records(scope)
        klass = self.class

        z = klass.select("#{klass.table_name}.*, IF(rownum < @num, 'previous', 'next') AS direction, rownum").arel
        t = klass.select("z.*, @rownum := @rownum + 1 AS rownum, CASE WHEN z.id = #{id} THEN @num := @rownum END").arel

        t.join(Arel.sql('JOIN (SELECT @rownum := 0, @num := NULL) n'))

        t.from("(#{scope.to_sql}) z")
        z.from("(#{t.to_sql}) #{klass.table_name}")

        sql = z.where(Arel.sql('rownum > @num - 2 AND rownum < @num + 2 AND rownum <> @num')).to_sql

        items = klass.find_by_sql(sql)

        if items[0]
          if items[0].direction == 'previous'
            [items[0], items[1]]
          else
            [nil, items[0]]
          end
        else
          [nil, nil]
        end
      end
    end
  end
end