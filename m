Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2267E4F751D
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 07:15:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KYqMM70SBz2yjS
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 15:15:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=mu7Txdp7;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=coolpad.com (client-ip=101.36.218.48; helo=v04.bc.feishu.cn;
 envelope-from=huyue2@coolpad.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn
 header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1
 header.b=mu7Txdp7; dkim-atps=neutral
Received: from v04.bc.feishu.cn (v04.bc.feishu.cn [101.36.218.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KYqMG3X0Vz2xgY
 for <linux-erofs@lists.ozlabs.org>; Thu,  7 Apr 2022 15:15:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=coolpad-com.20200927.dkim.feishu.cn; t=1649307684;
 h=mime-version:from:date:message-id:subject:to;
 bh=/q5YGobiw70uXNgrsMR5SIErIwoVJmylo9baPEpCLjM=;
 b=mu7Txdp7tUkk9dgk48asIHlzTJIQe1pAOGHlvVxzu3NZC3ResMOXv5TxMikxsjvnD+hWZe
 chR6TifRqE1jb9K48mgNvYBbyEwadsQX3hP7WMuoyRhaPIbNCON5mDTjxo50r57iN+J6oc
 vxCiNLThq0hTj49yoLkMoDo2errPtf8qHQQJZSRCGMo6fm58nEZtDY7jCJpfXN0t4tM9jj
 e7GawnlTnN3oriLFqc+XKqnJ7xQsV3824G5v0yXhi84+LgNpycSIBjOlDOsn1K8wdLoggE
 d6YdeTk2a2aVq3c8uPslL10te1moNcrCl8LII6qS3HVAxqVqH6775kiFGFX1Vw==
From: "Yue Hu" <huyue2@coolpad.com>
Subject: [PATCH] erofs: do not prompt for risk any more when using big pcluster
Date: Thu, 07 Apr 2022 13:01:23 +0800
X-Mailer: git-send-email 2.17.1
Content-Type: multipart/alternative;
 boundary=1995dbbdee206d5241629df32871de62cbc2f6b463564a51d19df42a7fc4
To: <xiang@kernel.org>, <chao@kernel.org>
Message-Id: <20220407050101.12556-1-huyue2@coolpad.com>
Mime-Version: 1.0
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
Cc: zbesathu@gmail.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
 zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--1995dbbdee206d5241629df32871de62cbc2f6b463564a51d19df42a7fc4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

The big pluster feature has been merged for a year, it has been mostly
stable now.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/decompressor.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 3efa686c7644..0f445f7e1df8 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -46,8 +46,6 @@ int z_erofs_load_lz4_config(struct super_block *sb,
 			erofs_err(sb, "too large lz4 pclusterblks %u",
 				  sbi->lz4.max_pclusterblks);
 			return -EINVAL;
-		} else if (sbi->lz4.max_pclusterblks >=3D 2) {
-			erofs_info(sb, "EXPERIMENTAL big pcluster feature in use. Use at your o=
wn risk!");
 		}
 	} else {
 		distance =3D le16_to_cpu(dsb->u1.lz4_max_distance);
--=20
2.17.1
--1995dbbdee206d5241629df32871de62cbc2f6b463564a51d19df42a7fc4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<p>The big pluster feature has been merged for a year, it has been mostly
<br>stable now.
<br>
<br>Signed-off-by: Yue Hu <huyue2@coolpad.com>
<br>---
<br> fs/erofs/decompressor.c | 2 --
<br> 1 file changed, 2 deletions(-)
<br>
<br>diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
<br>index 3efa686c7644..0f445f7e1df8 100644
<br>--- a/fs/erofs/decompressor.c
<br>+++ b/fs/erofs/decompressor.c
<br>@@ -46,8 +46,6 @@ int z_erofs_load_lz4_config(struct super_block *sb,
<br> 			erofs_err(sb, "too large lz4 pclusterblks %u",
<br> 				  sbi->lz4.max_pclusterblks);
<br> 			return -EINVAL;
<br>-		} else if (sbi->lz4.max_pclusterblks >=3D 2) {
<br>-			erofs_info(sb, "EXPERIMENTAL big pcluster feature in use. Use at yo=
ur own risk!");
<br> 		}
<br> 	} else {
<br> 		distance =3D le16_to_cpu(dsb->u1.lz4_max_distance);
<br>--=20
<br>2.17.1</p>
--1995dbbdee206d5241629df32871de62cbc2f6b463564a51d19df42a7fc4--
