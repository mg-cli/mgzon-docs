'use client';
System.register(["react","jotai/vanilla","jotai/vanilla/internals"],(function(B){"use strict";var S,p,E,d,v,V,R,k,C,w,D,P;return{setters:[function(n){S=n.createContext,p=n.useContext,E=n.useRef,d=n.createElement,v=n.default,V=n.useReducer,R=n.useEffect,k=n.useDebugValue,C=n.useCallback},function(n){w=n.getDefaultStore,D=n.createStore},function(n){P=n.INTERNAL_getBuildingBlocksRev2}],execute:(function(){B({Provider:N,useAtom:I,useAtomValue:j,useSetAtom:x,useStore:m});const n=S(void 0);function m(t){const e=p(n);return(t==null?void 0:t.store)||e||w()}function N({children:t,store:e}){const o=E(null);return e?d(n.Provider,{value:e},t):(o.current===null&&(o.current=D()),d(n.Provider,{value:o.current},t))}const b=t=>typeof(t==null?void 0:t.then)=="function",h=t=>{t.status||(t.status="pending",t.then(e=>{t.status="fulfilled",t.value=e},e=>{t.status="rejected",t.reason=e}))},_=v.use||(t=>{if(t.status==="pending")throw t;if(t.status==="fulfilled")return t.value;throw t.status==="rejected"?t.reason:(h(t),t)}),y=new WeakMap,T=(t,e,o)=>{const a=P(t)[26];let u=y.get(e);return u||(u=new Promise((f,g)=>{let l=e;const i=s=>A=>{l===s&&f(A)},c=s=>A=>{l===s&&g(A)},r=()=>{try{const s=o();b(s)?(y.set(s,u),l=s,s.then(i(s),c(s)),a(t,s,r)):f(s)}catch(s){g(s)}};e.then(i(e),c(e)),a(t,e,r)}),y.set(e,u)),u};function j(t,e){const{delay:o,unstable_promiseStatus:a=!v.use}=e||{},u=m(e),[[f,g,l],i]=V(r=>{const s=u.get(t);return Object.is(r[0],s)&&r[1]===u&&r[2]===t?r:[s,u,t]},void 0,()=>[u.get(t),u,t]);let c=f;if((g!==u||l!==t)&&(i(),c=u.get(t)),R(()=>{const r=u.sub(t,()=>{if(a)try{const s=u.get(t);b(s)&&h(T(u,s,()=>u.get(t)))}catch(s){}if(typeof o=="number"){console.warn(`[DEPRECATED] delay option is deprecated and will be removed in v3.

Migration guide:

Create a custom hook like the following.

function useAtomValueWithDelay<Value>(
  atom: Atom<Value>,
  options: { delay: number },
): Value {
  const { delay } = options
  const store = useStore(options)
  const [value, setValue] = useState(() => store.get(atom))
  useEffect(() => {
    const unsub = store.sub(atom, () => {
      setTimeout(() => setValue(store.get(atom)), delay)
    })
    return unsub
  }, [store, atom, delay])
  return value
}
`),setTimeout(i,o);return}i()});return i(),r},[u,t,o,a]),k(c),b(c)){const r=T(u,c,()=>u.get(t));return a&&h(r),_(r)}return c}function x(t,e){const o=m(e);return C((...a)=>o.set(t,...a),[o,t])}function I(t,e){return[j(t,e),x(t,e)]}})}}));
