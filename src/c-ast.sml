(*
    Copyright 2018 Fernando Borretti <fernando@borretti.me>

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

structure CAst = struct
    datatype ty = NamedType of string
                | Pointer of ty
                | Struct of (ty * string) list
                | Union of (ty * string) list

    datatype exp_ast = BoolConstant of bool
                     | IntConstant of string
                     | FloatConstant of string
                     | StringConstant of string
                     | NullConstant
                     | Negation of exp_ast
                     | Variable of string
                     | Binop of binop * exp_ast * exp_ast
                     | Cast of ty * exp_ast
                     | Deref of exp_ast
                     | AddressOf of exp_ast
                     | ArrayIndex of exp_ast * exp_ast
                     | SizeOf of ty
                     | StructInitializer of ty * (string * exp_ast) list
                     | StructAccess of exp_ast * string
                     | Funcall of string * exp_ast list
         and binop = Add
                   | Sub
                   | Mul
                   | Div
                   | EqualTo
                   | NotEqualTo
                   | GreaterThan
                   | LessThan
                   | GreaterThanEq
                   | LessThanEq

    datatype block_ast = Sequence of block_ast list
                       | Declare of ty * string
                       | Assign of exp_ast * exp_ast
                       | DeclareAssign of ty * string * exp_ast
                       | Cond of exp_ast * block_ast * block_ast
                       | While of exp_ast * block_ast
                       | Switch of exp_ast * (int * block_ast) list
                       | VoidFuncall of string * exp_ast list

    datatype top_ast = FunctionDef of string * param list * ty * block_ast * exp_ast
                     | ExternFunctionDecl of string * ty list * Function.foreign_arity * ty
                     | TypeDef of string * ty
                     | ToplevelProgn of top_ast list
         and param = Param of string * ty
end
