Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C842A4865E
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Feb 2025 18:16:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z3dKY2y9Mz3bsJ
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Feb 2025 04:16:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740676576;
	cv=none; b=nTdx+aEKd1K4Ig8s/lEA9CWJHjY9QGrxPZxbanlg4Rxr05ECRzkp1YzefAZ8xgW6SZuLiJAh7Pr+48YxFj1POfiEOwjHMNGFi3UR3Tr4hFIHJNptIMzDpMlBQKMLozvYQPXIY86cbVfa+dBZlG1SfC5kMeLnucUZke09gXOUx5xke4A8o3goz7pVj8OdgIlni0SYkEnz067qILVNh4nCsjGM+TlOgRla4xWDGqFTqlkLNenZcGg/rNxtCq6r0dHn1zy4B/L+YKb0z3CX6PK8IVa8msTWmvLuL6xcbBSsHRH3fg/vnNhPNPlMJcruYjQzmhqOIi4dNSRkj6SrAdHUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740676576; c=relaxed/relaxed;
	bh=RrLTKQIX7po87yKsUT7fPHwJvDgKbctMdN6h/IdBmdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fDXDzTCeX73bmhrwMQ0Q286mrHwLJiANO7CLdM5HrG5FaYNOLib5mPwh1LkjPslFkPXFTPkIkpEBqXNbbZUXlNVtD2dclUU6KhFdiT3NBWfjrTiTwmwqwda+ueHAuZDb/+9OVKL7NOvPZWzExpTV8scM8jMpzJrlODHGS0HhDeUdr4wzWDHsUNuiIwxT5l9RTLJqfgNR930NlV3FUkkF1hadGWICW+ZBefLm+kxAV+FbtgnG8O1dBtJouv9wttOsYNAMFtP9ff7aC96i6i80YwtO9Fat8ezDxt2pMf88umxf+sB1DFHBtSdRGH/wkhCTwIHZKOAZyKd53RVZ/HPP0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vpWowd8I; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vpWowd8I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z3dKS53Qfz2xPc
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Feb 2025 04:16:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740676566; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=RrLTKQIX7po87yKsUT7fPHwJvDgKbctMdN6h/IdBmdI=;
	b=vpWowd8IN56IVkMMEbg77IEqgOR7ADOm+WHoDsH8wrHzFZn5EDlNg6OOO50qPwnfKhiR3jQFWDQ9pYovB/9bMunMLnjyMH+d9V3uiaKNxx9+GKPrNaLZOWjoxAQKjaa0zLLSrV2Dzj669ta8HAwaGcKDMsjxv9LDgKbMNaIlmX0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQMpfu7_1740676558 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 01:16:03 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: tar: handle empty filenames correctly
Date: Fri, 28 Feb 2025 01:15:57 +0800
Message-ID: <20250227171557.3368310-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Tar entries with empty filenames are unusual but shouldn’t
cause a crash.  Handle this by following `tar` behavior:
substitute `.` for the empty filenames.

Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/tar.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 2ea3858..0f21a60 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -826,8 +826,13 @@ out_eot:
 		memcpy(path + j, th->name, sizeof(th->name));
 		path[j + sizeof(th->name)] = '\0';
 		j = strlen(path);
-		while (path[j - 1] == '/')
-			path[--j] = '\0';
+		if (__erofs_unlikely(!j)) {
+			path[0] = '.';
+			path[1] = '\0';
+		} else {
+			while (path[j - 1] == '/')
+				path[--j] = '\0';
+		}
 	}
 
 	dataoff = tar->offset;
-- 
2.43.5

