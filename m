Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 869EB998FD0
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 20:24:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPdSG43f8z3blK
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 05:23:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=142.171.88.164
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728584636;
	cv=none; b=R1ScH385oY+9yKgS7abFRHAl6/KK85Gtz+LnsK48CB2k8OwdkqgCK27fKm0k7sqquPnTlXL1zPI7m3gsF0EpjjiS+FPhMMPghpEqBoi4AuLHSuactHs4OZ/93Hfje80VnyGAKj/HHbKqBQA35ZUOz/IAUAGSxrv4VouNqrjfvMZwy8hUQUhEqWyzf6GfjJbDGZb0IIsblbMkFxVu/xdadzfhZIxRoFnZXW555p6TXccn8IjTNcDbcrpGFkuYXKTS8i0WLIJJIzUNzD/V30aMGZp1zd1R1qI7fLQZDhLFZ1ucovuqIG+/L0TDqX4De9K0aHM/lSDNoTU6z5fceAlyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728584636; c=relaxed/relaxed;
	bh=2MRrhjQVxoetfgay87Opp+bbXTrlCV+zzzIZY7woQBY=;
	h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type; b=EYxtjouYynf4Jh6fm8seJ92wkPSa2k1l50lEqUTiobarAkoBQX4NN94K2i2LkfgGSx6omY94txiWTM+Z2widqsEjneEzukSWYeoUPp+4Ta73ZhUfcE/acz/kVHeuaJnIfaNgEyK7Oe+VFyIfwQOeYFNL0Ki422VEFjyJfk2G7qzTZB52Ym2bnfN7xrOnhl9ABt0IAEUVYNTVhXDzCHI+1fr2//peCvm9YcsLDaXYfRX5EDUYBDV17+v/sy75cev+3j4odlL6G+c7FJhhYJ7tDqJxFtcAdfK22oVmbdng4B+iIVcKG07QiCUoxwlH9IgNG4V+HfFWET2A3rixN3YUQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gf.prooemparts.com; dkim=pass (2048-bit key; unprotected) header.d=gf.prooemparts.com header.i=@gf.prooemparts.com header.a=rsa-sha256 header.s=mailer header.b=CwCzzLff; dkim-atps=neutral; spf=pass (client-ip=142.171.88.164; helo=westcott.mu.precisionmoldingsolutions.com; envelope-from=queena@jnn.abgev.com; receiver=lists.ozlabs.org) smtp.mailfrom=jnn.abgev.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gf.prooemparts.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gf.prooemparts.com header.i=@gf.prooemparts.com header.a=rsa-sha256 header.s=mailer header.b=CwCzzLff;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=jnn.abgev.com (client-ip=142.171.88.164; helo=westcott.mu.precisionmoldingsolutions.com; envelope-from=queena@jnn.abgev.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1802 seconds by postgrey-1.37 at boromir; Fri, 11 Oct 2024 05:23:55 AEDT
Received: from westcott.mu.precisionmoldingsolutions.com (westcott.mu.precisionmoldingsolutions.com [142.171.88.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPdSC20whz2xJ8
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Oct 2024 05:23:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256;
 bh=2MRrhjQVxoetfgay87Opp+bbXTrlCV+zzzIZY7woQBY=; d=gf.prooemparts.com;
 h=Message-ID: Date: Subject: From: Reply-To: To: MIME-Version: Content-Type:
 Feedback-ID; i=@gf.prooemparts.com; s=mailer; c=relaxed/relaxed;
 t=1728582783;
 b=CwCzzLff2jeyCpW63x3g+2OF2k5oxcAMK96ZcN8cxOwosU2K/Fd5DgBrBb8klIQGlnn7dZ5I+
 XrskmOQzq0+F+rJKpRVma9C4d/hoN2u9iF64qwhZ/q1CkI4F9cI5SQJHiISsA4bsWul7LVn95
 qaI7sxqSi0jHWgSxuTiBOBx9MTjRCma2+fJpcGSpQdI2Miihilb1Nb3gO+h3SdVbRTDE3SH1C
 +U66ZhwIh8dyRY4jpP+GAcOtp9Fv3yTLhzzSfx8hiiWJf/pWmjBHSa7YHhzeF5GMfXLlJAYro
 evkmC4OIHbmOP45AQKMnbK4lm7aTXtql/201TBN7fuaDpc8yPg==
Message-ID: <3ef0c34b3e441cb3a1a54ca97abe90347752d649@jnn.abgev.com>
Date: Thu, 10 Oct 2024 17:53:03 +0000
Subject: Precision Die Casting for Optimal Product Quality
From: Manager of Molding <qcd@gf.prooemparts.com>
To: Linux erofs <linux-erofs@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="_=_swift_1728582783_fb11d252b438f20bdaab2fc4c2f0d9cf_=_"
Feedback-ID: nr438exxb4a40:regular:dt715recfkb51:pw841wvabp9d8
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
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
Reply-To: Manager of Molding <info@en.indhous.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--_=_swift_1728582783_fb11d252b438f20bdaab2fc4c2f0d9cf_=_
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

 good afternoon Linux erofs,

This is Petre from CNM. We started in 200=
0 as a precision casting
company and have since diversified into die cast=
ing and precision
casting.

We have both high pressure and low pressu=
re die casting equipment,
including 19 high pressure die casting machines=
 and 28 low pressure
machines; the high pressure process is mainly for al=
uminum alloy, and
the low pressure process includes aluminum alloy, zinc =
alloy, and
magnesium alloy as primary materials.

The precision casti=
ng workshop started exclusively with steel
precision casting and subseque=
ntly enhanced its offerings by adding
die casting, sand casting, gravity =
casting, and additional casting
options.

Our machining workshop feat=
ures 50 CNC lathes (four-axis and
five-axis), along with a complete range=
 of equipment, including
milling machines, grinders, drill machines, hydr=
aulic presses,
punches, and laser engravers. This equipment allows us to =
manufacture
our own products and also to undertake the machining of non-s=
tandard
custom parts for international trade. We work with materials such=
 as
metal, plastic, and rubber, serving industries like automotive,
ind=
ustrial, agricultural, aviation, medical, 5G, and transportation.

If y=
ou see a chance for us to work together, please share your
drawings or sa=
mples, and our technical and quality department will
rapidly get back to =
you with the most attractive price!

Kate Chen - Supplier Quality Engin=
eer - DEF Manufacturing

=20

--_=_swift_1728582783_fb11d252b438f20bdaab2fc4c2f0d9cf_=_
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
<head><meta charset=3D"utf-8"/>
=09<title>Prec=
ision Die Casting for Optimal Product Quality</title>
</head>
<body>goo=
d afternoon Linux erofs,<br />
<br />
This is Petre from CNM. We starte=
d in 2000 as a precision casting company and have since diversified into di=
e casting and precision casting.<br />
<br />
We have both high pressur=
e and low pressure die casting equipment, including 19 high pressure die ca=
sting machines and 28 low pressure machines; the high pressure process is m=
ainly for aluminum alloy, and the low pressure process includes aluminum al=
loy, zinc alloy, and magnesium alloy as primary materials.<br />
<br />=

The precision casting workshop started exclusively with steel precision =
casting and subsequently enhanced its offerings by adding die casting, sand=
 casting, gravity casting, and additional casting options.<br />
<br />=

Our machining workshop features 50 CNC lathes (four-axis and five-axis),=
 along with a complete range of equipment, including milling machines, grin=
ders, drill machines, hydraulic presses, punches, and laser engravers. This=
 equipment allows us to manufacture our own products and also to undertake =
the machining of non-standard custom parts for international trade. We work=
 with materials such as metal, plastic, and rubber, serving industries like=
 automotive, industrial, agricultural, aviation, medical, 5G, and transport=
ation.<br />
<br />
If you see a chance for us to work together, please=
 share your drawings or samples, and our technical and quality department w=
ill rapidly get back to you with the most attractive price!<br />
<br />=

Kate Chen - Supplier Quality Engineer - DEF Manufacturing<br />
<br />=

<scroll-to-top-button-container data-position-horizontal=3D"right" data-=
position-vertical=3D"bottom" data-state-active=3D""> <noscript>
<style ty=
pe=3D"text/css">scroll-to-top-button-container { display: none !important; =
}
</style>
</noscript> </scroll-to-top-button-container><scroll-to-top-=
button-container data-position-horizontal=3D"right" data-position-vertical=
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
</noscript> </scroll-to-top-button-container></body>
<=
scroll-to-top-button-container data-position-horizontal=3D"right" data-posi=
tion-vertical=3D"bottom" data-state-active=3D"">
<noscript>
<style type=
=3D"text/css">scroll-to-top-button-container { display: none !important; }=

</style>
</noscript>
</scroll-to-top-button-container></html>

--_=_swift_1728582783_fb11d252b438f20bdaab2fc4c2f0d9cf_=_--

