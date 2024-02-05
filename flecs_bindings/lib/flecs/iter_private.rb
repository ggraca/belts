module Flecs
  class IterPrivate < FFI::Struct
    class IterUnion < FFI::Union
      layout(
        term: TermIter.by_value,
        filter: FilterIter.by_value,
        query: QueryIter.by_value,
        rule: RuleIter.by_value,
        snapshot: SnapshotIter.by_value,
        page: PageIter.by_value,
        worker: WorkerIter.by_value
      )
    end

    layout(
      iter: IterUnion.by_value,
      entity_iter: :pointer,
      cache: IterCache.by_value
    )
  end
end
