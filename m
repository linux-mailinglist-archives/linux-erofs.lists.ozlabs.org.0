Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0298E63CD0A
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 02:56:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NMMkw04tCz3bWw
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 12:56:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=lensmedia.co.za header.i=@lensmedia.co.za header.a=rsa-sha256 header.s=xneelo header.b=iG+tQTrF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lensmedia.co.za (client-ip=129.232.250.54; helo=outgoing19.jnb.host-h.net; envelope-from=internet@lensmedia.co.za; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=lensmedia.co.za header.i=@lensmedia.co.za header.a=rsa-sha256 header.s=xneelo header.b=iG+tQTrF;
	dkim-atps=neutral
X-Greylist: delayed 1764 seconds by postgrey-1.36 at boromir; Wed, 30 Nov 2022 12:56:26 AEDT
Received: from outgoing19.jnb.host-h.net (outgoing19.jnb.host-h.net [129.232.250.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NMMkf4dZNz3bNB
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Nov 2022 12:56:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lensmedia.co.za; s=xneelo; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Subject:From:To:Date:reply-to:sender:cc:bcc:
	in-reply-to:references; bh=bNqDwrhbp1d/X5nwJQKrfCbQDC6dvE4fF0baifMPa+8=; b=iG
	+tQTrFQGh5yeDfY9ghN0nHMySmzxN74fUPyQt2/9wVcFL/c45L3RFrCv8sEBsQocUCUjoqx6I6CKn
	NDN2CFCxHU2lUaPj2XxrfISEMzRRYEm+8Boc10C0EaXnyC5vjSBSNFW6Jjt86IQTheyIB8Qk6jTDj
	+HdIceRlUPvD0daVFNcEtPu5aRoUgpODO5eu2lvZnYS/4F7tLrWqLsI9pV1rUhljSRmrnO0Vx9ty/
	D6XnQrnOEjv3EEW2Hv6DnV5sD24ujaKJW14dhdfra91TaBDSDEi2hfmbg9li2MCdrg+vG3hcnthKU
	OP0Rc3ucRIDg0VgGUDzDzZrLG4siYRhQ==;
Received: from dedi636.jnb1.host-h.net ([196.22.132.57])
	by antispam9-jnb1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <Internet@lensmedia.co.za>)
	id 1p0BsE-0001PW-6E
	for linux-erofs@lists.ozlabs.org; Wed, 30 Nov 2022 03:26:56 +0200
Received: from localhost ([127.0.0.1] helo=dedi636.jnb1.host-h.net)
	by dedi636.jnb1.host-h.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <Internet@lensmedia.co.za>)
	id 1p0BsD-000CAw-Ov
	for linux-erofs@lists.ozlabs.org; Wed, 30 Nov 2022 03:26:53 +0200
Received: from lensmztdjg by dedi636.jnb1.host-h.net with local (Exim 4.92)
	(envelope-from <lensmztdjg@dedi636.jnb1.host-h.net>)
	id 1p0BsD-000CAC-El
	for linux-erofs@lists.ozlabs.org; Wed, 30 Nov 2022 03:26:53 +0200
Date: Wed, 30 Nov 2022 03:25:19 +0200
To: linux-erofs@lists.ozlabs.org
From: DHL-Express <Internet@lensmedia.co.za>
Subject: Your package cannot be delivered
Message-ID: <8160c7b69dd5af763cf8ae4b1777eb21@lensmedia.co.za>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="16d674136408a57006513f5b32007a2dd"
Content-Transfer-Encoding: 8bit
X-Hetz-Sender-Domain: lensmedia.co.za
X-Originating-IP: 196.22.132.57
X-SpamExperts-Domain: lensmedia.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@lensmedia.co.za
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.81)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9q8PrFAnbsj50pUURKgi2aPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wWiBl0YHq+V9e3FaR3VZzS9oDZAdEaXq3QGKSvDs/Qko9w
 knWGobBIYos3d1n2bRGYuyWAzvkwMgK60hgh/d7s5WCy5VkstzhnxgTXqsdmp/GGJrMdKNLNqzRZ
 /YfNPboU/qxCl/RgMmFj7zwwK9MmE+tD+PYIJGn+mkv4NX2CdbXGbPWr0+j9jpP0XoFqOyKsXCJX
 oaZdVP6o+a28AMz0bxmuL1kgEZnTfX9pa6Iogt2CKK2MtbMPV1tIeJAbItY+kOx1oceoYbtheCmu
 2flcsArQv+5M23dYLDjUbMZvVmr6m72Gjb0JXKncO30D1zlDSsJwEdqFYrGPm5xKlgiopu966WQb
 IkFjUVC43wWhRrSnieghpAe8S6B/ftSyu9OYWiVBZmDDttt4TJV/KIXtvvE/X9f4ikS6v/cnqp1T
 bBmSvC6qJad8oDRDO7zv2HwzKB9Jz3yXRnoRrPjCCDcuuTNa7IVsbMNf4F0zLZ5qoQbTN00ljn+y
 UBPeOMGWHNrDeo2F/515C8kJ0QodJwfrmFGs5lmow6gOzU/CbOds0gEiRQv+PVjjwa+Z5RFCOMT8
 RsLp54SbSibygiXnHNfmuL6rg/D+rerIYMlM/72UvwYZpcmbL2ptU2UoDaQHXtv4J0q4jfUjaYdd
 OiIBoi26YhxPV/RpcMEbzdiiDm73dOeURvP7468+f+EGtWkSZL06EfcDaVDY8BsX918XkPvzqZ+z
 /nvBUorBpChWMkPW49F+Wq05Zptvn508rZ/PeiB8jcRTMwL1wlMCqjfS+zFhUV8ShebT8U8Xw9HT
 DfreWR5Cfo6diKc7jUoyUV+1PcH6DxWSEoQUnaVSVuR240EwaOZJWLrJ35g4ZMztplV9zX70NJt6
 ZhYGZsE6XiRt+TEr8l1a+B3b8WJsR0wzQmfG/pbAD840s9+S5qjBIkbFKP6vGzqnLcjiFXBTF8Kq
 Jhcwo+IgA0B4bNK6AkRqqzXn9jihx+Za/cV70jOJzN2r4A==
X-Report-Abuse-To: spam@antispammaster.host-h.net
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

This is a multi-part message in MIME format.

--16d674136408a57006513f5b32007a2dd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit




	



DHL Express

 

Hi,


 

We inform you that your shipment No 54960131540 is still awaiting instructions from you.

 

You have to pay the additional shipping fees to ship your parcel as soon as possible.

 

As soon as we receive your additional shipping fees we’ll be in touch to arrange delivery.

 

 

 Start Delivery


 

Reminder : This procedure is mandatory to prevent your package from being returned to the sender

 
Your goods are at our warehouse.

Kind regards
Customer Support




--16d674136408a57006513f5b32007a2dd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!doctype html>
<html>
<head>
=09<title></title>
</head>
<body>
<div align=3D"left" style=3D"font-family: Verdana; border: 0px; font-stretc=
h: inherit; font-size: 15px; line-height: inherit;">
<p style=3D"box-sizing: border-box; line-height: normal; margin: 1em 0px; p=
adding: 0px; border-width: 0px;"><span style=3D"color: rgb(153, 0, 0);"><sp=
an style=3D"font-size: 48px;"><span style=3D"font-family: arial, helvetica,=
 sans-serif;"><strong style=3D"box-sizing: border-box; font-stretch: inheri=
t; margin: 0px; padding: 0px; border-width: 0px;">DHL Express</strong></spa=
n></span></span></p>

<p style=3D"box-sizing: border-box; line-height: normal; margin: 1em 0px; p=
adding: 0px; border-width: 0px;">=C2=A0</p>

<p style=3D"box-sizing: border-box; line-height: normal; margin: 1em 0px; p=
adding: 0px; border-width: 0px;"><strong style=3D"box-sizing: border-box; f=
ont-stretch: inherit; margin: 0px; padding: 0px; border-width: 0px;">Hi,</s=
trong></p>
</div>

<div align=3D"left" style=3D"font-family: Verdana; border: 0px; font-stretc=
h: inherit; font-size: 15px; line-height: inherit;">=C2=A0</div>

<div align=3D"left" style=3D"font-family: Verdana; border: 0px; font-stretc=
h: inherit; font-size: 15px; line-height: inherit;">We inform you that your=
 shipment=C2=A0<strong style=3D"box-sizing: border-box; font-stretch: inher=
it; margin: 0px; padding: 0px; border-width: 0px;"><span style=3D"border: 0=
px; font-weight: normal; font-stretch: inherit; font-size: inherit; line-he=
ight: normal; font-family: inherit; margin: 0px; padding: 0px; vertical-ali=
gn: baseline; box-sizing: border-box; color: inherit;">No</span></strong>=
=C2=A0<span style=3D"color: rgb(153, 0, 0);"><a href=3D"https://loyalfiling=
s.com/wp-content/indexxxx.php"><strong style=3D"box-sizing: border-box; fon=
t-stretch: inherit; margin: 0px; padding: 0px; border-width: 0px;"><span st=
yle=3D"border: 0px; font-weight: normal; font-stretch: inherit; font-size: =
inherit; line-height: normal; font-family: inherit; margin: 0px; padding: 0=
px; vertical-align: baseline; box-sizing: border-box;">54960131540</span></=
strong></a>=C2=A0</span>is still awaiting instructions from you.</div>

<div align=3D"left" style=3D"font-family: Verdana; border: 0px; font-stretc=
h: inherit; font-size: 15px; line-height: inherit;">=C2=A0</div>

<div align=3D"left" style=3D"font-family: Verdana; border: 0px; font-stretc=
h: inherit; font-size: 15px; line-height: inherit;">You have to pay the add=
itional shipping fees to ship your parcel as soon as possible.</div>

<div align=3D"left" style=3D"font-family: Verdana; border: 0px; font-stretc=
h: inherit; font-size: 15px; line-height: inherit;">=C2=A0</div>

<div align=3D"left" style=3D"font-family: Verdana; border: 0px; font-stretc=
h: inherit; font-size: 15px; line-height: inherit;">As soon as we receive y=
our additional shipping fees we=E2=80=99ll be in touch to arrange delivery.=
</div>

<div align=3D"left" style=3D"font-family: Verdana; border: 0px; font-stretc=
h: inherit; font-size: 15px; line-height: inherit;">=C2=A0</div>

<div align=3D"left" style=3D"font-family: Verdana; border: 0px; font-stretc=
h: inherit; font-size: 15px; line-height: inherit;">=C2=A0</div>

<div align=3D"left" style=3D"font-family: Verdana; border: 0px; font-stretc=
h: inherit; font-size: 15px; line-height: inherit;"><span style=3D"border: =
0px; font: inherit; margin: 0px; padding: 0px; vertical-align: baseline; co=
lor: inherit; box-sizing: border-box;">=C2=A0<a href=3D"https://loyalfiling=
s.com/wp-content/indexxxx.php" style=3D"border: 0px none; font: inherit; ma=
rgin: 0px; padding: 12px 24px; vertical-align: baseline; box-sizing: border=
-box; background-position: 0px 0px; color: rgb(255, 255, 255); background-c=
olor: rgb(168, 15, 15);" target=3D"_blank"><span style=3D"border: 0px; font=
: inherit; margin: 0px; padding: 0px; vertical-align: baseline; color: inhe=
rit; box-sizing: border-box;">Start Delivery</span></a></span></div>

<div align=3D"left" style=3D"font-family: Verdana; border: 0px; font-stretc=
h: inherit; font-size: 15px; line-height: inherit;">
<p align=3D"left" style=3D"box-sizing: border-box; line-height: normal; mar=
gin: 1em 0px; padding: 0px; border-width: 0px;">=C2=A0</p>

<p align=3D"left" style=3D"box-sizing: border-box; line-height: normal; mar=
gin: 1em 0px; padding: 0px; border-width: 0px;"><span style=3D"color: rgb(1=
53, 0, 0);"><strong style=3D"color: rgb(255, 0, 0); font-family: arial, hel=
vetica, sans-serif; font-size: 18px;">Reminder : This procedure is mandator=
y to prevent your package from being returned to the sender</strong></span>=
</p>

<p style=3D"box-sizing: border-box; line-height: normal; margin: 1em 0px; p=
adding: 0px; border-width: 0px;">=C2=A0</p>
Your goods are at our warehouse.

<p style=3D"box-sizing: border-box; line-height: normal; margin: 1em 0px; p=
adding: 0px; border-width: 0px;">Kind regards<br style=3D"box-sizing: borde=
r-box;" />
<a href=3D"https://loyalfilings.com/wp-content/indexxxx.php">Customer Suppo=
rt</a></p>
</div>
</body>
</html>


--16d674136408a57006513f5b32007a2dd--
