Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9295B2AA417
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Nov 2020 10:03:43 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CSrs84Fl2zDrQ1
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Nov 2020 20:03:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=trix.bounces.google.com (client-ip=2607:f8b0:4864:20::748;
 helo=mail-qk1-x748.google.com;
 envelope-from=34wkmxw4jc0qjov.gmxktzca88msgor.iusrot03-kxulyroyzy.u5rghy.uxm@trix.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=J4g9M7Hp; dkim-atps=neutral
Received: from mail-qk1-x748.google.com (mail-qk1-x748.google.com
 [IPv6:2607:f8b0:4864:20::748])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CSrs40KktzDrPY
 for <linux-erofs@lists.ozlabs.org>; Sat,  7 Nov 2020 20:03:32 +1100 (AEDT)
Received: by mail-qk1-x748.google.com with SMTP id d22so2340040qko.10
 for <linux-erofs@lists.ozlabs.org>; Sat, 07 Nov 2020 01:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:message-id:date:subject:from:to;
 bh=DZvPhaPkcBgiQ5brV2bzdnBfozVGIo0UU4VFyEe8sGo=;
 b=J4g9M7HpFECtstmEgubzuLJ/aQAXRgZSqiwKhTiKkJPXEdUPU0hV/f7Sk745ceyUnB
 VrLTJawS7nhkk69SlBqMGT726X/mdxEo92hfbiwxuaMt2YTeWg7VcB7iDXRGu1vxA9Zp
 KZ9J/3pPzhQw31QL7ysrb85vHjNedQDH/a/XlYjSdcW+aCOYsgdUVamZctb7LWd+TOrW
 oTd9vhk48KsFmBSS4Yl1WHShK/xMCh8YPWZAndQ7M4wB2GAhYBNZ8LXzvQshzFj48lNM
 SBxooafv6rJzIzyXTkN0bdCRRTguTnCvd0IecxpmrUFc9DacWdvn+WRK668UyXaMK/st
 vTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:message-id:date:subject
 :from:to;
 bh=DZvPhaPkcBgiQ5brV2bzdnBfozVGIo0UU4VFyEe8sGo=;
 b=XxTeLtCYVypNS7FZBafyoV3OO4vd/CqUwFnepHTDt702cLWggHh9L5QqIREogGP0Z9
 lk6WCIkpBYMCEtv3F2OgapQfPiqOhyR7RPabuD6h3yB2Knq/r2kzr2I2PTp9K4p7iPJ2
 gxtuzpI2v15O71PonJ99r2MfkE0iP6ZgnhurN+cxOYgF0Pj6MPilffWwnA9IFQVKXvrX
 hLS4Eb9O4QeRmthdFLTmBbuR80i8haCeJED+GVHjQG7EQRLZb1QYrXo04rvIUMIyTt9m
 s9gO5cZyRhKdIBUqcWbOcql4s4vreIkaX5Mt1jke4wECJ+nJBxNQ2ues69i1PcCZETNO
 8Oew==
X-Gm-Message-State: AOAM530/iPfbuEzxP31TG+geTd6keW65rbU0Z8TgglGsSGQ5eoYngafp
 RSKFeV+9QHEgMMMCFz0ge037jrK8zVbrJFffTfvX
MIME-Version: 1.0
X-Received: by 2002:a05:620a:818:: with SMTP id
 s24mt5220826qks.181.1604739809662; 
 Sat, 07 Nov 2020 01:03:29 -0800 (PST)
X-No-Auto-Attachment: 1
Message-ID: <0000000000004ffd4805b3809ab4@google.com>
Date: Sat, 07 Nov 2020 09:03:30 +0000
Subject: U.S. Customs and Border Protection.
From: dip.agrent6422@gmail.com
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="0000000000005fdba205b3809a2b"
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
Reply-To: dip.agrent6422@gmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000005fdba205b3809a2b
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SSd2ZSBpbnZpdGVkIHlvdSB0byBmaWxsIG91dCB0aGUgZm9sbG93aW5nIGZvcm06DQpVbnRpdGxl
ZCBmb3JtDQoNClRvIGZpbGwgaXQgb3V0LCB2aXNpdDoNCmh0dHBzOi8vZG9jcy5nb29nbGUuY29t
L2Zvcm1zL2QvZS8xRkFJcFFMU2ZmejltQUl0dlRHWVN5M19XZ21HVnFzb3cwdmJwTjVRRnVqQTk5
TGphbzJYTEk3Zy92aWV3Zm9ybT92Yz0wJmFtcDtjPTAmYW1wO3c9MSZhbXA7ZmxyPTAmYW1wO3Vz
cD1tYWlsX2Zvcm1fbGluaw0KDQpHb29kIG1vcm5pbmcgdG8geW91Lg0KDQpUaGlzIG1lc3NhZ2Ug
aXMgY29taW5nIHRvIHlvdSBmcm9tIFUuUy4gQ3VzdG9tcyBhbmQgQm9yZGVyIFByb3RlY3Rpb24g
LSAgDQpDaGllZiBNb3VudGFpbiBQb3J0IG9mIEVudHJ5LCBUaGUgbWVzc2FnZSBpcyBiZWNhdXNl
IG9mIHlvdXIgcGFja2FnZSBib3ggIA0Kd2hpY2ggd2FzIGp1c3QgcmVsZWFzZWQgYW5kIGNsZWFy
ZWQgYWJvdXQgMzAgbWludXRlcyBhZ2/igKYgd2Ugd2FudCB5b3UgdG8gIA0KY29tZSBkb3duIGhl
cmUgaW4gcGVyc29uIGFuZCB0YWtlIGF3YXkgeW91ciBwYWNrYWdlIHdpdGhvdXQgYW55IHF1ZXN0
aW9uIG9yICANCmRlbGF5IGZyZWVseSAoQWRkcmVzczogMTM5NSBDaGllZiBNb3VudGFpbiBId3ks
IEJhYmIsIE1UIDU5NDExLCBVbml0ZWQgIA0KU3RhdGVzKQ0KYnV0IGlmIGl0IGNhbuKAmXQgYmUg
cG9zc2libGUgZm9yIHlvdSB0byBjb21lIGRvd24gZHVlIHRvIHdvcmtpbmcgaG91ciBqdXN0ICAN
CmdvIGRvd24gdG8gYW55IG5lYXJlc3Qgc3RvcmUgYnV5IHN0ZWFtIGNhcmQgb3Igbm9yZHN0cm9t
IGNhcmQgb2YgJDE5MCBhbmQgIA0Kc2VuZCBpdCB0byB5b3VyIGRlbGl2ZXJ5IGFnZW50IHZpYSBl
IGVtYWlsIChob25vcmFibGVoYXJyaXNvbjJAZ21haWwuY29tKSAgDQpvciBwaG9uZSArMSAoMjE2
KSA0NjUtNTMxNyBpIGV4cGVjdCB5b3VyIHVyZ2VudCBjYWxsIHBsZWFzZSBhbHNvIHByb3ZpZGUg
IA0KeW91ciBhZGRyZXNzIHdoZXJlIHlvdSB3YW50IHlvdXIgcGFja2FnZSBib3ggdG8gYmUgZGVs
aXZlcmVkIHRvICB5b3UgaW4gIA0KbmV4dCA0IGhvdXJzIHlvdSB3aWxsIGNvbmZpcm0geW91ciBw
YWNrYWdlIGltbWVkaWF0ZWx5LCBwbGVhc2UgZG9u4oCZdCBpZ25vcmUgIA0KdGhpcyBtZXNzYWdl
IGJlY2F1c2UgeW91IGFyZSB2ZXJ5IGx1Y2t5IHBlcnNvbiB0b2RheeKApi4uDQoNClUuUy4gQ3Vz
dG9tcyBhbmQgQm9yZGVyIFByb3RlY3Rpb24uDQoNCkdvb2dsZSBGb3JtczogQ3JlYXRlIGFuZCBh
bmFseXplIHN1cnZleXMuDQo=
--0000000000005fdba205b3809a2b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"font-family: Roboto,Helvetica,Arial,sans-serif; margin=
: 0; padding: 0; height: 100%; width: 100%;"><table border=3D"0" cellpaddin=
g=3D"0" cellspacing=3D"0" style=3D"background-color:rgb(103,58,183);" width=
=3D"100%" role=3D"presentation"><tbody><tr height=3D"64px"><td style=3D"pad=
ding: 0 24px;"><img alt=3D"Google Forms" height=3D"26px" style=3D"display: =
inline-block; margin: 0; vertical-align: middle;" width=3D"143px" src=3D"ht=
tps://www.gstatic.com/docs/forms/google_forms_logo_lockup_white_2x.png"></t=
d></tr></tbody></table><div style=3D"padding: 24px; background-color:rgb(23=
7,231,246)"><div align=3D"center" style=3D"background-color: #fff; border-b=
ottom: 1px solid #e0e0e0;margin: 0 auto; max-width: 624px; min-width: 154px=
;padding: 0 24px;"><table align=3D"center" cellpadding=3D"0" cellspacing=3D=
"0" style=3D"background-color: #fff;" width=3D"100%" role=3D"presentation">=
<tbody><tr height=3D"24px"><td></td></tr><tr><td><span style=3D"display: ta=
ble-cell; vertical-align: top; font-size: 13px; line-height: 18px; color: #=
424242;" dir=3D"auto">Good morning to you.<br><br>This message is coming to=
 you from U.S. Customs and Border Protection - Chief Mountain Port of Entry=
, The message is because of your package box which was just released and cl=
eared about 30 minutes ago=E2=80=A6 we want you to come down here in person=
 and take away your package without any question or delay freely (Address: =
1395 Chief Mountain Hwy, Babb, MT 59411, United States)<br>but if it can=E2=
=80=99t be possible for you to come down due to working hour just go down t=
o any nearest store buy steam card or nordstrom card of $190 and send it to=
 your delivery agent via e email (honorableharrison2@gmail.com) or phone +1=
 (216) 465-5317 i expect your urgent call please also provide your address =
where you want your package box to be delivered to  you in next 4 hours you=
 will confirm your package immediately, please don=E2=80=99t ignore this me=
ssage because you are very lucky person today=E2=80=A6..<br><br>U.S. Custom=
s and Border Protection.</span></td></tr><tr height=3D"20px"><td></tr><tr s=
tyle=3D"font-size: 20px; line-height: 24px;"><td dir=3D"auto"><a href=3D"ht=
tps://docs.google.com/forms/d/e/1FAIpQLSffz9mAItvTGYSy3_WgmGVqsow0vbpN5QFuj=
A99Ljao2XLI7g/viewform?vc=3D0&amp;c=3D0&amp;w=3D1&amp;flr=3D0&amp;usp=3Dmai=
l_form_link" style=3D"color: rgb(103,58,183); text-decoration: none; vertic=
al-align: middle; font-weight: 500">Untitled form</a><div itemprop=3D"actio=
n" itemscope itemtype=3D"http://schema.org/ViewAction"><meta itemprop=3D"ur=
l" content=3D"https://docs.google.com/forms/d/e/1FAIpQLSffz9mAItvTGYSy3_Wgm=
GVqsow0vbpN5QFujA99Ljao2XLI7g/viewform?vc=3D0&amp;c=3D0&amp;w=3D1&amp;flr=
=3D0&amp;usp=3Dmail_goto_form"><meta itemprop=3D"name" content=3D"Fill out =
form"></div></td></tr><tr height=3D"24px"></tr><tr><td><table border=3D"0" =
cellpadding=3D"0" cellspacing=3D"0" width=3D"100%"><tbody><tr><td><a href=
=3D"https://docs.google.com/forms/d/e/1FAIpQLSffz9mAItvTGYSy3_WgmGVqsow0vbp=
N5QFujA99Ljao2XLI7g/viewform?vc=3D0&amp;c=3D0&amp;w=3D1&amp;flr=3D0&amp;usp=
=3Dmail_form_link" style=3D"border-radius: 3px; box-sizing: border-box; dis=
play: inline-block; font-size: 13px; font-weight: 700; height: 40px; line-h=
eight: 40px; padding: 0 24px; text-align: center; text-decoration: none; te=
xt-transform: uppercase; vertical-align: middle; color: #fff; background-co=
lor: rgb(103,58,183);" target=3D"_blank" rel=3D"noopener">Fill out form</a>=
</td></tr></tbody></table></td></tr><tr height=3D"24px"></tr></tbody></tabl=
e></div><table align=3D"center" cellpadding=3D"0" cellspacing=3D"0" style=
=3D"max-width: 672px; min-width: 154px;" width=3D"100%" role=3D"presentatio=
n"><tbody><tr height=3D"24px"><td></td></tr><tr><td><a href=3D"https://docs=
.google.com/forms?usp=3Dmail_form_link" style=3D"color: #424242; font-size:=
 13px;">Create your own Google Form</a></td></tr></tbody></table></div></bo=
dy></html>
--0000000000005fdba205b3809a2b--
