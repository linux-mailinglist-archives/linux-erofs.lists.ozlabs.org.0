Return-Path: <linux-erofs+bounces-3464-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K5OJ/UuDWq8uAUAu9opvQ
	(envelope-from <linux-erofs+bounces-3464-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 20 May 2026 05:48:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7D25875BE
	for <lists+linux-erofs@lfdr.de>; Wed, 20 May 2026 05:48:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKyDc6TKcz2xy3;
	Wed, 20 May 2026 13:48:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.149.242.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779248880;
	cv=none; b=gdhTFn2xj4qMjjQ8sNW2uO+ncKtO0TMd4NzZqda4YCi9mW2qs7D251esJGHGI14/aMuMpGvEg+x5W7le6pyNKZL3tbuKNkIk68tZ7NZsXIqmoVWglenzMcB6VUgai3B62kHxwbVRbXJdAOI3bVB36J4PDZwfwjxP8D7WNW5Zs3E4Ddb/d1jLSUYudn3najiDW7YQ49insFkrkWRzeO2vSFB5ZAPzOxZzgo6J9iMesroYGa0riO+izwrxur85QJtOYCfBzBQ8b9M2zW3iDU5ASQ3PsXzC3MV9BdKk8dC/OwWCSDyYAb3V+cG+9/pIS9dk28lK5KDsoQGuzW1b9424UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779248880; c=relaxed/relaxed;
	bh=mspc1aUu6CgWqs54mQCmP4k4Liy2LtNRdjCy1C379GM=;
	h=Date:Content-Type:To:Subject:Message-Id:Mime-Version:From:Cc; b=hMfZg4RWE1cllbZsZp5gtr3vsfpn9EB5qK/JFfrcI6bMSOdZdGGwc+FU+Hmxp/2HNfymSBlctQIhwdFMKqLGEVHMpmnFYc87oJ6Gl86+fPKRiaw1tyqLuUtucerqoR7SzDQkt0Yassd2CETsD8zFXixT1TyPupBcawin4TazS8dZF5evn6dePBXFsg38wYf8tkOi8pk6vXfUOSlNMc5VDwgwC5eeH8d1wTSzzVuSmheSAhRqFwARJmeiJY33Gu1lCAkDXyc7HzV/ZhnDsrzs2Zt9zf+JLex/SUgxTjSe2lk1qt98wvapfyEaJ2dAxHNHgdOVWe0U/NTUXfOsb9X9aQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=qcURkZT6; dkim-atps=neutral; spf=pass (client-ip=103.149.242.131; helo=lf-1-131.ptr.blmpb.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=qcURkZT6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=103.149.242.131; helo=lf-1-131.ptr.blmpb.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 152 seconds by postgrey-1.37 at boromir; Wed, 20 May 2026 13:47:57 AEST
Received: from lf-1-131.ptr.blmpb.com (lf-1-131.ptr.blmpb.com [103.149.242.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKyDY2GJYz2xrC
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 May 2026 13:47:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779248741; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=mspc1aUu6CgWqs54mQCmP4k4Liy2LtNRdjCy1C379GM=;
 b=qcURkZT6qvTt91eJmHS2T0Jevgc8irO+e3CUo058XIwhEjVklqdNTZo9WZ6cC2U6N79c81
 ti9o4/RPYi3qGalxVnBzsD4BAS509f3kGCGbrY1tq6Jb6jwIZT2Q5Ai+OixjnIucmKwAPD
 Lc2TwWYhpxNH8hJF7/3oh8G1+Ox/XZ8YFGRS13aFNfbbXGOG+gyX8ki+8IAFXaYsuBEGdn
 U+r1aZ3vqNCt1iQQXh+H+eCw5k9YvqPiqHNui2/qX+2kxxAp38Y2TYDHLRDueiXrjp1UUS
 ZPRWRCc7p6aR713VWnVextLq1Ck6muausq9OQqWGoMfwim4JViitWRHZOQxtBg==
Date: Wed, 20 May 2026 11:45:32 +0800
X-Original-From: Jia Zhu <zhujia.zj@bytedance.com>
X-Lms-Return-Path: <lba+26a0d2e63+5d30e9+lists.ozlabs.org+zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: "Gao Xiang" <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>
Subject: [PATCH] erofs: reuse xattr metabuf across init and iterators
Message-Id: <20260520034532.42557-1-zhujia.zj@bytedance.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 7bit
From: "Jia Zhu" <zhujia.zj@bytedance.com>
Cc: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, 
	"Yue Hu" <zbestahu@gmail.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>, 
	"Sandeep Dhavale" <dhavale@google.com>, 
	"Hongbo Li" <lihongbo22@huawei.com>, "Chunhai Guo" <guochunhai@vivo.com>, 
	"Gao Xiang" <hsiangkao@linux.alibaba.com>, 
	"Jia Zhu" <zhujia.zj@bytedance.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:hsiangkao@linux.alibaba.com,m:zhujia.zj@bytedance.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,bytedance.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3464-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[zhujia.zj@bytedance.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[zhujia.zj@bytedance.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:mid,bytedance.com:dkim,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: EC7D25875BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_init_inode_xattrs() used a local metabuf to read the inline xattr
header and shared xattr ids.

getxattr and listxattr then initialized a separate iterator metabuf for
the following inline/shared xattr walk.

Pass the iterator metabuf into erofs_init_inode_xattrs() so initialization
and the inline iterator path share the same metabuf lifetime. The getxattr
and listxattr callers now use a single cleanup exit for their iterator
metabuf.

Drop and reinitialize the metabuf before switching from inline xattrs to
the shared xattr metadata area, since that path may use a different
mapping.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/xattr.c | 76 ++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index df7ea019526d7..f7eb7431b0b81 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -27,9 +27,8 @@ struct erofs_xattr_iter {
 
 static const char *erofs_xattr_prefix(unsigned int idx, struct dentry *dentry);
 
-static int erofs_init_inode_xattrs(struct inode *inode)
+static int erofs_init_inode_xattrs(struct erofs_buf *buf, struct inode *inode)
 {
-	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct super_block *sb = inode->i_sb;
 	const struct erofs_xattr_ibody_header *ih;
@@ -78,7 +77,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	}
 
 	pos = erofs_iloc(inode) + vi->inode_isize;
-	ih = erofs_read_metabuf(&buf, sb, pos, erofs_inode_in_metabox(inode));
+	ih = erofs_read_metabuf(buf, sb, pos, erofs_inode_in_metabox(inode));
 	if (IS_ERR(ih)) {
 		ret = PTR_ERR(ih);
 		goto out_unlock;
@@ -101,7 +100,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	/* skip the ibody header and read the shared xattr array */
 	pos += sizeof(struct erofs_xattr_ibody_header);
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		xattr_id = erofs_bread(&buf, pos + i * sizeof(__le32), true);
+		xattr_id = erofs_bread(buf, pos + i * sizeof(__le32), true);
 		if (IS_ERR(xattr_id)) {
 			kfree(vi->xattr_shared_xattrs);
 			vi->xattr_shared_xattrs = NULL;
@@ -115,7 +114,6 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	smp_mb();
 	set_bit(EROFS_I_EA_INITED_BIT, &vi->flags);
 out_unlock:
-	erofs_put_metabuf(&buf);
 	clear_and_wake_up_bit(EROFS_I_BL_XATTR_BIT, &vi->flags);
 	return ret;
 }
@@ -337,40 +335,48 @@ static int erofs_getxattr(struct inode *inode, int index, const char *name,
 {
 	int ret;
 	unsigned int hashbit;
-	struct erofs_xattr_iter it;
+	struct erofs_xattr_iter it = {
+		.sb = inode->i_sb,
+		.buf = __EROFS_BUF_INITIALIZER,
+		.buffer = buffer,
+		.buffer_size = buffer_size,
+		.buffer_ofs = 0,
+	};
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
 	if (!name)
 		return -EINVAL;
 
-	ret = erofs_init_inode_xattrs(inode);
+	ret = erofs_init_inode_xattrs(&it.buf, inode);
 	if (ret)
-		return ret;
+		goto out;
 
 	/* reserved flag is non-zero if there's any change of on-disk format */
 	if (erofs_sb_has_xattr_filter(sbi) && !sbi->xattr_filter_reserved) {
 		hashbit = xxh32(name, strlen(name),
 				EROFS_XATTR_FILTER_SEED + index);
 		hashbit &= EROFS_XATTR_FILTER_BITS - 1;
-		if (vi->xattr_name_filter & (1U << hashbit))
-			return -ENODATA;
+		if (vi->xattr_name_filter & (1U << hashbit)) {
+			ret = -ENODATA;
+			goto out;
+		}
 	}
 
 	it.index = index;
 	it.name = QSTR(name);
-	if (it.name.len > EROFS_NAME_LEN)
-		return -ERANGE;
-
-	it.sb = inode->i_sb;
-	it.buf = __EROFS_BUF_INITIALIZER;
-	it.buffer = buffer;
-	it.buffer_size = buffer_size;
-	it.buffer_ofs = 0;
+	if (it.name.len > EROFS_NAME_LEN) {
+		ret = -ERANGE;
+		goto out;
+	}
 
 	ret = erofs_xattr_iter_inline(&it, inode, true);
-	if (ret == -ENODATA)
+	if (ret == -ENODATA) {
+		erofs_put_metabuf(&it.buf);
+		it.buf = __EROFS_BUF_INITIALIZER;
 		ret = erofs_xattr_iter_shared(&it, inode, true);
+	}
+out:
 	erofs_put_metabuf(&it.buf);
 	return ret ? ret : it.buffer_ofs;
 }
@@ -378,27 +384,33 @@ static int erofs_getxattr(struct inode *inode, int index, const char *name,
 ssize_t erofs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 {
 	int ret;
-	struct erofs_xattr_iter it;
+	struct erofs_xattr_iter it = {
+		.sb = dentry->d_sb,
+		.buf = __EROFS_BUF_INITIALIZER,
+		.dentry = dentry,
+		.buffer = buffer,
+		.buffer_size = buffer_size,
+		.buffer_ofs = 0,
+	};
 	struct inode *inode = d_inode(dentry);
 
-	ret = erofs_init_inode_xattrs(inode);
-	if (ret == -ENODATA)
-		return 0;
+	ret = erofs_init_inode_xattrs(&it.buf, inode);
+	if (ret == -ENODATA) {
+		ret = 0;
+		goto out;
+	}
 	if (ret)
-		return ret;
-
-	it.sb = dentry->d_sb;
-	it.buf = __EROFS_BUF_INITIALIZER;
-	it.dentry = dentry;
-	it.buffer = buffer;
-	it.buffer_size = buffer_size;
-	it.buffer_ofs = 0;
+		goto out;
 
 	ret = erofs_xattr_iter_inline(&it, inode, false);
-	if (!ret || ret == -ENODATA)
+	if (!ret || ret == -ENODATA) {
+		erofs_put_metabuf(&it.buf);
+		it.buf = __EROFS_BUF_INITIALIZER;
 		ret = erofs_xattr_iter_shared(&it, inode, false);
+	}
 	if (ret == -ENODATA)
 		ret = 0;
+out:
 	erofs_put_metabuf(&it.buf);
 	return ret ? ret : it.buffer_ofs;
 }
-- 
2.39.5 (Apple Git-154)

