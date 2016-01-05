# MemoizedSelector
Memoized selector on Swift for Redux(e.g.: [ReduxKit](https://github.com/ReduxKit/ReduxKit)).
Inspired by [rackt/reselect](https://github.com/rackt/reselect).

## Installation

Add to Cartfile:

```
github "oreshinya/MemoizedSelector"
```

## Usage(example)

```swift
import ReactiveKit
import MemoizedSelector

class TodosViewModel {
    
    // [String:TodoEntity], its key is entity id, and its value is entity.
    private let todosSelector = MemoizedSelector<[String:TodoEntity],[TodoEntity]>(
        checkChanged: { $0 == $1 },
        selector: {$0.values.sort({$0.createdAt > $1.createdAt})}
    )
    
    let todos: ObservableCollection<[TodoEntity]>
    
    init() {
        let todoArray = todosSelector.exec(store.getState().todos)
        self.todos = ObservableCollection(todoArray)
        store.subscribe { [unowned self] state in
            let todoArray = self.todosSelector.exec(state.todos)
            self.todos.replace(todoArray)
        }
    }

}
```

## License
MIT
