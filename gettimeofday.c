/*
 * This file is part of lua-gettimeofday.
 * Copyright 2011 Emil Renner Berthing
 *
 * lua-gettimeofday is free software: you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation, either version 3 of
 * the License, or (at your option) any later version.
 *
 * lua-gettimeofday is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with lua-gettimeofday. If not, see <http://www.gnu.org/licenses/>.
 */

#include <sys/time.h>
#include <lua.h>

static int
gettimeofday_lua(lua_State *L)
{
	struct timeval tp;
	lua_Number ret;

	(void)gettimeofday(&tp, NULL);

	ret = (lua_Number)tp.tv_usec;
	ret /= 1.0e6;
	ret += (lua_Number)tp.tv_sec;

	lua_pushnumber(L, ret);
	return 1;
}

int
luaopen_gettimeofday(lua_State *L)
{
	lua_pushcfunction(L, gettimeofday_lua);
	return 1;
}
