Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A45E9F04D4
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 07:33:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8fgG0n7nz3bM7
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 17:33:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.155.80.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734071624;
	cv=none; b=ncmJJxcMA0qGJ62/yf7ZZFaA/xNl2xO4Xa4QF9myeOH2vqjH90YBj+jj4zeovnGGfTY14vJtcrA0ab0rewYkpcr5MtA4KOxwMhlE+FGFUjrHuRzvqAOeVL38drxJXQj+aCuLG+gzYerIB7dVp6nng5k35q983yV+Y0tJmsSdeO9QD2BhHoIQOfNzHFFy4SczIPOMp211RvyIB5G/ercAqoLl57+0/ioAzPtZC5Zo0H2JChqrjl0Mgy6hDryCrguFf6nXI6T+BOx6q60bxKzYS6XnYlN06W8SifrLRj6F1EFVPXJXwxFMeDqliSalbc1xwaWmC9aUvUTyULlVHLWifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734071624; c=relaxed/relaxed;
	bh=rgkmKvltYJABjccgvOwrI8jK6v7c367g8gECsvvgdKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aluirkRbgI8qQnChuspQGXBbdrHV8NmsdbyoR8VxWgmvfTLOL1u+DDVDPYCkKFR6Qd0DdWQ7LnzW3VWEAXmXaplCFM1lroMbe/YTb06TSpZL6BH2tfElGorJPJUaYU4Bw0ZVqRPT/x4louR6iJ3qHDML1KLuIBzO4yuoORVWlwjZwf7iYgNHBsP7oFFe1w0fbuWJQ6yX1T0o+hKycXLHNKgAKh5zg1z6wwWNZy5yeUGZ3OVAPYQG6CxThBYm/BnyxXPD07zL8NDgZ9/LukZMzoEzmv1HzqZ6Gv9UhvbcCTu/Qrzq8/dFMJxXBXWhpP+2RG63zKrUocP9GPTNZHnU3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=deepin.org; dkim=pass (1024-bit key; unprotected) header.d=deepin.org header.i=@deepin.org header.a=rsa-sha256 header.s=ukjg2408 header.b=k6ugc5d2; dkim-atps=neutral; spf=pass (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=heyuming@deepin.org; receiver=lists.ozlabs.org) smtp.mailfrom=deepin.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=deepin.org header.i=@deepin.org header.a=rsa-sha256 header.s=ukjg2408 header.b=k6ugc5d2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=deepin.org (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=heyuming@deepin.org; receiver=lists.ozlabs.org)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8fg96jJ3z2yhM
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 17:33:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1734071577;
	bh=rgkmKvltYJABjccgvOwrI8jK6v7c367g8gECsvvgdKA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=k6ugc5d2KRnCp8Q7oqNdXoHBVuHhRINaoNCE3ovglLRjXNUFIMh+giHAH0GW49j/f
	 En8qZFzgixxaczzkNKVTFoIBZPHnQ2Hf2tbVPWrg49iTWg3t3FCEnFw4c7J6R5mtGc
	 wcKunI04vE8BEWNLxgRC1ydKSXXMgufVS4pZ4TO0=
X-QQ-mid: bizesmtp85t1734071574tz4ggok3
X-QQ-Originating-IP: lh5gcq4ISix5bu6PpG9nvXtuij1jl28rxAZuoyf7KuQ=
Received: from ComixHe.tail207ab.ts.net ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Dec 2024 14:32:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9534306071855275332
From: ComixHe <heyuming@deepin.org>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH] erofs-utils: lib: correct erofsfuse build script
Date: Fri, 13 Dec 2024 14:32:50 +0800
Message-ID: <8725A28257A20420+20241213063250.314786-1-heyuming@deepin.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:deepin.org:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: MACXe2l6e7j9vsyjk6G9u6wToeghqP7beuyn4FD85DklItZa9eDmHBxd
	tyJa+1ZxJkfnbjdd9+IGThLU5wn+3x/iT5s+O6IwdZEGqLl0O4sNIq0ltzTfiygeKh4djxF
	ytpAszLsIMKa71NlHEfqwuGp3CUEHrJeglj08xAqBcq6drmT/R0dP/2KrA9DSCjcGYnV/T4
	9koL1BX7flRc2dmW6M8RVKVJSMgdL4yB60ggbQhSlYlA66Oa1QZREvjpd9IZE4cDg8UPLc5
	3zIAsPupYOn88aXVG0UBvazMbouPfO37hsRaWRaLU6Eo2b5K+7coYD+GfOCt7+tCGfiRW18
	pZdzvoaChJnb3U3KMyrcidQyS6HDw65CFYh9D3uXRdguO8o3SrEgKGXRF6UsmdAg2US+rsU
	Iu4QHH1SQjM2rEmb4GbJy+s/xmDr6jFahjBfUKWwy2a5Ls3DynFpPG7UucBxmYWOz5jYSZn
	U2YLC2fwieQenBSKQ1r+wq+M4Py/TInaCSM9J7zlhvrx47aC0RG9RwfYRLLiadZOdYFu9I7
	4/ZmaMdttXjRNhvPGBoe38YBd5NRk3MHqBQOY6kTkXSsqCnzxO7I8FPZGOGYFqEhyt+N72w
	FjcMtfkNrAG5jsj3Hzew5WjiHGzhdCPzAf+pimhOC7MKDAm2dcBOxUyHuq64OpqImR9aGaB
	9Zjhic3Cad/VqIHqGrbhA8Xo7p9xrTCZpKvA0VmYByRsx/7AF1vUBx0kV1/aCzfWqaI/VdH
	yLzaV64+NAEhtPc0WCKPNW6HMI0duXJm7nHVr1IAH0DoqKLY2C/8ex/mabpPzvQTRJXfS2k
	pjJJn5APGpjVSJZXUmiD+X3dEM458mN9G3HpKg0ynEXLTMNF4FY44xQYv9GYgYdryvg8F2W
	7X7LECylpwuxO62CvTTqxFizDkhIJJ8uv91Rl2nN1H0=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
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
Cc: ComixHe <heyuming@deepin.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Some of the symbols required by erofsfuse are provided by liberofs.
When option 'enable-static-fuse' is set, all these object file should be
exported to liberofsfuse.a

Signed-off-by: ComixHe <heyuming@deepin.org>
---
 fuse/Makefile.am | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 1062b73..50186da 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -11,9 +11,9 @@ erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LI
 	${libqpl_LIBS}
 
 if ENABLE_STATIC_FUSE
-lib_LIBRARIES = liberofsfuse.a
-liberofsfuse_a_SOURCES = main.c
-liberofsfuse_a_CFLAGS  = -Wall -I$(top_srcdir)/include
-liberofsfuse_a_CFLAGS += -Dmain=erofsfuse_main ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
-liberofsfuse_a_LIBADD  = $(top_builddir)/lib/liberofs.la
+lib_LTLIBRARIES = liberofsfuse.la
+liberofsfuse_la_SOURCES = main.c
+liberofsfuse_la_CFLAGS  = -Wall -I$(top_srcdir)/include
+liberofsfuse_la_CFLAGS += -Dmain=erofsfuse_main ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
+liberofsfuse_la_LIBADD  = $(top_builddir)/lib/liberofs.la
 endif
-- 
2.47.1

