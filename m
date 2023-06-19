Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96E8735526
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jun 2023 13:02:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ql6KN5LL2z30Ps
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jun 2023 21:02:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ql6KK4dSNz300p
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jun 2023 21:01:56 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VlV8FlL_1687172510;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VlV8FlL_1687172510)
          by smtp.aliyun-inc.com;
          Mon, 19 Jun 2023 19:01:51 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: add documentation for long xattr name prefixes feature
Date: Mon, 19 Jun 2023 19:01:50 +0800
Message-Id: <20230619110150.107958-1-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add documentation for the long xattr name prefixes feature, which has
landed upstream since v6.4.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 Documentation/filesystems/erofs.rst | 47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 4654ee57c1d5..d3408d25165e 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -328,3 +328,50 @@ but it's easy to know the size of such pcluster is 1 lcluster as well.
 
 Since Linux v6.1, each pcluster can be used for multiple variable-sized extents,
 therefore it can be used for compressed data deduplication.
+
+Long xattr name prefixes
+------------------------
+In use cases together with overlayfs like Composefs model, there are xattrs with
+diverse xattr values but only a few common xattr names (trusted.overlay.redirect,
+trusted.overlay.digest, and maybe more in the future).  The existing predefined
+prefixes mechanism, e.g. {.e_name_index = EROFS_XATTR_INDEX_TRUSTED,
+.e_name = "overlay.redirect"} for "trusted.overlay.redirect", works inefficiently
+in both image size and runtime performance in such scenarios.
+
+The long xattr name prefixes feature is introduced (since Linux v6.4) to address
+this issue.  The general idea is that, apart from the existing predefined
+prefixes, the xattr entry could also refer to user specified long xattr name
+prefixes, e.g. "trusted.overlay." in above described use cases.
+
+When referring to a long xattr name prefix, the highest bit (bit 7) of
+erofs_xattr_entry.e_name_index is set, while the lower bits (bit 0-6) as a whole
+represents the index of the referred long name prefix among all long xattr name
+prefixes.  Besides only the trailing part of the xattr name apart from the long
+xattr name prefix is stored in erofs_xattr_entry.e_name, which could be empty if
+the xattr name matches exactly as the long xattr name prefix.
+
+All long xattr prefixes are stored one by one in the packed inode as long as the
+packed inode exists, or meta inode otherwise.  The xattr_prefix_count (of
+on-disk superblock) represents the total number of the long xattr name prefixes,
+while (xattr_prefix_start * 4) indicates the start offset of long name prefixes
+in the packed/meta inode.  The long xattr name prefixes feature is not used when
+xattr_prefix_count is 0.
+
+Each long xattr name prefix (in packed/meta inode) is stored in the format:
+ALIGN({__le16 len, data}, 4), where len represents the total size of following
+data.  The data part, describing one long xattr name prefixes record, is
+represented by 'struct erofs_xattr_long_prefix', where base_index represents the
+index of the referred predefined short xattr name prefix, e.g.
+EROFS_XATTR_INDEX_TRUSTED for "trusted.overlay." long name prefix, while the
+infix string represents the string after stripping the short prefix, e.g.
+"overlay." for the above example.
+
+::
+
+         |-> aligned with 4 bytes               |-> aligned with 4 bytes
+     _________________________________________________________________________________
+    | .. | len | base_index | infix string | .. | len | base_index | infix string | ..
+    |____|_____|____________|______________|____|_____|____________|______________|___
+         ^     |<--  xattr_long_prefix  -->|          |<--  xattr_long_prefix  -->|
+	 .
+    + (xattr_prefix_start * 4) offset
-- 
2.19.1.6.gb485710b

