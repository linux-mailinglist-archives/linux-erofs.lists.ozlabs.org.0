Return-Path: <linux-erofs+bounces-2300-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLlZDQb3i2m3eAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2300-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Feb 2026 04:27:02 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56015120E75
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Feb 2026 04:27:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9kPZ0qV4z2xlj;
	Wed, 11 Feb 2026 14:26:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.63
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770780418;
	cv=none; b=kKbIsouxq9JL0Ap7PuT96HB0mE5OZPFvz2h2W9ArEgBg8lTMwDVNSbSgTumBa6HTeOAVffwvdY5OqWso9Tz0c3bLbcVML4DccDpTE55cdmFy3W/IDw4uCOytntQu4o1qHccs84UQwZdXnTYuOhKUr06RcGeSnyBpoBYe8jw5oTyldkQfljqGEWum9j1GvvGS1sHKGon0JZUmpnW532FRhCvoUyZkw2L9zvGjsbsoAU6ZatCTAjH4ntB+01L/UPaBf3zDNLKjkjad2D35XpHwgHdSaKa3FVUYz3/Th0Pch+WEWJBfTsRnjf3XbZTydWSBsqgwa93+t7VYZ7Q500z5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770780418; c=relaxed/relaxed;
	bh=y/6LrWPB07bqEJq1geE8c8qguXlle7WUErK4+p0H7gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHhUUeF+XAABM6BjRfNx2GRyo3++X01OQttNvqG0E8jplCy+Q+yOHfK3yx0kMjmQHSzNYUueB99W/4qP9mfsDlldo7GsEWZ+jsW9dyOpNIvWu0fcM4KT/DFcFweKoUbGWxNsiOreWUknCzIzTOhngFl0lzr8fS2cxv6qdWBiCLrg5+zGewxDicAyNnIrJiPonhLypWY0SlR8dSEr80qYnYQY3r0OvyN0TUY8qfN/IHllq+R1GKi+Ljt72KKFY7Lcqi2CLKqC4Z7N2pqzOET9uN2J8UTEmUKA1qMe2RnMGkyfx4g2gHsz04qKklxpYyQ40IlNmH+2udzbf5QOcSeTsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.63; helo=out28-63.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.63; helo=out28-63.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-63.mail.aliyun.com (out28-63.mail.aliyun.com [115.124.28.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9kPW4MSvz2xd6
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Feb 2026 14:26:52 +1100 (AEDT)
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.gUV-ct7_1770780405 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 11 Feb 2026 11:26:46 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v1] erofs-utils: mount: mark OCI as experimental
Date: Wed, 11 Feb 2026 11:26:45 +0800
Message-ID: <20260211032645.20962-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.47.1
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
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.00 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[cyzhu.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2300-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,tencent.com:email,cyzhu.com:mid]
X-Rspamd-Queue-Id: 56015120E75
X-Rspamd-Action: no action

From: Chengyu Zhu <hudsonzhu@tencent.com>

mark the OCI backend as EXPERIMENTAL in
both the help message and runtime warning.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 mount/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mount/main.c b/mount/main.c
index a596c36..5a3dc54 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -100,7 +100,7 @@ static void usage(int argc, char **argv)
 		"    --reattach         reattach to an existing NBD device\n"
 #ifdef OCIEROFS_ENABLED
 		"\n"
-		"OCI-specific options (with -o):\n"
+		"OCI-specific options (EXPERIMENTAL, with -o):\n"
 		"   oci.blob=<digest>   specify OCI blob digest (sha256:...)\n"
 		"   oci.layer=<index>   specify OCI layer index\n"
 		"   oci.platform=<name> specify platform (default: linux/amd64)\n"
@@ -228,6 +228,7 @@ static long erofsmount_parse_flagopts(char *s, long flags, char **more)
 		if (strncmp(s, "oci", 3) == 0) {
 			/* Initialize ocicfg here iff != EROFSNBD_SOURCE_OCI */
 			if (nbdsrc.type != EROFSNBD_SOURCE_OCI) {
+				erofs_warn("OCI support is EXPERIMENTAL, use at your own risk.");
 				nbdsrc.type = EROFSNBD_SOURCE_OCI;
 				nbdsrc.ocicfg.layer_index = -1;
 			}
-- 
2.47.1


