type action = 
  | UpdateCounter(int)
  | ResetCounter;

type state = {
  counter: int,
  likes: int
};

 @react.component
  let make = () => {
   // let (counter, setCounter) = React.useState(() => 1);

    let (state, send) = React.useReducer((prev, act) => 
      switch act {
      | UpdateCounter(count) => {...prev, counter: prev.counter + count }
      | ResetCounter => {...prev, counter: 0 }
      }, {counter: 0, likes: 0});

    // let page = switch route {
    // | "" => <MainPage />
    // | "about" => <AboutPage />
    // };

    let clicks = React.useRef(0);

    let onClick = (_) => {
      clicks.current = clicks.current + 1;
    };

 

    <>
      <div> 
        <div>{"Counter "->React.string} {state.counter->React.int}</div>
        <button onClick={(_) => send(UpdateCounter(1))}> {"Click"->React.string}</button>
        <button onClick={(_) => send(ResetCounter)}> {React.string("Reset")}</button>
      </div>

      <Button count=5><h1>{React.string("children")}</h1></Button>
      <div onClick>
        {Belt.Int.toString(clicks.current)->React.string}
        <ThemedButton />
      </div>

      <ToDoList />
     </>
  }
