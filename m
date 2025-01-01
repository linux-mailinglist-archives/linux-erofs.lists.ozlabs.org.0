Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4520D9FF4BF
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Jan 2025 19:19:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YNdQ95wswz2yVT
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2025 05:18:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.95.140.46
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735755536;
	cv=none; b=ALVivawXhFbPv1P5oxB6bYq6E/b4afX5p0w+wYduCUkUWTLw+sea5w4OQJsH2aKt0L4mtNm3GgpsP9q1PQ408Pyg+oXnv8J5xVQZ7htlpYazY16Nzsx45kLV8biK/7/v5WhU1TYxTq7QcB5yVR08XzY1HaLiuyJyL+G1Dtu5xjHxMynQOxy4ar33oCEjIaIA471MU7lZxUMtzTU8grxYnUPfQC6IAUtZ4qqKee+7NFctMQlmncf5O4ZgO9c4hYVmBoyDYsueWyZudTNqlcCDV+QHMBV0+nw3CRbfop6ZC2WFwBDkZiF3wk5X/avZct3/YuMqysvhJEX4KZrkB1RIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735755536; c=relaxed/relaxed;
	bh=yZoujjuoHOIscwBaK88nIPwg7F9OFbn/eabUcw5Z0eA=;
	h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type:
	 References; b=oFc4gFp0FIX+NjlnwWIoYhmXkwEKrp6g2V+VN41pCYByN8pUtCbGgz5qYQQukM7N9vvDuFburaIjECvnLCLumJyJUi5SRmBOlOvVMuTmwUAHO1Pci2FNNfLCpGhcJwgSWxjZy6ly22aG37er1oBWcymFg0CAB+hRaU+QIxgjGhtPgpl0052XOeeIKvbxJ1S4eEGp34xqAAHr/QrQbctmk6Ks+OipbvYlQu7hycD2IIRzyFSFMj9YXXBAYmuFgG189IQNaLH9yge6izyx6n36rY8qCPXrw3VRbyzz3MQazdcdVhP9UXoVoBitlkRZbphUEiL8ITpd0egKr4erRko8rA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=xzr.extdie.com; dkim=fail header.d=xzr.extdie.com header.i=aleen@xzr.extdie.com header.a=rsa-sha256 header.s=selector2 header.b=q5kfGXw1 reason="key not found in DNS"; dkim=pass (2048-bit key; unprotected) header.d=xzr.extdie.com header.i=@xzr.extdie.com header.a=rsa-sha256 header.s=mailer header.b=ErBg8lpl; dkim-atps=neutral; spf=pass (client-ip=23.95.140.46; helo=constructlab.expertmoldmakers.com; envelope-from=trena@rh.malydworek.com; receiver=lists.ozlabs.org) smtp.mailfrom=rh.malydworek.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=xzr.extdie.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="key not found in DNS" header.d=xzr.extdie.com header.i=aleen@xzr.extdie.com header.a=rsa-sha256 header.s=selector2 header.b=q5kfGXw1;
	dkim=pass (2048-bit key; unprotected) header.d=xzr.extdie.com header.i=@xzr.extdie.com header.a=rsa-sha256 header.s=mailer header.b=ErBg8lpl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rh.malydworek.com (client-ip=23.95.140.46; helo=constructlab.expertmoldmakers.com; envelope-from=trena@rh.malydworek.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1204 seconds by postgrey-1.37 at boromir; Thu, 02 Jan 2025 05:18:54 AEDT
Received: from constructlab.expertmoldmakers.com (constructlab.expertmoldmakers.com [23.95.140.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YNdQ62Ygkz2xWT
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Jan 2025 05:18:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=selector2; d=xzr.extdie.com;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:
 References; i=aleen@xzr.extdie.com;
 bh=yZoujjuoHOIscwBaK88nIPwg7F9OFbn/eabUcw5Z0eA=;
 b=q5kfGXw1nA7Y31ZV9BUOuA5BpgdgwZaN4XxSnEQQyaVaGccaZF0kT/7APS2U+bm/Abgvzk8Ngx4o
   PD6CCWwnui0/wjGR++T/bQ53JEErpfh7+R46FTx517utloIBdaMvvrawTiO5w9SnlW1jlpRhFJIb
   ytEkQ9CfDxo5gleiLZY=
DKIM-Signature: v=1; a=rsa-sha256;
 bh=yZoujjuoHOIscwBaK88nIPwg7F9OFbn/eabUcw5Z0eA=; d=xzr.extdie.com;
 h=Message-ID: Date: Subject: From: Reply-To: To: MIME-Version: Content-Type:
 References; i=@xzr.extdie.com; s=mailer; c=relaxed/relaxed; t=1735754326;
 b=ErBg8lplnMkWfWHyw+XaSseB7IJtO8rJEbHmmBBhw3Rp/N+4vk+F0JWZomcs62GPo8XOu/X2y
 9h45pKzZq17IfK8jFBWXYH/lhceSKHspR2BGDGgXk6x0BRwGk3I69LvOOZNN9l+C3FIBGnjgt
 /xCPu8ARB+Ps1pbuRrikfUj5FR/B3prsjMUYc+TkLKkaD7T2QV7t7LybAozOabMrBEaSeky6t
 DnNJ5tXDoAGDbQ7CEDIiSSqfw6RE6/kAxUhgq2DnLbqUj+TgtF2fGyCY9W6Xq7FWn7oj1g6Qd
 +uHGQkm4ydH84xdmey55r/1GxebONshMLePFbf6RazwLHXFRrg==
Message-ID: <4b0ade799f38336fc308ee03df045a76fcb508f8@rh.malydworek.com>
Date: Wed, 01 Jan 2025 17:58:46 +0000
Subject: Leading the Industry with Innovative CNC Techniques
From: cnm enterprise <aleen@xzr.extdie.com>
To: Linux erofs <linux-erofs@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="_=_swift_1735754326_70a82af88da13ba3aa15c7779ad975ee_=_"
References: pw841wvabp9d8
X-Spam-Status: No, score=3.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,T_STY_INVIS_DIRECT
	autolearn=disabled version=4.0.0
X-Spam-Level: ***
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
Reply-To: cnm enterprise <info@en.fastchng.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--_=_swift_1735754326_70a82af88da13ba3aa15c7779ad975ee_=_
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

 good evening Linux erofs,

Hello, my name is Petre, and I represent CN=
M. We initiated our
operations in 2000 as a precision casting company and=
 expanded into
die casting over time.

The company possesses both hig=
h pressure and low pressure die casting
machinery, with 19 units of high =
pressure die casting machines and 28
units of low pressure die casting ma=
chines; the primary material for
high pressure casting is aluminum alloy,=
 while low pressure casting
primarily utilizes aluminum alloy, zinc alloy=
, and magnesium alloy.

Originally, the precision casting workshop deal=
t only with steel
precision casting, but it later added capabilities for =
die casting,
sand casting, gravity casting, and other casting techniques.=


We have our own machining workshop equipped with 50 CNC lathes
(inc=
luding both four-axis and five-axis machines), alongside an array
of mach=
inery such as milling machines, grinders, drill presses,
hydraulic presse=
s, punches, and laser engravers. Our machining
capabilities allow us to p=
roduce our own products while primarily
focusing on the machining of non-=
standard custom parts for foreign
trade goods. The materials we work with=
 include metal, plastic, and
rubber, catering to industries such as autom=
otive parts,
manufacturing, agriculture, aviation, healthcare, 5G technol=
ogy, and
transportation.

If we can find a way to cooperate, please s=
end us your drawings or
samples, and our technical and quality team will =
respond in no time
with the best possible price!

Supplier Management=
 Department - Kate Chen, Supplier Engineer

pw841wvabp9d8=20

--_=_swift_1735754326_70a82af88da13ba3aa15c7779ad975ee_=_
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
<head><meta charset=3D"utf-8"/>
=09<title>Lead=
ing the Industry with Innovative CNC Techniques</title>
</head>
<body>g=
ood evening Linux erofs,<br />
<br />
Hello, my name is Petre, and I re=
present CNM. We initiated our operations in 2000 as a precision casting com=
pany and expanded into die casting over time.<br />
<br />
The company =
possesses both high pressure and low pressure die casting machinery, with 1=
9 units of high pressure die casting machines and 28 units of low pressure =
die casting machines; the primary material for high pressure casting is alu=
minum alloy, while low pressure casting primarily utilizes aluminum alloy, =
zinc alloy, and magnesium alloy.<br />
<br />
Originally, the precision=
 casting workshop dealt only with steel precision casting, but it later add=
ed capabilities for die casting, sand casting, gravity casting, and other c=
asting techniques.<br />
<br />
We have our own machining workshop equi=
pped with 50 CNC lathes (including both four-axis and five-axis machines), =
alongside an array of machinery such as milling machines, grinders, drill p=
resses, hydraulic presses, punches, and laser engravers. Our machining capa=
bilities allow us to produce our own products while primarily focusing on t=
he machining of non-standard custom parts for foreign trade goods. The mate=
rials we work with include metal, plastic, and rubber, catering to industri=
es such as automotive parts, manufacturing, agriculture, aviation, healthca=
re, 5G technology, and transportation.<br />
<br />
If we can find a wa=
y to cooperate, please send us your drawings or samples, and our technical =
and quality team will respond in no time with the best possible price!<br /=
>
<br />
Supplier Management Department - Kate Chen, Supplier Engineer<=
br />
<br />
<scroll-to-top-button-container data-position-horizontal=
=3D"right" data-position-vertical=3D"bottom" data-state-active=3D""> <noscr=
ipt>
<style type=3D"text/css">scroll-to-top-button-container { display: n=
one !important; }
</style>
</noscript> </scroll-to-top-button-container=
><scroll-to-top-button-container data-position-horizontal=3D"right" data-po=
sition-vertical=3D"bottom" data-state-active=3D""> <noscript>
<style type=
=3D"text/css">scroll-to-top-button-container { display: none !important; }=

</style>
</noscript> </scroll-to-top-button-container><scroll-to-top-b=
utton-container data-position-horizontal=3D"right" data-position-vertical=
=3D"bottom" data-state-active=3D""> <noscript>
<style type=3D"text/css">s=
croll-to-top-button-container { display: none !important; }
</style>
</=
noscript> </scroll-to-top-button-container><scroll-to-top-button-container =
data-position-horizontal=3D"right" data-position-vertical=3D"bottom" data-s=
tate-active=3D""> <noscript>
<style type=3D"text/css">scroll-to-top-butto=
n-container { display: none !important; }
</style>
</noscript> </scroll=
-to-top-button-container><scroll-to-top-button-container data-position-hori=
zontal=3D"right" data-position-vertical=3D"bottom" data-state-active=3D""> =
<noscript>
<style type=3D"text/css">scroll-to-top-button-container { disp=
lay: none !important; }
</style>
</noscript> </scroll-to-top-button-con=
tainer><scroll-to-top-button-container data-position-horizontal=3D"right" d=
ata-position-vertical=3D"bottom" data-state-active=3D""> <noscript>
<styl=
e type=3D"text/css">scroll-to-top-button-container { display: none !importa=
nt; }
</style>
</noscript> </scroll-to-top-button-container><scroll-to-=
top-button-container data-position-horizontal=3D"right" data-position-verti=
cal=3D"bottom" data-state-active=3D""> <noscript>
<style type=3D"text/css=
">scroll-to-top-button-container { display: none !important; }
</style>=

</noscript> </scroll-to-top-button-container><div style=3D"display:none;=
">pw841wvabp9d8</div>

</body>
<scroll-to-top-button-container data-p=
osition-horizontal=3D"right" data-position-vertical=3D"bottom" data-state-a=
ctive=3D"">
<noscript>
<style type=3D"text/css">scroll-to-top-button-co=
ntainer { display: none !important; }
</style>
</noscript>
</scroll-t=
o-top-button-container></html>

--_=_swift_1735754326_70a82af88da13ba3aa15c7779ad975ee_=_--

