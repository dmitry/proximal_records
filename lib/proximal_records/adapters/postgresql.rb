module ProximalRecords
  module Adapters
    module Postgresql
      def proximal_records(scope)
        orders = scope.orders.join(', ')

        orders = "OVER(#{"ORDER BY #{orders}" if orders.present?})"
        with_near_by = scope.select("articles.*, LAG(articles.id) #{orders} AS previous_id, LEAD(articles.id) #{orders} AS next_id")

        table = with_near_by.arel
        as = table.as(Arel.sql('articles'))
        a = self.class.from(as.to_sql).where(articles: {id: id}).limit(1)

        a = a.first
        previous_id, next_id = a.previous_id, a.next_id
        [(self.class.find_by_id(previous_id)), (self.class.find_by_id(next_id))]
      end
    end
  end
end