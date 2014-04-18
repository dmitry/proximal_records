module ProximalRecords
  module Adapters
    module Postgresql
      def proximal_records(scope)
        klass = self.class

        orders = scope.orders.join(', ')

        orders = "OVER(#{"ORDER BY #{orders}" if orders.present?})"
        primary_key = "#{klass.table_name}.#{klass.primary_key}"
        with_near_by = scope.select("#{klass.table_name}.*, LAG(#{primary_key}) #{orders} AS previous_id, LEAD(#{primary_key}) #{orders} AS next_id")

        table = with_near_by.arel
        as = table.as(Arel.sql('z'))
        a = klass.select('z.*').from(as.to_sql).where(z: {klass.primary_key => id}).limit(1)[0]

        [(klass.find_by_id(a.previous_id)), (klass.find_by_id(a.next_id))]
      end
    end
  end
end