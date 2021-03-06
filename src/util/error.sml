(*
    Copyright 2018–2019 Fernando Borretti <fernando@borretti.me>

    This file is part of Austral.

    Austral is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Austral is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Austral.  If not, see <http://www.gnu.org/licenses/>.
*)

signature ERROR = sig
    val syntax : string -> 'a
    val semantic : string -> 'a
    val notImplemented : unit -> 'a
    val internal : string -> 'a
end

structure Error :> ERROR = struct
    fun syntax message =
        raise Fail ("Syntax error: " ^ message)

    fun semantic message =
        raise Fail ("Semantic error: " ^ message)

    fun notImplemented () =
        raise Fail "Not implemented"

    fun internal message =
        raise Fail ("Internal compiler error: " ^ message)
end
