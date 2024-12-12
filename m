Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389609EE81E
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 14:57:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8DYG2bVPz30dx
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 00:57:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734011824;
	cv=none; b=euwwE1Wti341UwdNHIZytgfSeT6T/TSfCh51nowr5ul7MrEpg7Db/VZ2KN2iy4rtLc6zYtJDgVxg/cHb7kuQA4pHHlucqj5pF+ifuhPeOGwxK+5ujW2VFZIuY0l4/NAeBVTMvpk7k29S3xypYSB4+H20B+raxHu+HKtOfE2/JWTk11BQy/FjEeDxpSFN1WzHYzlL5mGESFsjvJS+xd2pPMn0sq2+QKNmw2qxogJJSAF3QnyS79coz/hclIFDuWJNvUFefeoZwZnzxj7hYwC7/BwKMWgsmaPFkMo9RXQFCcrSaSVsER2jgC1TJvcTHxDvO4i32qvYIwYxVpKRRDVcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734011824; c=relaxed/relaxed;
	bh=uAL1FryeYhL6RhKycgj/HN+k34pTb9b0bSiI+dpg/Io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZPjEfmL2adbuU0a0tr7Mg8OcXhtLLlJ7QOM4Om6Dcr+8CPPJmqQ08VLF88GebYPtNlBbIpavtiizlQwV1+Ef2357mO6Dsln7AxOqesTnuqGj/eRsnIfv1Mkx7TjIhyxmlcGE/822HfkktdR/c8aYIOb5SnKe2+Ya08faEevKJJh8KmTLjfBJJik/88PC2eBs29nJP2QLdWKeoUJ3TTER9Oox/Lpj6WpybnVucTHU4Rs62dE6Lm+rxi7tbNlQe+ymLIXQBqY9bxWEQiKuUkZHNvOF+WjsVhrFMky0SS4Wt49FQj1m+d/V4S04Eepri8QzXTUmN7cc2OZsQh/ljR61w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IHRRF/9d; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=katexochen0@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IHRRF/9d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=katexochen0@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8DYC3JXwz306d
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 00:57:03 +1100 (AEDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5d2726c0d45so1119433a12.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 12 Dec 2024 05:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734011817; x=1734616617; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uAL1FryeYhL6RhKycgj/HN+k34pTb9b0bSiI+dpg/Io=;
        b=IHRRF/9dy3jKj0EUBX8pu5Vt6bz8comYDffcDxCGDgcuGznVv0NYgUF/lQbaD3Oomo
         uDQB/W19k174r+LhDf2F9szGT8wxbqB5yLa5A/XYHQ6sfp2YE3nxRPnO90xWZNb4j1rM
         NHm0xvpAvf39SuU6PupF4KllyoY+XamEQyU6QklKKNSd8xseCQ8ZoDqQtxedKZWRInNS
         KNb9e6hq05VRVeKn2yplt8jvLzTpdoCpvC/PrB8W74Qz3V8EN5g37e4+/4NXu+PTlh17
         aKIYafbdMkAwseJjaM7q6ftWEnR+4qIFb6pzhX0m9JwgvvYXM+1qjc15NlIx5yw3rN1c
         0l/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734011817; x=1734616617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAL1FryeYhL6RhKycgj/HN+k34pTb9b0bSiI+dpg/Io=;
        b=AtzKQ0vIyd9xkRo7rfh87A6vN2x+vcNVkE+r/F7x+Y1oRiP+mv3SKuD6/MfkXAOd6v
         dy+7mZraXggaaXveL9XUp3SR3fwCbC3tkSslGHyI44D3DuNVRAkm7q6pWeZGvw/uAJlm
         PTHE7H+TAbTaEtma+PlQKGKX+qGQB+Uprmmf/jTHqeJ/5kCE3JO9X4SJcMHwhXqTase5
         X4okZPl0cs/zE4A2TWtu0vtCBhoygE+F8wa/TP1bAoodvlrnNEzbD8InPAtSl4aBtsbN
         KnBFL76l/jvMzosnWMyF0SnNyBPD0pKrPiPINsW0+/YVMXHeRUjB38D4qKghD+Aq7ypo
         PpCQ==
X-Gm-Message-State: AOJu0YzQ0lavm07lUr6iGhIoC0cS1ghVeWMF5x8yw5qNG3k/Fal7rRiE
	MsGteEl23mFzl63ddpKkbOQ2Snkg+6GzUYnQffEJMeiiGbFnabZugvOvLpXF
X-Gm-Gg: ASbGncuv5CEEGUmsqUgHmS6B4HRWlEbbFc+pfayeR1zLKDIZhFmUPGLuXlaVgoIn/4W
	Tz9HN99m2lID5UVRR5qQVJw5KFSuybXtQ2JKwzVajwzIXphp4SUw7aJh4jkVk6QOAebGVWFCFPb
	W9+pxZHl7o9z+GQru/6VnjGPx5QAZT/JzIPFskHsaMDGV30h2pgtswIC1RUCgDdLAHee4xd63md
	b/JYL2fzAk0OWqWfxKe1PBxEmSdvEUe7wdZVP1SCdKjDx7aoZpTqG5npl2Pz3GZDhKw
X-Google-Smtp-Source: AGHT+IG3MT1J4W1SoVsTf8cy9IDLBJ4SEuiZZy0YRsb6y+kp89jUB5EqVbWjnNAY7VKsTDo+1fLNpA==
X-Received: by 2002:a17:906:1db1:b0:aa6:4a5b:b729 with SMTP id a640c23a62f3a-aa6b11ead86mr626948766b.33.1734011816741;
        Thu, 12 Dec 2024 05:56:56 -0800 (PST)
Received: from np14s.fritz.box ([2a01:41e3:29fd:6800:c136:e024:bd3c:259c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa658614e26sm810115366b.100.2024.12.12.05.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:56:56 -0800 (PST)
From: Paul Meyer <katexochen0@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: add --hardlink-dereference option
Date: Thu, 12 Dec 2024 14:56:03 +0100
Message-ID: <20241212135630.15811-1-katexochen0@gmail.com>
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

v1: https://lore.kernel.org/all/20241211150734.97830-1-katexochen0@gmail.com/
change since v1:
 - rename option to --hard-dereference
 - add usage

 include/erofs/config.h | 1 +
 lib/inode.c            | 2 +-
 mkfs/main.c            | 5 +++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index cff4cea..bb03e70 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -58,6 +58,7 @@ struct erofs_configure {
 	bool c_extra_ea_name_prefixes;
 	bool c_xattr_name_filter;
 	bool c_ovlfs_strip;
+	bool c_hard_dereference;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/lib/inode.c b/lib/inode.c
index 7e5c581..0404a8d 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1141,7 +1141,7 @@ static struct erofs_inode *erofs_iget_from_srcpath(struct erofs_sb_info *sbi,
 	 * hard-link, just return it. Also don't lookup for directories
 	 * since hard-link directory isn't allowed.
 	 */
-	if (!S_ISDIR(st.st_mode)) {
+	if (!S_ISDIR(st.st_mode) && (!cfg.c_hard_dereference)) {
 		inode = erofs_iget(st.st_dev, st.st_ino);
 		if (inode)
 			return inode;
diff --git a/mkfs/main.c b/mkfs/main.c
index d422787..7eb86f5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -85,6 +85,7 @@ static struct option long_options[] = {
 	{"mkfs-time", no_argument, NULL, 525},
 	{"all-time", no_argument, NULL, 526},
 	{"sort", required_argument, NULL, 527},
+	{"hard-dereference", no_argument, NULL, 528},
 	{0, 0, 0, 0},
 };
 
@@ -214,6 +215,7 @@ static void usage(int argc, char **argv)
 #ifdef EROFS_MT_ENABLED
 		, erofs_get_available_processors() /* --workers= */
 #endif
+		" --hard-dereference    dereference hardlinks, add links as separate inodes\n"
 	);
 }
 
@@ -846,6 +848,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (!strcmp(optarg, "none"))
 				erofstar.try_no_reorder = true;
 			break;
+		case 528:
+			cfg.c_hard_dereference = true;
+			break;
 		case 'V':
 			version();
 			exit(0);
-- 
2.47.0

