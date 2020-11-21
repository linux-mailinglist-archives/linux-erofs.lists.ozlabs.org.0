Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC7C2BBC3A
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 03:27:49 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CdHPt1XdWzDr1x
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 13:27:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605925666;
	bh=iHLsAkH76M68dYhT67+uE/1jDGUtE6pZG7kvlwRQWZ8=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=N/uqL5PSN7Dlx2SzjcqbEFXvKj1pY5vk9QS95xid7Ig54QDcAgtjeD+qYjT2DFFWh
	 bM8bIkhuDlfgysKxDgBszG/PVAlmXaqy5i8JhKw90XqvRJQ3JIuc3KAyAIYpI9jG/b
	 3udM0RTkI0gBN07rSIQ2iJqxJ1Hu1SnF4tpue3dmovR3cUGVLuuamBxYb9d3UkYrgg
	 lIjyu/EunUJyUbXF9GrRZhEWYhqP0opj0fdTL2XocKZKeyrE8ITemfPrQoPPe4uVJ1
	 IeZ5C61eKtLFO1h0IPso6GG9sdedaNdRP3YRDgIM0GhgFyS9GzYad5tUsLTYoC3K1H
	 fbor77niqyr4A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.84; helo=sonic314-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Syf5wWvQ; dkim-atps=neutral
Received: from sonic314-21.consmr.mail.gq1.yahoo.com
 (sonic314-21.consmr.mail.gq1.yahoo.com [98.137.69.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CdHPg5MR3zDr1X
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Nov 2020 13:27:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605925646; bh=Ogfi2xfVOcWDCZjB2Yt5+UNa6Xfwwx+qLyyUvHSdHyM=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=Syf5wWvQSUEuqWXUnmt/xLo0ECHgYXhAd7LK0sJLmOofo/Su7jzSjIGnC+PmOClZ3m4qiJ1Szyg3JfWjUHIAaAJv4GDcxYe2njRAyNM8e9cMMAtbq5Gagkhi8SkILc40NgLDK1skPz9o14e+q/sgIpgcfl9u2ucFQq+mA2LY1+tXKgdLQ5Okzs2ZwK/ibj8d/1U7e49yeOEFOTU1ilvpkbDhi7Gwb97YaT/uSU/ncjTU8YkMNKnoIE4+nb+Z0RxYqk2q/OaH5IWiyQddDfUUFBRNsFOsoXIReplcDY4ypTSWO4xBNP0fOJ1z2WpvB67kO9CaCNVnELL1hzd1xjS33g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605925646; bh=KsyePq43mwrXjAmJGenmh2nU8VJyIu4RxvLmHXZEvT1=;
 h=From:To:Subject:Date:From:Subject;
 b=Z52+59XMv6ZtOdLws3dw/W7J2Iee7uEAFIYmVFFjXiY0WOK6K0YvDbrrNUaH9RxUgJqVhtEIgLFiZUMxS5B6iAUb24gTjcjqONke8P40f9m13sYyO2z5BnkWQG57uBTCTKIhqLGNtfn1bcjJatkvT8FLam/NcJqDttL3BKd2qejtjkaHIaaaJNtkDjoA5bqOC4i4Ntw5j+nDuWT2U0IiXhsYe0bW//hoaU0osuFQhqcNVNgf6JM+l8fddtgNNnjY+auP4mQAEL6e4tVMxAu+UKkaUN01Glso6deDCt/jsqEKVlV9AVhZIn0IWJm/WefiSCkSa+CDmzOgUOKHI7slyA==
X-YMail-OSG: X1F.yGoVM1lGtAAblav4LNK7.AJiHjQc1LM5TcDgxi3vkOgseFEyThM2rc52FUp
 5SqcpIBnIi4dcyuLpcfckt3n6Bjbd3zl6wZ.4YW3zcdA0902tc7JbzmZQZ78RRcTWkwL4C2iFZvE
 VpF30JpEG66trX.5KPowgNogJfnFWnkg_Ne9tycUaToDuOYZGanBqboU5YWDKi.WGITasR0sNW71
 bthSRP3lPgyCa3OWK52dPy8b2Z2eHwobNZFr2_7XwNQtMCLjX3TGqiY7OnTmVJvTVJI6bLJsjSt6
 bfW62FiPzxdxeqpGzVVXmIsQ3KeWNA7OOWL2DlVRzbTNR48SkV5vQy_rkEjbQHZX2foHwNQUBpCl
 xhUjAyg_qQ9rdiJeqiFVLkKStzSoWfA9NV7nUCsRHyqC6qImerMzq4CiIpOyiPLZVNx9jIzP0HeP
 YEfw9aVT0b99WnFEQBNmS4msCTkRoGZeDXJyOhwtwGmoUKB9ihQrd4_YRstzVhMawcVYEluLdHQa
 6N8fOX387.kj0U1umWisBZqzh8qDLilLWNjadwFn27L7SRAqy8BRk9gozUPS5HjxePocyorbGM5k
 dTgRFOVFSjsDR4l8rusDFlvBGDT92bMKd2X2KEdxMvwmbDmxDLF4XhVt9BMOC4Bgrr.i4rHYdT12
 xq7fbi8bnz9Bv3pDGBhux78zYYvbpUNByTFgjtlTnaoaBfe9tHWVQmdkn7Ns.6OdIcN4xIYRPME3
 4arBm7QnfAIVzkFmHZ7vgowKZp.BS0GVkF_ir2TM.W21hHcynjE4BryIJtbex8TNqwoKgSUTJHWg
 N.9fcTrFQurFrNub07mXqFDIg4g.GJ_HPvNVJPbMmJliMtqn2ZthJmQyBsXU8mAglqLnudWwGpjx
 Q1RkTJ_Yuv.5C1CRCakr6CmvL8xgm8LwSWOfIGZ6ayDRE9n5rHm9ukgh7b_opfqXBtC6kaK0JiZc
 _NjWuJ2cA6yXq7Om2XF1iL3NlCDr8Muy_tvEVqTp3WSTWJg5HJM85W1DEZl5yPWr7J2Uo5zG3Z5a
 912yUS0FGkJKm9VrZYE7ts0LXin5FE9qogVMwJjMyQbXh3KcJdbx3W_.3qcLqgtobyY87TmVwbGZ
 SD4td5sCKbRmo_NgOKeqpiEVrIxdhs1xQ_bZ8H8nFlVbg6LOH4.jGgW6BBpOsDlMtqBtSnrvv9Py
 1fSNu3nhe8cTF4TLZjLJZx3Dhndz_idDN1f9vbFVe7K2DA5U57PG07Cu5wkQWdS2MMoBggjyYWWc
 9X4KvW8bLbA_JExRSUSKtdF.VVPpYm63RYdDPUCYHbLrl3WytoPpRdHk2t.tuSdd8tcMaIZbWG4h
 D_tn9.dgpClh1afJU1wxHbdviqJd2e4hTfHxcors4ZPVJk5uzLRdf_cgt.yc7LhDrWOa2cY5Fa1N
 dA.SiYZegh7ZDMiO_5RqnczjTKXbG7AE9X6BWLdQTBGV1Cr0gCkXcNhNTkm4CXT5qj5jH4bsMq1b
 32GXuST2fQ8DpuTI3ndmZQQL9nhtHF1YrLrEcviFlgaVNN7OaJPq7aW_tYqbcGKmBvceG9huZWOb
 qCpVfomWPpxMnQM2yr18r2ig_IiiKBzjwME0jXAvJ1WdnKIid9yl.adnQe4.CEszHLIuhv7q1AlV
 4U5Z.BuWk6iUPURgimUyTzNX0zOLZHQbZQ_tCkS2U9_RmP8ummorxty8sjjbxE1EHwxaDIRN_aRi
 u9jTW75dZu6YCldOcfikwmiSgKyIhJtrl4Cq2fYOkbkNmmWpbLzO8cXUavKoYlVyzo1r3rcIYu_z
 p.UIMkF3vjCnRX6mwRCyNmoWiCypf5oItXTS5_AnBNGik6hFd8FzC2XTekL8mCKwQVwI4GfXzCDn
 V8V.WASwANU5uCAiOi3kmgNelZ_iGMkQS8daB0xXx9b3t9AlUDpOVcw2ZGhl19uwD8QnLmwYT8LS
 tT1nzZVZo5a6VInSoGuR7mQUFibfeJMdEGHZXDqClcoS5PEwi2_016Iw73lixu4F5Wu0.NUH5HUV
 ux4fZkSL6g6ibPBW8SJ51RVxbqVblabCGKDKxwMnBFlf95tIZX3BEZ3lfVU2p0mcAKZIWYf_AIJd
 2BynJ5Diy0EdnUSArJEkOmHEazskcmBWGZ7_ebwBIuly3JRFTQFZNB.MA3RVfs8On8e2a9g.Da5g
 kvZq5Ideg3lJJIr8Mb_AxUycy5zsbv5TRAYdi8_QeHm3.fMj3ssbt0B0GH7cYRxLb.oE90UzIYrF
 d3Ae7EIzK.RC8hbNQ8poGA9qbDsnmejfyQe3yqAwoAp1zFzB9mzkvhL2KxNH9H7ijTxfWeWOHHHs
 N8EqqpHNGHcMlCrWP8Z.K5DdnASXnnFN3gKT10KM2o0roQFCYGhwl.Hd2UjHl8rm.gXnlMi6ZXPD
 r376XWDvmQw06kNJ7xOHQNWvarveNBA_bb20qYMqRsZW6QfqKdsNY5SwVosMVkUUExJNiOIRqbgk
 WsWef50XUy52CXYXXEUEkYIJC22TewppkAyrmdvy_QSJk1IW8FZsIGgWYWHRi_qQf5ZfEIyuM.a3
 NX4exH_tjJFrdDY75LRlG3RLSaZfbMNSQnMWuvoTmyPOB0cJz2y2ugWtF9vmqjF1d158yHA5gKn3
 7mq2_1jPIaXBh681PSJoU5obpBET.a89GahGWkZKx5iODeajqXrRfgzwSAJXCKuoPG3E-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Sat, 21 Nov 2020 02:27:26 +0000
Received: by smtp401.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 74b21d6d18b50adda7c1c053fd211ed4; 
 Sat, 21 Nov 2020 02:27:20 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/2] erofs-utils: drop known issue in README
Date: Sat, 21 Nov 2020 10:26:22 +0800
Message-Id: <20201121022623.3882-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201121022623.3882-1-hsiangkao.ref@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@aol.com>

Since lz4-1.9.3 has been released,
https://github.com/lz4/lz4/releases/tag/v1.9.3

Move this lz4hc issue (lz4 <= 1.9.2) to "Comments" instead.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
v2: fix "lz4 <= 1.8.2" to "lz4 <= 1.9.2" typo.

 README | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/README b/README
index 5addd6b80e04..7a7ac5d5cb6f 100644
--- a/README
+++ b/README
@@ -19,7 +19,7 @@ It can create 2 primary kinds of erofs images: (un)compressed.
 Dependencies
 ~~~~~~~~~~~~
 
- lz4-1.8.0+ for lz4 enabled [2], lz4-1.9.0+ recommended
+ lz4-1.8.0+ for lz4 enabled [2], lz4-1.9.3+ recommended [4].
 
 How to build for lz4-1.9.0 or above
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -48,7 +48,7 @@ On Fedora, static lz4 can be installed using:
 	yum install lz4-static.x86_64
 
 However, it's not recommended to use those versions since there were bugs
-in these compressors, see [2] [3] as well.
+in these compressors, see [2] [3] [4] as well.
 
 How to generate erofs images
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -70,19 +70,6 @@ add "-E legacy-compress" to the command line, e.g.
 
  $ mkfs.erofs -E legacy-compress -zlz4hc foo.erofs.img foo/
 
-
-Known issues
-~~~~~~~~~~~~
-
-1. LZ4HC cannot compress long zeroed buffer properly with
-   LZ4_compress_HC_destSize()
-   https://github.com/lz4/lz4/issues/784
-
-   which has been resolved in
-   https://github.com/lz4/lz4/commit/e7fe105ac6ed02019d34731d2ba3aceb11b51bb1
-
-   and will be included in lz4-1.9.3 if all goes well.
-
 Obsoleted erofs.mkfs
 ~~~~~~~~~~~~~~~~~~~~
 
@@ -149,3 +136,13 @@ Comments
     version as well) or backport all stable bugfixes to old stable versions,
     e.g. our unoffical lz4 fork: https://github.com/erofs/lz4
 
+[4] LZ4HC didn't compress long zeroed buffer properly with
+    LZ4_compress_HC_destSize()
+    https://github.com/lz4/lz4/issues/784
+
+    which has been resolved in
+    https://github.com/lz4/lz4/commit/e7fe105ac6ed02019d34731d2ba3aceb11b51bb1
+
+    and already included in lz4-1.9.3, see:
+    https://github.com/lz4/lz4/releases/tag/v1.9.3
+
-- 
2.24.0

