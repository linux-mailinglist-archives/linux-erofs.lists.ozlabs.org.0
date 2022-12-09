Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2FC6480DA
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Dec 2022 11:22:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NT6X44dt5z3bfM
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Dec 2022 21:22:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1670581332;
	bh=JUZ1nbgPyt696GphUrYZhsJZC+42uCS/7nfOQ2ALbBw=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=am19ixIY/j+5YnedU+HRQTXHx1Y1mJD1suJYM7hlWjqddwHAIzK2CF6tHGwvDOeQZ
	 E8BNyi8V1/926KPJtuGbSfdqFnkh/Ll5vDOahzYKTMFOvgSNNOWMI9bHuZSboY5PYA
	 L3PscID9psapeYBrnkh7GrkjwTHDlE0cL+bVONdkznRSXAYkFmdEI04EyuFWRSlzYS
	 dO2QasxnhTZzA9qDP3EWCj1Ef+Crq4stlWXvuMva7BJxNotRcgghmZgwWqLbnYUj5f
	 +MRxC6OvITFMcC7XOJEY6YSh79nrNl4Uws1rz/gdphBPNwM8w5MHJljrloBrJLDO8o
	 lcdYiXxNbe0nQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siddh.me (client-ip=103.117.158.50; helo=sender-of-o50.zoho.in; envelope-from=code@siddh.me; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=siddh.me header.i=code@siddh.me header.a=rsa-sha256 header.s=zmail header.b=PnHtyBfH;
	dkim-atps=neutral
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NT6Wx6mCqz3bZS
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Dec 2022 21:22:05 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1670581320; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=JKZvFEQC0s+u8mPgmbSg+4UnMydSwUlXT7fqoEejG0SsstB2FdiD4GRHE7PDef5NucFMzmuyqfZUZ4XSG5LtfL/xGPS42BG6JJvUDLUoVbEg70I+2I+3PBGnTt1xWLJuUk5xyuANF9q+XYCUQLcA2xRfJZYl5SXwME+3pdUEhik=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1670581320; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=JUZ1nbgPyt696GphUrYZhsJZC+42uCS/7nfOQ2ALbBw=; 
	b=M1BKZrHabNPzWfYVHg9Yse+zEUwQV4k89Js9gDG2v79E0BICX7ASemKskTNQJDIY88VAdPfwtFMQY7AwuOpJcawS3JW/wd9GhgLo9tGbrIOaM1+taio25LZj+iTR6PZgH9qKO9mhPA9ZjuXJ48cwZAuHggaOOmoun8XxN+szwVY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
	with SMTPS id 1670581318019810.3770917612286; Fri, 9 Dec 2022 15:51:58 +0530 (IST)
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Message-ID: <20221209102151.311049-1-code@siddh.me>
Subject: [PATCH v2] erofs/zmap.c: Fix incorrect offset calculation
Date: Fri,  9 Dec 2022 15:51:51 +0530
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
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
From: Siddh Raman Pant via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Siddh Raman Pant <code@siddh.me>
Cc: linux-erofs <linux-erofs@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>, syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Effective offset to add to length was being incorrectly calculated,
which resulted in iomap->length being set to 0, triggering a WARN_ON
in iomap_iter_done().

Fix that, and describe it in comments.

This was reported as a crash by syzbot under an issue about a warning
encountered in iomap_iter_done(), but unrelated to erofs.

C reproducer: https://syzkaller.appspot.com/text?tag=3DReproC&x=3D1037a6b28=
80000
Kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3De2=
021a61197ebe02
Dashboard link: https://syzkaller.appspot.com/bug?extid=3Da8e049cd3abd34293=
6b6

Reported-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
Changes since v2:
- Fix the calculation instead of bailing out.

 fs/erofs/zmap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 0bb66927e3d0..a171e4caba3c 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -790,12 +790,16 @@ static int z_erofs_iomap_begin_report(struct inode *i=
node, loff_t offset,
 =09=09iomap->type =3D IOMAP_HOLE;
 =09=09iomap->addr =3D IOMAP_NULL_ADDR;
 =09=09/*
-=09=09 * No strict rule how to describe extents for post EOF, yet
-=09=09 * we need do like below. Otherwise, iomap itself will get
+=09=09 * No strict rule on how to describe extents for post EOF, yet
+=09=09 * we need to do like below. Otherwise, iomap itself will get
 =09=09 * into an endless loop on post EOF.
+=09=09 *
+=09=09 * Calculate the effective offset by subtracting extent start
+=09=09 * (map.m_la) from the requested offset, and add it to length.
+=09=09 * (NB: offset >=3D map.m_la always)
 =09=09 */
 =09=09if (iomap->offset >=3D inode->i_size)
-=09=09=09iomap->length =3D length + map.m_la - offset;
+=09=09=09iomap->length =3D length + offset - map.m_la;
 =09}
 =09iomap->flags =3D 0;
 =09return 0;
--=20
2.35.1


