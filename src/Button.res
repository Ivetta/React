
  @react.component
  let make = (~count: int, ~children=?) => {
    let times = switch count {
    | 1 => "once"
    | 2 => "twice"
    | n => Belt.Int.toString(n) ++ " times"
    }
    let msg = "Click me " ++ times

    <div>
      <button> {React.string(msg)} </button>
      {switch children {
      | Some(element) => element
      | None => React.string("No children provided")
      }}
    </div> 
    }
  
