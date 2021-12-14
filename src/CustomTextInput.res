@send external focus: Dom.element => unit = "focus"

@react.component
let make = () => {
  let textInput = React.useRef(Js.Nullable.null)
  let setTextInputRef = element => {
    textInput.current = element;
  }

  let focusTextInput = _ => {
    textInput.current
    ->Js.Nullable.toOption
    ->Belt.Option.forEach(input => input->focus)
  }

  <div>
    <input type_="text" ref={ReactDOM.Ref.callbackDomRef(setTextInputRef)} />
    <input
      type_="button" value="Focus the text input" onClick={focusTextInput}
    />
  </div>
}