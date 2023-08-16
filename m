Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7A877D947
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 05:50:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQZ0B5sMyz3cTQ
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 13:50:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQZ0003Pbz2yW8
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Aug 2023 13:49:50 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VpuGnyq_1692157784;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VpuGnyq_1692157784)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 11:49:45 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/4] erofs-utils: add erofs_read_metadata() helper
Date: Wed, 16 Aug 2023 11:49:40 +0800
Message-Id: <20230816034941.126866-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230816034941.126866-1-jefflexu@linux.alibaba.com>
References: <20230816034941.126866-1-jefflexu@linux.alibaba.com>
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

Add erofs_read_metadata() helper reading variable-sized metadata from
inode specified by @nid.  Read from meta inode if @nid is 0.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/internal.h |  2 +
 lib/data.c               | 84 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index a04e6a6..3e7319d 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -364,6 +364,8 @@ int erofs_read_one_data(struct erofs_inode *inode, struct erofs_map_blocks *map,
 int z_erofs_read_one_data(struct erofs_inode *inode,
 			struct erofs_map_blocks *map, char *raw, char *buffer,
 			erofs_off_t skip, erofs_off_t length, bool trimmed);
+void *erofs_read_metadata(struct erofs_sb_info *sbi, erofs_nid_t nid,
+			  erofs_off_t *offset, int *lengthp);
 
 static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
 					  erofs_off_t *size)
diff --git a/lib/data.c b/lib/data.c
index a172bb5..3ec5330 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -372,3 +372,87 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 	}
 	return -EINVAL;
 }
+
+static void *erofs_read_meta(struct erofs_sb_info *sbi, erofs_nid_t nid,
+			     erofs_off_t *offset, int *lengthp)
+{
+	struct erofs_inode vi = { .sbi = sbi, .nid = nid };
+	__le16 __len;
+	int ret, len;
+	char *buffer;
+
+	ret = erofs_read_inode_from_disk(&vi);
+	if (ret)
+		return ERR_PTR(ret);
+
+	*offset = round_up(*offset, 4);
+	ret = erofs_pread(&vi, (void *)&__len, sizeof(__le16), *offset);
+	if (ret)
+		return ERR_PTR(ret);
+
+	len = le16_to_cpu(__len);
+	if (!len)
+		return ERR_PTR(-EFSCORRUPTED);
+
+	buffer = malloc(len);
+	if (!buffer)
+		return ERR_PTR(-ENOMEM);
+	*offset += sizeof(__le16);
+	*lengthp = len;
+
+	ret = erofs_pread(&vi, buffer, len, *offset);
+	if (ret) {
+		free(buffer);
+		return ERR_PTR(ret);
+	}
+	*offset += len;
+	return buffer;
+}
+
+static void *erofs_read_metainode(struct erofs_sb_info *sbi,
+				  erofs_off_t *offset, int *lengthp)
+{
+	int ret, len, i, cnt;
+	void *buffer;
+	u8 data[EROFS_MAX_BLOCK_SIZE];
+
+	*offset = round_up(*offset, 4);
+	ret = blk_read(sbi, 0, data, erofs_blknr(sbi, *offset), 1);
+	if (ret)
+		return ERR_PTR(ret);
+	len = le16_to_cpu(*(__le16 *)&data[erofs_blkoff(sbi, *offset)]);
+	if (!len)
+		return ERR_PTR(-EFSCORRUPTED);
+
+	buffer = malloc(len);
+	if (!buffer)
+		return ERR_PTR(-ENOMEM);
+	*offset += sizeof(__le16);
+	*lengthp = len;
+
+	for (i = 0; i < len; i += cnt) {
+		cnt = min_t(int, erofs_blksiz(sbi) - erofs_blkoff(sbi, *offset),
+			    len - i);
+		ret = blk_read(sbi, 0, data, erofs_blknr(sbi, *offset), 1);
+		if (ret) {
+			free(buffer);
+			return ERR_PTR(ret);
+		}
+		memcpy(buffer + i, data + erofs_blkoff(sbi, *offset), cnt);
+		*offset += cnt;
+	}
+	return buffer;
+}
+
+/*
+ * read variable-sized metadata, offset will be aligned by 4-byte
+ *
+ * @nid is 0 if metadata is in meta inode
+ */
+void *erofs_read_metadata(struct erofs_sb_info *sbi, erofs_nid_t nid,
+			  erofs_off_t *offset, int *lengthp)
+{
+	if (!nid)
+		return erofs_read_metainode(sbi, offset, lengthp);
+	return erofs_read_meta(sbi, nid, offset, lengthp);
+}
-- 
2.19.1.6.gb485710b

