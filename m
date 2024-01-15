Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0569C82D51D
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jan 2024 09:34:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TD56l6gDjz2xdX
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jan 2024 19:34:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TD56j0HLjz2xdX
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jan 2024 19:34:52 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W-eSTCt_1705307687;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W-eSTCt_1705307687)
          by smtp.aliyun-inc.com;
          Mon, 15 Jan 2024 16:34:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-cachefs@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 3/4] erofs: Don't use certain internal folio_*() functions
Date: Mon, 15 Jan 2024 16:34:45 +0800
Message-Id: <20240115083445.1356899-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240109180117.1669008-4-dhowells@redhat.com>
References: <20240109180117.1669008-4-dhowells@redhat.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Yue Hu <huyue2@coolpad.com>, Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: David Howells <dhowells@redhat.com>

Filesystems should use folio->index and folio->mapping, instead of
folio_index(folio), folio_mapping() and folio_file_mapping() since
they know that it's in the pagecache.

Change this automagically with:

perl -p -i -e 's/folio_mapping[(]([^)]*)[)]/\1->mapping/g' fs/erofs/*.c
perl -p -i -e 's/folio_file_mapping[(]([^)]*)[)]/\1->mapping/g' fs/erofs/*.c
perl -p -i -e 's/folio_index[(]([^)]*)[)]/\1->index/g' fs/erofs/*.c

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: Yue Hu <huyue2@coolpad.com>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Hi folks,

I tend to apply this patch upstream since compressed data fscache
adaption touches this part too.  If there is no objection, I'm
going to take this patch separately for -next shortly..

Thanks,
Gao Xiang

Change since v1:
 - a better commit message pointed out by Jeff Layton.

 fs/erofs/fscache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 87ff35bff8d5..bc12030393b2 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -165,10 +165,10 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 {
 	int ret;
-	struct erofs_fscache *ctx = folio_mapping(folio)->host->i_private;
+	struct erofs_fscache *ctx = folio->mapping->host->i_private;
 	struct erofs_fscache_request *req;
 
-	req = erofs_fscache_req_alloc(folio_mapping(folio),
+	req = erofs_fscache_req_alloc(folio->mapping,
 				folio_pos(folio), folio_size(folio));
 	if (IS_ERR(req)) {
 		folio_unlock(folio);
@@ -276,7 +276,7 @@ static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
 	struct erofs_fscache_request *req;
 	int ret;
 
-	req = erofs_fscache_req_alloc(folio_mapping(folio),
+	req = erofs_fscache_req_alloc(folio->mapping,
 			folio_pos(folio), folio_size(folio));
 	if (IS_ERR(req)) {
 		folio_unlock(folio);
-- 
2.39.3

