<!---
Copyright 2013 Kai Koenig, Ventego Creative Ltd

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--->

<cfcomponent output="false">

	<cffunction name="init" access="public" output="false" returntype="any">

		<cfscript>
			return this;
		</cfscript>

	</cffunction>

	<cffunction name="build" access="package" output="false" returntype="struct">

		<cfargument name="issueDataStruct" type="struct" required="yes">

		<cfscript>
			var returnContent = {};
			var stackTraceData = [];
			var stackTraceLines = [];
			var tagContextData = [];
			var lenStackTraceLines = 0;
			var lenTagContext = 0;
			var stackTraceLineElements = [];
			var j = 0;

			stackTraceLines = arguments.issueDataStruct.stacktrace.split("\n\sat");
			lenStackTraceLines = ArrayLen(stackTraceLines);

			for (j=2;j<=lenStackTraceLines;j++)
			{
				stackTraceLineElements = stackTraceLines[j].split("\(");
				stackTraceData[j-1] = {};
				stackTraceData[j-1]["methodName"] = Trim(ListLast(stackTraceLineElements[1],"."));
				stackTraceData[j-1]["className"] = Trim(ListDeleteAt(stackTraceLineElements[1],ListLen(stackTraceLineElements[1],"."),"."));
				// PR 26 - It seems there are Java Strack Traces without line numbers
				// Check if a line number is present in the Java Stack Trace
				// We look for a colon followed by number(s)
				// If no line number, return 0 so it's apparent none was given.
				if (ReFind("\:(?!\D+)",stackTraceLineElements[2])){
					stackTraceData[j-1]["fileName"] = Trim(ReReplace(stackTraceLineElements[2].split("\:(?!\D+)")[1],"[\)\n\r]",""));
					stackTraceData[j-1]["lineNumber"] = Trim(ReReplace(stackTraceLineElements[2].split("\:(?!\D+)")[2],"[\)\n\r]",""));
				}
				else
				{
					stackTraceData[j-1]["fileName"] = Trim(ReReplace(stackTraceLineElements[2],"[\)\n\r]",""));
					stackTraceData[j-1]["lineNumber"] = 0;
				}
			}

			returnContent["data"] = {"JavaStrackTrace" = stackTraceData};

			// if we deal with an error struct, there'll be a root cause
			if (StructKeyExists(arguments.issueDataStruct,"RootCause"))
			{
				if (StructKeyExists(arguments.issueDataStruct["RootCause"],"Type") and arguments.issueDataStruct["RootCause"]["Type"] eq "expression")
				{
					returnContent["data"]["type"] = arguments.issueDataStruct["RootCause"]["Type"];
				}
				if (StructKeyExists(arguments.issueDataStruct["RootCause"],"Message"))
				{
					returnContent["message"] = arguments.issueDataStruct["RootCause"]["Message"];
				}
				returnContent["catchingMethod"] = "error struct";
			}
			// otherwise there's no root cause and the specific data has to be grabbed from somewhere else
			else
			{
				returnContent["data"]["type"] = arguments.issueDataStruct.type;
				returnContent["message"] = arguments.issueDataStruct.message;
				returnContent["catchingMethod"] = "cfcatch struct";
			}

			// if we have a message property in the params section, we want to use that instead
			if (structKeyExists(arguments.issueDataStruct,"customRequestData") && isStruct(arguments.issueDataStruct.customRequestData.getParams()) && structKeyExists(arguments.issueDataStruct.customRequestData.getParams(),"message"))
			{
				var params = arguments.issueDataStruct.customRequestData.getParams();
				returnContent["message"] = params.message;
			}

			returnContent["className"] = trim( arguments.issueDataStruct.type );

			lenTagContext = arraylen(arguments.issueDataStruct.tagcontext);

			for (j=1;j<=lenTagContext;j++)
			{
				tagContextData[j] = {};
				tagContextData[j]["methodName"] = "";
				tagContextData[j]["className"] = (structKeyExists(arguments.issueDataStruct.tagcontext[j],"id")) ?
					trim(arguments.issueDataStruct.tagcontext[j]["id"]) : "";
				tagContextData[j]["fileName"] = (structKeyExists(arguments.issueDataStruct.tagcontext[j],"template")) ?
					trim(arguments.issueDataStruct.tagcontext[j]["template"]) : "";
				tagContextData[j]["lineNumber"] = (structKeyExists(arguments.issueDataStruct.tagcontext[j],"line")) ?
					trim(arguments.issueDataStruct.tagcontext[j]["line"]) : "";
			}

			returnContent["stackTrace"] = tagContextData;

			return returnContent;
		</cfscript>

	</cffunction>

</cfcomponent>
