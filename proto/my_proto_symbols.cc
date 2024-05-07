#include "proto/my_proto.pb.h"
namespace proto {
void symbols_func() {
  proto::MyProto symbols_MyProto;
  symbols_MyProto.GetDescriptor();
  symbols_MyProto.my_bytes_val();
  proto::MyProto::default_instance();
}
}
