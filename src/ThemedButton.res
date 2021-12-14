module ThemeContext = {
  type theme = Light | Dark;
  let context = React.createContext(Light)

  module Provider = {
    let provider = React.Context.provider(context)

    @react.component
    let make = (~value, ~children) => {
      React.createElement(provider, {"value": value, "children": children})
    }
  }
}

module Button = {
  @react.component
  let make = (~theme) => {
    let className = switch theme {
      | ThemeContext.Light => "theme-light"
      | ThemeContext.Dark => "theme-black"
    };
    <button className> {React.string("Click me")} </button>
  }
}

module ThemedButton = {
  @react.component
  let make = () => {
    let theme = React.useContext(ThemeContext.context)

    <Button theme/>
  }
}

module Toolbar = {
  @react.component
  let make = () => {
    <div> <ThemedButton /> </div>
  }
}

@react.component
let make = () => {
  <ThemeContext.Provider value=ThemeContext.Dark>
    <div> <Toolbar /> </div>
  </ThemeContext.Provider>
}
