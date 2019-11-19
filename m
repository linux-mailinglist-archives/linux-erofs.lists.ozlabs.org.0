Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3A510239D
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Nov 2019 12:51:22 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47HPKz4fkBzDqWr
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Nov 2019 22:51:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mykernel.net (client-ip=124.251.121.247;
 helo=sender2.zoho.com.cn; envelope-from=cgxu519@mykernel.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mykernel.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=mykernel.net header.i=cgxu519@mykernel.net
 header.b="EzeTgs+u"; dkim-atps=neutral
X-Greylist: delayed 764 seconds by postgrey-1.36 at bilbo;
 Tue, 19 Nov 2019 22:51:04 AEDT
Received: from sender2.zoho.com.cn (sender3-of-o52.zoho.com.cn
 [124.251.121.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47HPKh1ZMMzDqMd
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Nov 2019 22:51:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574164253; 
 s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
 h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
 l=865; bh=+FwHwfxfCC02esvMwBIpiezVL59KIt/RyeILg7L7HdU=;
 b=EzeTgs+udigUBc3x4SreYE86cHePJThYfak062WykuFUFMMmlrz3bucj7Z+SICQu
 vdMhj8aP8xPJp/fXBqyap+xmSI5smXK/w1k0Lxg+86cmarFX9sb0W5DaSYXW5mTbd8X
 g3zsJJIomHGw93I5DDPDiBYly9rsvlQLosu8idIw=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by
 mx.zoho.com.cn with SMTPS id 1574164251601930.7687279860228;
 Tue, 19 Nov 2019 19:50:51 +0800 (CST)
From: Chengguang Xu <cgxu519@mykernel.net>
To: xiang@kernel.org,
	chao@kernel.org
Message-ID: <20191119115049.3401-1-cgxu519@mykernel.net>
Subject: [PATCH] erofs: remove unnecessary output in erofs_show_options()
Date: Tue, 19 Nov 2019 19:50:49 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
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
Cc: Chengguang Xu <cgxu519@mykernel.net>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

We have already handled cache_strategy option carefully,
so incorrect setting could not pass option parsing.
Meanwhile, print 'cache_strategy=3D(unknown)' can cause
failure on remount.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/erofs/super.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 06e721bd1c8c..65c7da996643 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -581,9 +581,6 @@ static int erofs_show_options(struct seq_file *seq, str=
uct dentry *root)
 =09=09seq_puts(seq, ",cache_strategy=3Dreadahead");
 =09} else if (sbi->cache_strategy =3D=3D EROFS_ZIP_CACHE_READAROUND) {
 =09=09seq_puts(seq, ",cache_strategy=3Dreadaround");
-=09} else {
-=09=09seq_puts(seq, ",cache_strategy=3D(unknown)");
-=09=09DBG_BUGON(1);
 =09}
 #endif
 =09return 0;
--=20
2.20.1



