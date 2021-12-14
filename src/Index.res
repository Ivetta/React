switch ReactDOM.querySelector("#root") {
  | Some(el) => ReactDOM.render(<App />, el)
  | None => failwith("DOM node `#root` not found")
}

// ReactDOM.querySelector("#root")
//   -> Belt.Option.map((el) => ReactDOM.render(<App />, el));

// let wrapChildren = (children: React.element) => {
//   <div>
//     <h1> {React.string("Overview")} </h1>
//     children
//   </div>
// }

// wrapChildren(<div> {React.string("Let's use React with ReScript")} </div>);
