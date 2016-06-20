	constructor(){

	}

	render() {
		return(
			React.createElement("div", null, 
				React.createElement("h1", null, "Count"), 
				React.createElement("h3", null, this.state.count)
			)
		)}

}

React.render(
	React.createElement(Count, null),
	document.getElementById("content")
);