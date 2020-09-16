from django.contrib.auth import get_user_model
from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator

User = get_user_model()
 
class UserSerializer(serializers.ModelSerializer):
  
    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user

    class Meta(object):
        model = User
        fields = ('id', 'username', 'email', 'password')
        extra_kwargs = {'password': {'write_only': True}}