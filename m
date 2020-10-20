Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E0B293E71
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Oct 2020 16:17:18 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CFwgG6kc1zDqjX
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Oct 2020 01:17:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=trix.bounces.google.com (client-ip=2607:f8b0:4864:20::746;
 helo=mail-qk1-x746.google.com;
 envelope-from=3u_goxxijahqxstawffw.lsyjgustyyesad.uge@trix.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=mLVXiVmo; dkim-atps=neutral
Received: from mail-qk1-x746.google.com (mail-qk1-x746.google.com
 [IPv6:2607:f8b0:4864:20::746])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CFwg22pDTzDqYS
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Oct 2020 01:16:54 +1100 (AEDT)
Received: by mail-qk1-x746.google.com with SMTP id d5so1850869qkg.16
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Oct 2020 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:message-id:date:subject:from:to;
 bh=cuBTdI68D8XuG8iqlnoJ5YX57tVh0JcK9hSz+lVfVfI=;
 b=mLVXiVmoSoFQ50ovJiooYM3oYWqtYgU2Ois6vjKrlHL8W5aDM9J0/IaJC8jgXd5OqJ
 UbPcbMJWc1crNQyEE88ur8AhoAKmkyE4Y8GTxjk5TDlNJRNY6cgWdvr6brdPS9gyawYR
 dLe9n0030mkhSAomhkidxP+iobhH4g6w0Jo6xA89fV2X9Hedb37TgdbSUb4mUzR1D/j7
 wEN8FcSvuEQ7EiCqx8GMdJ1ShH/Ueb3jgWSy4a4JpSb/V3SC0kUPh9zgM5vi0VnMwrhO
 gWtvLHHnSaTP7fP7fll5yaGkCFsKdtWffRP759h3fDMDGIEWE/Hi9gykCY7GW4nn0eHJ
 lG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:message-id:date:subject
 :from:to;
 bh=cuBTdI68D8XuG8iqlnoJ5YX57tVh0JcK9hSz+lVfVfI=;
 b=WxPaHwMyhGC8fwjY6YtqGd0JgybGAK1jIFaqQ5L7IQHwRDNfYr3S6R2ClLn6rFzpgW
 Lz4+CaUhNdzZ6E3vgTgomwItv4th+fc59dqYP8Z3wChldwCNyatMX4CDmLuJNk0NWyfC
 vNof6CVF6ekFVfb1ilZoVs7GmD5VGYnIfiGaErpsX/uPGY14zDyl0KIxMULQt3UAf4Kr
 1ZQwVoEBr1RTKTbiePvv9w0prXr0Rmh3tnMv03u72LsqwZVYaqPRtW+jdhaOeOeYkeoz
 ILACoxKiqMVf3n4MR9XUclXhF0Jis4d5SUYPZ8GMvpdYYVt+CWIPyCWZnH7DjXGxiBOP
 bODA==
X-Gm-Message-State: AOAM531BHtu3QuEP/LrM4lkRZ4ju/Jt3xAeBHufw0fpvJEMG2gBnZMH7
 G64YnVMrbtNhIlUOAQDNUJaVjOVxHqG3iYyditoC
MIME-Version: 1.0
X-Received: by 2002:a05:622a:1c4:: with SMTP id
 t4mt3177835qtw.147.1603203411022; 
 Tue, 20 Oct 2020 07:16:51 -0700 (PDT)
X-No-Auto-Attachment: 1
Message-ID: <000000000000d11c9205b21ae113@google.com>
Date: Tue, 20 Oct 2020 14:16:51 +0000
Subject: From Miss Nidal Aoussa.
From: fabienne.tagro2016@gmail.com
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000d4815d05b21ae1d6"
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
Reply-To: fabienne.tagro2016@gmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000d4815d05b21ae1d6
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

I've invited you to fill out the following form:
Untitled form

To fill it out, visit:
https://docs.google.com/forms/d/e/1FAIpQLSeQIj2QpMXgQbMEcEv3RJXvlfCdBYxn9Y22RoTGN5DS88sjBw/viewform?vc=0&amp;c=0&amp;w=1&amp;flr=0&amp;usp=mail_form_link

Hello Dear,

I am very sorry that my letter may come as a surprise to you since we have  
never met each other before. I am Miss Nidal Aoussa. I am the only daughter  
of Cheikh Ag Aoussa, the President of (HCUA) in Mali who was assasinated on  
the octobre 2016.

https://www.jeuneafrique.com/365432/politique/mali-sait-on-mort-de-cheikh-ag-aoussa/
https://fr.wikipedia.org/wiki/Cheikh_Ag_Aoussa

I have a business transaction which i solicit your help. It is all about a  
fund to be transferred in your country for urgent investment on important  
projects. I want you to guide me and invest this money in your country.  
This fund amount to Eleven Millions Five Hundred Thousand United States  
dollars which i inherited from my late dad.. If you are capable of handling  
or participate in this transaction, kindly respond quickly through my  
private emails to enable me give you more details about this fund and how  
this project shall be carried out. I will accord you 20% of the total fund  
for your kind assistance. Respond through this my private emails addresses  
below.

Miss Nidal Aoussa
Email: ( nidal.kong2020@gmail.com )

Google Forms: Create and analyze surveys.

--000000000000d4815d05b21ae1d6
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
424242;" dir=3D"auto">Hello Dear,<br><br>I am very sorry that my letter may=
 come as a surprise to you since we have never met each other before. I am =
Miss Nidal Aoussa. I am the only daughter of Cheikh Ag Aoussa, the Presiden=
t of (HCUA) in Mali who was assasinated on the octobre 2016.<br><br>https:/=
/www.jeuneafrique.com/365432/politique/mali-sait-on-mort-de-cheikh-ag-aouss=
a/<br>https://fr.wikipedia.org/wiki/Cheikh_Ag_Aoussa<br><br>I have a busine=
ss transaction which i solicit your help. It is all about a fund to be tran=
sferred in your country for urgent investment on important projects. I want=
 you to guide me and invest this money in your country. This fund amount to=
 Eleven Millions Five Hundred Thousand United States dollars which i inheri=
ted from my late dad.. If you are capable of handling or participate in thi=
s transaction, kindly respond quickly through my private emails to enable m=
e give you more details about this fund and how this project shall be carri=
ed out. I will accord you 20% of the total fund for your kind assistance. R=
espond through this my private emails addresses below.<br><br>Miss Nidal Ao=
ussa<br>Email: ( nidal.kong2020@gmail.com )</span></td></tr><tr height=3D"2=
0px"><td></tr><tr style=3D"font-size: 20px; line-height: 24px;"><td dir=3D"=
auto"><a href=3D"https://docs.google.com/forms/d/e/1FAIpQLSeQIj2QpMXgQbMEcE=
v3RJXvlfCdBYxn9Y22RoTGN5DS88sjBw/viewform?vc=3D0&amp;c=3D0&amp;w=3D1&amp;fl=
r=3D0&amp;usp=3Dmail_form_link" style=3D"color: rgb(103,58,183); text-decor=
ation: none; vertical-align: middle; font-weight: 500">Untitled form</a><di=
v itemprop=3D"action" itemscope itemtype=3D"http://schema.org/ViewAction"><=
meta itemprop=3D"url" content=3D"https://docs.google.com/forms/d/e/1FAIpQLS=
eQIj2QpMXgQbMEcEv3RJXvlfCdBYxn9Y22RoTGN5DS88sjBw/viewform?vc=3D0&amp;c=3D0&=
amp;w=3D1&amp;flr=3D0&amp;usp=3Dmail_goto_form"><meta itemprop=3D"name" con=
tent=3D"Fill out form"></div></td></tr><tr height=3D"24px"></tr><tr><td><ta=
ble border=3D"0" cellpadding=3D"0" cellspacing=3D"0" width=3D"100%"><tbody>=
<tr><td><a href=3D"https://docs.google.com/forms/d/e/1FAIpQLSeQIj2QpMXgQbME=
cEv3RJXvlfCdBYxn9Y22RoTGN5DS88sjBw/viewform?vc=3D0&amp;c=3D0&amp;w=3D1&amp;=
flr=3D0&amp;usp=3Dmail_form_link" style=3D"border-radius: 3px; box-sizing: =
border-box; display: inline-block; font-size: 13px; font-weight: 700; heigh=
t: 40px; line-height: 40px; padding: 0 24px; text-align: center; text-decor=
ation: none; text-transform: uppercase; vertical-align: middle; color: #fff=
; background-color: rgb(103,58,183);" target=3D"_blank" rel=3D"noopener">Fi=
ll out form</a></td></tr></tbody></table></td></tr><tr height=3D"24px"></tr=
></tbody></table></div><table align=3D"center" cellpadding=3D"0" cellspacin=
g=3D"0" style=3D"max-width: 672px; min-width: 154px;" width=3D"100%" role=
=3D"presentation"><tbody><tr height=3D"24px"><td></td></tr><tr><td><a href=
=3D"https://docs.google.com/forms?usp=3Dmail_form_link" style=3D"color: #42=
4242; font-size: 13px;">Create your own Google Form</a></td></tr></tbody></=
table></div></body></html>
--000000000000d4815d05b21ae1d6--
