Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7765349F292
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jan 2022 05:46:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JlQ072CmPz3bPR
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jan 2022 15:46:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=SQbyEUZV;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32d;
 helo=mail-wm1-x32d.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=SQbyEUZV; dkim-atps=neutral
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JlQ00245nz2yQC
 for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jan 2022 15:46:21 +1100 (AEDT)
Received: by mail-wm1-x32d.google.com with SMTP id
 d138-20020a1c1d90000000b0034e043aaac7so4712642wmd.5
 for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jan 2022 20:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IfSl3IFy9vgB26J4W9f9Ld7jQAnc+wEp6AK6RrYhUO4=;
 b=SQbyEUZVqv8C21JbaFOBO6CgA+Hplq52mX2BC3Z54RLkefcBT/Yt/T3iXQqBV8SG4y
 dEF0bYTBRUeMWZFGd1FzvcGfTO6FM5G0OmpVA8cvoclAAK1YstU+viW5i5XyZcSwjDbM
 4x0BdxTfoZrVtu1bldcDIfmFXUBLYpVj9FBWlSXMbKcx/IlSo0duQPrutw9ulIiE0ux4
 ruEg5eLdvfOSBRZ49zPPg4mWH1cpOZAkhXM11WTEgY+weUaJP7Azw15YXE9k6FaBowGg
 pSVsSiy+UOAQnt89LZzrPU3hB5jC3tLCtRtcrzVAmyWK0KKoCmwXY1CM3kcKrStb6y2q
 kySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IfSl3IFy9vgB26J4W9f9Ld7jQAnc+wEp6AK6RrYhUO4=;
 b=EU9pkDmFh88shP090N0Vem7gl13Z4MkG9QF4Zs1+aUm7FXFkA90YqGNr0GYvTjnI6F
 i5QJE+TE14WYHj+bl8fyr6glsQrUoV9xwzmYr5gk2I8EyuX2uQcG++Y4fHjEMRMWqKS7
 ukoI6IGKAD3nZEr1O5ZqUeVADsYhuZ26e8aQoIea0r1A6Z/Ng5/DE6j1knQDS23yPWu8
 z4wcBIJhoh6mARCJW1qCJaVppQ16KOmXYEJqzfLHud74NGrIhswALUBoW6+gEC4ABOEy
 qMWgJbpNVVFNY0yszwh+Jk3SiK3IM5BzvPNOmZW2SrV1zSzSaa8RTWANypGJ3CDLK04B
 wNwA==
X-Gm-Message-State: AOAM533yZ+NhTo4XQhk8oxllJNDLJa8BGrqJB2QPBv76Dro+Zi+ewFBe
 yZ3ysWjIn8wwIR15X8LjKzQyV4NWhp6QkA==
X-Google-Smtp-Source: ABdhPJwydEmgFkQqesRxwX5t5Yy2vUTOSchfcLQnmy2EO+AS/wVrHDRvuLlT2ZE+lHRYEREzT6dgZg==
X-Received: by 2002:a05:600c:6020:: with SMTP id
 az32mr5855968wmb.2.1643345177620; 
 Thu, 27 Jan 2022 20:46:17 -0800 (PST)
Received: from Iceberg-PC.localdomain ([185.110.110.225])
 by smtp.gmail.com with ESMTPSA id r13sm956335wmq.33.2022.01.27.20.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jan 2022 20:46:17 -0800 (PST)
From: Igor Ostapenko <igoreisberg@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck: fix issues related to --extract=X
Date: Fri, 28 Jan 2022 06:46:13 +0200
Message-Id: <20220128044613.26-1-igoreisberg@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YfNvloN0RAX0mHRn@B-P7TQMD6M-0146>
References: <YfNvloN0RAX0mHRn@B-P7TQMD6M-0146>
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
Cc: Igor Eisberg <igoreisberg@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Igor Eisberg <igoreisberg@gmail.com>

* Moved no_preserve_owner/no_preserve_perms to local scope.
* Added missing return -EINVAL.

Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>
---
 fsck/main.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 9080a66..2f13870 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -31,8 +31,6 @@ struct erofsfsck_cfg {
 	bool overwrite;
 	bool preserve_owner;
 	bool preserve_perms;
-	bool no_preserve_owner;
-	bool no_preserve_perms;
 };
 static struct erofsfsck_cfg fsckcfg;
 
@@ -97,6 +95,7 @@ static void erofsfsck_print_version(void)
 static int erofsfsck_parse_options_cfg(int argc, char **argv)
 {
 	int opt, ret;
+	bool no_preserve_owner = false, no_preserve_perms = false;
 
 	while ((opt = getopt_long(argc, argv, "Vd:p",
 				  long_options, NULL)) != -1) {
@@ -154,32 +153,28 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			fsckcfg.overwrite = true;
 			break;
 		case 6:
-			fsckcfg.preserve_owner = true;
-			fsckcfg.preserve_perms = true;
-			fsckcfg.no_preserve_owner = false;
-			fsckcfg.no_preserve_perms = false;
+			fsckcfg.preserve_owner = fsckcfg.preserve_perms = true;
+			no_preserve_owner = no_preserve_perms = false;
 			break;
 		case 7:
 			fsckcfg.preserve_owner = true;
-			fsckcfg.no_preserve_owner = false;
+			no_preserve_owner = false;
 			break;
 		case 8:
 			fsckcfg.preserve_perms = true;
-			fsckcfg.no_preserve_perms = false;
+			no_preserve_perms = false;
 			break;
 		case 9:
-			fsckcfg.no_preserve_owner = true;
-			fsckcfg.no_preserve_perms = true;
-			fsckcfg.preserve_owner = false;
-			fsckcfg.preserve_perms = false;
+			fsckcfg.preserve_owner = fsckcfg.preserve_perms = false;
+			no_preserve_owner = no_preserve_perms = true;
 			break;
 		case 10:
-			fsckcfg.no_preserve_owner = true;
 			fsckcfg.preserve_owner = false;
+			no_preserve_owner = true;
 			break;
 		case 11:
-			fsckcfg.no_preserve_perms = true;
 			fsckcfg.preserve_perms = false;
+			no_preserve_perms = true;
 			break;
 		default:
 			return -EINVAL;
@@ -192,13 +187,19 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			return -EINVAL;
 		}
 	} else {
-		if (fsckcfg.force)
+		if (fsckcfg.force) {
 			erofs_err("--force must be used together with --extract=X");
-		if (fsckcfg.overwrite)
+			return -EINVAL;
+		}
+		if (fsckcfg.overwrite) {
 			erofs_err("--overwrite must be used together with --extract=X");
+			return -EINVAL;
+		}
 		if (fsckcfg.preserve_owner || fsckcfg.preserve_perms ||
-			  fsckcfg.no_preserve_owner || fsckcfg.no_preserve_perms)
+			  fsckcfg.no_preserve_owner || fsckcfg.no_preserve_perms) {
 			erofs_err("--[no-]preserve[-owner/-perms] must be used together with --extract=X");
+			return -EINVAL;
+		}
 	}
 
 	if (optind >= argc)
-- 
2.30.2

