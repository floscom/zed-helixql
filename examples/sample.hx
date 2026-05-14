// Sample HelixQL exercising every construct our highlights touch.

N::User {
  INDEX name: String,
  age: I32 DEFAULT 0,
  created: Date DEFAULT NOW,
  bio: String,
}

E::Follows {
  From: User,
  To: User,
  Properties: {
    since: Date,
    weight: F32 DEFAULT 0.5,
  }
}

V::Embedding {
  dim: I32,
}

QUERY getFollowers(userId: ID, limit: I32) =>
  followers <- N<User>(userId)::InE<Follows>::FromN::WHERE(_::{age}::GT(18))
  count <- followers::COUNT
  RETURN followers::|f| { id: f.id, name: f.name, .. }, count

QUERY addUser(name: String, age: I32) =>
  newUser <- AddN<User>({ name: name, age: age })
  RETURN newUser

QUERY purge(id: ID) =>
  user <- N<User>(id)
  DROP user
  RETURN NONE
