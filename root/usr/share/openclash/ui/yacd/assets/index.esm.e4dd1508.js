import{_ as at,Q as $,r as E}from"./index.171f553a.js";function U(n,t){if(n==null)return{};var r={},i=Object.keys(n),a,l;for(l=0;l<i.length;l++)a=i[l],!(t.indexOf(a)>=0)&&(r[a]=n[a]);return r}function L(){return L=Object.assign?Object.assign.bind():function(n){for(var t=1;t<arguments.length;t++){var r=arguments[t];for(var i in r)Object.prototype.hasOwnProperty.call(r,i)&&(n[i]=r[i])}return n},L.apply(this,arguments)}function ot(n,t){n.prototype=Object.create(t.prototype),n.prototype.constructor=n,at(n,t)}var q=Number.isNaN||function(t){return typeof t=="number"&&t!==t};function st(n,t){return!!(n===t||q(n)&&q(t))}function lt(n,t){if(n.length!==t.length)return!1;for(var r=0;r<n.length;r++)if(!st(n[r],t[r]))return!1;return!0}function N(n,t){t===void 0&&(t=lt);var r,i=[],a,l=!1;function c(){for(var f=[],p=0;p<arguments.length;p++)f[p]=arguments[p];return l&&r===this&&t(f,i)||(a=n.apply(this,f),l=!0,r=this,i=f),a}return c}var ct=typeof performance=="object"&&typeof performance.now=="function",H=ct?function(){return performance.now()}:function(){return Date.now()};function j(n){cancelAnimationFrame(n.id)}function ut(n,t){var r=H();function i(){H()-r>=t?n.call(null):a.id=requestAnimationFrame(i)}var a={id:requestAnimationFrame(i)};return a}var P=-1;function K(n){if(n===void 0&&(n=!1),P===-1||n){var t=document.createElement("div"),r=t.style;r.width="50px",r.height="50px",r.overflow="scroll",document.body.appendChild(t),P=t.offsetWidth-t.clientWidth,document.body.removeChild(t)}return P}var _=null;function V(n){if(n===void 0&&(n=!1),_===null||n){var t=document.createElement("div"),r=t.style;r.width="50px",r.height="50px",r.overflow="scroll",r.direction="rtl";var i=document.createElement("div"),a=i.style;return a.width="100px",a.height="100px",t.appendChild(i),document.body.appendChild(t),t.scrollLeft>0?_="positive-descending":(t.scrollLeft=1,t.scrollLeft===0?_="negative":_="positive-ascending"),document.body.removeChild(t),_}return _}var ft=150,dt=function(t,r){return t};function Q(n){var t,r=n.getItemOffset,i=n.getEstimatedTotalSize,a=n.getItemSize,l=n.getOffsetForIndexAndAlignment,c=n.getStartIndexForOffset,f=n.getStopIndexForStartIndex,p=n.initInstanceProps,z=n.shouldResetStyleCacheOnItemSizeChange,g=n.validateProps;return t=function(x){ot(M,x);function M(v){var e;return e=x.call(this,v)||this,e._instanceProps=p(e.props,$(e)),e._outerRef=void 0,e._resetIsScrollingTimeoutId=null,e.state={instance:$(e),isScrolling:!1,scrollDirection:"forward",scrollOffset:typeof e.props.initialScrollOffset=="number"?e.props.initialScrollOffset:0,scrollUpdateWasRequested:!1},e._callOnItemsRendered=void 0,e._callOnItemsRendered=N(function(o,s,u,m){return e.props.onItemsRendered({overscanStartIndex:o,overscanStopIndex:s,visibleStartIndex:u,visibleStopIndex:m})}),e._callOnScroll=void 0,e._callOnScroll=N(function(o,s,u){return e.props.onScroll({scrollDirection:o,scrollOffset:s,scrollUpdateWasRequested:u})}),e._getItemStyle=void 0,e._getItemStyle=function(o){var s=e.props,u=s.direction,m=s.itemSize,S=s.layout,d=e._getItemStyleCache(z&&m,z&&S,z&&u),h;if(d.hasOwnProperty(o))h=d[o];else{var y=r(e.props,o,e._instanceProps),O=a(e.props,o,e._instanceProps),T=u==="horizontal"||S==="horizontal",b=u==="rtl",R=T?y:0;d[o]=h={position:"absolute",left:b?void 0:R,right:b?R:void 0,top:T?0:y,height:T?"100%":O,width:T?O:"100%"}}return h},e._getItemStyleCache=void 0,e._getItemStyleCache=N(function(o,s,u){return{}}),e._onScrollHorizontal=function(o){var s=o.currentTarget,u=s.clientWidth,m=s.scrollLeft,S=s.scrollWidth;e.setState(function(d){if(d.scrollOffset===m)return null;var h=e.props.direction,y=m;if(h==="rtl")switch(V()){case"negative":y=-m;break;case"positive-descending":y=S-u-m;break}return y=Math.max(0,Math.min(y,S-u)),{isScrolling:!0,scrollDirection:d.scrollOffset<m?"forward":"backward",scrollOffset:y,scrollUpdateWasRequested:!1}},e._resetIsScrollingDebounced)},e._onScrollVertical=function(o){var s=o.currentTarget,u=s.clientHeight,m=s.scrollHeight,S=s.scrollTop;e.setState(function(d){if(d.scrollOffset===S)return null;var h=Math.max(0,Math.min(S,m-u));return{isScrolling:!0,scrollDirection:d.scrollOffset<h?"forward":"backward",scrollOffset:h,scrollUpdateWasRequested:!1}},e._resetIsScrollingDebounced)},e._outerRefSetter=function(o){var s=e.props.outerRef;e._outerRef=o,typeof s=="function"?s(o):s!=null&&typeof s=="object"&&s.hasOwnProperty("current")&&(s.current=o)},e._resetIsScrollingDebounced=function(){e._resetIsScrollingTimeoutId!==null&&j(e._resetIsScrollingTimeoutId),e._resetIsScrollingTimeoutId=ut(e._resetIsScrolling,ft)},e._resetIsScrolling=function(){e._resetIsScrollingTimeoutId=null,e.setState({isScrolling:!1},function(){e._getItemStyleCache(-1,null)})},e}M.getDerivedStateFromProps=function(e,o){return mt(e,o),g(e),null};var I=M.prototype;return I.scrollTo=function(e){e=Math.max(0,e),this.setState(function(o){return o.scrollOffset===e?null:{scrollDirection:o.scrollOffset<e?"forward":"backward",scrollOffset:e,scrollUpdateWasRequested:!0}},this._resetIsScrollingDebounced)},I.scrollToItem=function(e,o){o===void 0&&(o="auto");var s=this.props,u=s.itemCount,m=s.layout,S=this.state.scrollOffset;e=Math.max(0,Math.min(e,u-1));var d=0;if(this._outerRef){var h=this._outerRef;m==="vertical"?d=h.scrollWidth>h.clientWidth?K():0:d=h.scrollHeight>h.clientHeight?K():0}this.scrollTo(l(this.props,e,o,S,this._instanceProps,d))},I.componentDidMount=function(){var e=this.props,o=e.direction,s=e.initialScrollOffset,u=e.layout;if(typeof s=="number"&&this._outerRef!=null){var m=this._outerRef;o==="horizontal"||u==="horizontal"?m.scrollLeft=s:m.scrollTop=s}this._callPropsCallbacks()},I.componentDidUpdate=function(){var e=this.props,o=e.direction,s=e.layout,u=this.state,m=u.scrollOffset,S=u.scrollUpdateWasRequested;if(S&&this._outerRef!=null){var d=this._outerRef;if(o==="horizontal"||s==="horizontal")if(o==="rtl")switch(V()){case"negative":d.scrollLeft=-m;break;case"positive-ascending":d.scrollLeft=m;break;default:var h=d.clientWidth,y=d.scrollWidth;d.scrollLeft=y-h-m;break}else d.scrollLeft=m;else d.scrollTop=m}this._callPropsCallbacks()},I.componentWillUnmount=function(){this._resetIsScrollingTimeoutId!==null&&j(this._resetIsScrollingTimeoutId)},I.render=function(){var e=this.props,o=e.children,s=e.className,u=e.direction,m=e.height,S=e.innerRef,d=e.innerElementType,h=e.innerTagName,y=e.itemCount,O=e.itemData,T=e.itemKey,b=T===void 0?dt:T,R=e.layout,J=e.outerElementType,X=e.outerTagName,Y=e.style,tt=e.useIsScrolling,et=e.width,W=this.state.isScrolling,F=u==="horizontal"||R==="horizontal",rt=F?this._onScrollHorizontal:this._onScrollVertical,A=this._getRangeToRender(),it=A[0],nt=A[1],D=[];if(y>0)for(var w=it;w<=nt;w++)D.push(E.exports.createElement(o,{data:O,key:b(w,O),index:w,isScrolling:tt?W:void 0,style:this._getItemStyle(w)}));var k=i(this.props,this._instanceProps);return E.exports.createElement(J||X||"div",{className:s,onScroll:rt,ref:this._outerRefSetter,style:L({position:"relative",height:m,width:et,overflow:"auto",WebkitOverflowScrolling:"touch",willChange:"transform",direction:u},Y)},E.exports.createElement(d||h||"div",{children:D,ref:S,style:{height:F?"100%":k,pointerEvents:W?"none":void 0,width:F?k:"100%"}}))},I._callPropsCallbacks=function(){if(typeof this.props.onItemsRendered=="function"){var e=this.props.itemCount;if(e>0){var o=this._getRangeToRender(),s=o[0],u=o[1],m=o[2],S=o[3];this._callOnItemsRendered(s,u,m,S)}}if(typeof this.props.onScroll=="function"){var d=this.state,h=d.scrollDirection,y=d.scrollOffset,O=d.scrollUpdateWasRequested;this._callOnScroll(h,y,O)}},I._getRangeToRender=function(){var e=this.props,o=e.itemCount,s=e.overscanCount,u=this.state,m=u.isScrolling,S=u.scrollDirection,d=u.scrollOffset;if(o===0)return[0,0,0,0];var h=c(this.props,d,this._instanceProps),y=f(this.props,h,d,this._instanceProps),O=!m||S==="backward"?Math.max(1,s):1,T=!m||S==="forward"?Math.max(1,s):1;return[Math.max(0,h-O),Math.max(0,Math.min(o-1,y+T)),h,y]},M}(E.exports.PureComponent),t.defaultProps={direction:"ltr",itemData:void 0,layout:"vertical",overscanCount:2,useIsScrolling:!1},t}var mt=function(t,r){t.children,t.direction,t.height,t.layout,t.innerTagName,t.outerTagName,t.width,r.instance},ht=50,C=function(t,r,i){var a=t,l=a.itemSize,c=i.itemMetadataMap,f=i.lastMeasuredIndex;if(r>f){var p=0;if(f>=0){var z=c[f];p=z.offset+z.size}for(var g=f+1;g<=r;g++){var x=l(g);c[g]={offset:p,size:x},p+=x}i.lastMeasuredIndex=r}return c[r]},vt=function(t,r,i){var a=r.itemMetadataMap,l=r.lastMeasuredIndex,c=l>0?a[l].offset:0;return c>=i?Z(t,r,l,0,i):pt(t,r,Math.max(0,l),i)},Z=function(t,r,i,a,l){for(;a<=i;){var c=a+Math.floor((i-a)/2),f=C(t,c,r).offset;if(f===l)return c;f<l?a=c+1:f>l&&(i=c-1)}return a>0?a-1:0},pt=function(t,r,i,a){for(var l=t.itemCount,c=1;i<l&&C(t,i,r).offset<a;)i+=c,c*=2;return Z(t,r,Math.min(i,l-1),Math.floor(i/2),a)},B=function(t,r){var i=t.itemCount,a=r.itemMetadataMap,l=r.estimatedItemSize,c=r.lastMeasuredIndex,f=0;if(c>=i&&(c=i-1),c>=0){var p=a[c];f=p.offset+p.size}var z=i-c-1,g=z*l;return f+g},yt=Q({getItemOffset:function(t,r,i){return C(t,r,i).offset},getItemSize:function(t,r,i){return i.itemMetadataMap[r].size},getEstimatedTotalSize:B,getOffsetForIndexAndAlignment:function(t,r,i,a,l,c){var f=t.direction,p=t.height,z=t.layout,g=t.width,x=f==="horizontal"||z==="horizontal",M=x?g:p,I=C(t,r,l),v=B(t,l),e=Math.max(0,Math.min(v-M,I.offset)),o=Math.max(0,I.offset-M+I.size+c);switch(i==="smart"&&(a>=o-M&&a<=e+M?i="auto":i="center"),i){case"start":return e;case"end":return o;case"center":return Math.round(o+(e-o)/2);case"auto":default:return a>=o&&a<=e?a:a<o?o:e}},getStartIndexForOffset:function(t,r,i){return vt(t,i,r)},getStopIndexForStartIndex:function(t,r,i,a){for(var l=t.direction,c=t.height,f=t.itemCount,p=t.layout,z=t.width,g=l==="horizontal"||p==="horizontal",x=g?z:c,M=C(t,r,a),I=i+x,v=M.offset+M.size,e=r;e<f-1&&v<I;)e++,v+=C(t,e,a).size;return e},initInstanceProps:function(t,r){var i=t,a=i.estimatedItemSize,l={itemMetadataMap:{},estimatedItemSize:a||ht,lastMeasuredIndex:-1};return r.resetAfterIndex=function(c,f){f===void 0&&(f=!0),l.lastMeasuredIndex=Math.min(l.lastMeasuredIndex,c-1),r._getItemStyleCache(-1),f&&r.forceUpdate()},l},shouldResetStyleCacheOnItemSizeChange:!1,validateProps:function(t){t.itemSize}}),zt=Q({getItemOffset:function(t,r){var i=t.itemSize;return r*i},getItemSize:function(t,r){var i=t.itemSize;return i},getEstimatedTotalSize:function(t){var r=t.itemCount,i=t.itemSize;return i*r},getOffsetForIndexAndAlignment:function(t,r,i,a,l,c){var f=t.direction,p=t.height,z=t.itemCount,g=t.itemSize,x=t.layout,M=t.width,I=f==="horizontal"||x==="horizontal",v=I?M:p,e=Math.max(0,z*g-v),o=Math.min(e,r*g),s=Math.max(0,r*g-v+g+c);switch(i==="smart"&&(a>=s-v&&a<=o+v?i="auto":i="center"),i){case"start":return o;case"end":return s;case"center":{var u=Math.round(s+(o-s)/2);return u<Math.ceil(v/2)?0:u>e+Math.floor(v/2)?e:u}case"auto":default:return a>=s&&a<=o?a:a<s?s:o}},getStartIndexForOffset:function(t,r){var i=t.itemCount,a=t.itemSize;return Math.max(0,Math.min(i-1,Math.floor(r/a)))},getStopIndexForStartIndex:function(t,r,i){var a=t.direction,l=t.height,c=t.itemCount,f=t.itemSize,p=t.layout,z=t.width,g=a==="horizontal"||p==="horizontal",x=r*f,M=g?z:l,I=Math.ceil((M+i-x)/f);return Math.max(0,Math.min(c-1,r+I-1))},initInstanceProps:function(t){},shouldResetStyleCacheOnItemSizeChange:!0,validateProps:function(t){t.itemSize}});function G(n,t){for(var r in n)if(!(r in t))return!0;for(var i in t)if(n[i]!==t[i])return!0;return!1}var gt=["style"],St=["style"];function Mt(n,t){var r=n.style,i=U(n,gt),a=t.style,l=U(t,St);return!G(r,a)&&!G(i,l)}export{zt as F,yt as V,Mt as a};
