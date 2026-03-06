Return-Path: <linux-erofs+bounces-2527-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /356Icp/qmnKSgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2527-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Mar 2026 08:18:34 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF5E21C565
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Mar 2026 08:18:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRyS65r0Qz3bnJ;
	Fri, 06 Mar 2026 18:18:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772781510;
	cv=none; b=M8ufIENnWoZMtur8VSqSouaoDoYHagzhtL/hZPaPEf78CTFz8G90b/FruZIwGIxr0YLOq9Ie9Ip5wyqf3bHvkHVtuDCHWyz03U4FpOpzhcLi2xfbCimKPp7vbIZAYUIxe3FCagHEDTKMuLiVj+fuuWjHNPiRZRnjM4P3+fNmtvUvIOEHcqRpnrLFMVGRtuQgnsEixMsoHYeTu6mk28ybwB/dOnjkj6eOGUZZ9kieDp1j6CZHjiG8nUZNiWK20f5ycHQZTUAjE2TrYcnj/klZ1U+bbrSTWys5lP6qc6STQzKO0mZ7vRsFm9EZljgBGkNMg+udIffBBv/pZEqBVGOFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772781510; c=relaxed/relaxed;
	bh=tsK/zfVW8xxyTfciajHUyCL5dozAcoedsYyOmyrUqMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmlNUrrDV+CnVcrxyMYUn7mK13jJgvwQNcUh0BQCmWD7+O6f4yT0kBN6DfV9pov/ZCyNKbTAo0bwhvOyGHoHYX+5T0ZnF1ffLEGIkyh4j6+vrSO1ELrBSk/4kg1I+VV9P/XrJWdGJGPQHXQq0QyQ7YtTzRIfYEVNdbsMS2T2QA2O/XV18W4fxRYwBKSsmUoNNaKXKv9Ims0O8brF27Plh7j2UM41MFGTG8zc/Q258415r5Zy6Jk1LO7mWGqrolbTFGjcN5rlNGoWLbLIB5n9+3FQq31JbLMuV3uX3FQr5nX6KJ9uycAs1dWLO0/ngi8GLItamy/2bevtKtKlFyck3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i7XHYdIl; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i7XHYdIl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRyRn23K4z30T9
	for <linux-erofs@lists.ozlabs.org>; Fri, 06 Mar 2026 18:18:10 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772781483; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tsK/zfVW8xxyTfciajHUyCL5dozAcoedsYyOmyrUqMM=;
	b=i7XHYdIlALa3Fk5euduMr3LHCuloeESej2MeqvwUpamMcmLhE8r44pBkPM8/8k0jm6BRoooeUhuvMD4ap1pi30Xf+OAn52UDOdHIDaUiydS6SvO5a+BnQXBVAlBbzQcMCtMUwb4t8pvDrijSR+IGuIqeFo2XdGlflDQhb7Ih7TM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-MTKEI_1772781478 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Mar 2026 15:18:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Kern Walster <kern.walster@gmail.com>,
	Derek McGowan <derek@mcg.dev>
Subject: [PATCH] erofs-utils: tar: avoid linux-like hard-coded makedev()
Date: Fri,  6 Mar 2026 15:17:57 +0800
Message-ID: <20260306071757.4000825-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Queue-Id: 6BF5E21C565
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2527-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[linux.alibaba.com,gmail.com,mcg.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,alibaba.com:email,eh.link:url,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

This code needs a way to construct a valid st_rdev (dev_t) from major
and minor device numbers, so that erofs_new_encode_dev() can later
convert the dev_t into the EROFS on-disk rdev format.

But it never uses makedev() to generate dev_t; instead,
erofs_new_encode_dev() uses major()/minor(), so the usage is unpaired
and the original one works only on the Linux platform and non-portable.

Reported-by: Kern Walster <kern.walster@gmail.com>
Closes: https://github.com/erofs/go-erofs/pull/9#issuecomment-4008973934
Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Cc: Derek McGowan <derek@mcg.dev>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/tar.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/tar.c b/lib/tar.c
index eca29f54c06f..26461f8cdbc9 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -11,6 +11,9 @@
 #include "erofs/xattr.h"
 #include "erofs/blobchunk.h"
 #include "erofs/importer.h"
+#if defined(HAVE_SYS_SYSMACROS_H)
+#include <sys/sysmacros.h>
+#endif
 #if defined(HAVE_ZLIB)
 #include <zlib.h>
 #endif
@@ -957,7 +960,7 @@ out_eot:
 			goto out;
 		}
 
-		st.st_rdev = (major << 8) | (minor & 0xff) | ((minor & ~0xff) << 12);
+		st.st_rdev = makedev(major, minor);
 	} else if (th->typeflag == '1' || th->typeflag == '2') {
 		if (!eh.link)
 			eh.link = strndup(th->linkname, sizeof(th->linkname));
-- 
2.43.5


