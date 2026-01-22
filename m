Return-Path: <linux-erofs+bounces-2156-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EyjLgc2cmmadwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2156-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 15:36:55 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C86B568006
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 15:36:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxkCm1445z2yFm;
	Fri, 23 Jan 2026 01:36:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769092612;
	cv=none; b=EiDNHPGapQ7CCLkHeufbsc1pa7VoH6K9jPPSnIkKxnYcpZ51JQWeNbcC4a+wXJpN1OHbyDKcoMfX71ZZgQp6CfkzxXT02SSeE3CWiTT2vNdnnPHj6GZ9Io2tvZph4ABVw/hGejim/ZlmDFrHYDhB3N4ECn14esHxbayYM4g9kY825+lOq2I85sPQoPwtfgxWuL22JNrdfVOiKTmlXkFUcaBcUVkY+XQ2pbxG5BGZaIGyED5aTVUiNx0VhI0P4+4tRMs+gi4ssD2MWK9w5j8tYTRsoBVO4VECI09P780dTbKhIDGYKqTV5vpzrVHfhAiHRdf2vTXgkoMhThyCUz1YSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769092612; c=relaxed/relaxed;
	bh=z8/Ug4crrEJ5u3wYxXOEMJIqkV8lK0cW12U+RkRRi0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XHvFs0JJN0RhQFxwUp28lPsqHXAejajTKideoFuThGER/2P5+lM2nCT6aSPt4g4mg+LE8PI5a8qDDFc0s4idCzH+70w/FlMjwAoYXzTfKDvk3DKdazqlh2M9g+BTmVT8LvAvIc7nt8Vw90ggS+t86V7oeV1PohGAGL64jf61QCj1Lisb3CbC4QnCZqwPYvHrHuVQlllZDxvyNQQ8i4EbOSVGSFxXBxrGV5fVyF2nkEmE77rsnU3w6Drj3ASUZktrGPztkVv6Hj48gd0AvS9qkcWWTqPejm6v7mOCZiKMezU9oV3pR0m0iiIQPAxBEc2u3HQ6x0V15rVV+6m/wSAUTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=R024nWLO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=R024nWLO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxkCj5677z2xl0
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 01:36:47 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769092601; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=z8/Ug4crrEJ5u3wYxXOEMJIqkV8lK0cW12U+RkRRi0w=;
	b=R024nWLOfza6CPFbi8UEcUDZNwpcrhT0nqMo5TkhmieeJOcEvQ+CMZDe7RvHQTEmks4zKZw+1R57y3T7Z6gmSU87LHGH41mmoKN/qo/VSkeFGT5I9yBDbG/taNi16H40DO37+fwMihxErzAob3FWyjYvW6gqQFaKL+yqy3vAdSI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wxcc2mv_1769092594 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 22:36:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: tidy up erofs_init_inode_xattrs()
Date: Thu, 22 Jan 2026 22:36:33 +0800
Message-ID: <20260122143633.466466-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2156-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email]
X-Rspamd-Queue-Id: C86B568006
X-Rspamd-Action: no action

Mainly get rid of the use of `struct erofs_xattr_iter`, as it is
no longer needed now that meta buffers are used.

This also simplifies the code and uses an early return when there
are no xattrs.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/xattr.c | 62 +++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index dad076ce0108..512b998bdfff 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -29,13 +29,18 @@ static const char *erofs_xattr_prefix(unsigned int idx, struct dentry *dentry);
 
 static int erofs_init_inode_xattrs(struct inode *inode)
 {
-	struct erofs_inode *const vi = EROFS_I(inode);
-	struct erofs_xattr_iter it;
-	unsigned int i;
-	struct erofs_xattr_ibody_header *ih;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	struct erofs_inode *vi = EROFS_I(inode);
 	struct super_block *sb = inode->i_sb;
+	const struct erofs_xattr_ibody_header *ih;
+	__le32 *xattr_id;
+	erofs_off_t pos;
+	unsigned int i;
 	int ret = 0;
 
+	if (!vi->xattr_isize)
+		return -ENODATA;
+
 	/* the most case is that xattrs of this inode are initialized. */
 	if (test_bit(EROFS_I_EA_INITED_BIT, &vi->flags)) {
 		/*
@@ -45,7 +50,6 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 		smp_mb();
 		return 0;
 	}
-
 	if (wait_on_bit_lock(&vi->flags, EROFS_I_BL_XATTR_BIT, TASK_KILLABLE))
 		return -ERESTARTSYS;
 
@@ -62,66 +66,50 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	 *    undefined right now (maybe use later with some new sb feature).
 	 */
 	if (vi->xattr_isize == sizeof(struct erofs_xattr_ibody_header)) {
-		erofs_err(sb,
-			  "xattr_isize %d of nid %llu is not supported yet",
+		erofs_err(sb, "xattr_isize %d of nid %llu is not supported yet",
 			  vi->xattr_isize, vi->nid);
 		ret = -EOPNOTSUPP;
 		goto out_unlock;
 	} else if (vi->xattr_isize < sizeof(struct erofs_xattr_ibody_header)) {
-		if (vi->xattr_isize) {
-			erofs_err(sb, "bogus xattr ibody @ nid %llu", vi->nid);
-			DBG_BUGON(1);
-			ret = -EFSCORRUPTED;
-			goto out_unlock;	/* xattr ondisk layout error */
-		}
-		ret = -ENODATA;
+		erofs_err(sb, "bogus xattr ibody @ nid %llu", vi->nid);
+		DBG_BUGON(1);
+		ret = -EFSCORRUPTED;
 		goto out_unlock;
 	}
 
-	it.buf = __EROFS_BUF_INITIALIZER;
-	ret = erofs_init_metabuf(&it.buf, sb, erofs_inode_in_metabox(inode));
-	if (ret)
-		goto out_unlock;
-	it.pos = erofs_iloc(inode) + vi->inode_isize;
-
-	/* read in shared xattr array (non-atomic, see kmalloc below) */
-	it.kaddr = erofs_bread(&it.buf, it.pos, true);
-	if (IS_ERR(it.kaddr)) {
-		ret = PTR_ERR(it.kaddr);
+	pos = erofs_iloc(inode) + vi->inode_isize;
+	ih = erofs_read_metabuf(&buf, sb, pos, erofs_inode_in_metabox(inode));
+	if (IS_ERR(ih)) {
+		ret = PTR_ERR(ih);
 		goto out_unlock;
 	}
-
-	ih = it.kaddr;
 	vi->xattr_name_filter = le32_to_cpu(ih->h_name_filter);
 	vi->xattr_shared_count = ih->h_shared_count;
 	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
 						sizeof(uint), GFP_KERNEL);
 	if (!vi->xattr_shared_xattrs) {
-		erofs_put_metabuf(&it.buf);
+		erofs_put_metabuf(&buf);
 		ret = -ENOMEM;
 		goto out_unlock;
 	}
 
-	/* let's skip ibody header */
-	it.pos += sizeof(struct erofs_xattr_ibody_header);
-
+	/* skip the ibody header and read the shared xattr array */
+	pos += sizeof(struct erofs_xattr_ibody_header);
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		it.kaddr = erofs_bread(&it.buf, it.pos, true);
-		if (IS_ERR(it.kaddr)) {
+		xattr_id = erofs_bread(&buf, pos + i * sizeof(__le32), true);
+		if (IS_ERR(xattr_id)) {
 			kfree(vi->xattr_shared_xattrs);
 			vi->xattr_shared_xattrs = NULL;
-			ret = PTR_ERR(it.kaddr);
+			ret = PTR_ERR(xattr_id);
 			goto out_unlock;
 		}
-		vi->xattr_shared_xattrs[i] = le32_to_cpu(*(__le32 *)it.kaddr);
-		it.pos += sizeof(__le32);
+		vi->xattr_shared_xattrs[i] = le32_to_cpu(*xattr_id);
 	}
-	erofs_put_metabuf(&it.buf);
+	erofs_put_metabuf(&buf);
 
 	/* paired with smp_mb() at the beginning of the function. */
 	smp_mb();
 	set_bit(EROFS_I_EA_INITED_BIT, &vi->flags);
-
 out_unlock:
 	clear_and_wake_up_bit(EROFS_I_BL_XATTR_BIT, &vi->flags);
 	return ret;
-- 
2.43.5


