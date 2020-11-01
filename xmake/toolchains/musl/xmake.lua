--!A cross-platform build utility based on Lua
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
-- Copyright (C) 2015-2020, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        xmake.lua
--

-- define toolchain
toolchain("musl")

    -- set homepage
    set_homepage("https://musl.cc/")
    set_description("The musl-based cross-compilation toolchains")

    -- mark as standalone toolchain
    set_kind("standalone")

    -- check toolchain
    on_check(function (toolchain)
        return import("toolchains.cross.check", {rootdir = os.programdir()})(toolchain)
    end)

    -- on load
    on_load(function (toolchain)

        -- imports
        import("core.project.config")
        import("toolchains.cross.load", {rootdir = os.programdir()})

        -- load basic configuration of cross toolchain
        load(toolchain)

        -- add flags for arch
        if toolchain:is_arch("arm") then
            toolchain:add("cxflags", "-march=armv7-a", "-msoft-float", {force = true})
            toolchain:add("ldflags", "-march=armv7-a", "-msoft-float", {force = true})
        end
        toolchain:add("ldflags", "--static", {force = true})
        toolchain:add("syslinks", "gcc", "c")
    end)
