Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA13967471
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 05:31:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725161511;
	bh=oPDsSxeZiFfDMglVB7cWzWHmjfKoR3Y/Eh3c0qkQ9jo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=lWjEUyrJIJDXhyTUXdBfDjStLQAaCak6doB54BqcueJCge04823Peinzgwj00dD9s
	 TJlJw4+bg0z6dhul52jTp5vC2ZXJEiljOoOfYe9ipQ9dCKMrb5GDfTy+1Li+RKGvu+
	 Dgv8OkT3DYeR9lNxtQSAmnRDH3PXhmwromD9ZkZ3Eue+g0B943HxMPWCdSJsvPeJ4t
	 de6a9XwF2ZSZKunmMguOHMRm0Jxssh5v81NV1CQGnQVOy2vEtmrNZudGqZCnQcPfBq
	 ugIU1txwi6KRkdAbZe4Qsc1wx50zOIxBmk+ap07UGEjPoNcdgxNH2nWG7Xi8itd34e
	 Pd6mYj8+CLrEA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxHVv3w9Vz2yjg
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 13:31:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.235
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725161509;
	cv=none; b=QTZQR0vC3x3pmjQ9ROcgj36RiMnmjsf+UUscaTjIVJqIDjG2KrDQSBBJlqN+NiQyIQgnDfHquuM0tkzSfYAGZomisfxDCVkKObxDOVGX6fFuHLWKwIEuArKar4mOkbtKp25DYg4RJ7uzb/pOlG5NVHDbXBXQP4aHKznmXQAR4ki2XjedY5Nb2QvUJNSjDdKRxkOgib1baaibnUoiLxwe+BVuR07nFg51ZW4NGjKSSfwyaRUlRsbuiqgrefu7GGsc0hW/irZ/UdVyncOayy9x5FCJCUNz+pdURa+mHH0Vx/ET5P5Xtl+MFNjmC3u/8oL9kVTvIkC1qCuKmZJRKuTKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725161509; c=relaxed/relaxed;
	bh=oPDsSxeZiFfDMglVB7cWzWHmjfKoR3Y/Eh3c0qkQ9jo=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=lb6dJbXQV5YsUs3Npj/YwNwZR2L1d+N/5u2CGxdlpe73KK03TjKmy6k05uEH3jLFcPnXqUKav2dBDXtYoRirBh++j0guEVkA6NbXgCslE2l85gGxVhTkeYoFqrF2T9kvxAFtOHhz7qQqISBDAtERAwTsffhm11wBOl1xmC7it8Xraj9a+JnY96CjXOtAlICb3oClj45H8oVoRKa13X+1mCKTOzR25UQepbYR3S7Ln1cjR75gSHRvJ2tZPH04Q+GylGdIZwnnB70jUapyEAAqAl198DBzo1/3+eUdt0LUPSB6gpzxFE5WiXsV8PXjxNH7tsfQ14kiEnO6YmUEhjtJaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=VOJaSN9o; dkim-atps=neutral; spf=pass (client-ip=203.205.221.235; helo=out203-205-221-235.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=VOJaSN9o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.235; helo=out203-205-221-235.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4WxHVr4y8fz2y7K
	for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2024 13:31:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725161506; bh=oPDsSxeZiFfDMglVB7cWzWHmjfKoR3Y/Eh3c0qkQ9jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VOJaSN9oHqJGkKi6k9GQ0bXDNiyaSt+aTXK8CgP2s5QrdbGcglrbm8Wb1g5SEFh2j
	 5cGfsavBItHKC9KeEL43QefQRMYAkYBl+ST8Glsg5u0ckagQHF3hFURukSm6Yb6X4Z
	 3pAbvNqvEbJOJKIEo3zGKDZF35H5J51TvuiV5+4A=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 79AB0611; Sun, 01 Sep 2024 11:30:26 +0800
X-QQ-mid: xmsmtpt1725161441tunc4r4oh
Message-ID: <tencent_010056857A469CA68421701EEE3642B22F05@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2BPAy5uVX1GQDGX/c8iEatXFtr8uRG++tTTY4+GyNmMbwEQzno4
	 MLdpppivfxsYY0O/cCmFy1IRXNVQzS2xtu1e3+saJVuYvmIga7KIjsCfc4furdAmk4UZAfd7nfwT
	 Gjd/LZbY/8wpnuEmxDnc3JO9FqWn9FfenBFc/reC8+9fOmJ9lu6YEY2KVRtXXoAX8JTR9WuuwkU6
	 Bj+7yyIToTXPTCvIyao+Ef1ezG7xkppMEwdFECskwl0A9DZ8IdeGcuEDBD1YM0Ziy3Gw/ElxWBht
	 0J/AkHTbr/HwscQRc8MIC+xIG87+tHnZ03RWPp2qUR/HBltM/7Hb2A8ggWH4M3jh581+XequexqV
	 DLPcKiXehCe1fSD5kj2pwtlLh/DAI4Ca5cimGJa2SXgVgAJx6XRkyc92UaVTO+7uQe/c28iQ6Dtw
	 jcrhwX6E/d7FSpetGSGUnVBs48wz8cL4bboRDQzNy1aXA2JChJYvv5VJ2qfYnDXy6kfvVRHUuzuZ
	 n8v19YYNygxzAANH0SPF3QM4G1aTgV/O53Wq0qp6X1eMBSkPdVVfWFnVuaw45qgvODNKfPxVi1qu
	 XLAQGZEOLqhhh8+OOLANvd5zp5wfIjfRqGY3YP4nevkYHjGIQH+TAu7hq4OAf5+VV51zfABY+Q4s
	 XA/Gjr9NxrPSSiOx479O+2E5acN2SpmDXClY9SJpG/5U1vui/L5O+MHH7/Am2oIolB//nfY9lLbo
	 BbD6U1lONbBsmBcHHe4I8xRtDdGSoNO1Lm4AK0goja6s/NH50rCNQYiVZDgq+Sihe3DmweHDDgIl
	 wSEaBMvB6Mmgk8iKGKgDH8FTzdUyDkU6gYAw6t78V8Bni9/ffpX+dNIjGrQXH7777iD4dbuJkdEM
	 X412MuMY1sLNpqV1XtJhL082cZf4qRkuzVsltPs5qiHxBT/Ck3rknhULYxyr583MTeco4UaFYlTI
	 YbhHGc2kwDxTbTDgfzmZoN3buPU4y2Csf9cv/lb9LRTaOflTDR//G7UIZ0sWF2zjoJt/R43f0AMp
	 E002aNZ1+R8YvvWvC1uDNQXB4MRNdZIZDmtC45riZ27STR72+z
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/4] erofs-utils: tests: change makefile.am to support fssum
Date: Sun,  1 Sep 2024 11:30:21 +0800
X-OQ-MSGID: <20240901033021.2124850-4-kyr1ewang@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901033021.2124850-1-kyr1ewang@qq.com>
References: <20240901033021.2124850-1-kyr1ewang@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
From: Jiawei Wang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jiawei Wang <kyr1ewang@qq.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch make some changes to Makefile.am to support fssum.

Signed-off-by: Jiawei Wang <kyr1ewang@qq.com>
---
 fsck/Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 5bdee4d..b7f0289 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -4,7 +4,8 @@
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = fsck.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
-fsck_erofs_SOURCES = main.c
+noinst_HEADERS = fssum.h
+fsck_erofs_SOURCES = main.c fssum.c
 fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-- 
2.34.1

