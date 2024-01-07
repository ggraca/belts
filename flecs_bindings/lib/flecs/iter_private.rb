module Flecs
  class IterPrivate < FFI::Struct
    class StackCursor < FFI::Struct
      layout(
        prev: StackCursor.by_ref,
        page: :pointer,
        sp: :int16,
        is_free: :bool,
      )
    end

    class IterCache < FFI::Struct
      layout(
        stack_cursor: StackCursor.by_ref,
        used: :ecs_flags8_t,
        allocated: :ecs_flags8_t,
      )
    end

    class IterUnion < FFI::Union
      layout(
        term: TermIter.by_value,
        filter: FilterIter.by_value,
        query: QueryIter.by_value,
        rule: RuleIter.by_value,
        snapshot: SnapshotIter.by_value,
        page: PageIter.by_value,
        worker: WorkerIter.by_value,
      )
    end

    layout(
      iter: IterUnion.by_value,
      entity_iter: :pointer
      cache: IterCache.by_value,
    )
  end
end
