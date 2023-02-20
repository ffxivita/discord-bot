import mongoose, { Schema } from 'mongoose';

const temporaryCommandSchema = new Schema({
    command: String,
    moderator: String,
    content: String,
    date: Date,
    title: String,
    severity: String,
    imageUrl: String,
    lastUsed: Date,
})

const TemporaryCommand = mongoose.model('Temporary Command', temporaryCommandSchema);

export default TemporaryCommand;
