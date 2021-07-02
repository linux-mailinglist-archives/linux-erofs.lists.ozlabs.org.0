Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 788643B9A9D
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jul 2021 03:55:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GGJ870kC9z3027
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jul 2021 11:55:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature-key hash mismatch" header.d=postlinkhk.com header.i=@postlinkhk.com header.a=rsa-sha256 header.s=dkim header.b=gXItldxc;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=postlinkhk.com (client-ip=202.181.141.137;
 helo=gw1.euyansang.hlhk.net;
 envelope-from=mail_60de707f278fd6.89578701@postlinkhk.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="signature-key hash mismatch" header.d=postlinkhk.com
 header.i=@postlinkhk.com header.a=rsa-sha256 header.s=dkim header.b=gXItldxc; 
 dkim-atps=neutral
X-Greylist: delayed 409 seconds by postgrey-1.36 at boromir;
 Fri, 02 Jul 2021 11:55:43 AEST
Received: from gw1.euyansang.hlhk.net (unknown [202.181.141.137])
 by lists.ozlabs.org (Postfix) with ESMTP id 4GGJ7z3D0rz2yxT
 for <linux-erofs@lists.ozlabs.org>; Fri,  2 Jul 2021 11:55:43 +1000 (AEST)
Received: from vm.sms.e-post.com.hk (unknown [117.18.98.182])
 by gw1.euyansang.hlhk.net (Postfix) with ESMTPA id 67E6B5F12B
 for <linux-erofs@lists.ozlabs.org>; Fri,  2 Jul 2021 09:48:43 +0800 (HKT)
Date: Fri, 2 Jul 2021 09:48:47 +0800
To: linux-erofs <linux-erofs@lists.ozlabs.org>
From: recycletungsing <recycletungsing@yeah.net>
Subject: =?UTF-8?B?6Zu75a2Q5Zue5pS2ICAgRWxlY3Ryb25pY3MgcmVjeWNsZQ==?=
Message-ID: <YzoTUrGG5SC1e0VFtdlvY6lnsjFMVb82KJ1j3QnRkO4@vm.sms.e-post.com.hk>
X-Mailer: PHPMailer 6.1.7 (https://github.com/PHPMailer/PHPMailer)
X-SMTP: gw1.euyansang.hlhk.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="b1_YzoTUrGG5SC1e0VFtdlvY6lnsjFMVb82KJ1j3QnRkO4"
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; d=postlinkhk.com; s=dkim;
 a=rsa-sha256; q=dns/txt; t=1625190527; c=relaxed/simple;
 h=Date:To:From:Subject:Message-ID:X-Mailer:MIME-Version:Content-Type;
 z=Date:Fri,=202=20Jul=202021=2009:48:47=20+0800
 |To:linux-erofs=20<linux-erofs@lists.ozlabs.org>
 |From:recycletungsing=20<recycletungsing@yeah.net>
 |Subject:=3D?UTF-8?B?6Zu75a2Q5Zue5pS2ICAgRWxlY3Ryb25pY3MgcmVjeWNsZQ=3D=3D?
 =3D
 |Message-ID:<YzoTUrGG5SC1e0VFtdlvY6lnsjFMVb82KJ1j3QnRkO4@vm.sms.e-post.com
 .hk>
 |X-Mailer:PHPMailer=206.1.7=20(https://github.com/PHPMailer/PHPMailer)
 |MIME-Version:1.0
 |Content-Type:multipart/alternative=3B=20boundary=3D"b1_YzoTUrGG5SC1e0VFtd
 lvY6lnsjFMVb82KJ1j3QnRkO4";
 bh=SkbQ/bi9FAS35E0St19LQPJwnzzF8vYoAUH0OWAEdGI=;
 b=gXItldxc4LeVNNA33HBUvk9g68is9asPMpYNM6Oq8gN/rUARmBRMItCjTDmMORDAfkhMENgXn
 yvItF0E+T7SHj2alELQBoz+TLbX/ZLCe2zrD4m6AtqhORmv5qBG+0A5Omif8jEjKefVYdHlge
 QEXpWUm4VbfM06phFxAj+z7h0=
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format.

--b1_YzoTUrGG5SC1e0VFtdlvY6lnsjFMVb82KJ1j3QnRkO4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

如閣下未能閱讀此郵件，請按此。
 If you can’t see the image below, please click here
 
 
 本公司專業回收各類庫存新舊成品及配件，包括電子、鐘錶、五金廢料、貨辦及貨尾等存貨. 
 
 專人報價、現金交收、歡迎查詢。95137408 / 62363887  (陳生)
 
 Our Company specializes in recycling all kinds of electronic inventory & finished products, Including electronics component, watches, metal scrap, electronic samples and unsold inventory, 
 
 Free valet quote, please contact us at :
 可深圳或香港交貨, We accept goods on ShenZhen,
 
 Contact / 聯系人：Mr. Chan 陳生
 
 郵箱/email : recycletungsing@yeah.net
 
 Mobile |電話 / Whatsapp / Signal : (香港) 95137408 / 62363887
 
     (國内) 86-15546950150
 
 東 昇 回 收 Tung sing Recycling
 
 Room E, 5/F Winner Factory Bldg., 55 Hung To Road, Kwun Tong, Kowloon, Hong Kong.
 
 九龍觀塘鴻圖道55號幸運工業大廈5/F E室
 
  
 
 如要取消訂閱，請到此處。
 If you don’t wish to receive our Newsletter, please click here.

--b1_YzoTUrGG5SC1e0VFtdlvY6lnsjFMVb82KJ1j3QnRkO4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div><p id=3D"_header" style=3D"text-align: center;">=E5=A6=82=E9=96=A3=
=E4=B8=8B=E6=9C=AA=E8=83=BD=E9=96=B1=E8=AE=80=E6=AD=A4=E9=83=B5=E4=BB=B6=
=EF=BC=8C=E8=AB=8B<a href=3D"http://letter.postlinkhk.com/v1/Delivery/previ=
ew?uuid=3Dmail_60de707f278fd6.89578701">=E6=8C=89=E6=AD=A4</a>=E3=80=82<br>=
&#13; If you can=E2=80=99t see the image below, please click <a href=3D"htt=
p://letter.postlinkhk.com/v1/Delivery/preview?uuid=3Dmail_60de707f278fd6.89=
578701">here</a></p>&#13; </div><div><p style=3D"text-align: center;"><img =
alt=3D"" src=3D"http://letter.postlinkhk.com/data/personal/katrickwong/Scre=
enHunter_02_Jul_17_08.45.jpg" style=3D"width: 312px; height: 131px;"></p>&#=
13; &#13; <p align=3D"center"><span style=3D"font-size:14px;"><strong>=
=E6=9C=AC=E5=85=AC=E5=8F=B8=E5=B0=88=E6=A5=AD=E5=9B=9E=E6=94=B6=E5=90=84=
=E9=A1=9E=E5=BA=AB=E5=AD=98=E6=96=B0=E8=88=8A=E6=88=90=E5=93=81=E5=8F=8A=
=E9=85=8D=E4=BB=B6=EF=BC=8C=E5=8C=85=E6=8B=AC=E9=9B=BB=E5=AD=90=E3=80=81=
=E9=90=98=E9=8C=B6=E3=80=81=E4=BA=94=E9=87=91=E5=BB=A2=E6=96=99=E3=80=81=
=E8=B2=A8=E8=BE=A6=E5=8F=8A=E8=B2=A8=E5=B0=BE=E7=AD=89=E5=AD=98=E8=B2=A8. <=
/strong></span></p>&#13; &#13; <p align=3D"center"><span style=3D"font-size=
:14px;"><strong>=E5=B0=88=E4=BA=BA=E5=A0=B1=E5=83=B9=E3=80=81=E7=8F=BE=
=E9=87=91=E4=BA=A4=E6=94=B6=E3=80=81=E6=AD=A1=E8=BF=8E=E6=9F=A5=E8=A9=A2=
=E3=80=82</strong><strong>95137408 / 62363887=C2=A0 (</strong><strong>=
=E9=99=B3=E7=94=9F</strong><strong>)</strong></span></p>&#13; &#13; <p alig=
n=3D"center"><span style=3D"font-size:14px;"><strong>Our Company specialize=
s in recycling all kinds of electronic inventory &amp; finished products, I=
ncluding electronics component, watches, metal scrap, electronic samples an=
d unsold inventory, </strong></span></p>&#13; &#13; <p align=3D"center"><sp=
an style=3D"font-size:14px;"><strong>Free valet quote, please contact us at=
 :</strong><br>&#13; <strong>=E5=8F=AF=E6=B7=B1=E5=9C=B3=E6=88=96=E9=A6=
=99=E6=B8=AF=E4=BA=A4=E8=B2=A8</strong><strong>, We accept goods on ShenZhe=
n,</strong></span></p>&#13; &#13; <p align=3D"center"><span style=3D"font-s=
ize:14px;"><strong>Contact / </strong><strong>=E8=81=AF=E7=B3=BB=E4=BA=
=BA=EF=BC=9A</strong><strong>Mr. Chan </strong><strong>=E9=99=B3=E7=94=
=9F</strong></span></p>&#13; &#13; <p align=3D"center"><span style=3D"font-=
size:14px;"><strong>=E9=83=B5=E7=AE=B1</strong><strong>/e</strong><strong>m=
ail : </strong><a href=3D"mailto:recycletungsing@yeah.net"><strong>recyclet=
ungsing@yeah.net</strong></a></span></p>&#13; &#13; <p align=3D"center"><sp=
an style=3D"font-size:14px;"><strong>Mobile |</strong><strong>=E9=9B=BB=
=E8=A9=B1</strong><strong> / Whatsapp / Signal :=C2=A0(</strong><strong>=
=E9=A6=99=E6=B8=AF</strong><strong>) </strong><strong>95137408 / 62363887</=
strong></span></p>&#13; &#13; <p align=3D"center"><span style=3D"font-size:=
14px;"><strong>=C2=A0 =C2=A0=C2=A0(</strong><strong>=E5=9C=8B=E5=86=85</str=
ong><strong>) </strong><strong>86-15546950150</strong></span></p>&#13; &#13=
; <p align=3D"center"><strong>=E6=9D=B1=C2=A0</strong><strong>=E6=98=87=
=C2=A0</strong><strong>=E5=9B=9E=C2=A0</strong><strong>=E6=94=B6</strong><s=
trong> Tung sing Recycling</strong></p>&#13; &#13; <p align=3D"center"><str=
ong>Room E, 5/F Winner Factory Bldg.,=C2=A055=C2=A0Hung To Road, Kwun Tong,=
 Kowloon, Hong Kong.</strong></p>&#13; &#13; <p align=3D"center"><strong>=
=E4=B9=9D=E9=BE=8D=E8=A7=80=E5=A1=98=E9=B4=BB=E5=9C=96=E9=81=9355</strong><=
strong>=E8=99=9F=E5=B9=B8=E9=81=8B=E5=B7=A5=E6=A5=AD=E5=A4=A7=E5=BB=885/F E=
</strong><strong>=E5=AE=A4</strong></p>&#13; &#13; <p>=C2=A0</p>&#13; </div=
><div><p id=3D"_footer" style=3D"text-align: center;">&#13; =E5=A6=82=
=E8=A6=81=E5=8F=96=E6=B6=88=E8=A8=82=E9=96=B1=EF=BC=8C=E8=AB=8B=E5=88=B0<a =
href=3D"http://letter.postlinkhk.com/v1/Delivery/unsubscribe?uuid=3Dmail_60=
de707f278fd6.89578701">=E6=AD=A4=E8=99=95</a>=E3=80=82<br>&#13; If you don=
=E2=80=99t wish to receive our Newsletter, please click <a href=3D"http://l=
etter.postlinkhk.com/v1/Delivery/unsubscribe?uuid=3Dmail_60de707f278fd6.895=
78701">here</a>.&#13; </p></div><div><img alt=3D"image" src=3D"http://lette=
r.postlinkhk.com/v1/Delivery/img?uuid=3Dmail_60de707f278fd6.89578701" style=
=3D"display:none"></div>

--b1_YzoTUrGG5SC1e0VFtdlvY6lnsjFMVb82KJ1j3QnRkO4--

