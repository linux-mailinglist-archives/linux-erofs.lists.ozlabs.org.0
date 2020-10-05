Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3822830E0
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Oct 2020 09:32:04 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C4XNd26JmzDqGW
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Oct 2020 18:32:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mykernel.net (client-ip=163.53.93.243;
 helo=sender2-op-o12.zoho.com.cn; envelope-from=cgxu519@mykernel.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mykernel.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=mykernel.net header.i=cgxu519@mykernel.net
 header.a=rsa-sha256 header.s=zohomail header.b=TIfsumYy; 
 dkim-atps=neutral
X-Greylist: delayed 928 seconds by postgrey-1.36 at bilbo;
 Mon, 05 Oct 2020 18:31:50 AEDT
Received: from sender2-op-o12.zoho.com.cn (sender2-op-o12.zoho.com.cn
 [163.53.93.243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C4XNQ23d1zDqFY
 for <linux-erofs@lists.ozlabs.org>; Mon,  5 Oct 2020 18:31:46 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1601882166; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=CkTn9az3Qk8KS1/eFSxngRDs7m3P0dj6XGBpm4VwWz1/4TP3xn0Hpl5RgvBOdMwTv6ZnirrZm08KABwNagnbTriVRmJMzho6PAJSmYZELL8tc94kZ9zUGT6DNRMsgbJQqv6h6AZ45GmoMGkJy7mgfX8sFE5eHK9cQFEmPiYY2hY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1601882166;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To;
 bh=1t0NFyvHXnuE38Ag5hVgN66ANa2MI0MONrLwSKRfZGc=; 
 b=LHfrHnAaNAH+7wWvJJ7WFevyFK4juhQQVD4jYpzZsitoZDZ0rgpKg+ialOwU2cS8AHggzSE2FvROkGYTC5lrePoaNKzSYnFYc7b+gb5PQHBW3Zx+cqmGtfy73cQUGse6xNTJ0ZJuu8t3sCM6/j4e2lkN6mjpaal/tmazD9JQCcc=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=mykernel.net;
 spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
 dmarc=pass header.from=<cgxu519@mykernel.net>
 header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1601882166; 
 s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
 h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
 bh=1t0NFyvHXnuE38Ag5hVgN66ANa2MI0MONrLwSKRfZGc=;
 b=TIfsumYyNzPtD+Docwi1vVZ3mSrPeJ+7tUV16e9I4RoPM65WqW4gctnoxqUa0pkx
 8Rk9XeTPn0ccef5DuIiRleQQ3ZLRfH0Kt5FEcyFg8JhtRuqZQytL2yT0u2pwJFmPb+y
 RO8ubRAR2ZS64UDzn1LPqgRgfp3LY1/Urtgv2kWI=
Received: from localhost.localdomain (113.87.90.58 [113.87.90.58]) by
 mx.zoho.com.cn with SMTPS id 160188216368511.498811694850588;
 Mon, 5 Oct 2020 15:16:03 +0800 (CST)
From: Chengguang Xu <cgxu519@mykernel.net>
To: xiang@kernel.org,
	chao@kernel.org
Message-ID: <20201005071550.66193-1-cgxu519@mykernel.net>
Subject: [PATCH] erofs: remove unnecessary enum entries
Date: Mon,  5 Oct 2020 15:15:50 +0800
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
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
Cc: Chengguang Xu <cgxu519@mykernel.net>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Opt_nouser_xattr and Opt_noacl are useless, so just remove them.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/erofs/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index ddaa516c008a..b9a09806512a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -211,9 +211,7 @@ static void erofs_default_options(struct erofs_fs_conte=
xt *ctx)
=20
 enum {
 =09Opt_user_xattr,
-=09Opt_nouser_xattr,
 =09Opt_acl,
-=09Opt_noacl,
 =09Opt_cache_strategy,
 =09Opt_err
 };
--=20
2.26.2


