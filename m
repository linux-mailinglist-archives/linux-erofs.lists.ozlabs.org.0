Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B13F59228
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2019 05:46:28 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ZjNx1dGBzDql8
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2019 13:46:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="texMjThj"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ZjMV6XZbzDqMg
 for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2019 13:45:10 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id bi6so2420440plb.12
 for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2019 20:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=KXeTyYem+OqmfXAB9jLbUiQJPmVsVcB9d5ZOaBgKddE=;
 b=texMjThj9ELOsjSLEq9Y653PtH5SuvN1GG5Y4WjBzQ78DmK8vothKCoDarMC/zabdf
 dOx030cYIzc2IAzYObguAgEwet0sMRx14n3TP0n0+MNWPt5RHK6rrxHbh6XcVYO1rEVP
 DEUVrqxC1J13RZ3/9TWHkAHH+H4YTqjlMVaweakNMu2a9f5z/XGDci/PJiQkZBgrKGyh
 6NDYgauYnoWeIRAl79kkIBELWXk2PqWWLlBtvxyeJkj/4GI9anNqNBhwRP2gLP9G+xuE
 ZnkeLoPywR6luGzYn0SGkGMvfKGXJk7XdVD2taqRfYJM/ermdOONmkpTjndt+g10z4Wf
 i4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=KXeTyYem+OqmfXAB9jLbUiQJPmVsVcB9d5ZOaBgKddE=;
 b=JYAgQFGTgPztewyhEUNOWd9+NRA9dRujH3iGI6L9uLOba0LFi6dVkIUs89Uv/SqvMC
 FIag/ACE93WNmQM9q/tieXUxgp0ItVW6SPOtyurpZl1vI25Q034ApfQx+8DOPWl2coPG
 j7R2/y3I8FgJNPG5+BndSnlG4Cbmrny2HDa19IpdA/4sL3J90SeERrUEQl6rlPBxO+6G
 x7jYYjVcSRl6QSm/McS7xVJahecxvjxt4+rbJISqS9BTFJ0UCUEQ2w43jvLX9wfkUz3B
 V7eJfFRxmE9TP0SAULKsjL95vkZgMZFry6ZkSKX3iiJQG5Rbh+M2HJz9XvkvpGQH+kTU
 TBwg==
X-Gm-Message-State: APjAAAUk5nVssYcz+DNktcGXHG9HnP3N0CYgb2IU/IGbIHIqPkdxBqqX
 7y8JqVUeFXSwrF57qcAyeEw=
X-Google-Smtp-Source: APXvYqziLzLlQJalN1m0zwRWAZgf0EFjLz1Ds/0ZjyAtyiCKJGWj0KUtdxBH5Eh1IDYaR6xlQFjF5w==
X-Received: by 2002:a17:902:aa83:: with SMTP id
 d3mr8633526plr.74.1561693507494; 
 Thu, 27 Jun 2019 20:45:07 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id c69sm629715pje.6.2019.06.27.20.45.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 20:45:06 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: gaoxiang25@huawei.com,
	yuchao0@huawei.com,
	gregkh@linuxfoundation.org
Subject: [PATCH] staging: erofs: don't check special inode layout
Date: Fri, 28 Jun 2019 11:42:34 +0800
Message-Id: <20190628034234.8832-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
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
Cc: devel@driverdev.osuosl.org, huyue2@yulong.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

Currently, we will check if inode layout is compression or inline if
the inode is special in fill_inode(). Also set ->i_mapping->a_ops for
it. That is pointless since the both modes won't be set for special
inode when creating EROFS filesystem image. So, let's avoid it.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/staging/erofs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 1433f25..2fe0f6d 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -205,6 +205,7 @@ static int fill_inode(struct inode *inode, int isdir)
 			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 			inode->i_op = &erofs_generic_iops;
 			init_special_inode(inode, inode->i_mode, inode->i_rdev);
+			goto out_unlock;
 		} else {
 			err = -EIO;
 			goto out_unlock;
-- 
1.9.1

