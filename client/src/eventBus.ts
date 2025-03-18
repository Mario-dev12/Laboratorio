import { reactive } from "vue";  

const eventBus = reactive({  
  listeners: {} as Record<string, Array<Function>>,  
  emit(event: string, data: any) {  
    const handlers = this.listeners[event] || [];  
    handlers.forEach(handler => handler(data));  
  },  
  on(event: string, handler: Function) {  
    if (!this.listeners[event]) {  
      this.listeners[event] = [];  
    }  
    this.listeners[event].push(handler);  
  },  
  off(event: string, handler: Function) {  
    this.listeners[event] = this.listeners[event].filter(h => h !== handler);  
  },  
});  

export default eventBus;