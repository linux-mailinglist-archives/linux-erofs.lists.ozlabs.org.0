Return-Path: <linux-erofs+bounces-2804-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKwSD0ZyuWm8EgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2804-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 16:24:54 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9872ACF94
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 16:24:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZwkB4CjVz2yfP;
	Wed, 18 Mar 2026 02:24:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773761090;
	cv=none; b=kKPY1Fzf8K8+SSycC9qyZgDZTx/CBF9uHC9B0nRdL+KBRa80WKFIKcklAxk8/HsVyn6p45FkPDi8oxXCluH1kNY9tx/BeRQ34TCV3XxQrDrb8q54SXyI6bdUl/rTpKRurnOYYHAe8IL44Kuivfzi1ovk/1TLgzbzFz5ImiSQF93YBqlWEkF2Rz8JF+9AgMDBb0XtV+uhpZkcxV3qW6SxYrnHfJG4v84qYJHKPtGxHOQfqloZfCQIrunBgVUqiNTA4tmVWzbWld7SvyKwg1bsCT2I/Vn3r37SLgf4/yUtDJelvlWHytkF87A4vpyibLC3/PfMNwo60drRuLON+c3W+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773761090; c=relaxed/relaxed;
	bh=zK973YcGAPsQClcyZbHw6YemyR2f7H0nUyi0FbVd4iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJPYEX/SiU2wdK4Oh+gpOcjOvSC1NncsNaCtUbYW4g2APuFgPKxr6n2YAGC7MjFH9W0I4ggnJncJ02e8CKBsybRP2Zud2UjG4RHxp+QbuVXo9jaP27akhii1uu0zLVPLhC431HbFegh9in0N5mrneJwF5Wy7wNR7IaEairI+fCuo7zgOYeooUJJIksAJqgcVbsPUPcVDIAFerpnHltB8jY6tkKsxv0qObIUvOPk2UaNApQjoHFp1exdzRI9pMqlp/hzZ3qbmIWRKkK4snQClpW3ryz6Wuo5kb+GwKzxuCgrJWUVIV26ugIIgVGI1p5Aisg7SVbHxX0c+zEeghrJWAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=J0YjBJQS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=J0YjBJQS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZwk95Lk5z2xVT
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 02:24:48 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-35b918d0191so191598a91.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773761086; x=1774365886; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zK973YcGAPsQClcyZbHw6YemyR2f7H0nUyi0FbVd4iI=;
        b=J0YjBJQS19bKh0JJWiorHIUSts7mCjvdN8NEmE5wphqJroO65d1sWnxsxCZvjGPw0y
         TzpSkdZZiNvFT6c2tysLe6NIDe6rn1tHa33Ed7EnvC5TPHIB90LoQVRL5TcrHua1MxGZ
         Telr2xfUwLBWC0eM7l3DcTs8OHK3Nm56ckXTG+cF/L3V0R//WxNvbXZessmRTFxlDn0q
         2f7/Pd/GSCU5Kv5gjTsRvHSJl0RAvb97gDlTp7jtCn4kmdr1AHQe9tdGCCCWS/4iXC4I
         onhBXvIt9xicoGFAzey6x6H1RTWZFu/tZOwPPIyDWAA9roJptfrghKeEGkbkdxQjXXpU
         7BgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773761086; x=1774365886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zK973YcGAPsQClcyZbHw6YemyR2f7H0nUyi0FbVd4iI=;
        b=jrpWbhbK3q/wKcGvltXLkk7NEktpJ1CjDQ/WJRKQxGepnoSE7IVFBDXQBETX1WjOzZ
         3SJSi4H8JVpTBTD8wikf2u3O3GsnutQQ2J39MttJL6vx4XR03hD0iD3E74D5rYUhk+ty
         C+U9xL0oBOP/gYenkOmjqNUhton2AFf4lgnEHMB1qqC5YulfDcqsNkZpBm9ctpUpNL2a
         ZlzEFu49ul9+c/SlXDbsVTVPdF9npJYgaNWJd2qRE/m9swL7PoMy8d7arzFDBTiEIu+B
         tB6E1WERf2tm/n1lQ5OI3PrhEBGFqpdMpVhGcgA3s+tU5XpVEH36bobE4/XveJHCpmb+
         +DMw==
X-Gm-Message-State: AOJu0YylDJ1wyAJZKAQslcVckBxk47Uv2eRUaDNWtFOviJ2PqpWDb+Ei
	K0trisFuifBmRuCAQvaQim/nUkNlFoLOdL0FUU/nS1A3NV6xT4x9VSIRlwgMJWso
X-Gm-Gg: ATEYQzxt7iBNQfNIkt76Q6X7S+ZKZqNvQv+1NUpGYqZIvrEDHH0chTBhpKnkJYHpHw9
	lF/tND4N0qwz+0vQ3vKeXtvci9xgcQmIU52Zk78u1SZIu4S0Htlc773prvOKBBYXPeHk2zSKyJh
	blidliEnYG2fjTeC9mgIwq3io+PTidUG5i5U8QJGlAJWjWHXS4SIJNeNoMF61kSvVMyVndjoAyb
	Hl9jXM0y+mBUIpJWiqqCzTjueMPcvNFNKzsJC3ED1x7rs3MqGduzVIcAVWxTnoknWyY2nLoUFn2
	8a3Oa7Rk7bl5jVdJIuXRK+POQBXWtrA3FVlds8z/D62niILSMcIx2mUBSNK4Ghn3nFH6V90ON+j
	5wshIoTuLhAe093qJ3KUurpvORHFLzmC0ecpTFbldO/irMqK4I2hewbqMqd+mwNY7LWEjqYBtIs
	z2Ry6DHdZW3gb1wkkLQgj1uRDNSEHU7NR56weRPqYd1GRMyi/SYCfz8qLN9kc10XklmReXwNx0v
	/7s5FSzTj3AIk1xJ4dk68wjTGGMrMRtwl16OQ==
X-Received: by 2002:a17:903:90f:b0:2ae:63fd:6d6a with SMTP id d9443c01a7336-2aecaaf805dmr112552775ad.7.1773761086165;
        Tue, 17 Mar 2026 08:24:46 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06b74c672sm17614815ad.66.2026.03.17.08.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:24:45 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	yifan.yfzhao@linux.dev,
	linux-kernel@vger.kernel.org,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH v2] erofs: harden h_shared_count in erofs_init_inode_xattrs()
Date: Tue, 17 Mar 2026 15:24:39 +0000
Message-ID: <20260317152439.5738-1-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends in
	*      digit
	*      [singhutkal015(at)gmail.com]
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [singhutkal015(at)gmail.com]
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [117.203.246.41 listed in zen.spamhaus.org]
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:1033 listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2804-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,vger.kernel.org,gmail.com];
	NEURAL_HAM(-0.00)[-0.895];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 4E9872ACF94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`u8 h_shared_count` indicates the shared xattr count of an inode. It is
read from the on-disk xattr ibody header, which should be corrupted if
the size of the shared xattr array exceeds the space available in
`xattr_isize`.

It does not cause harmful consequence (e.g. crashes), since the image is
already considered corrupted, it indeed results in the silent processing
of garbage metadata.

Let's harden it to report -EFSCORRUPTED earlier.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 fs/erofs/xattr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index c411df5d9dfc..aaac37c6bb78 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -85,6 +85,14 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	}
 	vi->xattr_name_filter = le32_to_cpu(ih->h_name_filter);
 	vi->xattr_shared_count = ih->h_shared_count;
+	if ((u32)vi->xattr_shared_count * sizeof(__le32) >
+	    vi->xattr_isize - sizeof(struct erofs_xattr_ibody_header)) {
+		erofs_err(sb, "invalid h_shared_count %u in nid %llu",
+			  vi->xattr_shared_count, vi->nid);
+		erofs_put_metabuf(&buf);
+		ret = -EFSCORRUPTED;
+		goto out_unlock;
+	}
 	vi->xattr_shared_xattrs = kmalloc_objs(uint, vi->xattr_shared_count);
 	if (!vi->xattr_shared_xattrs) {
 		erofs_put_metabuf(&buf);
-- 
2.43.0


