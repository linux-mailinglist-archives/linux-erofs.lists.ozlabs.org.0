Return-Path: <linux-erofs+bounces-160-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D95A80224
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Apr 2025 13:45:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZX44z4jP9z309v;
	Tue,  8 Apr 2025 21:45:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744112707;
	cv=none; b=lRevpbGkL6BN7xrxWjZQK+SuFPkXkgNFTA+TxNoZHs35snqn28vyz+GsPsPB+apeWe2ifzsmWT+gmbvb+NKTYB1jNSIJA9fcyUFlRnEiTMFN4pbTcTOdEylgik9Qz+fHyO7ybNrZLVLPrpey6JTX+iLg2gCnONsrMS/S1tSKeXktMb9EaU2jU2bx8bp3yHCpsVd3O5lpTblHwZcGEgJpa2VotE0IBPdXFpI1A5FlVmuGG7gQWz8XUIfhhJw4aGYDMFadyA7I0K69TRHblPK/EzMZ3MYJdldt7jOAo6MzUa1Z0FgAVvPtGLnKhFQVbCgs0V7SPc+06IIB7eV6Gwt5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744112707; c=relaxed/relaxed;
	bh=2go647+k6sJue3+Dqabd8fg47Qz+7QMamqrKoll0NkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbvRxn/Hsv/9iG8I4Fg7M3h4CV5lRaYEx43e6u2ufM/DwbEayQvkY3jocdutKeuPb/f1wurrNOOuB8SU1BVHcpIae9rtSK4oGilYXDfgHKzwhZMCeVhE6lo7yGd3HURvNXxXKI0ql6IoKQGLEEdgVqBPWw21RijxxJ9d41MvAZvhsBXk7f+MYOjOSGn1GGSfQREoF9B5YtyVbdkgTv8oQefYLah7ocKmxLShhLZdI9h5NmUIQtDhEi2CB5NBNdMPnOmpmBRWhzsX6TGTKnjaDfQKThJxK1eODPb6lvw1ssiOxyt+1J3JL0nDgRbtKur4x7yeVLDUnN20OWz4+velvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AIBNJgPM; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AIBNJgPM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZX44v738Vz305v
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Apr 2025 21:45:02 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744112698; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=2go647+k6sJue3+Dqabd8fg47Qz+7QMamqrKoll0NkY=;
	b=AIBNJgPMaJRZ93itmRqBhd7ohVDpWKpRTKelP9OlftbBFY0Ge39SKlXSCw1nWr3yDmRUcwvWUwWPO9PZHBaTeFi/dRjxSl/VbKRC2cOpLQAddNIdtg9ydB9/KNvGxHcf+XDjwq55VlcqefdImPtLIpDT/Fq5eN6OD6Ve8fKvzeU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWFISVn_1744112694 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 19:44:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: fix encoded extents handling
Date: Tue,  8 Apr 2025 19:44:48 +0800
Message-ID: <20250408114448.4040220-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250408114448.4040220-1-hsiangkao@linux.alibaba.com>
References: <20250408114448.4040220-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

 - The MSB 32 bits of `z_fragmentoff` are available only in extent
records of size >= 8B.

 - Use round_down() to calculate `lstart` as well as increase `pos`
   correspondingly for extent records of size == 8B.

Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 8de50df05dfe..14ea47f954f5 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -559,7 +559,8 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 			pos += sizeof(__le64);
 			lstart = 0;
 		} else {
-			lstart = map->m_la >> vi->z_lclusterbits;
+			lstart = round_down(map->m_la, 1 << vi->z_lclusterbits);
+			pos += (lstart >> vi->z_lclusterbits) * recsz;
 			pa = EROFS_NULL_ADDR;
 		}
 
@@ -614,7 +615,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 		if (last && (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
 			map->m_flags |= EROFS_MAP_MAPPED | EROFS_MAP_FRAGMENT;
 			vi->z_fragmentoff = map->m_plen;
-			if (recsz >= offsetof(struct z_erofs_extent, pstart_lo))
+			if (recsz > offsetof(struct z_erofs_extent, pstart_lo))
 				vi->z_fragmentoff |= map->m_pa << 32;
 		} else if (map->m_plen) {
 			map->m_flags |= EROFS_MAP_MAPPED |
-- 
2.43.5


