#include <iostream>
#include "gtest/gtest.h"
#include "proto/my_proto.pb.h"

TEST(ProtoTest, ProtoTest) {
  std::cout << "ProtoTest START" << std::endl;

  proto::MyProto msg;

  msg.set_my_field("abc");
  msg.set_my_bytes("efg");
  msg.set_my_bytes_val("hij");
  EXPECT_EQ("proto.MyProto", msg.GetDescriptor()->full_name());
  EXPECT_EQ("proto.MyProto", msg.GetTypeName());
  EXPECT_EQ("abc", msg.my_field());
  EXPECT_EQ("efg", msg.my_bytes());
  EXPECT_EQ("hij", msg.my_bytes_val());

  std::string str_proto;
  msg.SerializeToString(&str_proto);

  std::unique_ptr<proto::MyProto> other_msg_ptr(
    proto::MyProto::default_instance().New());
  proto::MyProto &other_msg = *other_msg_ptr;
//  proto::MyProto other_msg;
  other_msg.ParseFromString(str_proto);

  EXPECT_EQ("abc", other_msg.my_field());
  EXPECT_EQ("efg", other_msg.my_bytes());
  EXPECT_EQ("hij", other_msg.my_bytes_val());

  std::cout << "ProtoTest END" << std::endl;
}
