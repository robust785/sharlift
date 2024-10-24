const mongoose=require("mongoose");
//firstName,lastName,email,phone,vehicalName,vehicalNumber
const userSchema=mongoose.Schema(
    {
        firstName:{
            required:true,
            type:String,
            trim:true        
        },
        lastName:{
            required:false,
            type:String,
            trim:true        
        },
    email:{
        required:true,
        type:String,
        trim:true,
        validate:{
            validator:async (value)=>{
                //re= RegEx
                let re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return await value.match(re);
            },
            //if not valid then
            message:"Please enter a valid email address.",
        }
    },
    profilePhoto:{
        required:false,
        type:String,
        trim:true,
        
    },
    password:{
        required:true,
        type:String,
        trim:true
        //jab akkal ayega toh dekh lena
        // validate:{
        //     validator:(value)=>{
        //         return value.length<6;
        //     },
        //     //if not valid then
        //     message:"password should be > 6 letters",
        // }
    },
    phone:{
        required:false,
        type:String,
        trim:true        
    },
    vehicalName:{
        required:false,
        type:String,
        trim:true        
    },
    vehicalNumber:{
        required:false,
        type:String,
        trim:true        
    },
    noOfLiftsGiven:{
        required:false,
        type:Number,
        trim:true        
    },
    ratingLiftsGiven:{
        required:false,
        type:Number,
        trim:true        
    },
    noOfLiftsTaken:{
        required:false,
        type:Number,
        trim:true        
    },
    ratingLiftsTaken:{
        required:false,
        type:Number,
        trim:true        
    },
    type:{
        type:String,
        default:"user"   
    }

});


const UserModel=mongoose.model("User",userSchema);  //model(model_name,schema)

module.exports=UserModel;