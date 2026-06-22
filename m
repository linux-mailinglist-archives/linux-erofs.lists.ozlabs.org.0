Return-Path: <linux-erofs+bounces-3710-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9NzOCkruOGrXkAcAu9opvQ
	(envelope-from <linux-erofs+bounces-3710-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 10:11:54 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA66AD8EC
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 10:11:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ye0Bxw5T;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3710-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3710-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkLWp5qWgz2yVZ;
	Mon, 22 Jun 2026 18:11:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782115910;
	cv=none; b=Ujh+pDwLyN98QWLTzQRBNO/pvR2/fe6E5ihOqQZJkHCUSfSy0JXGCK4ggdfJ1vUw4cldMb0967pjRTD2IZtheK0jSBPhslDeu42/rAClumB+H9Qnie+cnf3HR9c/yyMU0agPKCbN93CZIOlBUdvJ7BS+f6RqnTXuIu+lbGP2ecfAs6IlDXJZpCO60pzTfIbUC5flFCX2IYE+gcpjl18bVLQHlSd+A5is/0BjZvm7KzNGpJeq1Kr+27ek+1YFXfKh77Sn3iiEVJei0Gc4gB6MBFa+7X9IweDEI2gtxfvHVdl2lNGDAObZrkSf3AQyGOySY9/+alvFb+Hs7ANggKaJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782115910; c=relaxed/relaxed;
	bh=HXYpuDPGj98fITESmoSR7ZVa8CqipenLDj5cFiLsFH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4ReZ5ygGJ3+epu0aacBdskD1gtG2mshNWNHVGShlQR189D2eeJEFFoejx9PPiGl+tzoGgcefnC58rlGP0KCbHt6LxJbh9a6sph4G+NvxwDmx6ldCyfcVBzmm9PIcFTe2hGRVwTkU8+QS+QUvhosQ9uy0te95SGUYNXr0hZJ/YD5Asa6QL6+3mZmO7YFXTyNZ4x+Y3AKaG0EZpn6ul7lUpqODUrKpVY9fPQ76L5S8qnwWJkYVb21eYkKU0+pM6kByEEygGZ1ibyISGc6nMER9HvpLwyxwWAqnr3xtYh8pGv+ZYJNoTMqTg2ao9F4E9Kf0XmIz90lQjT7MwVoKvy+ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ye0Bxw5T; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkLWn54lhz2xSN
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 18:11:48 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-845537740ddso1259044b3a.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 01:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782115907; x=1782720707; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXYpuDPGj98fITESmoSR7ZVa8CqipenLDj5cFiLsFH0=;
        b=Ye0Bxw5TiRzCBJVaz4rEoYx4GjsjWizsR0yRa2wBWF42KdEScFaT6IDAsONkTddQhu
         xW7BsQLNQk2Do75+nTbC5eHk1cqteNcC0mvkUyTsg1cuvImEubUwGk5OMSdwt3o3NPjn
         dxemhm9GCUOQOEOCwmfeoH4/V+7b69JeX8mgP89x6X/xSkS8MEVdbXYx+k7BM83Wvhcf
         fRo9H9+7pVrLXTd7f9jJm8NBlYgYZfSpFFqeCvtUDciTEFm8sZXb0dFgdJDGnpmtsZyp
         GGPhsngbHX/oy4VFuwbzELQuKh0e+o+WL9x9vMX8mFjNx/FNcOCRGZcz83A7J7c98w0B
         bnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782115907; x=1782720707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HXYpuDPGj98fITESmoSR7ZVa8CqipenLDj5cFiLsFH0=;
        b=P4FkVe010G+iYxW5EOb+zQ1ep5FZH+uZzvNzS4IowqGimA5tOWK+7/+1rh7pmEIQrv
         ERP9okEHS9TaWxHvvyOfPycOfsPuXbMlZacXP/5TTIHOchw7rIDOjVDp4BIB7T/3iLGN
         vDf6m2TuZ9O9qU6w1F3aSEy8vHrNMuKT/U3Wu4wZ9/+5QPaNNG1qy886uyrnpucgi/Bk
         siBGrwtHGe5cHTP472ORcTMbrMg/nudWpDJ06zHMhQz2DhK5r0nlBFjJGd5oK1Jqp0FJ
         e7cgBPoMf9baC/E0Wvb9Vi9L68bNWpZQ1h0QmnULkopJU/UvYC9tR7eiIWkSJPWe7Wlz
         uS/g==
X-Forwarded-Encrypted: i=1; AFNElJ9uhXoD0MucE49O6UfOjOQtLEnlEPvjvyOhcANz9uzIqEsQqwclBrKsX0mntQJ29IZyOwou5JrS/O3vyQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxGF4oVQJiDx47wSMNOohbd5DskxH2v2V/kCu+N1aZ8t0qj8NxP
	8D0whge0/6tUzCZK3Vv1GxkbtoRO/H5nRLhdqCYNpqYau8xN51EVRFeJ
X-Gm-Gg: AfdE7cnuslT+qN9IZ4Oy8x5TqCX3Rpcesl4vCF80yiUO1xeaSGm+8HsrSxtdDf8B88g
	3EPXfpy1DkgMmAlux2H+fLXFyCXCL9vkmW+OlP1lBOkcS8WHyEcSv9FLllGsGbLCsKntCfgqRch
	1gsvrrbDOtTWdOumJz0C7p5SMbtuLlU+96zcM8DpE4pr29PrMpLZQMdPC8CsaOBj7U0I9JBcLKh
	buNS2TdbTZEO4pBjV+Uvlj0pFS4l3fX+O0c0Vy3HHndx2km4/q0mdOC4S+ucWH9KLJP/0h4eUNk
	xTQXK/1UM27UNkQmUAu9xWrtf9zUZh+1lth++IFBtdntCR34w4rvmwMaD6f9QO3TN5k05cT/JEx
	G5OPxdaNKodQNWery9URfBgX8BVHJ8wJ4OPU84GDl8rYzJ8oySez2b3lxr5TSzoic73dbhHM/v/
	eMaBGcIOwuUZs8TiHMkf5dJks=
X-Received: by 2002:a05:6a00:124f:b0:841:89a4:5f86 with SMTP id d2e1a72fcca58-8455088e289mr17450673b3a.21.1782115906596;
        Mon, 22 Jun 2026 01:11:46 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e7696dsm8686514b3a.37.2026.06.22.01.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:11:45 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH v2] erofs: handle 48-bit blocks_hi for compressed inodes
Date: Mon, 22 Jun 2026 16:11:36 +0800
Message-ID: <20260622081136.2953243-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5cccd50c-cb18-4fb3-bce0-77bed389d00f@linux.alibaba.com>
References: <5cccd50c-cb18-4fb3-bce0-77bed389d00f@linux.alibaba.com>
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:chao@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3710-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:mid,xiaomi.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31FA66AD8EC

Combine i_nb.blocks_hi with i_u.blocks_lo when computing
inode->i_blocks for compressed inodes, mirroring the startblk_hi
handling for unencoded inodes a few lines above.  Also evaluate
the shift in u64 to avoid truncation.

Fixes: efb2aef569b3 ("erofs: add encoded extent on-disk definition")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v2:
 - Fix the Fixes: tag to efb2aef569b3 ("erofs: add encoded extent
   on-disk definition"), the commit that introduced blocks_hi for
   compressed inodes (Gao Xiang)
 - Reorder to "blocks_lo | (blocks_hi << 32)" with explicit parentheses
   and shorter lines (Gao Xiang)

 fs/erofs/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index a188c570087a..dc0e3d6bb2b1 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -191,8 +191,9 @@ static int erofs_read_inode(struct inode *inode)
 		err = -EFSCORRUPTED;
 		goto err_out;
 	} else {
-		inode->i_blocks = le32_to_cpu(copied.i_u.blocks_lo) <<
-				(sb->s_blocksize_bits - 9);
+		inode->i_blocks = (le32_to_cpu(copied.i_u.blocks_lo) |
+				   ((u64)le16_to_cpu(copied.i_nb.blocks_hi) << 32)) <<
+				  (sb->s_blocksize_bits - 9);
 	}
 
 	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
-- 
2.43.0


