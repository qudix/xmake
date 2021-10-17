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
-- Copyright (C) 2015-present, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        xmake.lua
--

rule("c++.unit_build")
    after_load(function (target)
        import("unit_build")
        local sourcebatches = target:sourcebatches()
        if sourcebatches then
            for _, rulename in ipairs({"c.build", "c++.build"}) do
                local sourcebatch = sourcebatches[rulename]
                if sourcebatch then
                    unit_build(target, sourcebatch)
                end
            end
        end
    end)
    before_build(function (target, opt)
        import("unit_build")
        local sourcebatches = target:sourcebatches()
        if sourcebatches then
            for _, rulename in ipairs({"c.build", "c++.build"}) do
                local sourcebatch = sourcebatches[rulename]
                if sourcebatch then
                    unit_build.generate_unitfiles(target, sourcebatch, opt)
                end
            end
        end
    end)
