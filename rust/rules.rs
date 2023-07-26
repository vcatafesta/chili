enum Role {
	Admin,
	Reader,
	Writer,
}

fn can_published_blog(r: Role) -> bool {
	match r {
		Role::Admin | Role::Writer =>true,
		_ => false,
	}
}
