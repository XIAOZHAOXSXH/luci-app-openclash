import{j as e,b,i as y,r as l}from"./index.171f553a.js";const F="_spining_4i8sg_1",M="_spining_keyframes_4i8sg_1",j={spining:F,spining_keyframes:M},{useState:v}=y;function B({children:s}){return e("span",{className:j.spining,children:s})}const H={right:10,bottom:10},L=({children:s,...n})=>e("button",{type:"button",...n,className:"rtf--ab",children:s}),E=({children:s,...n})=>e("button",{type:"button",className:"rtf--mb",...n,children:s}),O={bottom:24,right:24},R=({event:s="hover",style:n=O,alwaysShowTitle:o=!1,children:f,icon:g,mainButtonStyles:h,onClick:p,text:d,..._})=>{const[a,r]=v(!1),c=o||!a,u=()=>r(!0),m=()=>r(!1),x=()=>s==="hover"&&u(),k=()=>s==="hover"&&m(),N=t=>p?p(t):(t.persist(),s==="click"?a?m():u():null),$=(t,i)=>{t.persist(),r(!1),setTimeout(()=>{i(t)},1)},C=()=>l.exports.Children.map(f,(t,i)=>l.exports.isValidElement(t)?b("li",{className:`rtf--ab__c ${"top"in n?"top":""}`,children:[l.exports.cloneElement(t,{"data-testid":`action-button-${i}`,"aria-label":t.props.text||`Menu button ${i+1}`,"aria-hidden":c,tabIndex:a?0:-1,...t.props,onClick:I=>{t.props.onClick&&$(I,t.props.onClick)}}),t.props.text&&e("span",{className:`${"right"in n?"right":""} ${o?"always-show":""}`,"aria-hidden":c,children:t.props.text})]}):null);return e("ul",{onMouseEnter:x,onMouseLeave:k,className:`rtf ${a?"open":"closed"}`,"data-testid":"fab",style:n,..._,children:b("li",{className:"rtf--mb__c",children:[e(E,{onClick:N,style:h,"data-testid":"main-button",role:"button","aria-label":"Floating menu",tabIndex:0,children:g}),d&&e("span",{className:`${"right"in n?"right":""} ${o?"always-show":""}`,"aria-hidden":c,children:d}),e("ul",{children:C()})]})})};export{L as A,R as F,B as I,H as p};
