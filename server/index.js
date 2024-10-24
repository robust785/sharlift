const express=require("express");
const mongoose=require("mongoose");


const auth=require("./routes/auth.js");
const product=require("./routes/product.js");


const app=express();

//middlewares
app.use(express.json());
app.use(auth);
app.use(product);


//DB connectivity
const PORT=process.env.PORT ||3000;

console.log("Starting SharLift server...");

const DB='mongodb+srv://mayur:mayur0785@sharlift.bsq0l.mongodb.net/?retryWrites=true&w=majority&appName=sharlift';

mongoose.connect(DB).then(()=>{
    console.log("Successfully connected to the database.");
    console.log("Server is live.");
}).catch((e)=>{console.log(e);});

//running our node server to PORT
app.listen(PORT,'0.0.0.0',()=>{
    console.log(`Listening to port ${PORT}`);
});