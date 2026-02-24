extends RigidBody2D

@rpc("any_peer", 'call_local', 'reliable')
func assume_owner(id):
	set_multiplayer_authority(id)