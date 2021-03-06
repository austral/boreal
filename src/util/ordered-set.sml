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

signature ORDERED_SET = sig
    type ''a set

    val empty : ''a set
    val singleton : ''a -> ''a set

    val exists : ''a set -> ''a -> bool

    val add : ''a set -> ''a -> ''a set
    val addList : ''a set -> ''a list -> ''a set

    val union : ''a set -> ''a set -> ''a set
    val unionList : ''a set list -> ''a set

    val difference : ''a set -> ''a set -> ''a set

    val size : ''a set -> int
    (* positions start at 1 *)
    val positionOf : ''a set -> ''a -> int option
    val nth : ''a set -> int -> ''a

    val filter : ''a set -> (''a -> bool) -> ''a set

    val fromList : ''a list -> ''a set
    val toList : ''a set -> ''a list

    val toUnordered : ''a set -> ''a Set.set
end

structure OrderedSet :> ORDERED_SET = struct
    datatype ''a set = Set of ''a list

    val empty = Set []

    fun singleton a = Set [a]

    fun exists (Set l) elem =
        Util.member elem l

    fun add (Set l) elem =
        if Util.member elem l then
            Set l
        else
            Set (elem :: l)

    fun addList set (x::xs) = add (addList set xs) x
      | addList set nil = set

    fun union (Set a) (Set b) = addList (addList empty a) b

    fun unionList l = foldl (fn (a, b) => union a b)
                            empty
                            l

    fun difference (Set blist) a =
        (* All elements in B but not in A *)
        Set (List.filter (fn belem => not (exists a belem)) blist)

    fun size (Set l) = List.length l

    fun positionOf (Set l) elem =
        case Util.position elem l of
            SOME p => SOME ((List.length l) - p)
          | _ => NONE

    fun nth (Set l) idx =
        List.nth (l, idx - 1)

    fun filter (Set l) f = Set (List.filter f l)

    fun fromList (x::xs) = add (fromList xs) x
      | fromList nil = empty

    fun toList (Set l) = l

    fun toUnordered (Set l) =
        Set.fromList l
end
