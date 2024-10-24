const mongoose=require("mongoose");
//firstName,lastName,email,phone,vehicalName,vehicalNumber
const productSchema=mongoose.Schema(
    {
        giverID:{
            required:true,
            type:String,
            trim:true        
        },
        from:{
            required:true,
            type:String,
            trim:true        
        },
        to:{
            required:true,
            type:String,
            trim:true        
        },
        price:{
            required:true,
            type:Number,
            trim:true        
        },
        time_of_start:{
            required:true,
            type:String,
            trim:true        
        },
        date_of_start:{
            required:true,
            type:String,
            trim:true        
        },
        msg:{
            required:false,
            type:String,
            trim:true        
        },
        pickUpPoint:{
            required:true,
            type:String,
            trim:true        
        },
        //online,pending,complete
        status:{
            required:true,
            type:String,
            trim:true        
        },
        arr_req_id: [
            {
            type: String,
            required: false,
            },
        ],
        chosenID:{
            required:false,
            type:String,
            trim:true        
        },
        lifterCode:{
            required:false,
            type:String,
            trim:true        
        },
        passengerCode:{
            required:false,
            type:String,
            trim:true        
        },
        
        
    firstName:{
        required:false,
        type:String,
        trim:true        
    },
    lastName:{
        required:false,
        type:String,
        trim:true        
    },
    
    phone:{
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
    vehicalName:{
        required:false,
        type:String,
        trim:true        
    },
    vehicalNumber:{
        required:false,
        type:String,
        trim:true        
    }
    ,
   
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
    profilePhoto:{
        required:false,
        type:String,
        trim:true        
    }
    ,    
    modeOfPayment:{
        required:false,
        type:String,
        trim:true        
    }
    ,    
    completeFromLifter:{
        required:false,
        type:Boolean,
        trim:true        
    }
    ,    
    completeFromPassenger:{
        required:false,
        type:Boolean,
        trim:true        
    }
    

});


const ProductModel=mongoose.model("Add Lift",productSchema);  //model(model_name,schema)

module.exports=ProductModel;