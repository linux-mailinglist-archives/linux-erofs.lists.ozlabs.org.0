Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AF39ECF61
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 16:08:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y7f9h3jtqz30Ng
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 02:08:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733929686;
	cv=none; b=E3isNXVSo9wS6NSv4xrJYVGza20a92Imqaue59zeb5DrFtbfLx3mr9ju0lEKk9WHb8QAfr0xw+0m+l5ixXxCgr+EeUmu5CRKXkfkTMBdFjxzHw+5fa1tyrLMA0uJSk01e21pBSsUg0vhmYWupz7YyXjYcUI8bpu70tTUFBUuTsw2I0P+Zt/pQwGUAk7e0zmzrCTbZsxnf99vOnreH8mvQDRmbIj47vi27ib074+D0KIsy97NWKdvovntN/eUgUKrVsM+H/fQ2ZcAUrpBEfBvOh4Qlhin8QAFi0tD9cIV2CZe9Z5owAUbGwMugLNprxoIX0SUQnRFIFpP6JLraqgPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733929686; c=relaxed/relaxed;
	bh=uDLyuf94rwGpIVeGHgONreq7GaPj4bZQYkGW93MVCoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/Kvr4H08uu6HNxcUmTBIlTI+/uofu7ACgHlcFHujh4PrpRKS1YpAGApIneHR7FqM66TxRX+vO3hjpmZfvoWnw1HxeZeAQetlMqQ+BxLGJ2zgUNigWd1Bh7SXHPPUy64pbCF1cFiOCx4xCYAJquscEi6tIoDDFfPugl36SKmjRrzKnmPmLVvdnpO8Rg8/aFrplr3WUGR4Y8osl+oq2BwILvRqzgFm9OKGx1cXVZzEcrZpAc51hstRU4NMiNiH5oWuPXyVubZ2b2dk21G/S4I2Jjf6ByVLzhvMuSqoAckIUOmvrBY3YV+0dd4Fo4em5I9o9EalKbO1Oxssm4fqAN9ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OjLQUHkS; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=katexochen0@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OjLQUHkS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=katexochen0@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y7f9c251nz2xjM
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Dec 2024 02:08:03 +1100 (AEDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso65468675e9.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 11 Dec 2024 07:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733929676; x=1734534476; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uDLyuf94rwGpIVeGHgONreq7GaPj4bZQYkGW93MVCoE=;
        b=OjLQUHkSLRKgJkTpfLYqX0HWK9MZujtoYax6+MQmjh8mXmYjIy6V7uZuh9Ail2V1sh
         lc5jjQKBVk5nLemrv57otEq4KSuBIrwmRYyHq5+n8whPglnmy76E4by+bSrOafD/icJx
         7y7LwDJI7GqDZTuapITVPlcHpziqWd+XvvX8ihmp7r5/Y6lPfXVOaYxUuGEN7p7SxewD
         81TRaqmO6KwELEtodQk0C78+zaZd/JxDnlJgplO/+jhdrY0DB2eKlM1ABzvC+XnHkepB
         q3FIIkOL+1eCLz6RvDvaRmMJWQ2yqYYrSnERiAmPtPvBrx3suwyX0NBpIJ1+n0ozucZf
         ug5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733929676; x=1734534476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDLyuf94rwGpIVeGHgONreq7GaPj4bZQYkGW93MVCoE=;
        b=TOXIAqtu6PTLtk5RWJx7Sztvu/MqoBObmpj3tpQx7bTxQ6r0HKHHvrn+BuySQAmE/n
         QxZ2suxwl/bJbGBILGnuKEel1uXdP1OK6G1uBaAIEvYvIAb7/DV2AaJwkU/VFmSO3aZf
         2e1Fb26fyKIfLK6BPy7v51GfHVSb2erAsnLCYHJvbFFY6wgPk6vIDcz41TOHssluzluO
         j8v9HnCwCweiYXAP/YkmEgG21LNtyjzfwRp6OnlnBdqQ4E9mB0zqy1Yu2oRYiPXUUcZU
         Sc5OGZ2IPP/2wAoUupjfw98Q7i7X7yyeQCkh+T4A7YyKmvzPrRQ9sHWloADXH+5Tgeyn
         3dVA==
X-Gm-Message-State: AOJu0Yz6XgMU/N4HGsB3ywPcqirZcvQnzHlxPQZmB6LFGrnWMslCLbdj
	HeuOudBdnfCHgY9vXKc7kndLa60OtjmC3qATkX3B5OTigwDR5JFEGkIzgCha
X-Gm-Gg: ASbGncvGzosBFXCBPBYnEoNS51+XwTKAGjoFltFA6m+nfmifuoX4dkS8bJgZeEkiKND
	J62uzAre5Rtw4206quFaJattef5NFvYExZiYyZ7FeDPqA8tSOVdDFsE4IMTPWUgeDPwHGr7CKIJ
	lhI7OQTOb//LigV0417XgW0BSRTgQtQMm0hhNtE7mALLh2NlWod0wmporddY5GqyC/t28pQg3md
	12VxTcBLId26HSY8wqrxg5uSDUOBejNux5gry734G+q3d8nf6NNLLYdA6ANXT83nw==
X-Google-Smtp-Source: AGHT+IHG/6OH/jHA/7z/iTfobxnVwDaB6N6EkCblvsht0tKpu/OdpwOiRG5uX6Vvg5tBBppDj9zq8w==
X-Received: by 2002:a05:600c:3b94:b0:434:a94f:f8a9 with SMTP id 5b1f17b1804b1-4361c41972amr20082965e9.28.1733929676123;
        Wed, 11 Dec 2024 07:07:56 -0800 (PST)
Received: from np14s.fritz.box ([2a01:41e3:29b6:6000:f342:90f2:2782:5a95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361968eed5sm41517925e9.42.2024.12.11.07.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:07:55 -0800 (PST)
From: Paul Meyer <katexochen0@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: add --hardlink-dereference option
Date: Wed, 11 Dec 2024 16:07:34 +0100
Message-ID: <20241211150734.97830-1-katexochen0@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
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
Cc: Paul Meyer <katexochen0@gmail.com>, Leonard Cohnen <leonard.cohnen@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add option --hardlink-dereference to dereference hardlinks when
creating an image. Instead of reusing the inode, hardlinks are added
as separate inodes. This is useful for reproducible builds, when the
rootfs is space-optimized using hardlinks on some machines, but not on
others.

Co-authored-by: Leonard Cohnen <leonard.cohnen@gmail.com>
Signed-off-by: Paul Meyer <katexochen0@gmail.com>
---
 include/erofs/config.h | 1 +
 lib/inode.c            | 2 +-
 mkfs/main.c            | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index cff4cea..8399afb 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -58,6 +58,7 @@ struct erofs_configure {
 	bool c_extra_ea_name_prefixes;
 	bool c_xattr_name_filter;
 	bool c_ovlfs_strip;
+	bool c_hardlink_dereference;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/lib/inode.c b/lib/inode.c
index 7e5c581..5d181b3 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1141,7 +1141,7 @@ static struct erofs_inode *erofs_iget_from_srcpath(struct erofs_sb_info *sbi,
 	 * hard-link, just return it. Also don't lookup for directories
 	 * since hard-link directory isn't allowed.
 	 */
-	if (!S_ISDIR(st.st_mode)) {
+	if (!S_ISDIR(st.st_mode) && (!cfg.c_hardlink_dereference)) {
 		inode = erofs_iget(st.st_dev, st.st_ino);
 		if (inode)
 			return inode;
diff --git a/mkfs/main.c b/mkfs/main.c
index d422787..09e39f5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -85,6 +85,7 @@ static struct option long_options[] = {
 	{"mkfs-time", no_argument, NULL, 525},
 	{"all-time", no_argument, NULL, 526},
 	{"sort", required_argument, NULL, 527},
+	{"hardlink-dereference", no_argument, NULL, 528},
 	{0, 0, 0, 0},
 };
 
@@ -846,6 +847,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (!strcmp(optarg, "none"))
 				erofstar.try_no_reorder = true;
 			break;
+		case 528:
+			cfg.c_hardlink_dereference = true;
+			break;
 		case 'V':
 			version();
 			exit(0);
-- 
2.47.0

