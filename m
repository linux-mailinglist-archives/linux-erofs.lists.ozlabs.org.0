Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9C70282F
	for <lists+linux-erofs@lfdr.de>; Mon, 15 May 2023 11:22:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QKYm93W1hz3f30
	for <lists+linux-erofs@lfdr.de>; Mon, 15 May 2023 19:22:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QKYm41zQYz3bmL
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 May 2023 19:21:55 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vifybmh_1684142508;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vifybmh_1684142508)
          by smtp.aliyun-inc.com;
          Mon, 15 May 2023 17:21:48 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix null-ptr-deref caused by erofs_xattr_prefixes_init
Date: Mon, 15 May 2023 17:21:48 +0800
Message-Id: <20230515092148.1485-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fragments and dedup share one feature bit, and thus packed inode may not
exist when fragment feature bit (dedup feature bit exactly) is set, e.g.
when deduplication feature is in use while fragments feature is not.  In
this case, sbi->packed_inode could be NULL while fragments feature bit
is set.

Fix this by accessing packed inode only when it exists.

Reported-by: syzbot+902d5a9373ae8f748a94@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=902d5a9373ae8f748a94
Fixes: 9e382914617c ("erofs: add helpers to load long xattr name prefixes")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index cd80499351e0..bbfe7ce170d2 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -675,7 +675,7 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 	if (!pfs)
 		return -ENOMEM;
 
-	if (erofs_sb_has_fragments(sbi))
+	if (sbi->packed_inode)
 		buf.inode = sbi->packed_inode;
 	else
 		erofs_init_metabuf(&buf, sb);
-- 
2.19.1.6.gb485710b

