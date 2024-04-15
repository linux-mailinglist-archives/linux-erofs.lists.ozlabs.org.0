Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB388A59F8
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Apr 2024 20:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1713206159;
	bh=nH8Zt2xW4XVswjuzmgzK14OilNSgeHbZ3CRjwgBL2Pc=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=kDHULSaxgBPhNR0ZNLlEyilQ8j44fxDOvkOYe0fS2Rp8sBng86D4LsvjNj810jki0
	 gOem1LBi2CY1lll8nRWqrYk+/zQ4xiBmJO0jjnNQgsIeAMv19xnTIYfoeIpaVnwCUK
	 a9OiTxsGXx41cb1gLenk1UKxV62xc60Ai1a6ITTFW6cSi7yESuHPslfW+8vAsIdiGj
	 FLL/WzZxyeWqVifAKxTb2sXUfLHOiDIjYLrADqiRl3TM25kx1K89e4QOGRZZ1/DuA7
	 TR5P5Fzx4QmF3fMwkvuIKQJW5S4UrBHVO4W6bFvWBlPe3HSekIXiy6oSjxTXb7RiU6
	 Ael/gpWrgLF/w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJG8H2nWKz3dWS
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 04:35:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=A6lCi9hX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com; envelope-from=3f3mdzgckcxqx1ufu5y08805y.w86527eh-yb8zc52cdc.8j5uvc.8b0@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJG852Nwcz3dTr
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Apr 2024 04:35:47 +1000 (AEST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dbf618042daso5464951276.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 15 Apr 2024 11:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713206144; x=1713810944;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nH8Zt2xW4XVswjuzmgzK14OilNSgeHbZ3CRjwgBL2Pc=;
        b=L30qg2/N5l7aZKawh86h90HEOcLwNYV0nOasbcqDciw05R7aYJRlgcup1E2AeidCK3
         ef4zQ3qjo8rSy3iF9sefv/QIhsPxNmEtH/uAyGjV+14nHOp2sqYMrMFXAqWlK7zWG0Lx
         nT9Bz+8YK5oHELM94i86XxN+z8nsR3ptrtqxo3KleFwERBTa1Y10z2WtnRSdMzYcTkPE
         EDkOVPR0VFP8ykKbBgTX0GSBzqmgHsDzXWNbaY/kM1J7GVxf8poWzeY7StPFs4+uRjAU
         7mED9yN0O3pm6RR3nWHUBMXtibXzA/3Bgb1QZvnSR1WRP8ghXJU903cVZo3ug1RKRInZ
         KjZw==
X-Gm-Message-State: AOJu0YwiSDam8up1kX5s1/GjY1joRb1AWppb+l85fgE1oP8mQRmFZbk+
	u0MBXf0tAvFii1s1s08xfxNKtVCKsaVTcPf6/b7GZEEBBb6Wae77qP9amR7NGcAbMBfWgAfqbli
	4dJnsXN6v1kIaR9uW5NRRUoiOvWHvL+W7WsXFPM/3XHNTdnUHd5LX5y8srUpr3FAnz31XBdHExD
	0eSLgK7I6a6BViZZWSGd/yVV8GaZn2Fd+KJixnwkjcwnwwxg==
X-Google-Smtp-Source: AGHT+IH+NrDFn/fr/pwz3Wbvm5SCZ9RWIJ0QvKhbnbLUk2JOstb3Nst9b66a+wRPoxlrZ2J6rVl9Vnzns3gp
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:607f:ce4e:94ad:c134])
 (user=dhavale job=sendgmr) by 2002:a25:b292:0:b0:dda:f314:7e1f with SMTP id
 k18-20020a25b292000000b00ddaf3147e1fmr1078612ybj.4.1713206143826; Mon, 15 Apr
 2024 11:35:43 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:35:38 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415183538.2012717-1-dhavale@google.com>
Subject: [PATCH v2] erofs-utils: dump: print filesystem blocksize
To: linux-erofs@lists.ozlabs.org
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
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

mkfs.erofs supports creating filesystem images with different
blocksizes. Add filesystem blocksize in super block dump so
its easier to inspect the filesystem.

The field is added after FS magic, so the output now looks like:

Filesystem magic number:                      0xE0F5E1E2
Filesystem blocksize:                         65536
Filesystem blocks:                            21
Filesystem inode metadata start block:        0
Filesystem shared xattr metadata start block: 0
Filesystem root nid:                          36
Filesystem lz4_max_distance:                  65535
Filesystem sb_extslots:                       0
Filesystem inode count:                       10
Filesystem created:                           Fri Apr 12 15:43:40 2024
Filesystem features:                          sb_csum mtime 0padding
Filesystem UUID:                              a84a2acc-08d8-4b72-8b8c-b811a815fa07

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
Changes since v2:
	- Moved the field after FS magic as suggested by Gao
 dump/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dump/main.c b/dump/main.c
index a89fc6b..928909d 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -633,6 +633,8 @@ static void erofsdump_show_superblock(void)
 
 	fprintf(stdout, "Filesystem magic number:                      0x%04X\n",
 			EROFS_SUPER_MAGIC_V1);
+	fprintf(stdout, "Filesystem blocksize:                         %llu\n",
+			erofs_blksiz(&sbi) | 0ULL);
 	fprintf(stdout, "Filesystem blocks:                            %llu\n",
 			sbi.total_blocks | 0ULL);
 	fprintf(stdout, "Filesystem inode metadata start block:        %u\n",
-- 
2.44.0.683.g7961c838ac-goog

