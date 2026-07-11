Return-Path: <linux-erofs+bounces-3875-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aW7IMoBUUmroOQMAu9opvQ
	(envelope-from <linux-erofs+bounces-3875-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jul 2026 16:34:40 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1762741CC3
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jul 2026 16:34:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lHWseNxI;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3875-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3875-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gyB6d21rSz2xlY;
	Sun, 12 Jul 2026 00:34:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783780473;
	cv=none; b=YnwOMDeRIhS/n9jYVBuH7K525FLrIO/j46WcPruowoeEB+LlQDU8l7MH28OQ/kNIU7DggLBIOvgcy4h0jfX/Bp06wTOzatjnZGxsiqQ7uboA0LhlKZV9PZvOPda6QXRiJiCIF0NpcQ4L5DjSJMJXQm4n/yLBT4D4xJMYRAzaoRj4BlTOTyp7T80iCDeBje2uhxEFXg9HI6Za+Hsy1LY5/ID0bBj1jPcd6Uxbe6rAzKunOe/sLGrNON/qBU6z5Y75trtMmlhJkrI9a0s7AA6dJDS7ei/Zcf+LtuN9XFGeanaCFs3gH/29tVbKiVOxGmeuTt8YIRVdfJmCwrNdBvdIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783780473; c=relaxed/relaxed;
	bh=Pn3TuWsy7LPK2Mh7RYsHyafjd2c/ye1pFlJPL8EwT/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3naUW2Op9pjAj84ZZQxqBXQDRbq3Kxr5BrYQCyhI15NCebLPD4z+UffcQUCknweX6MhRDE3JG1DbhPZHNCnpPV5wOKe+QyBajqxiUYZJHq1E2oYPP/O+uJcVgJua3p+7/OkR8kx/X3wmHPCBTeZVcF6A3tlfsapuzAT5HRAXNGmRlnYwvA+XOyAMQCFfKN8uLmZqChLqIfC3ZDejkYNdadp0dafVtZn/5ELTg4HqVIziSbp4SJfXs1bmGj4Wjtm8oFRjyGrT9MvRU3F9XWi6eBW/Ht1NPmJeZ3Og7PtHm1xMWJCAfkpu5FMOOhpzgRvcpAg+VEe7lvTZoKmEvT/gQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lHWseNxI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com; envelope-from=michael.bommarito@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gyB6b2HBLz2xjd
	for <linux-erofs@lists.ozlabs.org>; Sun, 12 Jul 2026 00:34:31 +1000 (AEST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-92e6c4a867cso104657985a.0
        for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jul 2026 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783780467; x=1784385267; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pn3TuWsy7LPK2Mh7RYsHyafjd2c/ye1pFlJPL8EwT/Q=;
        b=lHWseNxI1ZR5Vd/VVHxtNsRLs71bUaHwQvVNhlIrl0lVfMHjsEMj2dOmacXZ4AQdvI
         8/kDo717a+ZBrgu/WD06klptxfywFtW9nIKAzUehgdmIAcuBEqz+swAv5F2AhI28w09P
         EW3NgEamN7bF9V500aerCR8Go0dXu/anvyHNU3dHB3DlyvjZmJcP7nDz8fRaT8RyvdcL
         G1XpU/OJFUjp9yXZr9R3xhjDriu9LohuAdAqv5YLmACamhtAqhPHx3nDQbjQUfKs/ENb
         iGYFuu2Cgvb489kwJvXYCn+LGMLlOFZfJZIfrEgT1sN7unINvW3fiGcljBKl3nVjNejG
         oE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783780467; x=1784385267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pn3TuWsy7LPK2Mh7RYsHyafjd2c/ye1pFlJPL8EwT/Q=;
        b=VxrAk9oJ0v2Okz7Drbv55iNiQO791/ClQPAt/C5l2ZcQcqR0t6UGta7Nb7/U7jgw/G
         cK/GsjDsMybgHstG8TPUR3mNEMdSNlLsH8g/7jUuMbiwJ4/xyw8biWj94oq/W/iL0AsG
         ZAmKapJacrAaJ9XHVYfgGSyFHW8aFtE5KwaOUee/PBDu229JmdF7yVEVVuPAb5cVocVA
         efuEWO95FgG9onhJaliQCurDuIShwEz3FIb/5N8G2UdAY8DPu6NwSgzp+36YhikHMVc1
         K0hPPA8Xxh9Wbvu5Rscwv1gw/8FeUSOeeMzEfjEzuTaxtWPKGE9+pDhjo3SpVldiXv96
         iaIQ==
X-Forwarded-Encrypted: i=1; AHgh+RragYUD3aQh9MV9v1BU3smKHZbMCRphefWbCLP3Xc4Ej/sbfiQ05NDkc0FM/MdNurhkGQ7NBVq4qtccFQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy+jUmFaXxCPT2ysbpHC+ygCmuXgH8glo1pBeuBO8rpngsQZK8k
	as7KBCZ5rmr8JUcLwfkLB6x/Enfah0gh0Zajtpn0GG7R3WSYlnHSX37n
X-Gm-Gg: AfdE7clZU8ejULb0k/mf0eMe6F0AZRnJYxmy3pDnLL45K9jQoxWvq0BKzgUCL6+kL5S
	erZUfa7FkUIibcFbYlwMPOlBmOZIC6VYocjOvxVTtAN2YIyIuR5j8Bw+1tTd884PvkdolfkYb3K
	CWPTLcYvz5HTvIhOePhP9D7Vz1/6DFFSNl4zdouIRb+3TTx1D6amzYop1ar3irSKTh7e7WR39Vj
	g9GTsuOvrsT7JECwUPgIm5/TKBPpJn5ltx3x8uJqV3qrPx+ZflnQ5EE7HKC+PR+4oC6h/gaFkl+
	g8JEhLIqHHdhTKtBhyCKTVgK6h6vFE4nkLSq8pM0jTGhlxAdQtNpfKa07Mp20QYnxuMkFFX9hMo
	W4ONfP1XXYbfN0dcgw1kUpisdLhlX7MVrh6gedboxAnOuucWUw85n5uLGXJTjn/YqoKIne89YIp
	ceoF09VAVl9T1+SSfeOfSEImwVUmOUXZvHqQhjHHQYal7+S152DLvbdtnu33FnFBoOumXwKk7jZ
	QFjAmI0z8wINd7XnMA9
X-Received: by 2002:a05:620a:258c:b0:92e:54b1:2881 with SMTP id af79cd13be357-92ef2bb787bmr329664185a.16.1783780466845;
        Sat, 11 Jul 2026 07:34:26 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d375fesm461652085a.37.2026.07.11.07.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 07:34:26 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] erofs: cap LZMA stream pool size
Date: Sat, 11 Jul 2026 10:34:19 -0400
Message-ID: <20260711143419.2762894-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,lists.ozlabs.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-3875-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1762741CC3

fs/erofs/decompressor_lzma.c sizes the module-global MicroLZMA stream
pool from num_possible_cpus() or the lzma_streams module parameter, then
z_erofs_load_lzma_config() preallocates one image-supplied dictionary per
stream, accepting dictionaries up to 8 MiB.  On high-CPU systems, a small
EROFS image can pin hundreds of MiB of vmalloc-backed decoder state until
the erofs module is unloaded.

Impact: an attacker-supplied EROFS image mounted by the system can pin up
to 8 MiB times the LZMA stream count of kernel vmalloc memory.

Bound the LZMA stream pool by a new CONFIG_EROFS_FS_ZIP_LZMA_MAX_STREAMS
option, default 16.  The default keeps the worst-case preallocated
dictionary pool at 128 MiB while preserving the existing per-image
dictionary limit; memory-constrained systems can lower it and large
servers can raise it.

Fixes: 622ceaddb764 ("erofs: lzma compression support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: bound the pool with a Kconfig option
    (CONFIG_EROFS_FS_ZIP_LZMA_MAX_STREAMS, default 16) instead of a
    hardcoded 16, per Gao Xiang's review, so memory-constrained and
    server deployments can size it.  Kept the EROFS_FS_ZIP_ prefix of
    the sibling options.
v1: https://lore.kernel.org/linux-erofs/20260710023036.3745254-1-michael.bommarito@gmail.com/

 fs/erofs/Kconfig             | 20 ++++++++++++++++++++
 fs/erofs/decompressor_lzma.c |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 4789b1077d8ce..3e4731dd03e7c 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -131,6 +131,26 @@ config EROFS_FS_ZIP_LZMA
 
 	  Say N if you want to disable LZMA compression support.
 
+config EROFS_FS_ZIP_LZMA_MAX_STREAMS
+	int "EROFS LZMA maximum decompression stream pool size"
+	depends on EROFS_FS_ZIP_LZMA
+	range 1 1024
+	default 16
+	help
+	  EROFS preallocates a pool of MicroLZMA decoder streams, one per
+	  possible CPU by default, or as set by the lzma_streams module
+	  parameter.  Each stream can hold a dictionary of up to 8 MiB taken
+	  from the mounted image, so on systems with a large number of CPUs a
+	  single small image can pin a large amount of vmalloc memory until the
+	  erofs module is unloaded.
+
+	  This bounds the number of preallocated streams.  The worst-case
+	  preallocated dictionary memory is 8 MiB times this value.  Lower it on
+	  memory-constrained or embedded systems; raise it on large servers that
+	  decompress many EROFS images in parallel.
+
+	  If unsure, keep the default of 16.
+
 config EROFS_FS_ZIP_DEFLATE
 	bool "EROFS DEFLATE compressed data support"
 	depends on EROFS_FS_ZIP
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index f6692d0f2f04d..882684c663f47 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -52,6 +52,13 @@ static int __init z_erofs_lzma_init(void)
 	/* by default, use # of possible CPUs instead */
 	if (!z_erofs_lzma_nstrms)
 		z_erofs_lzma_nstrms = num_possible_cpus();
+	/*
+	 * Each stream can pin an 8 MiB image-supplied dictionary, so bound the
+	 * module-global pool to keep the worst-case preallocation in check on
+	 * systems with many CPUs (or a large lzma_streams request).
+	 */
+	z_erofs_lzma_nstrms = min_t(unsigned int, z_erofs_lzma_nstrms,
+				    CONFIG_EROFS_FS_ZIP_LZMA_MAX_STREAMS);
 
 	for (i = 0; i < z_erofs_lzma_nstrms; ++i) {
 		struct z_erofs_lzma *strm = kzalloc_obj(*strm);
-- 
2.53.0


