Return-Path: <linux-erofs+bounces-3468-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4gDGDi89DWqquwUAu9opvQ
	(envelope-from <linux-erofs+bounces-3468-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 20 May 2026 06:48:47 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA61587A09
	for <lists+linux-erofs@lfdr.de>; Wed, 20 May 2026 06:48:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKzZd2xhjz2xy3;
	Wed, 20 May 2026 14:48:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.149.242.129
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779252521;
	cv=none; b=Xrr5ttom7b9XeKOH6WsF6NhRo2IS138pM3xRK0grmZ2C/qw9hVWTcMGxWDDoHWAW1CsprRD5SvhEriiVIiPVvy9qdBUKI9Awv91nodhXlvzDe7gbu3jgUfSJsyDqKjx0LHxLr9Y0NwKbMmg4WK9HkvRIcpob7czWZAhnTJpYvQNOP1jS/KwcbrrEF9LYbKfe96dLivHhKFSp8lxYRs0osflBJTpX+jAj5H/WKg1yDKwoGIwyjjJkuYd+xKlSQ5R97idSCnLhwO9ZuTTWLtIELDhQbGf2U7scgHTSkF4vlcMlumn2K4nD1E33Ue9kMosYbyJIefALh7CKEb6tWKSLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779252521; c=relaxed/relaxed;
	bh=NNXYVdNOk08NyvAM1XrvfKwXcAVxz+xeGBQj1CZCknQ=;
	h=Cc:From:Mime-Version:References:Content-Type:Message-Id:Date:
	 In-Reply-To:To:Subject; b=gFtPVbajo/MDqEyEalHmNbqwn0XEKJcmFWG1qvTdWlOwIXDNGZBKB+pqbxSOk+xA194gKlkz1DpDgHgCe1HYdEYbCiOTsoxS4HDCcmEY0hwmbHIXv2z7JqJXB6yBPTHs4t7j/4PrIvFJOl27Wd5Nu6SiVp7Fpuiz4OUvqKDBRkFjf/BwKVR27k1xeMCZ1JS9wFjmAzoM9kugj+8HlnO1tpig0Hxqpycc7IGv1BNVZN6l5e6Px20GL0ySnXpsort+A18+whLnhKEcEoIOBRy/oXshzG627GIaNTlPqd6IE9e/5vsXdjtHBZJgZNWkepU4UODRzRwzngptm22QJs/T0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=pJmlhcHE; dkim-atps=neutral; spf=pass (client-ip=103.149.242.129; helo=lf-1-129.ptr.blmpb.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=pJmlhcHE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=103.149.242.129; helo=lf-1-129.ptr.blmpb.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
Received: from lf-1-129.ptr.blmpb.com (lf-1-129.ptr.blmpb.com [103.149.242.129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKzZY1dl0z2x9N
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 May 2026 14:48:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779252377; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=NNXYVdNOk08NyvAM1XrvfKwXcAVxz+xeGBQj1CZCknQ=;
 b=pJmlhcHEJzwV4USceD37bJ6zJRPX4z7a+A7hiDY9ZEUKH2vVz3BgpBf5p9FHyMzSB9NikD
 EjEMEB8dwbnD3DxT+Ky7MxKjPuhTCLJAhK3ysN6chvfNGggSqU5f00IYflx6JhKLuqrNXB
 UZxmIABX6ym6M3gXusga1olVHXI/TJ0lXdLwQoW8wVGN9Bq5Iea0nSESgZTDZxYFI/CJiy
 z52HhhTY6ZwwHL+tUq4XPwWhYtefJI+b34af2+5f2sR/3S/h9eCIaTUzQyze2suGkS3wpF
 5AvVUQIptwe2lyjc6POsDcePYxy8lHS8KBDFmbq95NnmoVEcoDnJVp58Jav8DA==
Cc: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, 
	"Yue Hu" <zbestahu@gmail.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>, 
	"Sandeep Dhavale" <dhavale@google.com>, 
	"Hongbo Li" <lihongbo22@huawei.com>, "Chunhai Guo" <guochunhai@vivo.com>, 
	"Amir Goldstein" <amir73il@gmail.com>, 
	"Gao Xiang" <hsiangkao@linux.alibaba.com>, 
	"Jia Zhu" <zhujia.zj@bytedance.com>
From: "Jia Zhu" <zhujia.zj@bytedance.com>
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
References: <20260520034252.40163-1-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20260520044607.50992-1-zhujia.zj@bytedance.com>
Date: Wed, 20 May 2026 12:46:07 +0800
X-Lms-Return-Path: <lba+26a0d3c97+182f2e+lists.ozlabs.org+zhujia.zj@bytedance.com>
In-Reply-To: <20260520034252.40163-1-zhujia.zj@bytedance.com>
X-Original-From: Jia Zhu <zhujia.zj@bytedance.com>
To: "Gao Xiang" <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>
Subject: [PATCH v2] erofs: fix metabuf leak in inode xattr initialization
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,bytedance.com];
	TAGGED_FROM(0.00)[bounces-3468-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[zhujia.zj@bytedance.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:mid,bytedance.com:dkim,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 4EA61587A09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit bb88e8da0025 ("erofs: use meta buffers for xattr operations")
converted xattr operations to use on-stack erofs_buf instances.
erofs_init_inode_xattrs() uses such a metabuf while reading the inline
xattr header and shared xattr id array.

Some error paths after erofs_read_metabuf() leave through out_unlock
without dropping the metabuf, so the folio reference can leak.

Consolidate the cleanup at out_unlock. erofs_put_metabuf() is a
no-op if no folio has been acquired, and this keeps all paths after
taking EROFS_I_BL_XATTR_BIT covered by a single cleanup site.

Fixes: bb88e8da0025 ("erofs: use meta buffers for xattr operations")

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/xattr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 41e311019a251..df7ea019526d7 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -89,13 +89,11 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	    vi->xattr_isize - sizeof(struct erofs_xattr_ibody_header)) {
 		erofs_err(sb, "invalid h_shared_count %u @ nid %llu",
 			  vi->xattr_shared_count, vi->nid);
-		erofs_put_metabuf(&buf);
 		ret = -EFSCORRUPTED;
 		goto out_unlock;
 	}
 	vi->xattr_shared_xattrs = kmalloc_objs(uint, vi->xattr_shared_count);
 	if (!vi->xattr_shared_xattrs) {
-		erofs_put_metabuf(&buf);
 		ret = -ENOMEM;
 		goto out_unlock;
 	}
@@ -112,12 +110,12 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 		}
 		vi->xattr_shared_xattrs[i] = le32_to_cpu(*xattr_id);
 	}
-	erofs_put_metabuf(&buf);
 
 	/* paired with smp_mb() at the beginning of the function. */
 	smp_mb();
 	set_bit(EROFS_I_EA_INITED_BIT, &vi->flags);
 out_unlock:
+	erofs_put_metabuf(&buf);
 	clear_and_wake_up_bit(EROFS_I_BL_XATTR_BIT, &vi->flags);
 	return ret;
 }
-- 
2.39.5 (Apple Git-154)

