Return-Path: <linux-erofs+bounces-3793-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v+RHNkNbRGqmtQoAu9opvQ
	(envelope-from <linux-erofs+bounces-3793-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Jul 2026 02:11:47 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCC26E8CB5
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Jul 2026 02:11:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BBmDMCoo;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3793-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3793-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqgRg6xyrz2ySJ;
	Wed, 01 Jul 2026 10:11:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782864703;
	cv=none; b=CYyCPiADgNWvbYBoH+GsP6miwv/xJJTSDTcuTcClaoq9ViYhACsNKmjOFvq9JNlpO5WVw9apgl6mCXSZoF9OuQhnJZ4DeNdOXF1HzwbZ2E2rgC3TsaPaTMzuVra7LZ/KbIOMKCkdt7nMDgcgoBHGjLXOc+mkR/4gtT5N/folNdLWp7HEWCFLwwbzM+XqSXLWeTDHERz6WZJxlgnfCFGVNnp5A9+SYclTeBV95xOq1fWc7Q894Mg9bv9rB7uzrKSZTr2j3C1aihKB2OEGFl8Q2s4JukL1M490NmycVtgMAXsOepqJNw+AG9RWTkK3LNWyMBRsfkpzRSujYC7VAowXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782864703; c=relaxed/relaxed;
	bh=N7+CcIiDetDTiagtbVpMn37s8DwFl6V2j0Jf9vPEZaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw5e93iIjnQPMVNgv0DDHXojhuW/xCuAsHWfoAGTvhN6+0G+/1AtMv09zy+DFLEThNt91VxYZd/qLTq0D67yWYfXRAagwkEyuauJXKLEO6t3gSGdfBD1/THJe84DFN2RFhhJQAnhNesN5kZ/wIZyiR+0asFgJAiUSdGTw5z/vQm7VADioddcTMT3c0RtgSz+4sz8V3DxPwfddkGK8HPl07m0Zr0GQT8zJ1n9N1S60vAEH9gRtDklcNF99aBx2qfMJv+LRCUQK7uZQGRIH5ytrsAUJi7/hPH4GKa/rP4aA3zeq0+vaTJwNUhlDk1d2nsMTbAlVJ3+W5OlA3jPovkygw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BBmDMCoo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com; envelope-from=joannelkoong@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqgRf4zq3z2yQG
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Jul 2026 10:11:41 +1000 (AEST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-7e94b0aeaa1so64664a34.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jun 2026 17:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864698; x=1783469498; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7+CcIiDetDTiagtbVpMn37s8DwFl6V2j0Jf9vPEZaw=;
        b=BBmDMCooPWp+QTTlFt6pFe1Hpiz4c0thnHQJOPxyRfP0lcCfnnHUybUE/xYDaD+1F+
         VBF276St6irG5PF7X8RFtByqxByClLoWpNfureJ0Wxub+QjGM1qLeoYGS/eaiwjm+AJ9
         VTRrIc+6Nox05rM1iEqra7VFCsUay9XauP/fuwOr2EcIqfWTV1kJQNhLtSK5gHHthb/F
         dVEi/WW4Zs2R7gEt7OozXNUY9PdfODrfcUwLVDR7O6uzQfCJrKVZU4b5rhQyp+ypyxd7
         3DwN7fbUfvjSW+D5PtjIppCWJSxlVMLjWS4ztV+7vaLzrE8fJ6dyGPq0Xt+LL2LIuy5d
         51hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864698; x=1783469498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7+CcIiDetDTiagtbVpMn37s8DwFl6V2j0Jf9vPEZaw=;
        b=TWU9tpHLyrLlMug6arYP6krmbGtqeNGIH//V8S5KDXOZyhfeJkPDx0MGJAGDm3kkZx
         SMSmbUQSyS6C6p4C4rzH1b3OYgj8gBPPYJPx77mYYVTvncwut2SlgwGphcNV5Ts7OSCy
         8t41Ls6mnzGLNLfHTIJnSlwIj+MNeqLy0qgEVn+SJHAjKFN/bndtMfhvXLRK0E+NTyPB
         n2xr1I9HAxKeWoQzMxsOLmAf8ZUQxcTcD2yj+6879mCkaluJf6LTeMZ+pbGkg6vXzqB5
         OxIgQ4GboUyWupdh4KOw5XQYx7r+yXZD4xz/EeUDGUTgOMHvpun6USRUIIR0NG2Nv45Q
         KjwA==
X-Forwarded-Encrypted: i=1; AFNElJ9Unc+U677fKXue0jkR1IQbGxofb03botMoEHCQBVbS0iIvgGWvsuHw6kwvdBkvIB60kRHxpdh8ZGzj/g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzttJQFCONhFpAN2zwXM4gps4IPWhqyAOxRwqr9Kz2usUTxc367
	4bSZwODwd7IS2gtg9QuzaI4uADnGPZ9QnqDhQSnpXwVawBKq5oAqbwFz
X-Gm-Gg: AfdE7cku323FdHW0Gxh5uGVRRVI5kg3mXFylq4xY/LZQHhPtmPadjDWZWxUYfvIX4Gh
	HUjEHjaI20B11+FJk+a56XY7nmsCQmlq9VEpo9qtJalk0vacZFNBrOYyVVBQvDrIuJ53is8oeYD
	Jx7BVquX9FClKvudAgxRTLPflorbM4+QLBEvcjQSbJwmwoLWrg1yIpwA+Y67D/amnTDS8fpsMOR
	plF/eoUwUBHn1zM8fGz70mUWfpIlrOPAy+8JoLQGihrj2m6st6zAZpn5WGohGV1hY0bE9EFzvqI
	VKzRIo8Kpye1eiCD2b1ogs0ZedCmbRGhuMGmjn2UWbVs0folMnuO7E5Ds4Te7XBKPLkCI82KrDp
	83ZM3uvxFPT0lwkcbGhwydWGrIoMN0SICLiu/forTQKbeg0fNGFSEQSBy4vO9YZo9kObTlpDzva
	A/15nFRWfHrxFXJpkE6gpgCdb0xoLgr35rT/P1m+sIExM3G+5tcJBFktGg0ElbsnZv
X-Received: by 2002:a05:6830:3808:b0:7dc:cdea:7d9 with SMTP id 46e09a7af769-7e9fc15ad0cmr1772936a34.22.1782864698251;
        Tue, 30 Jun 2026 17:11:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec2b96c0sm3558136a34.14.2026.06.30.17.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:11:37 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	linux-erofs@lists.ozlabs.org (open list:EROFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 07/18] erofs: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:22 -0700
Message-ID: <20260701000949.1666714-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260701000949.1666714-1-joannelkoong@gmail.com>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:hch@lst.de,m:djwong@kernel.org,m:willy@infradead.org,m:hsiangkao@linux.alibaba.com,m:linux-fsdevel@vger.kernel.org,m:linux-xfs@vger.kernel.org,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joannelkoong@gmail.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,linux.alibaba.com,vger.kernel.org,gmail.com,google.com,huawei.com,vivo.com,lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_FROM(0.00)[bounces-3793-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FCC26E8CB5

Convert erofs iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/erofs/data.c | 10 ++++++++--
 fs/erofs/zmap.c |  9 ++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 9aa48c8d67d1..47dba61ec576 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -380,9 +380,15 @@ static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return written;
 }
 
+static int erofs_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
+			    struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, erofs_iomap_begin,
+			     erofs_iomap_end);
+}
+
 static const struct iomap_ops erofs_iomap_ops = {
-	.iomap_begin = erofs_iomap_begin,
-	.iomap_end = erofs_iomap_end,
+	.iomap_next = erofs_iomap_next,
 };
 
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index bab521613552..dd058413a0b6 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -821,6 +821,13 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static int z_erofs_iomap_next_report(const struct iomap_iter *iter,
+				     struct iomap *iomap, struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, z_erofs_iomap_begin_report,
+			     NULL);
+}
+
 const struct iomap_ops z_erofs_iomap_report_ops = {
-	.iomap_begin = z_erofs_iomap_begin_report,
+	.iomap_next = z_erofs_iomap_next_report,
 };
-- 
2.52.0


