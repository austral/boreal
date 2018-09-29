(*
    Copyright 2018 Fernando Borretti <fernando@borretti.me>

    This file is part of Boreal.

    Boreal is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Boreal is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Boreal.  If not, see <http://www.gnu.org/licenses/>.
*)

signature AST = sig
    datatype ast = IntConstant of string
                 | FloatConstant of string
                 | StringConstant of CST.escaped_string
                 | Symbol of Symbol.symbol
                 | Keyword of Symbol.symbol_name
                 | Let of binding * ast
                 | The of RCST.rcst * ast
                 | Operator of Symbol.symbol * ast list
         and binding = Binding of Symbol.symbol * ast

    type docstring = string option

    datatype top_ast = Defun of Symbol.symbol * param list * Type.typespec
                     | Defclass
                     | Definstance
                     | Deftype of Symbol.symbol * Type.param list * Type.typespec * docstring
                     | Defdisjunction
                     | Defmacro
                     | DefineSymbolMacro of Symbol.symbol * RCST.rcst * docstring
                     | Defmodule of Module.module
                     | InModule of Symbol.symbol_name
         and param = DefunParam of Symbol.symbol * Type.typespec

    val transform : RCST.rcst -> ast
end
