Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7356D5A30
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 10:02:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrKxd4PPXz3c9r
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 18:02:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrKxP4PSGz3cFd
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Apr 2023 18:02:32 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VfL3LM5_1680595348;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfL3LM5_1680595348)
          by smtp.aliyun-inc.com;
          Tue, 04 Apr 2023 16:02:28 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH 4/6] erofs-utils: introduce init/cleanup routine for extra xattr name prefix
Date: Tue,  4 Apr 2023 16:02:21 +0800
Message-Id: <20230404080224.77577-5-jefflexu@linux.alibaba.com>
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

Introduce helpers for registering and cleaning up extra xattr name
prefix.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/xattr.h |  3 +++
 lib/xattr.c           | 58 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 9efadc5..1085908 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -70,6 +70,9 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
 int erofs_build_shared_xattrs_from_path(const char *path);
 
+int erofs_insert_ea_type(const char *prefix);
+void erofs_cleanup_ea_type(void);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/xattr.c b/lib/xattr.c
index a292f2c..ec40aad 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -61,6 +61,14 @@ static struct xattr_prefix {
 	}
 };
 
+struct ea_type_node {
+	struct list_head list;
+	struct xattr_prefix type;
+	u8 index;
+};
+static LIST_HEAD(ea_types);
+static unsigned int ea_types_count;
+
 static unsigned int BKDRHash(char *str, unsigned int len)
 {
 	const unsigned int seed = 131313;
@@ -1222,3 +1230,53 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 		return ret;
 	return shared_listxattr(vi, &it);
 }
+
+int erofs_insert_ea_type(const char *prefix)
+{
+	struct ea_type_node *tnode;
+	struct xattr_prefix *p;
+	bool matched = false;
+	char *s;
+
+	if (ea_types_count == EROFS_XATTR_EA_FLAG || strlen(prefix) > UINT8_MAX)
+		return -EOVERFLOW;
+
+	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
+		if (!strncmp(p->prefix, prefix, p->prefix_len)) {
+			matched = true;
+			break;
+		}
+	}
+	if (!matched)
+		return -ENODATA;
+
+	s = strdup(prefix);
+	if (!s)
+		return -ENOMEM;
+
+	tnode = malloc(sizeof(*tnode));
+	if (!tnode) {
+		free(s);
+		return -ENOMEM;
+	}
+
+	tnode->type.prefix = s;
+	tnode->type.prefix_len = strlen(prefix);
+
+	tnode->index = EROFS_XATTR_EA_FLAG | ea_types_count;
+	ea_types_count++;
+	init_list_head(&tnode->list);
+	list_add_tail(&tnode->list, &ea_types);
+	return 0;
+}
+
+void erofs_cleanup_ea_type(void)
+{
+	struct ea_type_node *tnode, *n;
+
+	list_for_each_entry_safe(tnode, n, &ea_types, list) {
+		list_del(&tnode->list);
+		free(tnode->type.prefix);
+		free(tnode);
+	}
+}
-- 
2.19.1.6.gb485710b

