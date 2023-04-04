Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F576D5A36
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 10:02:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrKxr5rxVz3chX
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 18:02:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrKxR5Rk0z3cG7
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Apr 2023 18:02:35 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VfL00-W_1680595350;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfL00-W_1680595350)
          by smtp.aliyun-inc.com;
          Tue, 04 Apr 2023 16:02:31 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH] tmp debug
Date: Tue,  4 Apr 2023 16:02:24 +0800
Message-Id: <20230404080224.77577-8-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230404080224.77577-1-jefflexu@linux.alibaba.com>
References: <20230404080224.77577-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/inode.c | 7 ++++++-
 lib/xattr.c | 3 +++
 mkfs/main.c | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/inode.c b/lib/inode.c
index 6861b99..b252904 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -272,8 +272,11 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 	struct erofs_buffer_head *const bh = inode->bh;
 	erofs_off_t off, meta_offset;
 
-	if (!bh || (long long)inode->nid > 0)
+	if (!bh || (long long)inode->nid > 0) {
+		erofs_dbg(" nid %llu to file %s, bh %p",
+		  inode->nid, inode->i_srcpath, inode->bh);
 		return inode->nid;
+	}
 
 	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
@@ -1266,6 +1269,8 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 	if (name == EROFS_PACKED_INODE) {
 		sbi.packed_nid = EROFS_PACKED_NID_UNALLOCATED;
 		inode->nid = sbi.packed_nid;
+		erofs_dbg("erofs_mkfs_build_special_from_fd: nid %llu to file %s, bh %p",
+		  inode->nid, inode->i_srcpath, inode->bh);
 	}
 
 	ret = erofs_write_compressed_file(inode, fd);
diff --git a/lib/xattr.c b/lib/xattr.c
index de462ab..c336d9d 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -141,11 +141,14 @@ static bool match_prefix(const char *key, u8 *index, u16 *len)
 	struct xattr_prefix *p;
 	struct extra_xattr_type_node *tnode;
 
+	printf("[match_prefix]: enter extra_xattr_types_count++ is %u\n", extra_xattr_types_count);
 	list_for_each_entry(tnode, &extra_xattr_types, list) {
 		p = &tnode->type;
+		printf("[iterating]: key %s, prefix %s\n", key, p->prefix);
 		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
 			*len = p->prefix_len;
 			*index = tnode->index;
+			printf("match_prefix: key %s, matches prefix %s, index %u\n", key, p->prefix, tnode->index);
 			return true;
 		}
 	}
diff --git a/mkfs/main.c b/mkfs/main.c
index d06f6f5..ce220c7 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -911,13 +911,17 @@ int main(int argc, char **argv)
 			erofs_update_progressinfo("Handling packed_file ...");
 			packed_inode = erofs_mkfs_build_packedfile();
 			if (IS_ERR(packed_inode)) {
+				printf("[%s %d] erofs_mkfs_build_packedfile failed\n", __func__, __LINE__);
 				err = PTR_ERR(packed_inode);
 				goto exit;
 			}
+			printf("[%s %d] start erofs_lookupnid...\n", __func__, __LINE__);
 			packed_nid = erofs_lookupnid(packed_inode);
+			printf("[%s %d] packed_nid %lu\n", __func__, __LINE__, packed_nid);
 			erofs_iput(packed_inode);
 		}
 	}
+	printf("[%s %d] packed_nid %lu\n", __func__, __LINE__, packed_nid);
 
 	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks,
 					    packed_nid);
-- 
2.19.1.6.gb485710b

