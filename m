Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FE779F4C4
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 00:11:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1694643106;
	bh=6lsvtHpgBmeqWj7IIfogRL2t/Vh1MTy47LRs1rtsNI8=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=j9+PDtSMayOsYBiJPJ/UMUHBJYeKtHxmgvk3pMH9jZhBQHWAAHvbQyT0qAButgI0M
	 wNtpJbM1Nw6Fy4EizHgAAAmagMYkOCCeSVaSOyJ8tt54blhxYmtCNMpYCmHIDbQi1Y
	 3I9AKel3B9XYxiAk+WMwrF5UyqkUUVyrAzQkTPsvmLPL23zlUqYePpPblULKIhyy8I
	 jvX67MQgtKgdDBxQqpRvxcpbrlVMGGBp4sXOwKpf+lA2Vvp5Sd172WlpLzy83VOUe1
	 iUsOEn7EI+9locgXowHeNjlNFC4nPVRJu7pu6JT5NH6YwtPkm0zKuRiYNv0Vz1r0tv
	 2++HWaqFVG8xw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RmF6V3F4Cz3cDR
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 08:11:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=a4PVXd65;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::114a; helo=mail-yw1-x114a.google.com; envelope-from=3jtmczqckcywlpiditmowwotm.kwutqvcf-mzwnatqaba.whtija.wzo@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RmF671kLQz3bV7
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Sep 2023 08:11:27 +1000 (AEST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b5884836cso3953027b3.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 15:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694643085; x=1695247885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lsvtHpgBmeqWj7IIfogRL2t/Vh1MTy47LRs1rtsNI8=;
        b=KmTPZMVYmLo23jUlc0CgY+inApw5whIkFFwWjcLqwVD+Flz0L1jnmMa8MrXtPYe23o
         q7LnP2zw93MwbwrgwCiR+5G7W1H9gRbd0HFb22JDW9GlcoF5fxFl06ZF+CvJjYmfQwnk
         VTBWpWIzFAprQ7VGiCuputAKKEkgY8XI7O6AYxZoAvIis3s1bjvhmSTmSNlB+IVU5SEl
         3cYQhx8vIXuW9zi2nO40BNVPljYftnaeYYBuRUamMMNuq+hR/DNcuSrMRPZREM4D9JA7
         qfuUO6AGEFNJS7ufMXymJ2zlRZC1Ce4U/a/86sE+jKUKJ/Cm5t+QVUHmFWlQpXgJfk9P
         g3Sg==
X-Gm-Message-State: AOJu0YwQ24y82SJ2KWdYPYidPNAfENttM3+spf10z0d4txRYbo+8hoqh
	laOD2w240BdlJ1KINmnlXFIsLLZo9gKXOBNCOnbyhL0YXeoyiH7r5Oe8ICXX6iLODUd8NkSlyzS
	U1b1dyx5HzvN/sV5SQcqXtJ0GjCQxCdrI7NNAh63XuYq25iKFfzOfHU7RLFtfOYT5AssEL1/S
X-Google-Smtp-Source: AGHT+IHEYMqO4nQhX53/652DkGs2/uPMBbX6uOY6tDZghW3ptT/bk4HG48bBU6zrRPNvVRzdtIiv9sQmdkYO
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a81:b143:0:b0:58c:8c9f:c05a with SMTP id
 p64-20020a81b143000000b0058c8c9fc05amr103870ywh.9.1694643085183; Wed, 13 Sep
 2023 15:11:25 -0700 (PDT)
Date: Wed, 13 Sep 2023 15:11:01 -0700
In-Reply-To: <20230913221104.429825-1-dhavale@google.com>
Mime-Version: 1.0
References: <20230913221104.429825-1-dhavale@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913221104.429825-5-dhavale@google.com>
Subject: [PATCH v1 4/7] erofs-utils: lib: Check for error from z_erofs_pack_file_from_fd()
To: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

If z_erofs_pack_file_from_fd() fails, take the error path to free up the
allocated resources.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 lib/compress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/compress.c b/lib/compress.c
index 8c79418..81f277a 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -927,6 +927,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
 	    !inode->fragment_size) {
 		ret = z_erofs_pack_file_from_fd(inode, fd, ctx.tof_chksum);
+		if (ret)
+			goto err_free_idata;
 	} else {
 		while (ctx.remaining) {
 			const u64 rx = min_t(u64, ctx.remaining,
-- 
2.42.0.283.g2d96d420d3-goog

