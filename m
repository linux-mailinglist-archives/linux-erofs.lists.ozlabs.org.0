Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D98A974859
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 04:51:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X3Q7M5M5xz2yhg
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 12:51:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.58.52.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726023068;
	cv=none; b=bRsqYMECjOA2FK6ZbDxOA+pu7QYB+p29/erP7dD/qIsLyFCznXJ2epzytNac9w2Fm+MEtlYENCxJXXrdUznuvWsEBMOjHqhVuOtS+dRFdmpahIlfVWln1FouYdwpAOr1JtitlCOXUcQnbQkPIv8WjQ1jOXGLeEQTDTMKQYariPhEDiwj4h7CPus9KlkkReei3r76HNenjVjidEIHnhXLw78VwcvMz3ig3z3FiC99eLvjPX8LX9J9iH4ASWrzT2Fv8fvE0/Q29QDRkqCyPXMLzsClc70CSj9yIsolWKxbRH7EKdEIX62htcAxQPmBTqxg+4jpAKiGX7ecr90be9/E7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726023068; c=relaxed/relaxed;
	bh=F0izTLkzvLaCVywJONgSsLsqtwszvHdfdXG1Axz7UgY=;
	h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type; b=it1EJneOXFjxUOO5q/3MNeISzWjVPE0TqwKJX3YpHagShYJFDUnnxj8f6BFPzBOpd31U5dgRj4ByxiMcAv5/ltlR0lgzCsvCpm0aZ925FFCczyFq7ymoJv/vqVy3gq6E8moQhEzYeDDwOrNKr5mZedfzc29oaaV/VNhm9KYwIRMC3DFKEKweia0yBpTFyY3jA9DuGlbAXZ4d/BDr1hg3cj8cXYdfyMuaSJqOj4OC3UbBxKyEVSrRGteNDssnbNt2Gr6lvHSn8/rwoDH1ZLEVCQoELC/pjUiEkra9NIIbChg7hJrUa6C6CdIbKjocapWGXFQeFqOikmw7GCE7SkrFrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=163.com; dkim=fail header.d=163.com header.i=salesluckygoods@163.com header.a=rsa-sha1 header.s=ossljy header.b=hP1LnP68 reason="key not found in DNS"; dkim-atps=neutral; spf=pass (client-ip=45.58.52.133; helo=server1.abioi.cn; envelope-from=manager@abioi.cn; receiver=lists.ozlabs.org) smtp.mailfrom=abioi.cn
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="key not found in DNS" header.d=163.com header.i=salesluckygoods@163.com header.a=rsa-sha1 header.s=ossljy header.b=hP1LnP68;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=abioi.cn (client-ip=45.58.52.133; helo=server1.abioi.cn; envelope-from=manager@abioi.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 603 seconds by postgrey-1.37 at boromir; Wed, 11 Sep 2024 12:51:07 AEST
Received: from server1.abioi.cn (abioi.cn [45.58.52.133])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X3Q7H289kz2xsH
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Sep 2024 12:51:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=ossljy; d=163.com;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=salesluckygoods@163.com;
 bh=2+8xM1b/9eHPohjIJKsp9LDGSK4=;
 b=hP1LnP68wdJdUM/2r9ElKfHFLEPC0jIenUT6ekM0uIasOXR+3NiqeiSvoDeCXarurb9CqHrpy9NN
   EymxEi+2Jl/iKJfXG965FQWHbbBmQG0znkWySqgyIuh5iFsMXhqf20o4u/rBFkGchS9Bkwy6K2/W
   jwkR6oyFXi48phZoBruQw32K9/mNcblggB77diEzfFWhKEqKLCEIwwAeSbfctJ6JeG0O4BffRd1R
   G9mgCxpjLMUqr+Fp/NfnZjl4SbBQ23BmSYaTY89cn3mBvVpYatxgZR5/JWoNxyQXQM5hNuEU9zDo
   YimFpM8eQ3tfiGUJY8eLULe/v2rTCiyEniPNCg==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=ossljy; d=163.com;
 b=x+6b2jzJMfEtuPjeknMtg2dt41/I/IE9W1ZgSGC0pr0AB/CIcmgOwD2N45G3Ep/7FP2QBrqaEUHF
   1QcYIq+gyQZSTtnrA2g8F36joou7mgej7gK8v7NaGHAb7V5qxpyBuifFXp44Na8BgQbuVBBuYF+M
   OKjxb8tEE2SIZC3fW0j0fa8KyUGvkKBJCJtB1PkM8kgHvu8qrtOYtGNBb5d8PSh1QRqxDff6vOpV
   pBcrzOdiDBPBEb/99a11Qk+npS+64NK9kKOp1GQ8uWxOzjXOxbGLVrYP1nVHULXV+4yFz3OIOQt4
   oMCnKcuZqXbrK7URmju3tY3lSGs8FhE2/nboZw==;
Received: from svip.ossedm.com (182.106.136.53) by server1.abioi.cn id hs42pm0e97c8 for <linux-erofs@lists.ozlabs.org>; Wed, 11 Sep 2024 02:41:00 +0000 (envelope-from <manager@abioi.cn>)
Message-ID: <22c6b74c1d3526c872f335f49bf7f0c4@abioi.cn>
Date: Wed, 11 Sep 2024 02:40:51 +0000
Subject: artificial flowers
From: Arrow <salesluckygoods@163.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="_=_swift_v4_1726022451_6d2ec18bc2f71ec9d4ae8ecc918da080_=_"
X-Tracking-Did: 0
X-Subscriber-Uid: zw225mbdyfb88
X-Report-Abuse: Please report abuse for this campaign here:
 http://svip.ossedm.com/index.php/campaigns/jf603e9wgkbf3/report-abuse/jn26570cnm0fe/zw225mbdyfb88
X-Mailer: SwiftMailer - 5.4.x
X-EBS: http://svip.ossedm.com/index.php/lists/block-address
X-Delivery-Sid: 42
X-Customer-Uid: jc916mcm3w7e5
X-Customer-Gid: 6
X-Campaign-Uid: jf603e9wgkbf3
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: jf603e9wgkbf3:regular:jn26570cnm0fe:jc916mcm3w7e5
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Reply-To: Arrow <salesluckygoods@163.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--_=_swift_v4_1726022451_6d2ec18bc2f71ec9d4ae8ecc918da080_=_
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi friend,
Good day!I'm Arrow from the Professional artificial flower pro=
ducts
manufacturer.
Do you sell artificial flower products?Are you a ma=
nufacturer or
distributor?
Warm regards,
Arrow,
Professional artifi=
cial flower products manu

--_=_swift_v4_1726022451_6d2ec18bc2f71ec9d4ae8ecc918da080_=_
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html><head><meta charset=3D"utf-8"><title>artificial flo=
wers</title></head><body><span style=3D"font-size:16px;"><span style=3D"fon=
t-family:&#31561;&#32447;"><span style=3D"font-family:&#23435;&#20307;"><sp=
an style=3D"color:#000000"><span style=3D"letter-spacing:0.0000pt"><span st=
yle=3D"text-transform:none"><span style=3D"font-style:normal"><font face=3D=
"&#23435;&#20307;">Hi friend,</font></span></span></span></span></span><br>=
<span style=3D"font-family:&#23435;&#20307;"><span style=3D"color:#000000">=
<span style=3D"letter-spacing:0.0000pt"><span style=3D"text-transform:none"=
><span style=3D"font-style:normal"><font face=3D"&#23435;&#20307;">Good day=
!I'm Arrow</font>&nbsp;<font face=3D"&#23435;&#20307;">from the Professiona=
l artificial flower</font>&nbsp;<font face=3D"&#23435;&#20307;">products ma=
nufacturer.<br><span style=3D"background-color:#e74c3c;">Do you sell artifi=
cial flower</span></font><span style=3D"background-color:#e74c3c;">&nbsp;</=
span><font face=3D"&#23435;&#20307;"><span style=3D"background-color:#e74c3=
c;">products?Are you a manufacturer or distributor?</span></font></span></s=
pan></span></span></span></span><br><span style=3D"font-family:&#31561;&#32=
447;"><span style=3D"font-family:&#23435;&#20307;"><span style=3D"color:#00=
0000"><span style=3D"letter-spacing:0.0000pt"><span style=3D"text-transform=
:none"><span style=3D"font-style:normal"><font face=3D"&#23435;&#20307;">Wa=
rm regards,</font></span></span></span></span></span></span><br><br><img al=
t=3D"" src=3D"https://pic.imgdb.cn/item/66a890d0d9c307b7e9e9d93e.jpg" style=
=3D"height: 191px; width: 500px;"><br><span style=3D"font-family:&#31561;&#=
32447;"><span style=3D"font-family:&#23435;&#20307;"><span style=3D"color:#=
000000"><span style=3D"letter-spacing:0.0000pt"><span style=3D"text-transfo=
rm:none"><span style=3D"font-style:normal">Arrow<font face=3D"&#23435;&#203=
07;">,</font></span></span></span></span></span></span><br><span style=3D"f=
ont-family:&#31561;&#32447;"><span style=3D"font-family:&#23435;&#20307;"><=
span style=3D"color:#000000"><span style=3D"letter-spacing:0.0000pt"><span =
style=3D"text-transform:none"><span style=3D"font-style:normal"><font face=
=3D"&#23435;&#20307;">Professional artificial flower</font>&nbsp;<font face=
=3D"&#23435;&#20307;">products manu</font></span></span></span></span></spa=
n></span></span><img width=3D"1" height=3D"1" src=3D"http://svip.ossedm.com=
/index.php/campaigns/jf603e9wgkbf3/track-opening/zw225mbdyfb88" alt=3D"" />=

</body></html>

--_=_swift_v4_1726022451_6d2ec18bc2f71ec9d4ae8ecc918da080_=_--

