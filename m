Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8587388606C
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Mar 2024 19:16:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V0tvm4GfQz3dVx
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Mar 2024 05:16:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cea.fr (client-ip=132.167.192.228; helo=sainfoin-smtp-out.extra.cea.fr; envelope-from=nicolas.granger@cea.fr; receiver=lists.ozlabs.org)
X-Greylist: delayed 1640 seconds by postgrey-1.37 at boromir; Fri, 22 Mar 2024 05:16:43 AEDT
Received: from sainfoin-smtp-out.extra.cea.fr (sainfoin-smtp-out.extra.cea.fr [132.167.192.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V0tvb6Zd5z3cZK
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Mar 2024 05:16:42 +1100 (AEDT)
Received: from e-emp-a0.extra.cea.fr (e-emp-a0.extra.cea.fr [132.167.198.35])
	by sainfoin-sys.extra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP id 42LHnDAI052245
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Mar 2024 18:49:13 +0100
Received: from pps.filterd (e-emp-a0.extra.cea.fr [127.0.0.1])
	by e-emp-a0.extra.cea.fr (8.17.1.24/8.17.1.24) with ESMTP id 42LHjsHh013125
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Mar 2024 18:49:13 +0100
Received: from muguet1-smtp-out.intra.cea.fr (muguet1-smtp-out.intra.cea.fr [132.166.192.12])
	by e-emp-a0.extra.cea.fr (PPS) with ESMTP id 3x07k85pp9-1
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Mar 2024 18:49:12 +0100 (CET)
Received: from I-EXCH-B2.intra.cea.fr (i-exch-b2.intra.cea.fr [132.166.88.236])
	by muguet1-sys.intra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP id 42LHnCvd001948
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Mar 2024 18:49:12 +0100
Received: from I-EXCH-A2.intra.cea.fr (132.166.88.226) by
 I-EXCH-B2.intra.cea.fr (132.166.88.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 21 Mar 2024 18:49:12 +0100
Received: from I-EXCH-A2.intra.cea.fr ([132.166.88.226]) by
 I-EXCH-A2.intra.cea.fr ([132.166.88.226]) with mapi id 15.01.2507.027; Thu,
 21 Mar 2024 18:49:12 +0100
From: GRANGER Nicolas <nicolas.granger@cea.fr>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: Slow concurrent reads on mounted loopback images
Thread-Topic: Slow concurrent reads on mounted loopback images
Thread-Index: AQHae7cGODh9xYTF2Eis1g82xizkpw==
Date: Thu, 21 Mar 2024 17:49:12 +0000
Message-ID: <894a823bf73641e1a2f177cefea83dbd@cea.fr>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [132.166.88.55]
x-tm-as-product-ver: SMEX-14.0.0.3080-9.0.1002-28266.000
x-tm-as-result: No-10--8.632800-8.000000
x-tmase-matchedrid: biL4YBBTMFaHQbrjloMo1Wg4D2QV/2zL6r3HCixfuKcc4ri4RJV/1d/O
	0TkwpBlDW5prtLhe9fW2kdECpOqtDcgM2GUFlvvaAjqAxuWkdTGOVGny5q72hpbI+L60qto8csx
	FLHbqBOKqH12uH+NHwq9PFo24EQfh4uz7w3KuxqydVNZaI2n6/5s7CfArGWFOiEiOvN7JAwrr76
	lSVRWjbSCTTYRivZuDbVs4Wv808jiJD329j4iIzMZmqSBzWZjEuVA5gviUr6wAJE0PfeCE1xQy+
	Gzi/Qd+5Rbg4NL8BOl5OPD8XJFfpEOrZJUSTvYo/hxxPCwzUoNIGo8bxrs5oa6DsiBwk1eFPfiW
	TuY5koPoLMfqky7X81ONIHxF2WfiQCl30gpd5m8=
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--8.632800-8.000000
x-tmase-version: SMEX-14.0.0.3080-9.0.1002-28266.000
x-tm-snts-smtp: 9A36F2686E42A0D3C93BD8A04993BAB1E4C039C11A10D54CC6750861FAA35CF52000:8
Content-Type: multipart/alternative;
	boundary="_000_894a823bf73641e1a2f177cefea83dbdceafr_"
MIME-Version: 1.0
X-Proofpoint-GUID: S6xstADi4fPCH3xSIAA4XXQoZioRhqSa
X-Proofpoint-ORIG-GUID: S6xstADi4fPCH3xSIAA4XXQoZioRhqSa
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

--_000_894a823bf73641e1a2f177cefea83dbdceafr_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi erofs team,


I'm working on a small daemon that caches and mounts disk images containing=
 datasets based on usage (https://github.com/CEA-LIST/scratch_manager).

My understanding is that this is a good use-case for EROFS. However, in my =
experience concurrent reads on loopback mounted disk images are rather slow=
.

I tested both squashfs and erofs images so I don't think it is specific to =
erofs, I just can't figure out where the bottleneck is. By any chance would=
 you have any any tips to share on that subject?


Best,

Nicolas Granger

--_000_894a823bf73641e1a2f177cefea83dbdceafr_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hi erofs team,</p>
<p><br>
</p>
<p>I'm working on a small daemon that caches and mounts disk images contain=
ing datasets based on usage (<a href=3D"https://github.com/CEA-LIST/scratch=
_manager" class=3D"OWAAutoLink" id=3D"LPlnk212396">https://github.com/CEA-L=
IST/scratch_manager</a>).</p>
<p>My understanding is that this is a good use-case for EROFS. However, in =
my experience concurrent reads on loopback mounted disk images are rather s=
low.</p>
<p>I tested both squashfs and erofs images so I don't think it is specific =
to erofs, I just can't figure out where the bottleneck is. By any chance wo=
uld you have any any tips to share on that subject?</p>
<p><br>
</p>
<p>Best,</p>
<p>Nicolas Granger<br>
</p>
</div>
</body>
</html>

--_000_894a823bf73641e1a2f177cefea83dbdceafr_--
