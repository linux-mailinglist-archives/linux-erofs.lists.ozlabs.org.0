Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0F1A47C7
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 07:53:51 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Lj7w65mGzDqsX
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 15:53:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567317228;
	bh=tzTLcizLsq/8/q5/dfyQgvLv0vmKe9vAx8y3sLIi/i8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=MIkaCTB0FSpPqnxQUhk/YMVHRSL/hj/IQryc86FVJm/v5JNE2TMc8XVEymH1QwXy8
	 kiorQ1GT2laeYSZgTJ/eofNY7DJADb8oE9gje3HU0/xPSbLoeSS+DarjMO1r4T3X5f
	 6jUx4d8pFSspE3nmF6iZcRbSob+sxmToCuYIfuO+YXqF+V7CFfZIAjCfGYuWQZNnak
	 TNAcnAEPBBJSq8eDP3TGWYjTsgjxEZxUBhOEvS3KVj2lmngMxvRVAU6Bisq/Ncyi7v
	 +EeNrHuOsWKGU4znCIXZg68Zy14RJvNDPYTM+XsrGAWjf3D/acZKvH9xB0G9W/Guh2
	 LHxK2e4FfvfgQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.64.82; helo=sonic305-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="eJtOhTE8"; 
 dkim-atps=neutral
Received: from sonic305-19.consmr.mail.gq1.yahoo.com
 (sonic305-19.consmr.mail.gq1.yahoo.com [98.137.64.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Lj7N3N4qzDqvK
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2019 15:53:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567317198; bh=SEiscPC1v1LfR84rbvNY+J8YVEUu/TB5z/fYe1mNmJc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=eJtOhTE8s39SZItn8ZXe6OEY1dUisdRMcWOeilpJUjeD0FmEr/0CWeDzUG6ihLCmK5+sT2IzyeaLnLctNIzTJgo14J0hkoeIdxLXkJpnI162p95SIatrRFDcn/3nIC1ygogG76CPVaWnXjP2xi4ZvxcqVeq8GwWi4kavrz1hJ6nCgRRft30vSP4zDlHDlHM7hkKFVLRqY+QCqx3X9wp127TVFkw81eOsJIc4lLMyFIYeYkNlSgQdsj9vysW8KfkOxW/g3Fpf49pPu/Icb197l4Fkr7/7OTUfL/LOvvumxzpkdlm7ZgCnUgz/xE0BQ2wDOL3ol9KSQtpy3L7I76GfwA==
X-YMail-OSG: ur40BOsVM1l6xEudGp5R0BcAxKwdyW_h2voKsZguKUu2EyU8n6J7ZYc8aYEsVQC
 cDIWxG0yi0Off1UZeh6cSDRgFFkOPcVM4VhBrnRGSYDHAzGIF1pGw22PB_RrZrVabnHLkDq.ZnEV
 rHBTuhGidsQwx.yPFXCNzN_aByfO3yep6e.nyx0ZnYb8LlZWJWKnOLwL6NrmNbgKDhjJiODINO.1
 IJu_E82if6OGFf2HOFnbbNdXxXw6dXqZXAEQX0afZLepgC7iwC9O8nqJopkiKprfDq7A2WaQTGzI
 wCjLjrnc8Ke0dOxUqkYe7ZkBbSijTtfwlTVwNPP0FFNvlJBkfTI4UX1bB8I4KjfMLctxK7zQsUT0
 FaqfEI0bGYIKgAhy0bf0lezkf_VxeIbDUp9IrO12G_IVH82gmZg8dx08pIddieaNOcRz0buNvT4M
 hAvYQ7TTDdft.o4yVnajhvmi2FFDhpd8PHTLg0eeggK9hyMIlQdbd5Lb_3z.X0vEQ.F48hfkC1zw
 CrALt8mVait_zAX40SqDse9C4XhzynmBxHA9pzyudjvFPLvxrr6.u8N3W5zKXrvRCGwP35BWGfVa
 4gKcqy7tcMxnFEc1RP4BO5_DQYzi0C7JrF0PQcbom57qvnctt_53prS6FWqTE2eEMo1SRKMHA4bK
 gvyIIZjMu56awnMdz_rObZJrBpuvI5SYXkS3AWFB1iJUgNHgt8jpwm3UQG2BzS2rYjjJxKIYcDvs
 4NTTKdjmd1XtYviPytzRklpH9hNgM0ojrg2w2RUQxvBN.txljGm9.a04XHPG770gEk8oboUJ4266
 ZD67Gz5JBLTkjKOWu9eYxmqq6E3LIBfpkNKhWiLd0A2.t5zxONDn2ddny3fIL9qSG0up_kRXZGtD
 z6Jg9ljijbUuDj2bk4zWfoUCVMNs.zXySLqwlhNmXtJrkCgap2ePDRQeBrRLBvTl11wUwd.09Ew8
 dfu6l.suG124TCNguc3QY7pyK_rcoztluPJKsvwnLVqPVrJSzeXa2zqWX6.Itb54c8JkuHN3jWaj
 fjNr89QqQy7XlPnFiI6yWLmkWBZzEfEpC_gJD9RL11glV3uv67ipRXG8dtAwpPL8vFlkb3iESmPm
 oxZ5vOxuv7S2IDkW1_xuVxw6aTSVXf6J2R4T5QDz_FBsU.TnE.lqF2OM1tXyYT9VXeHXWntHF1H_
 V_7MIskRkrsScNjNrRES_n49intgudd9wovqDy1h42jgLmlXVZl0NB7rmUV6FXDqJq8nYcPAXqI1
 V.5symirtkQqLDzBL6djeg46q3qlnF_VjeUmwiTe.5.1mnMcy6A--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:53:18 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 426e3b5ec1af9e36f409445c51071a70; 
 Sun, 01 Sep 2019 05:53:14 +0000 (UTC)
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 17/21] erofs: use a switch statement when dealing with the
 file modes
Date: Sun,  1 Sep 2019 13:51:26 +0800
Message-Id: <20190901055130.30572-18-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

As Christoph suggested [1], "
Please use a switch statement when dealing with the file modes
to make everything easier to read."

[1] https://lore.kernel.org/r/20190829102503.GF20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/inode.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 2ca4eda6e5bf..6e2486cc3cd4 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -32,17 +32,24 @@ static int read_inode(struct inode *inode, void *data)
 		vi->xattr_isize = erofs_xattr_ibody_size(v2->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(v2->i_mode);
-		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
-		    S_ISLNK(inode->i_mode))
+		switch (inode->i_mode & S_IFMT) {
+		case S_IFREG:
+		case S_IFDIR:
+		case S_IFLNK:
 			vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
-		else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+			break;
+		case S_IFCHR:
+		case S_IFBLK:
 			inode->i_rdev =
 				new_decode_dev(le32_to_cpu(v2->i_u.rdev));
-		else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
+			break;
+		case S_IFIFO:
+		case S_IFSOCK:
 			inode->i_rdev = 0;
-		else
+			break;
+		default:
 			goto bogusimode;
-
+		}
 		i_uid_write(inode, le32_to_cpu(v2->i_uid));
 		i_gid_write(inode, le32_to_cpu(v2->i_gid));
 		set_nlink(inode, le32_to_cpu(v2->i_nlink));
@@ -65,17 +72,24 @@ static int read_inode(struct inode *inode, void *data)
 		vi->xattr_isize = erofs_xattr_ibody_size(v1->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(v1->i_mode);
-		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
-		    S_ISLNK(inode->i_mode))
+		switch (inode->i_mode & S_IFMT) {
+		case S_IFREG:
+		case S_IFDIR:
+		case S_IFLNK:
 			vi->raw_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
-		else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+			break;
+		case S_IFCHR:
+		case S_IFBLK:
 			inode->i_rdev =
 				new_decode_dev(le32_to_cpu(v1->i_u.rdev));
-		else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
+			break;
+		case S_IFIFO:
+		case S_IFSOCK:
 			inode->i_rdev = 0;
-		else
+			break;
+		default:
 			goto bogusimode;
-
+		}
 		i_uid_write(inode, le16_to_cpu(v1->i_uid));
 		i_gid_write(inode, le16_to_cpu(v1->i_gid));
 		set_nlink(inode, le16_to_cpu(v1->i_nlink));
-- 
2.17.1

