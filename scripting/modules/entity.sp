void Entity_GetPosition(int entity, float position[3]) {
    GetEntPropVector(entity, Prop_Send, "m_vecOrigin", position);
}

void Entity_GetAngles(int entity, float angles[3]) {
    GetEntPropVector(entity, Prop_Send, "m_angRotation", angles);
}
