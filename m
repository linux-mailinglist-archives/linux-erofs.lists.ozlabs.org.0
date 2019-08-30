Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F627A3487
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 11:57:00 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KZdP4ZQBzDr3S
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 19:56:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lSZRzawc"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KZdH6t1xzDr2j
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 19:56:49 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id o13so3284900pgp.12
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 02:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=6/TpWOxycK339vhmQQxRey5svz2q6FKJZFsDs0FbtbE=;
 b=lSZRzawc9YXdT75P8dh7crJ6Z47mml87kaxgsVa64YFWd2Uhhe8kSnSE4z9mF2UFXW
 uIh1gKPpxZE8J9Af9gNiBbDgRHFRTR0g/WZt1Lz8kGYCYyMob1EzLLZ/bO66pTjgeovC
 lHw1tjwQWCfullMi7Ue5yX4s9dfhj2C+WnGejuaOM1DEmBp/IS0Z/059bugWFHD4dMZU
 LFm5+e6DnovFNSgtO7TzJHsEaQmhLCsswB++qFqgavGXIrf817mFaGpK/BnokUBB4Kyt
 0iaBbeO9X1GVqCXKOkQAj2ImIPRzBgcuQxq70OM3B8NugNYCPbXHKkHHFbIq3PCwat9R
 Apdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6/TpWOxycK339vhmQQxRey5svz2q6FKJZFsDs0FbtbE=;
 b=AyyVYgstkN8I4WN+iWNsl9Nwruz8TSmC2G7SdbO2rQ9lI06wPqYT3vbwB2qrRyZjV2
 1frMaS464bhwbwjxkObtMolk0Xxey2Mfu3QruZQvJlXSKdB6wxSCAcIlvGHi9yju4P8m
 mqu38zwaTdXnaso9c1cakwqEAd3Ci9tB4+1uU2tX/VQWnI3HAcUlTyDuGutfoTcQXoe9
 sx1GNO/FfNLapu1p6d3W+UOYaaYahtUMkO/0XM2RochvTp3aZMUCFpUmdLbqAEtg/w/c
 VxvdA4s9FV3JUkl5YLM4HrTErcaJr/V/UOya3i6ts1aRqPT1bHVVoVMibPFPxWqhgxOs
 rqyg==
X-Gm-Message-State: APjAAAVW2Ss9HNFeVHxIXuYCzlcEvd75NjAXMzxuDSSKln2XSTv7J7jC
 02wEVCLrYfExAqKSJsriABQEUHEUIrmQbA==
X-Google-Smtp-Source: APXvYqwCNbBxQFvSYtI71czk/W0eMQLf6UKu4OCvs/HJ2vx4FWUDNfeYaz9WrHo8YM19hDXUAPPJ0g==
X-Received: by 2002:aa7:8a47:: with SMTP id n7mr17898071pfa.182.1567159005718; 
 Fri, 30 Aug 2019 02:56:45 -0700 (PDT)
Received: from localhost.localdomain ([42.107.64.5])
 by smtp.gmail.com with ESMTPSA id o3sm19501196pje.1.2019.08.30.02.56.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Aug 2019 02:56:44 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	gaoxiang25@huawei.com,
	yuchao0@huawei.com
Subject: [PATCH] erofs: using switch-case while checking the inode type.
Date: Fri, 30 Aug 2019 15:26:15 +0530
Message-Id: <20190830095615.10995-1-pratikshinde320@gmail.com>
X-Mailer: git-send-email 2.9.3
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

while filling the linux inode, using switch-case statement to check
the type of inode.
switch-case statement looks more clean here.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 fs/erofs/inode.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 80f4fe9..6336cc1 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -190,22 +190,28 @@ static int fill_inode(struct inode *inode, int isdir)
 	err = read_inode(inode, data + ofs);
 	if (!err) {
 		/* setup the new inode */
-		if (S_ISREG(inode->i_mode)) {
+		switch (inode->i_mode & S_IFMT) {
+		case S_IFREG:
 			inode->i_op = &erofs_generic_iops;
 			inode->i_fop = &generic_ro_fops;
-		} else if (S_ISDIR(inode->i_mode)) {
+			break;
+		case S_IFDIR:
 			inode->i_op = &erofs_dir_iops;
 			inode->i_fop = &erofs_dir_fops;
-		} else if (S_ISLNK(inode->i_mode)) {
+			break;
+		case S_IFLNK:
 			/* by default, page_get_link is used for symlink */
 			inode->i_op = &erofs_symlink_iops;
 			inode_nohighmem(inode);
-		} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
-			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+			break;
+		case S_IFCHR:
+		case S_IFBLK:
+		case S_IFIFO:
+		case S_IFSOCK:
 			inode->i_op = &erofs_generic_iops;
 			init_special_inode(inode, inode->i_mode, inode->i_rdev);
 			goto out_unlock;
-		} else {
+		default:
 			err = -EFSCORRUPTED;
 			goto out_unlock;
 		}
-- 
2.9.3

