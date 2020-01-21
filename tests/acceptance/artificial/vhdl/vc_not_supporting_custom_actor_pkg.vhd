-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.
--
-- Copyright (c) 2014-2020, Lars Asplund lars.anders.asplund@gmail.com

library vunit_lib;
context vunit_lib.vunit_context;
context vunit_lib.com_context;
context vunit_lib.vc_context;
use vunit_lib.vc_pkg.all;

package vc_not_supporting_custom_actor_pkg is
  type vc_not_supporting_custom_actor_handle_t is record
    p_std_cfg : std_cfg_t;
  end record;

  constant vc_not_supporting_custom_actor_logger : logger_t := get_logger("vc_not_supporting_custom_actor");
  constant vc_not_supporting_custom_actor_checker : checker_t := new_checker(vc_not_supporting_custom_actor_logger);
  constant vc_not_supporting_custom_actor_actor : actor_t := new_actor("vc_not_supporting_custom_actor_actor");

  constant transaction_msg : msg_type_t := new_msg_type("transaction");

  impure function new_vc_not_supporting_custom_actor(
    logger : logger_t := vc_not_supporting_custom_actor_logger;
    actor : actor_t := null_actor;
    checker : checker_t := null_checker;
    fail_on_unexpected_msg_type : boolean := true
  ) return vc_not_supporting_custom_actor_handle_t;

  procedure transaction(
    signal net : inout network_t;
    vc_h : vc_not_supporting_custom_actor_handle_t
  );

  impure function as_sync(
    vc_h : vc_not_supporting_custom_actor_handle_t
  ) return sync_handle_t;

end package;

package body vc_not_supporting_custom_actor_pkg is
  impure function new_vc_not_supporting_custom_actor(
    logger                      : logger_t  := vc_not_supporting_custom_actor_logger;
    actor                       : actor_t   := null_actor;
    checker                     : checker_t := null_checker;
    fail_on_unexpected_msg_type : boolean   := true
  ) return vc_not_supporting_custom_actor_handle_t is
    constant p_std_cfg : std_cfg_t := create_std_cfg(
      vc_not_supporting_custom_actor_logger, vc_not_supporting_custom_actor_checker, actor, logger, checker, fail_on_unexpected_msg_type
    );

  begin
    return (p_std_cfg => p_std_cfg);
  end;

  procedure transaction(
    signal net : inout network_t;
    vc_h : vc_not_supporting_custom_actor_handle_t
  ) is
    variable msg : msg_t;
  begin
    msg := new_msg(transaction_msg);
    send(net, vc_not_supporting_custom_actor_actor, msg);
  end procedure;

  impure function as_sync(
    vc_h : vc_not_supporting_custom_actor_handle_t
  ) return sync_handle_t is
  begin
    return vc_not_supporting_custom_actor_actor;
  end;

end package body;

