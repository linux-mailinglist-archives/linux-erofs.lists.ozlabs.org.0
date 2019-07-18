Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5406C69B
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 05:18:28 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45pzqP2l3FzDqLJ
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 13:18:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=qq.com
 (client-ip=113.96.223.78; helo=qq.com; envelope-from=353779207@qq.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=qq.com header.i=@qq.com header.b="ry+J+vmE"; 
 dkim-atps=neutral
Received: from qq.com (smtpbg413.qq.com [113.96.223.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45pzmN0btczDqP5
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2019 13:15:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1563419730; bh=nvcH0Ry0ywgfZ1G6JucMbz8qWQBLaTFmy93MwvDS2wI=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=ry+J+vmERtoaX068gs1IiQdHdKfS4XlVVoBZUfqLBZ9SgY4el/iWl5R/rkB67++Vf
 oMdgiNMsJYGW8YX0vRo7El8H28xcAmlqj9sgTRlcwv4/+T7YQdKD/KSD8vzyDyXxxy
 o4vP3ULB10FhMmd3xGq87iTC64Yn81B2L7TgvFVc=
X-QQ-FEAT: yPYUgJ+lOUkC84leDJlxWM01d4ecWw/KbXTllIbLg+eh0fxMVHInK55Hq8T0Y
 mxYC5Z0y5lnVtUGwm8ZEF6xmmz6V8Qtb9YAxOvZAy7s1P2glzRbzT5NE6QW4BtWyYI6umU2
 /9+mGcQSUTog4Q8YNtN8klaqb/aOkI15SZLgBznkzhgeJWl5+ZXprk3hapP5dkrQk0DLXPU
 JHr9brVREbgSEEAci4XddtLcD69TiZQo/LUMWLl+bn+mGfXSLUJBRrJ1R/SrP7bnuUC7YFn
 iUkMOzJX+Bqy/h98ln0CzR7l7VUhRM8leGZ6gd8n155vT2
X-QQ-SSF: 0000000000000060
X-QQ-WAPMAIL: 1
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 117.136.75.97
References: <tencent_43D5609D92443B9ED755C87B7843FA71D705@qq.com>
 <d3efd7a5-c781-6163-d04a-c2e6382ea760@huawei.com>
 <c85d590a-2eed-2501-b144-33a95fc0bec2@huawei.com>
X-QQ-STYLE: 
X-QQ-mid: riamail29t1563419729t8829399
From: "=?gb18030?B?WkhPVQ==?=" <353779207@qq.com>
To: "=?gb18030?B?R2FvIFhpYW5n?=" <gaoxiang25@huawei.com>
Subject: =?gb18030?B?u9i4tKO6ZXJvc9DUxNzOyszi?=
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_5D2FE451_08BC2C80_4DC4F164"
Content-Transfer-Encoding: 8Bit
Date: Thu, 18 Jul 2019 11:15:29 +0800
X-Priority: 3
Message-ID: <tencent_4AE55DADBCB537681FA35D97D66948F2E209@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 3395389473
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Thu, 18 Jul 2019 11:15:29 +0800 (CST)
Feedback-ID: riamail:qq.com:bgforeign:bgforeign2
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

------=_NextPart_5D2FE451_08BC2C80_4DC4F164
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64

RGVhciB4aWFuZywNCsO709DG9NPDZGlyZWN0SU8sDQq6w7XELM7Ss6LK1NK7z8LE+szhuam1
xLLiytS3vbeooaMNCg0KDQq3x7OjuNDQuw0KDQoNCi0tLS0tLS0tLS0tLS0tLS0tLSDUrcq8
08q8/iAtLS0tLS0tLS0tLS0tLS0tLS0NCreivP7IyzogR2FvIFhpYW5nIDxnYW94aWFuZzI1
QGh1YXdlaS5jb20+DQq3osvNyrG85DogMjAxOcTqN9TCMTjI1SAxMToxMA0KytW8/sjLOiBa
SE9VIDwzNTM3NzkyMDdAcXEuY29tPg0Ks63LzTogTWlhbyBYaWUgPG1pYW94aWVAaHVhd2Vp
LmNvbT4sIGxpbnV4LWVyb2ZzIDxsaW51eC1lcm9mc0BsaXN0cy5vemxhYnMub3JnPg0K1vfM
4jogu9i4tKO6ZXJvc9DUxNzOysziDQoNCg0KDQoNCg0KT24gMjAxOS83LzE4IDEwOjU0LCBH
YW8gWGlhbmcgd3JvdGU6DQo+PiC3xcjrZXJvZnPW0KOssuLK1MP8we7OqqO6Li9pb3pvbmUg
LWkgMiAtcyAzMDBtIC1yIDRrIC0rRSAtdyAtZiAuL3ZlbmRvci90bXBfZmlsZQ0KPiDO0rK7
x+Wz/tXiuPa0+rHtyrLDtNLiy7yjrMrHt/HT0LbU06a1xGZpb7XEw/zB7qGjDQo+IA0KDQrB
7c3io6zO0sPHvajS6bXEy+a7+rbBcGF0dGVybqOo0rLKx87Sw8ey4srUudjXorXEo6nKxw0K
ZWNobyAzID4gL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzDQouL2ZpbyAtLXJlYWRvbmx5IC1y
dz1yYW5kcmVhZCAtc2l6ZT0xMDAlIC1icz00ayAtbmFtZT1qb2IxDQoNCtLyzqq++LTztuDK
/dOm08PDu9PQZGlyZWN0IEkvT8frx/OjrMO709BkaXJlY3QgSS9PtsHCt762o6y2zMbaw7vT
0GRpcmVjdCBJL0/Wp7PWvMa7rqOsDQrSsrK7vajS6cq508NkaXJlY3QgSS9PsuLK1NDUxNyh
ow==

------=_NextPart_5D2FE451_08BC2C80_4DC4F164
Content-Type: text/html;
	charset="gb18030"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibWluLWhlaWdodDoyMnB4O21hcmdpbi1ib3R0b206OHB4OyI+RGVhciB4
aWFuZyw8L2Rpdj48ZGl2IHN0eWxlPSJtaW4taGVpZ2h0OjIycHg7bWFyZ2luLWJvdHRvbTo4
cHg7Ij7Du9PQxvTTw2RpcmVjdElPLDwvZGl2PjxkaXYgc3R5bGU9Im1pbi1oZWlnaHQ6MjJw
eDttYXJnaW4tYm90dG9tOjhweDsiPrrDtcQsztKzosrU0rvPwsT6zOG5qbXEsuLK1Le9t6ih
ozwvZGl2PjxkaXYgc3R5bGU9Im1pbi1oZWlnaHQ6MjJweDttYXJnaW4tYm90dG9tOjhweDsi
Pjxicj48L2Rpdj48ZGl2IHN0eWxlPSJtaW4taGVpZ2h0OjIycHg7bWFyZ2luLWJvdHRvbTo4
cHg7Ij63x7OjuNDQuzwvZGl2PjxkaXYgaWQ9Im9yaWdpbmFsLWNvbnRlbnQiPjxicj48YnI+
PGRpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6NzAlO3BhZGRpbmc6MnB4IDA7Ij4tLS0tLS0t
LS0tLS0tLS0tLS0g1K3KvNPKvP4gLS0tLS0tLS0tLS0tLS0tLS0tPC9kaXY+PGRpdiBzdHls
ZT0iZm9udC1zaXplOjcwJTtiYWNrZ3JvdW5kOiNmMGYwZjA7Y29sb3I6IzIxMjEyMTtwYWRk
aW5nOjhweDtib3JkZXItcmFkaXVzOjRweCI+PGRpdj48Yj63orz+yMs6PC9iPiBHYW8gWGlh
bmcgJmx0O2dhb3hpYW5nMjVAaHVhd2VpLmNvbSZndDs8L2Rpdj48ZGl2PjxiPreiy83Ksbzk
OjwvYj4gMjAxOcTqN9TCMTjI1SAxMToxMDwvZGl2PjxkaXY+PGI+ytW8/sjLOjwvYj4gWkhP
VSAmbHQ7MzUzNzc5MjA3QHFxLmNvbSZndDs8L2Rpdj48ZGl2PjxiPrOty806PC9iPiBNaWFv
IFhpZSAmbHQ7bWlhb3hpZUBodWF3ZWkuY29tJmd0OywgbGludXgtZXJvZnMgJmx0O2xpbnV4
LWVyb2ZzQGxpc3RzLm96bGFicy5vcmcmZ3Q7PC9kaXY+PGRpdj48Yj7W98ziOjwvYj4gu9i4
tKO6ZXJvc9DUxNzOysziPC9kaXY+PC9kaXY+PC9kaXY+PGJyPjxicj48YnI+T24gMjAxOS83
LzE4IDEwOjU0LCBHYW8gWGlhbmcgd3JvdGU6PGJyPiZndDsmZ3Q7ILfFyOtlcm9mc9bQo6yy
4srUw/zB7s6qo7ouL2lvem9uZSAtaSAyIC1zIDMwMG0gLXIgNGsgLStFIC13IC1mIC4vdmVu
ZG9yL3RtcF9maWxlPGJyPiZndDsgztKyu8fls/7V4rj2tPqx7cqyw7TS4su8o6zKx7fx09C2
1NOmtcRmaW+1xMP8we6hozxicj4mZ3Q7IDxicj48YnI+we3N4qOsztLDx72o0um1xMvmu/q2
wXBhdHRlcm6jqNKyysfO0sPHsuLK1LnY16K1xKOpysc8YnI+ZWNobyAzICZndDsgL3Byb2Mv
c3lzL3ZtL2Ryb3BfY2FjaGVzPGJyPi4vZmlvIC0tcmVhZG9ubHkgLXJ3PXJhbmRyZWFkIC1z
aXplPTEwMCUgLWJzPTRrIC1uYW1lPWpvYjE8YnI+PGJyPtLyzqq++LTztuDK/dOm08PDu9PQ
ZGlyZWN0IEkvT8frx/OjrMO709BkaXJlY3QgSS9PtsHCt762o6y2zMbaw7vT0GRpcmVjdCBJ
L0/Wp7PWvMa7rqOsPGJyPtKysru9qNLpyrnTw2RpcmVjdCBJL0+y4srU0NTE3KGjPGJyPjwv
ZGl2Pg==

------=_NextPart_5D2FE451_08BC2C80_4DC4F164--



