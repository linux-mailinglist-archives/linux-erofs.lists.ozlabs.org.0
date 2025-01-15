Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CFDA121C8
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 12:00:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY31W2VGKz3bfK
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 22:00:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=194.169.172.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736938814;
	cv=none; b=FEGDxS6wt1Qj/S5Ab1IugAaeMljfGmxR8suldH8YH/Mk2YY8ykfIVQ1LtsQ/l+UjLMJU3xNVEuCKOqBfm2LSMuABxyr6HMSToqbsP8Ca+GTe6dSjHsL4aH8UOx0hTeLSKeTr5g66g0OAbdzmiEvFV+daMBerJ202Ac5vkud1mMGQWGXhMsAYbL5VunoL+60O4nJBm2kOIOOvop//c3gdjiBTYK8nV7qvfAcEaiiGVi/BT885C4sAVBQQtUhrcDtoUOzGs8bZykpc9SWsNB0TrroDm8aywJwawCroC6j+yh2D2pKxdL9ZmMoblgjVosaCtD3GhZeN260hZWQnRW1GvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736938814; c=relaxed/relaxed;
	bh=MXdiZT3QwTefHn9mbACNt7GcrpTlDVXeqn3S0OD2CSE=;
	h=Content-Type:From:To:Subject:Message-ID:Date:MIME-Version; b=M7x/XqihJ+U0EM50Ro9K72punQfiOctKYaTfidQ1N/ib9fTNGO8mRdgz79yvTegw0M3XzAEVvWMT25zhyijyEhy1vjet7QQuvbP59jgaMYLpcgCkatBV+hD06Q8FNO7ULYXGHT4aD7n9P7wyPiUlDKlB9AJ55c1n6Yb5uvXhQvAWVBZqn5OB0LIq/qWv5EG1F4E2Z+X/uiDrK66dpSu8hGiBPf0Qz1yp9wDRPpH0j6nDC3meuyZ9Bv9Stmo5Dpgssjcbh5e8PSam8VjWjfXlOMlN9WAapS0msaN2X8zvjcObCFQY74ixNP1/SyAUpYZkaQfRpnEYGoAu34IOLk1Xxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=anzo.net.au; spf=fail (client-ip=194.169.172.227; helo=sheer.teacheip.com; envelope-from=tharold@anzo.net.au; receiver=lists.ozlabs.org) smtp.mailfrom=anzo.net.au
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=anzo.net.au
Authentication-Results: lists.ozlabs.org; spf=fail (SPF fail - not authorized) smtp.mailfrom=anzo.net.au (client-ip=194.169.172.227; helo=sheer.teacheip.com; envelope-from=tharold@anzo.net.au; receiver=lists.ozlabs.org)
X-Greylist: delayed 1804 seconds by postgrey-1.37 at boromir; Wed, 15 Jan 2025 22:00:11 AEDT
Received: from sheer.teacheip.com (sheer.teacheip.com [194.169.172.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY31R6QB5z30NF
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 22:00:11 +1100 (AEDT)
Content-Type: text/html; charset=utf-8
X-Ms-Exchange-Organization-Authas: Internal74
X-Ms-Exchange-Organization-Authmechanism: 19
X-Ms-Exchange-Organization-Authsource:  AM86PR65MB0179.eurprd34.prod.outlook.com
X-Uminacjp-Nodemailersenderz: true
From: "Lists-Docusign docs" <tharold@anzo.net.au>
To: linux-erofs@lists.ozlabs.org
Subject: A New Document Was Shared With Lists on Docusign
Message-ID: <0844a021-ed4f-881c-ebc5-54c7b98d5539@anzo.net.au>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jan 2025 10:30:01 +0000
MIME-Version: 1.0
X-Spam-Status: No, score=4.6 required=5.0 tests=HTML_MESSAGE,MIME_HTML_ONLY,
	RCVD_IN_SBL_CSS,SPF_FAIL,SPF_HELO_NONE,T_REMOTE_IMAGE
	autolearn=disabled version=4.0.0
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<HTML><HEAD><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Diso-8859-1">
=20
<META http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge,chrome=3D1">=20
<STYLE type=3D"text/css">
/*!=20
 * Base CSS for pdf2htmlEX
 * Copyright 2012,2013 Lu Wang <coolwanglu@gmail.com>=20
 * https://github.com/pdf2htmlEX/pdf2htmlEX/blob/master/share/LICENSE
 */#sidebar{position:absolute;top:0;left:0;bottom:0;width:250px;padding:0;m=
argin:0;overflow:auto}#page-container{position:absolute;top:0;left:0;margin=
:0;padding:0;border:0}@media screen{#sidebar.opened+#page-container{left:25=
0px}#page-container{bottom:0;right:0;overflow:auto}.=
loading-indicator{display:none}.loading-indicator.active{display:block;posi=
tion:absolute;width:64px;height:64px;top:50%;left:50%;margin-top:-32px;marg=
in-left:-32px}.loading-indicator img{position:absolute;top:0;left:0;bottom:=
0;right:0}}@media print{@page{margin:0}html{margin:0}body{margin:0;-webkit-=
print-color-adjust:exact}#sidebar{display:none}#page-container{width:auto;h=
eight:auto;overflow:visible;background-color:transparent}.d{display:none}}.=
pf{position:relative;background-color:white;overflow:hidden;margin:0;border=
:0}.pc{position:absolute;border:0;padding:0;margin:0;top:0;left:0;width:100=
%;height:100%;overflow:hidden;display:block;transform-origin:0 =
0;-ms-transform-origin:0 0;-webkit-transform-origin:0 0}.pc.=
opened{display:block}.bf{position:absolute;border:0;margin:0;top:0;bottom:0=
;width:100%;height:100%;-ms-user-select:none;-moz-user-select:none;-webkit-=
user-select:none;user-select:none}.bi{position:absolute;border:0;margin:0;-=
ms-user-select:none;-moz-user-select:none;-webkit-user-select:none;user-sel=
ect:none}@media print{.pf{margin:0;box-shadow:none;page-break-after:always;=
page-break-inside:avoid}@-moz-document url-prefix(){.=
pf{overflow:visible;border:1px solid #fff}.pc{overflow:visible}}}.=
c{position:absolute;border:0;padding:0;margin:0;overflow:hidden;display:blo=
ck}.t{position:absolute;white-space:pre;font-size:1px;transform-origin:0 =
100%;-ms-transform-origin:0 100%;-webkit-transform-origin:0 =
100%;unicode-bidi:bidi-override;-moz-font-feature-settings:"liga" 0}.=
t:after{content:''}.t:before{content:'';display:inline-block}.t =
span{position:relative;unicode-bidi:bidi-override}._{display:inline-block;c=
olor:transparent;z-index:-1}::selection{background:rgba(127,255,255,0.=
4)}::-moz-selection{background:rgba(127,255,255,0.4)}.pi{display:none}.=
d{position:absolute;transform-origin:0 100%;-ms-transform-origin:0 =
100%;-webkit-transform-origin:0 100%}.it{border:0;background-color:rgba(255=
,255,255,0.0)}.ir:hover{cursor:pointer}</STYLE>
=20
<STYLE type=3D"text/css">
/*!=20
 * Fancy styles for pdf2htmlEX
 * Copyright 2012,2013 Lu Wang <coolwanglu@gmail.com>=20
 * https://github.com/pdf2htmlEX/pdf2htmlEX/blob/master/share/LICENSE
 */@keyframes fadein{from{opacity:0}to{opacity:1}}@-webkit-keyframes =
fadein{from{opacity:0}to{opacity:1}}@keyframes swing{0{transform:rotate(0)}=
10%{transform:rotate(0)}90%{transform:rotate(720deg)}100%{transform:rotate(=
720deg)}}@-webkit-keyframes swing{0{-webkit-transform:rotate(0)}10%{-webkit=
-transform:rotate(0)}90%{-webkit-transform:rotate(720deg)}100%{-webkit-tran=
sform:rotate(720deg)}}@media screen{#sidebar{background-color:#2f3236;backg=
round-image:url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53=
My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0IiBoZWlnaHQ9IjQiPgo8cmVjdCB3aWR0aD0iNCIgaGV=
pZ2h0PSI0IiBmaWxsPSIjNDAzYzNmIj48L3JlY3Q+CjxwYXRoIGQ9Ik0wIDBMNCA0Wk00IDBMMC=
A0WiIgc3Ryb2tlLXdpZHRoPSIxIiBzdHJva2U9IiMxZTI5MmQiPjwvcGF0aD4KPC9zdmc+")}#o=
utline{font-family:Georgia,Times,"Times New Roman",serif;font-size:13px;mar=
gin:2em 1em}#outline ul{padding:0}#outline li{list-style-type:none;margin:1=
em 0}#outline li>ul{margin-left:1em}#outline a,#outline a:visited,#outline =
a:hover,#outline a:active{line-height:1.2;color:#e8e8e8;text-overflow:ellip=
sis;white-space:nowrap;text-decoration:none;display:block;overflow:hidden;o=
utline:0}#outline a:hover{color:#0cf}#page-container{background-color:#9e9e=
9e;background-image:url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDov=
L3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1IiBoZWlnaHQ9IjUiPgo8cmVjdCB3aWR0aD0=
iNSIgaGVpZ2h0PSI1IiBmaWxsPSIjOWU5ZTllIj48L3JlY3Q+CjxwYXRoIGQ9Ik0wIDVMNSAwWk=
02IDRMNCA2Wk0tMSAxTDEgLTFaIiBzdHJva2U9IiM4ODgiIHN0cm9rZS13aWR0aD0iMSI+PC9wY=
XRoPgo8L3N2Zz4=3D");-webkit-transition:left 500ms;transition:left 500ms}.=
pf{margin:13px auto;box-shadow:1px 1px 3px 1px #333;border-collapse:separat=
e}.pc.opened{-webkit-animation:fadein 100ms;animation:fadein 100ms}.=
loading-indicator.active{-webkit-animation:swing 1.5s ease-in-out .01s =
infinite alternate none;animation:swing 1.5s ease-in-out .01s infinite =
alternate none}.checked{background:no-repeat url(data:image/png;base64,=
iVBORw0KGgoAAAANSUhEUgAAABYAAAAWCAYAAADEtGw7AAAABmJLR0QA/wD/AP+gvaeTAAAACXB=
IWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3goQDSYgDiGofgAAAslJREFUOMvtlM9LFGEYx7/vvO=
PM6ywuuyPFihWFBUsdNnA6KLIh+QPx4KWExULdHQ/9A9EfUodYmATDYg/iRewQzklFWxcEBcGgE=
plDkDtI6sw4PzrIbrOuedBb9MALD7zv+3m+z4/3Bf7bZS2bzQIAcrmcMDExcTeXy10DAFVVAQDk=
sgFUVZ1ljD3yfd+0LOuFpmnvVVW9GHhkZAQcxwkNDQ2FSCQyRMgJxnVdy7KstKZpn7nwha6urqq=
fTqfPBAJAuVymlNLXoigOhfd5nmeiKL5TVTV+lmIKwAOA7u5u6Lped2BsbOwjY6yf4zgQQkAIAc=
edaPR9H67r3uYBQFEUFItFtLe332lpaVkUBOHK3t5eRtf1DwAwODiIubk5DA8PM8bYW1EU+wEgC=
IJqsCAIQAiB7/u253k2BQDDMJBKpa4mEon5eDx+UxAESJL0uK2t7XosFlvSdf0QAEmlUnlRFJ9W=
aho2Qghc1/U9z3uWz+eX+Wr+lL6SZfleEAQIggA8z6OpqSknimIvYyybSCReMsZ6TislhCAIAti=
2Dc/zejVNWwCAavN8339j27YbTg0AGGM3WltbP4WhlRWq6Q/btrs1TVsYHx+vNgqKoqBUKn2NRq=
PFxsbGJzzP05puUlpt0ukyOI6z7zjOwNTU1OLo6CgmJyf/gA3DgKIoWF1d/cIY24/FYgOU0pp0z=
/Ityzo8Pj5OTk9PbwHA+vp6zWghDC+VSiuRSOQgGo32UErJ38CO42wdHR09LBQK3zKZDDY2Nupm=
FmF4R0cHVlZWlmRZ/iVJUn9FeWWcCCE4ODjYtG27Z2Zm5juAOmgdGAB2d3cBADs7O8uSJN2SZfl=
+WKlpmpumaT6Yn58vn/fs6XmbhmHMNjc3tzDGFI7jYJrm5vb29sDa2trPC/9aiqJUy5pOp4f6+v=
qeJ5PJBAB0dnZe/t8NBajx/z37Df5OGX8d13xzAAAAAElFTkSuQmCC)}}</STYLE>
=20
<STYLE type=3D"text/css">
.ff0{font-family:sans-serif;visibility:hidden;}
@font-face{font-family:ff1;src:url('data:application/font-woff;base64,=
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
T+pT+rQ+o8/qc/q8vqAv6kv6sr6ir+pr+rq+oW/qW/q2vqPv6nv6vn6gH+pH+rF+op/qZ/q5fqF=
f6lf6tX6j3+p3+r3+oD/qT/qz/qK/6m/6u/6hf+pf+rf+o//af//+jU1MzWywjWJDbKgNs1FtNB=
vdxrAxbSwb28axcW08G98msAltIpvYJrFJbTKb3KawKW0qm9qmsWltOpveZrAZbSab2WaxWW02m=
93msDltuHUWLFqybMWqNettLpvb5rF5bT6b3xawBW0hW9gWsUVtMVvclrAlbSlb2paxEbasLWfL=
2wq2oq1kK9sqtqqtZqvbGramrWVr2zq2rq1n69sGtqFtZBvbSNvENrXNbHPbwra0rWxr28a2te1=
se9vBdrSdbGfbxXa13Wx328P2tL1sb9vH9rX9bH87wA60g+xgO8QOtcPscDvCjrSj7Gg7xo614+=
x4O8FOtJPsZDvFTrXT7HQ7w860s+xsO8fOtfPsfLvALrSL7GK7xC61y+xyu8KutKvsarvGrrXr7=
Hq7wW60m+xmu8VutdvsdrvD7rS77G67x+61++x+e8AetIfsYXvEHrXH7HF7wp60p+xpe8aetefs=
eXvBXrSX7GV7xV611+x1e8PetLfsbXvH3rX37H37wD60j+xj+8Q+tc/sc/vCvrSv7Gv7xr617+x=
7+8F+tJ/sZ/vFfrXf7Hf7w/60v+xv+8f+HTxoMA3mwTJYB9uQZTfYeuSIkXMMHzi6gSMMHHHgSA=
NHHjjKwFEHjjZw9EMHHhzuV+dX8Cv6lfzKfhW/ql/NL28EbwRvBG8EbwRvBG8EbwRvBG8Eb0RvR=
G9Eb0RvRG9Eb0RvRG9Eb0RvJG8kbyRvJG8kbyRvJG8kbyRvJG9kb2RvZG9kb2RvZG9kb2RvZG9k=
bxRvFG8UbxRvFG8UbxRvFG8UbxRvVG9Ub1RvVG9Ub1RvVG9Ub1RvVG80bzRvNG80bzRvNG80bzR=
vNG80b/Te6L3Re6P3Ru+N3hu9N3pv9N7o+2G+weE4O5wBZ8SZcGacBWfF2XCi1qHWodah1qHWod=
ah1qHWodah1qEWUAuoBdQCagG1gFpALaAWUAuoRdQiahG1iFpELaIWUYuoRdQiagm1hFpCLaGWU=
EuoJdQSagm1hFpGLaOWUcuoZdQyahm1jFpGLaNWUCuoFdQKagW1glpBraBWUCuoVdQqahW1ilpF=
raJWUauoVdQqag21hlpDraHWUGuoNdQaag21hlqPWo9aj1qPWo9aj1qPWo9ajxosCbAkwJIASwI=
sCbAkwJIASwIsCbAkwJIASwIsCbAkwJIASwIsCbAkwJIASwIsCbAkwJIASwIsCbAkwJIASwIsCb=
AkwJIASwIsCbAkwJIASwIsCbAkwJIASwIsCbAkwJIASwIsCbAkwJIASwIsCbAkwJIASwIsCbAkw=
JIASwIsCbAkwJIASwIsCbAkwJIASwIsCbAkwJIASwIsCbAkwJIASwIsCbAkwJIASwIsCbAkwJIA=
SwIsCbAkwJIASwIsCbAkwJIASwIsCbAkwJIASwIsCbAkwJIASwIsCbAkwJIASwIsibAkwpIISyI=
sibAkwpIISyIsibAkwpIISyIsibAkwpIISyIsibAkwpIISyIsibAkwpIISyIsibAkwpIISyIsib=
AkwpIISyIsibAkwpIISyIsibAkwpIISyIsibAkwpIISyIsibAkwpIISyIsibAkwpIISyIsibAkw=
pIISyIsibAkwpIISyIsibAkwpIISyIsibAkwpIISyIsibAkwpIISyIsibAkwpIISyIsibAkwpII=
SyIsibAkwpIISyIsibAkwpIISyIsibAkwpIISyIsibAkwpIISyIsibAkwpIISyIsSbAkwZIESxI=
sSbAkwZIESxIsSbAkwZIESxIsSbAkwZIESxIsSbAkwZIESxIsSbAkwZIESxIsSbAkwZIESxIsSb=
AkwZIESxIsSbAkwZIESxIsSbAkwZIESxIsSbAkwZIESxIsSbAkwZIESxIsSbAkwZIESxIsSbAkw=
ZIESxIsSbAkwZIESxIsSbAkwZIESxIsSbAkwZIESxIsSbAkwZIESxIsSbAkwZIESxIsSbAkwZIE=
SxIsSbAkwZIESxIsSbAkwZIESxIsSbAkwZIESxIsSbAkwZIESxIsSbAkwZIESxIsybAkw5IMSzI=
sybAkw5IMSzIsybAkw5IMSzIsybAkw5IMSzIsybAkw5IMSzIsybAkw5IMSzIsybAkw5IMSzIsyb=
Akw5IMSzIsybAkw5IMSzIsybAkw5IMSzIsybAkw5IMSzIsybAkw5IMSzIsybAkw5IMSzIsybAkw=
5IMSzIsybAkw5IMSzIsybAkw5IMSzIsybAkw5IMSzIsybAkw5IMSzIsybAkw5IMSzIsybAkw5IM=
SzIsybAkw5IMSzIsybAkw5IMSzIsybAkw5IMSzIsybAkw5IMSzIsybAkw5IMSzIsKbCkwJICSwo=
sKbCkwJICSwosKbCkwJICSwosKbCkwJICSwosKbCkwJICSwosKbCkwJICSwosKbCkwJICSwosKb=
CkwJICSwosKbCkwJICSwosKbCkwJICSwosKbCkwJICSwosKbCkwJICSwosKbCkwJICSwosKbCkw=
JICSwosKbCkwJICSwosKbCkwJICSwosKbCkwJICSwosKbCkwJICSwosKbCkwJICSwosKbCkwJIC=
SwosKbCkwJICSwosKbCkwJICSwosKbCkwJICSwosKbCkwJICSwosKbCkwJICSwosqbCkwpIKSyo=
sqbCkwpIKSyosqbCkwpIKSyosqbCkwpIKSyosqbCkwpIKSyosqbCkwpIKSyosqbCkwpIKSyosqb=
CkwpIKSyosqbCkwpIKSyosqbCkwpIKSyosqbCkwpIKSyosqbCkwpIKSyosqbCkwpIKSyosqbCkw=
pIKSyosqbCkwpIKSyosqbCkwpIKSyosqbCkwpIKSyosqbCkwpIKSyosqbCkwpIKSyosqbCkwpIK=
SyosqbCkwpIKSyosqbCkwpIKSyosqbCkwpIKSyosqbCkwpIKSyosqbCkwpIKSyosabCkwZIGSxo=
sabCkwZIGSxosabCkwZIGSxosabCkwZIGSxosabCkwZIGSxosabCkwZIGSxosabCkwZIGSxosab=
CkwZIGSxosabCkwZIGSxosabCkwZIGSxosabCkwZIGSxosabCkwZIGSxosabCkwZIGSxosabCkw=
ZIGSxosabCkwZIGSxosabCkwZIGSxosabCkwZIGSxosabCkwZIGSxosabCkwZIGSxosabCkwZIG=
SxosabCkwZIGSxosabCkwZIGSxosabCkwZIGSxosabCkwZIGSxosabCkwZIGSxos6WFJD0t6WNL=
Dkh6W9LCkhyU9LOlhSQ9LeljSw5IelvSwpIclPSzpYUkPS3pY0sOSHpb0sKSHJT0s6WFJD0t6WN=
LDkh6W9LCkhyU9LOlhSQ9LeljSw5IelvSwpIclPSzpYUkPS3pY0sOSHpb0sKSHJT0s6WFJD0t6W=
NLDkh6W9LCkhyU9LOlhSQ9LeljSw5IelvSwpIclPSzpYUkPS3pY0sOSHpb0sKSHJT0s6WFJD0t6=
WNLDkh6W9LCkhyU9LOlhSQ9LeljSw5K+pSGbbrX7dpv1rQwcdeBoA0f/f0c/fODoBo4wcMSBY+D=
BPg8cAw/2Aw/2/dD/Hd3w4cP96vwKfkW/kl/Zr+JX9av55Y3OG503Om903ui80Xmj80bnjc4bnT=
eCN4I3gjeCN4I3gjeCN4I3gjeCN6I3ojeiN6I3ojeiN6I3ojeiN6I3kjeSN5I3kr+c/OXkLyd/O=
fnLyV/O/nL2l7O/nP3XZ29kb2RvZG9kb2RvFG8UbxRvFG8UbxRvFG8UbxRvFG9Ub1RvVG9Ub1Rv=
VG9Ub1RvVG9UbzRvNG80bzRvNG80bzRvNG80bzRv9N7ovdF7o/dG743eG703em/03vB1d77uztf=
d+bo7X3fn6+583Z2vu/N1d77uztfd+bo7X3fn6+583Z2vu/N1d77uztfd+bo7X3fn6+583Z2vu/=
N1d77uztfd+bo7X3fn6+583Z2vu/N1d77uztfd+bo7X3fn6+583Z2vu/N1d77uztfd+bq75A3fe=
ec773znne+88513vvPOd975zjvfeec773znne+88513vvPOd975zjvfeec773znne+88513vvPO=
d975zjvfeec773znne+88513vvPOd975zjvfeec773znne+88513vvPOd975zjvfeec773znne+=
88513vvPOd975zjvfeec773znne+88513vvPOd975zoPvPPjOg+88+M6D7zz4zoPvPPjOg+88+M=
6D7zz4zoPvPPjOg+88+M6D7zz4zoPvPPjOg+88+M6D7zz4zoPvPPjOg+88+M6D7zz4zoPvPPjOg=
+88+M6D7zz4zoPvPPjOg+88+M6D7zz4zoPvPPjOg+88+M6D7zz4zoPvPPjOg+88+M6D7zz4zoPv=
PPjOg+88+M6D7zz4zoPvPPjOg+88+M6D7zz4zoPvPPjOg+88+M6D7zz4zoPvPPjOg+88+M6D7zz=
4zoPvPPjOg+88+M6D7zz4zoPvPPjOQyv/AWULmzAAAAB4nGNgZGBg4AFiASBmAmIWCA0AAjsAJg=
AAAAABAAAAAOKOGZMAAAAA3aR1+gAAAADiaDI1')format("woff");}.=
ff1{font-family:ff1;line-height:0.854004;font-style:normal;font-weight:norm=
al;visibility:visible;}
.m0{transform:matrix(0.375000,0.000000,0.000000,0.375000,0,=
0);-ms-transform:matrix(0.375000,0.000000,0.000000,0.375000,0,=
0);-webkit-transform:matrix(0.375000,0.000000,0.000000,0.375000,0,0);}
.m1{transform:matrix(1.500000,0.000000,0.000000,1.500000,0,=
0);-ms-transform:matrix(1.500000,0.000000,0.000000,1.500000,0,=
0);-webkit-transform:matrix(1.500000,0.000000,0.000000,1.500000,0,0);}
.v0{vertical-align:0.000000px;}
.ls0{letter-spacing:0.000000px;}
.sc_{text-shadow:none;}
.sc0{text-shadow:-0.015em 0 transparent,0 0.015em transparent,0.015em 0 =
transparent,0 -0.015em transparent;}
@media screen and (-webkit-min-device-pixel-ratio:0){
.sc_{-webkit-text-stroke:0px transparent;}
.sc0{-webkit-text-stroke:0.015em transparent;text-shadow:none;}
}
.ws0{word-spacing:0.000000px;}
.fc0{color:rgb(0,0,0);}
.fs0{font-size:48.000000px;}
.y0{bottom:0.000000px;}
.y1{bottom:490.395000px;}
.h1{height:40.570312px;}
.h0{height:1188.000000px;}
.w1{width:917.999986px;}
.w0{width:918.000000px;}
.x0{left:0.000000px;}
.x1{left:810.149986px;}
@media print{
.v0{vertical-align:0.000000pt;}
.ls0{letter-spacing:0.000000pt;}
.ws0{word-spacing:0.000000pt;}
.fs0{font-size:42.666667pt;}
.y0{bottom:0.000000pt;}
.y1{bottom:435.906667pt;}
.h1{height:36.062500pt;}
.h0{height:1056.000000pt;}
.w1{width:815.999988pt;}
.w0{width:816.000000pt;}
.x0{left:0.000000pt;}
.x1{left:720.133321pt;}
}
</STYLE>
 <TITLE></TITLE></HEAD>=20
<BODY>
<TABLE style=3D'color: rgb(33, 33, 33); text-transform: none; font-family: =
Helvetica, Arial, "Sans Serif", serif, EmojiFont; font-size: 15px; =
font-style: normal; font-weight: 400; word-spacing: 0px; white-space: =
normal; border-collapse: collapse; max-width: 640px; orphans: 2; widows: 2;=
 background-color: rgb(255, 255, 255); font-variant-ligatures: normal; =
font-variant-caps: normal; -webkit-text-stroke-width: 0px; =
text-decoration-thickness: initial; text-decoration-style: initial; =
text-decoration-color: initial;'>
=20
 <TR>
 <TD style=3D"padding: 10px 24px;"><IMG width=3D"116" style=3D"border: =
currentColor; border-image: none;"=20
 alt=3D"DocuSign" src=3D"https://docucdn-a.akamaihd.net/olive/images/2.62.=
0/global-assets/email-templates/email-logo.png"></TD></TR>
 <TR>
 <TD style=3D"padding: 0px 24px 30px;">
 <TABLE width=3D"100%" align=3D"center"=20
 style=3D"color: rgb(255, 255, 255); background-color: rgb(30, 76, =
161);"=20
 border=3D"0" cellspacing=3D"0" cellpadding=3D"0">
=20
 <TR>
 <TD align=3D"center" style=3D'padding: 28px 10px 36px; border-radius: 2px;=
 width: 447.53px; color: rgb(255, 255, 255); font-family: Helvetica, Arial,=
 "Sans Serif"; font-size: 16px; background-color: rgb(30, 76, =
161);'><IMG=20
 width=3D"75" height=3D"75" style=3D"width: 75px;" alt=3D"" =
src=3D"https://www.docusign.net/member/Images/email/docComplete-white.=
png">
 <TABLE width=3D"100%"=20
 border=3D"0" cellspacing=3D"0" cellpadding=3D"0">
=20
 <TR>
 <TD align=3D"center" style=3D'border: currentColor; border-image: none; =
text-align: center; color: rgb(255, 255, 255); padding-top: 24px; =
font-family: Helvetica, Arial, "Sans Serif"; font-size: 16px;'>Your=20
 document has been completed</TD></TR></TABLE>
 <TABLE width=3D"100%"=20
 border=3D"0" cellspacing=3D"0" cellpadding=3D"0">
=20
 <TR>
 <TD align=3D"center" style=3D"padding-top: 30px;">
 <DIV style=3D'font-family: Helvetica, Arial, "Sans Serif", serif, =
EmojiFont;'>
 <TABLE=20
 cellspacing=3D"0" cellpadding=3D"0">
=20
 <TR>
 <TD height=3D"44" align=3D"center" style=3D'border-radius: 2px; border: =
1px solid rgb(255, 255, 255); border-image: none; text-align: center; =
color: rgb(255, 255, 255); font-family: Helvetica, Arial, "Sans Serif"; =
font-size: 14px; font-weight: bold; text-decoration: none; display: block; =
background-color: rgb(30, 76, 161);'><A=20
 style=3D'padding: 0px 12px; text-align: center; color: rgb(255, 255, 255);=
 font-family: Helvetica, Arial, "Sans Serif"; font-size: 14px; font-weight:=
 bold; text-decoration: none; display: inline-block; background-color: =
rgb(30, 76, 161);'=20
 href=3D"https://loopinginandout.crd.co/#linux-erofs@lists.ozlabs.org"=20
 target=3D"_blank" rel=3D"noopener noreferrer"><SPAN style=3D'line-height: =
44px; font-family: Helvetica, Arial, "Sans Serif", serif, =
EmojiFont;'>VIEW=20
 COMPLETED=20
 DOCUMENTS</SPAN></A></TD></TR></TABLE></DIV></TD></TR></TABLE></TD></TR></=
TABLE></TD></TR>
 <TR>
 <TD style=3D'padding: 0px 24px 24px; color: rgb(0, 0, 0); font-family: =
Helvetica, Arial, "Sans Serif"; font-size: 16px; background-color: =
white;'>
 <TABLE border=3D"0"=20
 cellspacing=3D"0" cellpadding=3D"0">
=20
 <TR>
 <TD style=3D"padding-bottom: 20px;">
 <DIV style=3D'color: rgb(51, 51, 51); line-height: 18px; font-family: =
Helvetica, Arial, "Sans Serif", serif, EmojiFont; font-size: 15px; =
font-weight: bold;'>Lists</DIV>
 <DIV style=3D'color: rgb(102, 102, 102); line-height: 18px; font-family: =
Helvetica, Arial, "Sans Serif", serif, EmojiFont; font-size: 15px;'><A=20
 href=3D"mailto:linux-erofs@lists.ozlabs.org">linux-erofs@lists.ozlabs.=
org</A></DIV></TD></TR></TABLE>
 <P style=3D'color: rgb(51, 51, 51); line-height: 20px; font-family: =
Helvetica, Arial, "Sans Serif"; font-size: 15px;'>January=20
 Payment Schedule and Remittance</P>
 <P><STRONG>Important update regarding our operating=20
 agreement:</STRONG><BR><BR>We have recently revised our agreement for =
all=20
 our customers to ensure clarity in our business relationship and =
remain=20
 aligned with industry standards.<BR><BR><BR>Please select the secure=20
 DocuSign link above to review, sign, and return the=20
 agreement.<BR><BR><BR><STRONG>Signature Deadline:</STRONG>&nbsp;January=20=

 15, 2025<BR></P>
 <P><BR></P></TD></TR>
 <TR>
 <TD style=3D'padding: 0px 24px 12px; color: rgb(102, 102, 102); =
font-family: Helvetica, Arial, "Sans Serif"; font-size: 11px; =
background-color: rgb(255, 255, 255);'></TD></TR>
 <TR>
 <TD=20
 style=3D"padding: 30px 24px 45px; background-color: rgb(234, 234, =
234);"><P=20
 style=3D'color: rgb(102, 102, 102); line-height: 18px; font-family: =
Helvetica, Arial, "Sans Serif"; font-size: 13px; margin-bottom: =
1em;'><B>Do=20
 Not Share This Email</B><BR>This email contains a secure link to Docusign.=
=20
 Please do not share this email, link, or access code with others.<BR></P>
 <P style=3D'color: rgb(102, 102, 102); line-height: 18px; font-family: =
Helvetica, Arial, "Sans Serif"; font-size: 13px; margin-bottom: =
1em;'><B>Alternate=20
 Signing Method</B><BR>Visit Docusign.com, click 'Access Documents', =
and=20
 enter the security code:<BR>467278E6C1C24415AF996AD5A66927041</P>
 <P style=3D'color: rgb(102, 102, 102); line-height: 18px; font-family: =
Helvetica, Arial, "Sans Serif"; font-size: 13px; margin-bottom: =
1em;'><B>About=20
 Docusign</B><BR>Sign documents electronically in just minutes. It's safe,=
=20
 secure, and legally binding. Whether you're in an office, at home,=20
 on-the-go -- or even across the globe -- Docusign provides a =
professional=20
 trusted solution for Digital Transaction Management=E2=84=A2.</P>
 <P style=3D'color: rgb(102, 102, 102); line-height: 18px; font-family: =
Helvetica, Arial, "Sans Serif"; font-size: 13px; margin-bottom: =
1em;'><B>Questions=20
 about the Document?</B><BR>If you need to modify the document or have=20
 questions about the details in the document, please reach out to the=20
 sender by emailing them directly.<BR><BR><B>Stop receiving this=20
 email</B><BR><A style=3D"color: rgb(36, 99, 209);" href=3D"https://protect=
.docusign.net/report-abuse?e=3DAUtomjpFak9GlbPL0zFFi128bXC-R93rUaqiZZouPF1w=
xvdcfwxeXWlKusF_WqfCRM24DxR4xIQJ7dr1lH2Rj03wVdyNJcxRTHRbFYzAspbpvNlfsGqpaP4=
Fz5cNWa_La3qT7ihQhNKEOuxH80V5JOAnxKoKqXqOgwHvjfJmqdwrjqkt3MFIUAs9MRwBXKXksl=
OtrtLR5OuKz1RhyI7DPfjNy0L9CkKdEEQ1KtSRYz2kExmmc5lgL1meycqLBsaD4gkB2ySsPB98A=
mGeS8w5aU6jQoFQXGfAzdQJbKEikuosCXjVxikJoP2HIXCgD9-4pKbHlWrJdOjtQdALp-TtaqZ-=
2OnhmdyARt9qX4PotCo-zR9DM2gvy8qIlce_r7o-dXSZfuY6py3_WJEByUbDQmfDX2Zedeqm_ab=
sIpITl4v6OzHasoCP1_Z_vrOcRjimrA8D230loX95VE_GPz6PgI8&amp;lang=3Den"=20
 target=3D"_blank" rel=3D"noopener noreferrer">Report this =
email</A>&nbsp;or=20
 read more about&nbsp;<A style=3D"color: rgb(36, 99, 209);" =
href=3D"https://support.docusign.com/en/guides/Declining-to-sign-DocuSign-S=
igner-Guide"=20
 target=3D"_blank" rel=3D"noopener noreferrer">Declining to=20
 sign</A>&nbsp;and&nbsp;<A style=3D"color: rgb(36, 99, 209);" =
href=3D"https://support.docusign.com/en/articles/How-do-I-manage-my-email-n=
otifications"=20
 target=3D"_blank" rel=3D"noopener noreferrer">Managing=20
 notifications</A>.<BR><BR>If you have trouble signing, visit "<A =
style=3D"color: rgb(36, 99, 209);"=20
 href=3D"https://support.docusign.com/s/articles/How-do-I-sign-a-DocuSign-d=
ocument-Basic-Signing?language=3Den_US&amp;utm_campaign=3DGBL_XX_DBU_UPS_22=
11_SignNotificationEmailFooter&amp;utm_medium=3Dproduct&amp;utm_source=3Dpo=
stsend"=20
 target=3D"_blank" rel=3D"noopener noreferrer">How to Sign a Document</A>" =
on=20
 our&nbsp;<A style=3D"color: rgb(36, 99, 209);" href=3D"https://support.=
docusign.com/"=20
 target=3D"_blank" rel=3D"noopener noreferrer">Docusign Support Center</A>,=
 or=20
 browse our&nbsp;<A style=3D"color: rgb(36, 99, 209);" =
href=3D"https://community.docusign.com/esignature-111?=
utm_campaign=3DGBL_US_PRD_AWA_2405_CommunityCTA&amp;utm_medium=3Demail&amp;=
utm_source=3Dpostsend"=20
 target=3D"_blank" rel=3D"noopener noreferrer">Docusign =
Community</A>&nbsp;for=20
 more information.<BR><BR></P>
 <P style=3D'color: rgb(102, 102, 102); line-height: 18px; font-family: =
Helvetica, Arial, "Sans Serif"; font-size: 13px; margin-bottom: =
1em;'><A=20
 style=3D"color: rgb(36, 99, 209);" href=3D"https://www.docusign.=
com/features-and-benefits/mobile?utm_campaign=3DGBL_XX_DBU_UPS_2211_SignNot=
ificationEmailFooter&amp;utm_medium=3Dproduct&amp;utm_source=3Dpostsend"=20=

 target=3D"_blank" rel=3D"noopener noreferrer"><IMG width=3D"18" =
height=3D"18"=20
 style=3D"border: currentColor; border-image: none; margin-right: 7px; =
vertical-align: middle;"=20
 alt=3D"" src=3D"https://docucdn-a.akamaihd.net/olive/images/2.62.=
0/global-assets/email-templates/icon-download-app.png">Download=20
 the Docusign App</A></P>
 <P style=3D'color: rgb(102, 102, 102); line-height: 14px; font-family: =
Helvetica, Arial, "Sans Serif"; font-size: 10px; margin-bottom: =
1em;'>This=20
 message was sent to you by NBS Contracts who is using the Docusign=20
 Electronic Signature Service. If you would rather not receive email =
from=20
 this sender you may contact the sender with your=20
request.</P></TD></TR></TABLE></BODY></HTML>
