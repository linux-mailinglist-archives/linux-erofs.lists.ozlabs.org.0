Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A7C4AE9D0
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 07:02:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jtq5h1wwhz30LQ
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 17:02:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jtq5Q3r6Mz30jV
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 17:01:45 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=15; SR=0; TI=SMTPD_---0V3zwJoJ_1644386496; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V3zwJoJ_1644386496) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 14:01:37 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 21/22] erofs: implement fscache-based data readahead for
 inline layout
Date: Wed,  9 Feb 2022 14:01:07 +0800
Message-Id: <20220209060108.43051-22-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ef5eef33e3d5..003f9abdaf1b 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -198,6 +198,7 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 enum erofs_fscache_readahead_type {
 	EROFS_FSCACHE_READAHEAD_TYPE_HOLE,
 	EROFS_FSCACHE_READAHEAD_TYPE_NOINLINE,
+	EROFS_FSCACHE_READAHEAD_TYPE_INLINE,
 };
 
 static int erofs_fscache_do_readahead(struct readahead_control *rac,
@@ -231,6 +232,9 @@ static int erofs_fscache_do_readahead(struct readahead_control *rac,
 			ret = erofs_fscache_readpage_noinline(page, fsmap);
 			fsmap->m_pa += EROFS_BLKSIZ;
 			break;
+		case EROFS_FSCACHE_READAHEAD_TYPE_INLINE:
+			ret = erofs_fscache_readpage_inline(page, fsmap);
+			break;
 		default:
 			DBG_BUGON(1);
 			return -EINVAL;
@@ -285,6 +289,10 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 				ret = erofs_fscache_do_readahead(rac, &fsmap,
 					EROFS_FSCACHE_READAHEAD_TYPE_NOINLINE);
 				break;
+			case EROFS_INODE_FLAT_INLINE:
+				ret = erofs_fscache_do_readahead(rac, &fsmap,
+					EROFS_FSCACHE_READAHEAD_TYPE_INLINE);
+				break;
 			default:
 				DBG_BUGON(1);
 				return;
-- 
2.27.0

