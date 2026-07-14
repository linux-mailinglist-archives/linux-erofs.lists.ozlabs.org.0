Return-Path: <linux-erofs+bounces-3896-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V2tsANwhVmrOzgAAu9opvQ
	(envelope-from <linux-erofs+bounces-3896-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jul 2026 13:47:40 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4B0754152
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jul 2026 13:47:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=p4M2RVPM;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3896-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3896-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzyGd02NLz2yY0;
	Tue, 14 Jul 2026 21:47:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784029656;
	cv=none; b=hzEgIHV/++x+nFEl1E0aPs4ZOPtJaOYKrDv1HjxI4BRAYzW+eUn1njHfm3cRFJ+LMOCb7tMRXoDi/+9xyTC3Fi1YZdnQ2I1ozmPPFi+RwPIZKg0P9xGAMV8cOw0/Rk3Ho6wBMSpA2Y7jKpLohYD1EXDkQRpVKCnE5D2a3kS70211+cr3KXXQ5g7+7yEU3/Z9Z+zI6+jrg6A8sX6cpuifdquXmfkRei+i2yJOAUHYLeLdKoxeq4KnfVUE8Rd5bGvpKwNWLs9ByQZmn9cceg99VB1Hb8J1uaauG/XJXnWmcFUe2sOs/PQsAYEvmMJdgsQ+YXEK/4t/SRXADm7JpY5oIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784029656; c=relaxed/relaxed;
	bh=v6XTzlQqHFw6xqg6gEsB8Wgx3QjcRA5c6qOuB7Sr3eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qy+xKRiCmc8NHTVAHhrEzLwUy0Y4q4T7lRR/9g/NeFckVDHq7HZxE1BJfKKakQCSn/j/yJe9YyUjJMF+osUx9Yx6eLgHgPkSnH8keseEP858MvpnWONevhIBB05EeglXpAiONt+4dCaWw6MIft6sNNtDpNQffgIHN6u3TJouHQFUsQh6qsU7X774PiescDLONpEwRjnNsck13Tl4cgrpCuNGqGmZR1bnInp3ylMgAF6qUcDTRDQmRnEBQ7EFQ4ekTs8XCDpA865GbF5kof/3ddKI8OOZWIrkULl3HnrvUMfB8Y9u8myRbXWJtublV6ie26kzKBSwUKo9/Sic2MHexQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p4M2RVPM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=michael.bommarito@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzyGb3bRdz2yXj
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jul 2026 21:47:35 +1000 (AEST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-90327237340so6337446d6.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jul 2026 04:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029653; x=1784634453; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v6XTzlQqHFw6xqg6gEsB8Wgx3QjcRA5c6qOuB7Sr3eQ=;
        b=p4M2RVPM+Vd00C8Q3xwKGUGEO9eVuXTlqrZSTjK3bkbsXzT9E8pG/F10kU7NQsvQLB
         G5CGpxBSF8GW2QPnspkN6unJfZIOSPaFXPPyJJSzWrBW60zKg33aSuPGzN5udW3QYD8o
         8FCq9DTuh/7qUPwfEguXonN4joIhYY5qKC6XtcdgLPqJLuGEq+ciDWgOJQC+EwefGSqX
         2YDAjIXlf+FKmkzB4IPMx/L9eoh4/JDZ4Gn9B0D2x8AzTzgNeQUKJzrdhA8QdXKLDsYQ
         2KIvTktuQCXgSPH+v27SnZxHGGQ8g4DEGOyOoIX3oxLrJNm6XelDj78CUXJDCSNyVDDe
         liBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029653; x=1784634453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v6XTzlQqHFw6xqg6gEsB8Wgx3QjcRA5c6qOuB7Sr3eQ=;
        b=LZ2e22JFKMF0OIgbZKti9/o3teStT5S+xJQv1ab8dU1g4SQ3gQrJAip7xlcdD3MnNj
         shU7J4ncRhpZmMHGVr290eXZ2k/WGjfrFgtapyOJXS3HULcXhLuzYwR6oyAdr3YRO029
         WPq7MEeIvs6GYxdI3zTXg8eQ5Ou2Opxf9fnR41RWypQIdC5hBTEpu6AE3ytC9AZ7F5C3
         3XpCETBa7sr0r3WKG17IYz1MBRxoX+e6vZSPUpkxu0icwzYLADYFDeB1SqU33hdOTVK7
         tAI3pm0hqxLWrnM/VrhnTkAx+ZzQE8obLNF9yDOBacCsT3b5Wa6B9KLhEVorMVwZBAO1
         SZqA==
X-Forwarded-Encrypted: i=1; AHgh+Rqv0KQ5So8Iuox1eoCcN+2C5LhHXUrjT6McTKM80sH6AGLRaqVfs4PSuhd8GujpuV7VWFgBSbaNlzZaQw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzb6/8wwSig0n/LoFRqZ7KZV2a4FGuKW+WNc4TzaVru0MhvKKjZ
	JSxsKGVrajHC+v1k4BwYSfn0ztLN43J+N7OCzl7faIq7Fx6vqJTBQpte
X-Gm-Gg: AfdE7claZtfkCHtKNizcEPsDjbpjfRKLYtto3tJaiEXxY38bax/l+x3UZh2WxKz4qSG
	z6WFaqf0UtyqAfEBPY5Abk/iLOiV2jjw54qgkvkGAkR41eZOTEl9zumrpU/4OM+I8Kp3UVQJh77
	FTMC4X15+OWmihPiO5Bi/f1wegYBue1nHRnkFj/wluCQj/nrarGUlWqaqUd+m+G/yOsXYaAuGIb
	C9F0jcmxMVvz9cjbexgeuS8mLJeIcKju3D9y15YUtfuHYOtLWEuuTuZ2rtkT93KLTE4kfcbHxBd
	t93FhdzF32sCkTlFua0Xh88dzyL+gAFgyV6qViBF0lxUtZXiYkRqgwXUkXS53v9wAsWWUWUTLw0
	IEjRecxSjIPeJJaMwHUYR1jNbJEVUNx3hqGwfzcSrLN35tMEc67598elvGptsOI3sYb+mxKHIoP
	Yg29oS2wiaPkx5hWtisOpXmARdZSKLxPuB+c5ceoPI0stbaVAsMoRYhS83WNhXaFcCoHBnbksJy
	e0Narndag==
X-Received: by 2002:ad4:5fc8:0:b0:8df:7b64:fc4c with SMTP id 6a1803df08f44-904167e20c3mr138859676d6.22.1784029652626;
        Tue, 14 Jul 2026 04:47:32 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9063df4319asm64144136d6.38.2026.07.14.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:47:32 -0700 (PDT)
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
Subject: [PATCH v3] erofs: cap LZMA stream pool size
Date: Tue, 14 Jul 2026 07:47:29 -0400
Message-ID: <20260714114729.3760594-1-michael.bommarito@gmail.com>
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
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,lists.ozlabs.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-3896-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 1B4B0754152

fs/erofs/decompressor_lzma.c sizes the module-global MicroLZMA stream
pool from num_possible_cpus() when the lzma_streams module parameter is
unset, then z_erofs_load_lzma_config() preallocates one image-supplied
dictionary per stream, accepting dictionaries up to 8 MiB.  On high-CPU
systems, a small EROFS image can pin hundreds of MiB of vmalloc-backed
decoder state until the erofs module is unloaded.

Impact: an attacker-supplied EROFS image mounted by the system can pin up
to 8 MiB times the LZMA stream count of kernel vmalloc memory.

Bound the default stream count by a new
CONFIG_EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS option, default 16, so the
worst-case default preallocation is 128 MiB while preserving the existing
per-image dictionary limit.  An explicit lzma_streams module parameter is
still honoured as-is, so administrators who deliberately size the pool are
not affected.

Fixes: 622ceaddb764 ("erofs: lzma compression support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v3: rename the Kconfig option to EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS
    and only cap the default (num_possible_cpus); an explicit non-zero
    lzma_streams module parameter is now honoured unchanged.  Simplified
    the Kconfig help text and dropped the in-code comment, per Gao
    Xiang's review.
v2: https://lore.kernel.org/linux-erofs/20260711143419.2762894-1-michael.bommarito@gmail.com/

Evidence: the stock code sets the stream count to num_possible_cpus() when
lzma_streams is unset, and z_erofs_load_lzma_config() then preallocates one
image-supplied dictionary (up to Z_EROFS_LZMA_MAX_DICT_SIZE, 8 MiB) per
stream, so on a host with many CPUs a single small mounted image reserves
num_possible_cpus() x up-to-8 MiB of vmalloc decoder state until the module
is unloaded.  With this patch an unset lzma_streams caps the default at
CONFIG_EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS (16, i.e. 128 MiB worst case),
while an explicit non-zero lzma_streams= is left unbounded.  Built with W=1,
no new warnings; boots and mounts an LZMA image with the capped default and
with lzma_streams= overriding it.

 fs/erofs/Kconfig             | 14 ++++++++++++++
 fs/erofs/decompressor_lzma.c |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 4789b1077d8ce..8948cb6314e07 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -131,6 +131,20 @@ config EROFS_FS_ZIP_LZMA
 
 	  Say N if you want to disable LZMA compression support.
 
+config EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS
+	int "EROFS LZMA default maximum decompression streams"
+	depends on EROFS_FS_ZIP_LZMA
+	range 1 1024
+	default 16
+	help
+	  By default EROFS allocates one LZMA decompression stream per CPU.
+	  Each stream can hold a dictionary of up to 8 MiB taken from the
+	  mounted image, so on systems with many CPUs this can reserve a lot
+	  of memory.  This caps the default; the lzma_streams module parameter
+	  still overrides it.
+
+	  If unsure, keep the default of 16.
+
 config EROFS_FS_ZIP_DEFLATE
 	bool "EROFS DEFLATE compressed data support"
 	depends on EROFS_FS_ZIP
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index f6692d0f2f04d..6b0cdb446c6ad 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -51,7 +51,8 @@ static int __init z_erofs_lzma_init(void)
 
 	/* by default, use # of possible CPUs instead */
 	if (!z_erofs_lzma_nstrms)
-		z_erofs_lzma_nstrms = num_possible_cpus();
+		z_erofs_lzma_nstrms = min_t(unsigned int, num_possible_cpus(),
+				CONFIG_EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS);
 
 	for (i = 0; i < z_erofs_lzma_nstrms; ++i) {
 		struct z_erofs_lzma *strm = kzalloc_obj(*strm);
-- 
2.53.0


