#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable debug verbose
%% ==========================================================================================================
%% SublimErl - A Sublime Text 2 Plugin for Erlang Integrated Testing & Code Completion
%% 
%% Copyright (C) 2012, Roberto Ostinelli <roberto@ostinelli.net>.
%% All rights reserved.
%%
%% BSD License
%% 
%% Redistribution and use in source and binary forms, with or without modification, are permitted provided
%% that the following conditions are met:
%%
%%  * Redistributions of source code must retain the above copyright notice, this list of conditions and the
%%        following disclaimer.
%%  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and
%%        the following disclaimer in the documentation and/or other materials provided with the distribution.
%%  * Neither the name of the authors nor the names of its contributors may be used to endorse or promote
%%        products derived from this software without specific prior written permission.
%%
%% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
%% WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
%% PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
%% ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
%% TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
%% HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
%% NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
%% POSSIBILITY OF SUCH DAMAGE.
%% ==========================================================================================================
-mode(compile).

% command line exposure
main(["lib_dir"]) ->
	io:format("~s", [code:lib_dir()]);

main(["format", FilePath]) ->
	Formatted = case epp_dodger:parse_file(FilePath) of 
		{ok, Forms} ->
			case lists:keymember(error, 1, Forms) of
				false ->
					erl_prettypr:format(erl_recomment:recomment_forms(Forms, erl_comment_scan:file(FilePath)));
				true ->
					""
			end;
		{error, _} ->
			""
	end,
	io:format("~p", [Formatted]);

main(_) ->
	halt(1).
