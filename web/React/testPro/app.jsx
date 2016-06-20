
/**
 * e.g 1. 理解虚拟 DOM
 */
class Count extends React.Component {
	constructor() {
		this.state = {count: 0}
	}

	update() {
		this.setState({
			count: ++this.state.count
		})
	}

	render() {
		return(
			<div className="comment">
				<h1>Count</h1>
				<h3>{this.state.count}</h3>
			</div>
		)}

}

/**
 * e.g 2. 组件嵌套(可复用的组件) & 属性
 */
class Comment extends React.Component {
	render() {
		return(
			// 所有组件都必须位于一个唯一的父组件中
			<div>
				<div className="commnet-body">
					{this.props.children}
				</div>
				<div className="comment-author">
					- {this.props.author}
				</div>
			</div>
		)
	}
}



class CommentList extends React.Component {
	render() {
		// console.log(this.props.comments)
		var commentNode = this.props.comments.map(function(comment,index){
			// 在迭代时需要指明唯一的 key
			return <Comment key={"comment" + index} author={comment.author} >
						{comment.body}
					</Comment>
		})

		return(
			<div className="comment-list">
				{commentNode}
				{/*
				<Comment author="ason">
					This is my comment.
				</Comment>
				<Comment author="jef">
					This is my comment.
				</Comment>
				<Comment author="pifoo">
					This is my comment.
				</Comment>
				*/}
			</div>
		)

	}
}
class CommentForm extends React.Component {

	handleSubmit(e){
		e.preventDefault();
		console.log(this, e);

		const author = this.refs.author.getDOMNode().value.trim();
		const body = this.refs.body.getDOMNode().value.trim();
		const form = this.refs.form.getDOMNode();

		console.log(author, body);

		this.props.onSubmit({author: author, body: body});
		form.reset()
	}

    render() {
	   return(
		   <form className="comment-form" ref="form"
			   onSubmit={ e => { this.handleSubmit(e) } }>
			   <input type="text" placeholder="Your name" ref="author" />
			   <input type="text" placeholder="Input your comment" ref="body" />
			   <input type="submit" value="Add commnet" />
		   </form>
	   )
   }
}
// 渲染列表
/*
var comments = [
	{author: "son", body: "this is my comment 1"},
	{author: "jet", body: "this is my comment 2"},
]
var commentList2 = [
	{author: "son", body: "this is my comment 1"},
	{author: "jaso", body: "this is my comment 3"},
]
*/


class CommentBox extends React.Component {
	constructor(props){
		super();
		// 通过控制组件State的变化来控制其DOM渲染,并且只会渲染差异值
		this.state = {
			comments: props.comments || []
		}
	}
	/**
	 * 生命周期方法
	 */
	componentWillMount(){
		console.log("在初始化渲染执行之前立刻调用一次,客户端/服务端有效.")
	}

	loadDataFromServer(){
		$.ajax({
			// url: "comments.json",
			url: this.props.url,
			dataType: "json",
			/*
			success: function(comments){
				// console.log(comments);
				// console.log(this);
				this.setState({comments: comments})
			}.bind(this)
			*/
			// 以上代码简化为以下ES6实现
			success: comments => { // 一参数可以省略（）
				this.setState({comments: comments})
			},
			error: (xhr, status, err) => {
				console.log(err.toString())
			}
		})
	}
	componentDidMount(){
		console.log("在初始化渲染执行之后立刻调用一次,客户端有效.")
		this.loadDataFromServer()
	}

	handleNewComment(comment){
		console.log(comment);

		const comments = this.state.comments;
		const newComments = comments.concat([comment])

		this.setState({comments: newComments});

		setTimeout(() => {
			$.ajax({
				url: this.props.url,
				dataType: "json",
				type: "POST",
				data: comment,
				success: comments => {
					this.setState({comments: comments})
				},
				error: (xhr, status, err) => {
					console.log(err.toString())
					this.setState({comments: comments})
				}
			})
		}, 2000)


	}

	render() {
		return(
			<div className="comment-box">
				<h1>Comments</h1>
				<CommentList comments={this.state.comments} />
				<CommentForm onSubmit={ comment =>
						this.handleNewComment(comment) } />
			</div>
		)
	}
}



/**
 * 渲染视图，并使外部可调
 */
box = React.render(
	//<Count/>,
	<CommentBox url="comments.json" />, // ajax动态获取数据，去掉 comments={comments}
	document.getElementById("content"),
	function(){
		console.log("渲染完成...");
	}
);
// box.update()
// box.setState({comments:comments})
