const express=require("express");
const jwt=require("jsonwebtoken");
const ProductModel = require("../models/productModel");
const UserModel = require("../models/user");



const productRouter=express.Router();

productRouter.post("/user/add-product",async(req,res)=>{
    try {
        // const {giverID,from,to,time_of_start,date_of_start,msg,pickUpPoint,status,arr_req_id,chosenID,code,firstName,lastName,phone,email,vehicalName,vehicalNumber}=req.body;
        const {giverID,from,to,price,time_of_start,date_of_start,msg,pickUpPoint,status,firstName,lastName,phone,email,vehicalName,vehicalNumber,completeFromPassenger,completeFromLifter}=req.body;
        const chosenID="";
        const lifterCode=Math.floor(100000 + Math.random() * 900000).toString();
        const passengerCode=Math.floor(100000 + Math.random() * 900000).toString();
        const user=await UserModel.findOne({email:email});
        const profilePhoto=user.profilePhoto;
        const ratingLiftsGiven=user.ratingLiftsGiven;
        const noOfLiftsGiven=user.noOfLiftsGiven;
        const modeOfPayment="";
        let product=new ProductModel({giverID,from,to,price,time_of_start,date_of_start,msg,pickUpPoint,status,firstName,lastName,phone,email,vehicalName,vehicalNumber,lifterCode,passengerCode,chosenID,ratingLiftsGiven,noOfLiftsGiven,profilePhoto,modeOfPayment,completeFromPassenger,completeFromLifter});
            product=await product.save();
            
            //RETURN SUCCESS MSG   
            res.json(product); 
    } catch (error) {
        res.status(500).json({error:error.message});
    }

});


productRouter.get("/user/search",  async (req, res) => {
    try {
        const from=req.query.from.toString();
        const to=req.query.to.toString();
        const products = await ProductModel.find({
        from: { $regex: from, $options: "i" },
        to: { $regex: to, $options: "i" },
    });

        res.json(products);
    } catch (e) {
    res.status(500).json({ error: e.message });
    }
});


productRouter.get("/lift-posted", async (req, res) => {
    try {
        const email = req.query.email.toString();
        
        
        const products = await ProductModel.find({ email:email });

        if (products.length === 0) {
            return res.status(404).json({ message: "No products found for this email." });
        }

        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});






productRouter.put("/send-request", async (req, res) => {
    try {
        const {requestEmail,liftID}=req.body;
        
       
        const updatedLift = await ProductModel.findByIdAndUpdate(
            liftID,
            { $addToSet: { arr_req_id: requestEmail } },  
            { new: true }  // updated document return karega
          );

       

        res.json(updatedLift);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});




productRouter.get("/fetch-all-request", async (req, res) => {
    try {
        const email = req.query.email.toString();
        const products = await ProductModel.find({ email: email });

        // console.log("Fetched Products: ", products); 

        if (products.length === 0) {
            return res.status(404).json({ message: "No products found for this email." });
        }

        let finalDocuments = [];

        for (const product of products) {
            // console.log("Product ID: ",  product._id.toString()); // Log the product ID
            
            
            if (product.arr_req_id && product.arr_req_id.length > 0) {
                for (const reqEmail of product.arr_req_id) {
                    const user = await UserModel.findOne({ email: reqEmail });

                    if (user) {
                        const finalDoc = {
                            id: product._id.toString(), // Convert _id to string
                            from: product.from,
                            to: product.to,
                            time_of_start: product.time_of_start,
                            date_of_start: product.date_of_start,
                            pickUpPoint: product.pickUpPoint,
                            firstName: user.firstName,
                            lastName: user.lastName,
                            phone: user.phone,
                            email: user.email,
                            profilePhoto: user.profilePhoto,
                            ratingLiftsTaken: user.ratingLiftsTaken,
                            noOfLiftsTaken: user.noOfLiftsTaken,
                            price: product.price,
                        };
                        finalDocuments.push(finalDoc);
                    } else {
                        console.log(`No user found for email: ${reqEmail}`);
                    }
                }
            }
        }

        if (finalDocuments.length === 0) {
            return res.status(404).json({ message: "No requests found." });
        }

        res.json(finalDocuments);
    } catch (e) {
       
        res.status(500).json({ error: e.message });
    }
});




productRouter.put("/decline-request", async (req, res) => {
    try {
        const liftID=req.query.liftID.toString();
        const declinedEmail=req.query.declinedEmail.toString();
        
       
        const updatedLift = await ProductModel.findByIdAndUpdate(
            liftID,
            { $pull: { arr_req_id: declinedEmail } },  
            { new: true }  // updated document return karega
          );

       

        res.json(updatedLift);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});




productRouter.put("/accept-request", async (req, res) => {
    try {
        const liftID=req.query.liftID.toString();
        const acceptedEmail=req.query.acceptedEmail.toString();
        
       
        const updatedLift = await ProductModel.findByIdAndUpdate(
            liftID,
            {
            $set: 
            { 
                arr_req_id: [],          // Empty the arr_req_id array
                chosenID: acceptedEmail ,
                status:"pending" // Set chosenID to the acceptedEmail
            }
            },
            { new: true }  // updated document return karega
          );

       

        res.json(updatedLift);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});







productRouter.get("/fetch-all-pending", async (req, res) => {
    try {
        const email = req.query.email.toString();
        const products = await ProductModel.find({
            $or: [{ email: email },{ chosenID: email }],
            status: "pending"
          });

        

        if (products.length === 0) {
            return res.status(200).json({ message: "No products found for this email." });
        }

        


        res.json(products);
    } catch (e) {
       
        res.status(500).json({ error: e.message });
    }
});



productRouter.get("/fetch-chosen", async (req, res) => {
    try {
        const email = req.query.email.toString();
        const user = await UserModel.findOne({ email });
    
        if (!user) {
          return res.status(404).json({ message: 'User not found' });
        }
    
        const { firstName, lastName, phone,profilePhoto,ratingLiftsTaken ,noOfLiftsTaken} = user; // Destructure to get only required fields
        return res.json({ firstName, lastName, phone ,profilePhoto,ratingLiftsTaken,noOfLiftsTaken});
      } catch (error) {
        return res.status(500).json({ message: 'Internal server error' });
      }
});






module.exports =productRouter;
