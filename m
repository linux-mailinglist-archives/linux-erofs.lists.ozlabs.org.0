Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E8F6C77F
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 05:25:18 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45pzzH71RPzDqDq
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 13:25:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=qq.com
 (client-ip=184.105.206.84; helo=smtpproxy19.qq.com;
 envelope-from=353779207@qq.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=qq.com header.i=@qq.com header.b="RKmoutSl"; 
 dkim-atps=neutral
X-Greylist: delayed 2191 seconds by postgrey-1.36 at bilbo;
 Thu, 18 Jul 2019 13:24:38 AEST
Received: from smtpproxy19.qq.com (smtpproxy19.qq.com [184.105.206.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45pzyZ5xV4zDqFL
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2019 13:24:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1563420270; bh=OenxSUojZMth6GSFeOrZYKx85QEBGiWqjFMSpcIfwFo=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=RKmoutSlOW6lrcdE4eRA3i8qegBRcBRyDLbf6jlRD1wT/kh6PbusmwAz/KogSZEtN
 0Y1LxeNoxA5JqTq7M7WhU2rbftY2guDgd8IQ1X3D/xxptxcGGfjRdNt7uDK5eCVeqr
 ihUSugqGLKoEpg1J8zmB+K1LOJL0smMHZ5/DmiOM=
X-QQ-FEAT: 357G+HpUJafbVELFfDAtPqSiKypfKgmy75faODspWwipPJzM0v8KPR+fTtA5m
 U5HRs+Ozaz5Rgj0Ciewmwm+eH1almGI+MHRvIzxt8t+qtTJLADtMa1qQMxdTLGA2zuMgG15
 wpUF+D4Xd5A9Ci0ywMFwDJJN5DmlxQmeqjQVjELrnNaufAYQ1OjEEaWj4EW3uagShRGkNU+
 dK0hoRvLaB05INATb/A0+07Fp6scqol51XFLQ6bMu5wmPKnxpFuy4X4iSig3YCwIlg/rNJi
 sz/vW7pKO2/zZnl/rtcf/GhiXBzh0b40TMcK7Q4DRUwuti6vSiMrLodRs=
X-QQ-SSF: 0000000000000060
X-QQ-WAPMAIL: 1
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 117.136.75.97
References: <tencent_43D5609D92443B9ED755C87B7843FA71D705@qq.com>
 <d3efd7a5-c781-6163-d04a-c2e6382ea760@huawei.com>
 <c85d590a-2eed-2501-b144-33a95fc0bec2@huawei.com>
 <tencent_4AE55DADBCB537681FA35D97D66948F2E209@qq.com>
 <5050b57d-bf2d-9615-fb2c-9f3edfbd84d5@huawei.com>
X-QQ-STYLE: 
X-QQ-mid: riamail29t1563420269t1724774
From: "=?gb18030?B?WkhPVQ==?=" <353779207@qq.com>
To: "=?gb18030?B?R2FvIFhpYW5n?=" <gaoxiang25@huawei.com>
Subject: =?gb18030?B?u9i4tKO6u9i4tKO6ZXJvc9DUxNzOyszi?=
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_5D2FE66D_08C40240_72AD9D14"
Content-Transfer-Encoding: 8Bit
Date: Thu, 18 Jul 2019 11:24:29 +0800
X-Priority: 3
Message-ID: <tencent_EE6B36FC1F655D8BD645489CE3A15DB1BC09@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 2502414467
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Thu, 18 Jul 2019 11:24:30 +0800 (CST)
Feedback-ID: riamail:qq.com:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
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
Cc: =?gb18030?B?bGludXgtZXJvZnM=?= <linux-erofs@lists.ozlabs.org>,
 =?gb18030?B?TWlhbyBYaWU=?= <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format.

------=_NextPart_5D2FE66D_08C40240_72AD9D14
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64

yse1xCC/tLT6wuvB97PMZXJvZnO4/LzyveAgsrvTprjDs/bP1tDUxNy28buvtcTOysziIMHt
zeLU2tf2eGF0dHLKsaOsztLDu9PQxvTTw3NoYXJltcS3vcq9o6zV4tTaYW5kcm9pZMnP06a4
w7K7u+HTsM/stb3Q1MTcsMmjrNLyzqrU2rbBc2VjdXJpdHnK9NDUuvO74bu6tOa1vWtlcm5l
bNbQDQoNCg0KQi5SDQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tINStyrzTyrz+IC0tLS0tLS0t
LS0tLS0tLS0tLQ0Kt6K8/sjLOiBHYW8gWGlhbmcgPGdhb3hpYW5nMjVAaHVhd2VpLmNvbT4N
Creiy83KsbzkOiAyMDE5xOo31MIxOMjVIDExOjE5DQrK1bz+yMs6IFpIT1UgPDM1Mzc3OTIw
N0BxcS5jb20+DQqzrcvNOiBNaWFvIFhpZSA8bWlhb3hpZUBodWF3ZWkuY29tPiwgbGludXgt
ZXJvZnMgPGxpbnV4LWVyb2ZzQGxpc3RzLm96bGFicy5vcmc+DQrW98ziOiC72Li0o7q72Li0
o7plcm9z0NTE3M7KzOINCg0KDQoNCg0KDQpPbiAyMDE5LzcvMTggMTE6MTUsIFpIT1Ugd3Jv
dGU6DQo+IERlYXIgeGlhbmcsDQo+IMO709DG9NPDZGlyZWN0SU8sDQo+ILrDtcQsztKzosrU
0rvPwsT6zOG5qbXEsuLK1Le9t6ihow0KDQrWwcnZttTT2rK70bnL9bXEx+m/9qOsxNHS1MDt
veLL5rv6tsHT0LLu0uyhow0KDQrQu9C7oaMNCg0KPiANCj4gt8ezo7jQ0LsNCj4gDQo+IA0K
PiAtLS0tLS0tLS0tLS0tLS0tLS0g1K3KvNPKvP4gLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICq3
orz+yMs6KiBHYW8gWGlhbmcgPGdhb3hpYW5nMjVAaHVhd2VpLmNvbT4NCj4gKreiy83Ksbzk
OiogMjAxOcTqN9TCMTjI1SAxMToxMA0KPiAqytW8/sjLOiogWkhPVSA8MzUzNzc5MjA3QHFx
LmNvbT4NCj4gKrOty806KiBNaWFvIFhpZSA8bWlhb3hpZUBodWF3ZWkuY29tPiwgbGludXgt
ZXJvZnMgPGxpbnV4LWVyb2ZzQGxpc3RzLm96bGFicy5vcmc+DQo+ICrW98ziOiogu9i4tKO6
ZXJvc9DUxNzOysziDQo+IA0KPiANCj4gDQo+IE9uIDIwMTkvNy8xOCAxMDo1NCwgR2FvIFhp
YW5nIHdyb3RlOg0KPj4+ILfFyOtlcm9mc9bQo6yy4srUw/zB7s6qo7ouL2lvem9uZSAtaSAy
IC1zIDMwMG0gLXIgNGsgLStFIC13IC1mIC4vdmVuZG9yL3RtcF9maWxlDQo+PiDO0rK7x+Wz
/tXiuPa0+rHtyrLDtNLiy7yjrMrHt/HT0LbU06a1xGZpb7XEw/zB7qGjDQo+Pg0KPiANCj4g
we3N4qOsztLDx72o0um1xMvmu/q2wXBhdHRlcm6jqNKyysfO0sPHsuLK1LnY16K1xKOpyscN
Cj4gZWNobyAzID4gL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzDQo+IC4vZmlvIC0tcmVhZG9u
bHkgLXJ3PXJhbmRyZWFkIC1zaXplPTEwMCUgLWJzPTRrIC1uYW1lPWpvYjENCj4gDQo+INLy
zqq++LTztuDK/dOm08PDu9PQZGlyZWN0IEkvT8frx/OjrMO709BkaXJlY3QgSS9PtsHCt762
o6y2zMbaw7vT0GRpcmVjdCBJL0/Wp7PWvMa7rqOsDQo+INKysru9qNLpyrnTw2RpcmVjdCBJ
L0+y4srU0NTE3KGj

------=_NextPart_5D2FE66D_08C40240_72AD9D14
Content-Type: text/html;
	charset="gb18030"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibWluLWhlaWdodDoyMnB4O21hcmdpbi1ib3R0b206OHB4OyI+yse1xCC/
tLT6wuvB97PMZXJvZnO4/LzyveAgsrvTprjDs/bP1tDUxNy28buvtcTOysziIMHtzeLU2tf2
eGF0dHLKsaOsztLDu9PQxvTTw3NoYXJltcS3vcq9o6zV4tTaYW5kcm9pZMnP06a4w7K7u+HT
sM/stb3Q1MTcsMmjrNLyzqrU2rbBc2VjdXJpdHnK9NDUuvO74bu6tOa1vWtlcm5lbNbQPC9k
aXY+PGRpdiBzdHlsZT0ibWluLWhlaWdodDoyMnB4O21hcmdpbi1ib3R0b206OHB4OyI+PGJy
PjwvZGl2Pjxmb250IGNvbG9yPSIjNDQ0NDQ0Ij5CLlI8L2ZvbnQ+PGJyPjxkaXYgaWQ9Im9y
aWdpbmFsLWNvbnRlbnQiPjxicj48YnI+PGRpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6NzAl
O3BhZGRpbmc6MnB4IDA7Ij4tLS0tLS0tLS0tLS0tLS0tLS0g1K3KvNPKvP4gLS0tLS0tLS0t
LS0tLS0tLS0tPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjcwJTtiYWNrZ3JvdW5kOiNm
MGYwZjA7Y29sb3I6IzIxMjEyMTtwYWRkaW5nOjhweDtib3JkZXItcmFkaXVzOjRweCI+PGRp
dj48Yj63orz+yMs6PC9iPiBHYW8gWGlhbmcgJmx0O2dhb3hpYW5nMjVAaHVhd2VpLmNvbSZn
dDs8L2Rpdj48ZGl2PjxiPreiy83KsbzkOjwvYj4gMjAxOcTqN9TCMTjI1SAxMToxOTwvZGl2
PjxkaXY+PGI+ytW8/sjLOjwvYj4gWkhPVSAmbHQ7MzUzNzc5MjA3QHFxLmNvbSZndDs8L2Rp
dj48ZGl2PjxiPrOty806PC9iPiBNaWFvIFhpZSAmbHQ7bWlhb3hpZUBodWF3ZWkuY29tJmd0
OywgbGludXgtZXJvZnMgJmx0O2xpbnV4LWVyb2ZzQGxpc3RzLm96bGFicy5vcmcmZ3Q7PC9k
aXY+PGRpdj48Yj7W98ziOjwvYj4gu9i4tKO6u9i4tKO6ZXJvc9DUxNzOysziPC9kaXY+PC9k
aXY+PC9kaXY+PGJyPjxicj48YnI+T24gMjAxOS83LzE4IDExOjE1LCBaSE9VIHdyb3RlOjxi
cj4mZ3Q7IERlYXIgeGlhbmcsPGJyPiZndDsgw7vT0Mb008NkaXJlY3RJTyw8YnI+Jmd0OyC6
w7XELM7Ss6LK1NK7z8LE+szhuam1xLLiytS3vbeooaM8YnI+PGJyPtbBydm21NPasrvRucv1
tcTH6b/2o6zE0dLUwO294svmu/q2wdPQsu7S7KGjPGJyPjxicj7Qu9C7oaM8YnI+PGJyPiZn
dDsgPGJyPiZndDsgt8ezo7jQ0Ls8YnI+Jmd0OyA8YnI+Jmd0OyA8YnI+Jmd0OyAtLS0tLS0t
LS0tLS0tLS0tLS0g1K3KvNPKvP4gLS0tLS0tLS0tLS0tLS0tLS0tPGJyPiZndDsgKreivP7I
yzoqIEdhbyBYaWFuZyAmbHQ7Z2FveGlhbmcyNUBodWF3ZWkuY29tJmd0Ozxicj4mZ3Q7ICq3
osvNyrG85DoqIDIwMTnE6jfUwjE4yNUgMTE6MTA8YnI+Jmd0OyAqytW8/sjLOiogWkhPVSAm
bHQ7MzUzNzc5MjA3QHFxLmNvbSZndDs8YnI+Jmd0OyAqs63LzToqIE1pYW8gWGllICZsdDtt
aWFveGllQGh1YXdlaS5jb20mZ3Q7LCBsaW51eC1lcm9mcyAmbHQ7bGludXgtZXJvZnNAbGlz
dHMub3psYWJzLm9yZyZndDs8YnI+Jmd0OyAq1vfM4joqILvYuLSjumVyb3PQ1MTczsrM4jxi
cj4mZ3Q7IDxicj4mZ3Q7IDxicj4mZ3Q7IDxicj4mZ3Q7IE9uIDIwMTkvNy8xOCAxMDo1NCwg
R2FvIFhpYW5nIHdyb3RlOjxicj4mZ3Q7Jmd0OyZndDsgt8XI62Vyb2Zz1tCjrLLiytTD/MHu
zqqjui4vaW96b25lIC1pIDIgLXMgMzAwbSAtciA0ayAtK0UgLXcgLWYgLi92ZW5kb3IvdG1w
X2ZpbGU8YnI+Jmd0OyZndDsgztKyu8fls/7V4rj2tPqx7cqyw7TS4su8o6zKx7fx09C21NOm
tcRmaW+1xMP8we6hozxicj4mZ3Q7Jmd0Ozxicj4mZ3Q7IDxicj4mZ3Q7IMHtzeKjrM7Sw8e9
qNLptcTL5rv6tsFwYXR0ZXJuo6jSssrHztLDx7LiytS52NeitcSjqcrHPGJyPiZndDsgZWNo
byAzICZndDsgL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzPGJyPiZndDsgLi9maW8gLS1yZWFk
b25seSAtcnc9cmFuZHJlYWQgLXNpemU9MTAwJSAtYnM9NGsgLW5hbWU9am9iMTxicj4mZ3Q7
IDxicj4mZ3Q7INLyzqq++LTztuDK/dOm08PDu9PQZGlyZWN0IEkvT8frx/OjrMO709BkaXJl
Y3QgSS9PtsHCt762o6y2zMbaw7vT0GRpcmVjdCBJL0/Wp7PWvMa7rqOsPGJyPiZndDsg0rKy
u72o0unKudPDZGlyZWN0IEkvT7LiytTQ1MTcoaM8YnI+PC9kaXY+

------=_NextPart_5D2FE66D_08C40240_72AD9D14--



