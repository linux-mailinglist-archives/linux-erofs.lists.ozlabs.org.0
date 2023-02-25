Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D2A6A29D5
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Feb 2023 13:52:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PP69337jqz3c9N
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Feb 2023 23:52:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=d19XGl0T;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.181.12.199; helo=m12.mail.163.com; envelope-from=zbestahu@163.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=d19XGl0T;
	dkim-atps=neutral
X-Greylist: delayed 825 seconds by postgrey-1.36 at boromir; Sat, 25 Feb 2023 23:52:01 AEDT
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PP68x5J6Kz30CT
	for <linux-erofs@lists.ozlabs.org>; Sat, 25 Feb 2023 23:51:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HsWMs
	Fo434zGXD48Vm85d+YE7+B+qx0IGG3SEn8Y5IQ=; b=d19XGl0TytIX0q9O3ILVS
	CJlh3cMX2ShuOnO/w/QyRwZQA/s+xBbMiwCvhRa0wHWgu36DXbCPBsJ6kSNDZS9l
	bShGzli2sVCDyRMxvyE9ExH6W7DhOAMVBBznSvGO+f6sRhcIFNto4/bUgD7BvKrk
	6m86pwJeBt4WENNsJ7TAQs=
Received: from localhost.localdomain (unknown [112.22.168.212])
	by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wCXn19WBPpjxm6jBA--.9622S2;
	Sat, 25 Feb 2023 20:51:47 +0800 (CST)
From: Yue Hu <zbestahu@163.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH resend] erofs-utils: manpage: add fragments extended option
Date: Sat, 25 Feb 2023 20:51:33 +0800
Message-Id: <20230225125133.26165-1-zbestahu@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXn19WBPpjxm6jBA--.9622S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWDJFWDXw1fJr1rtFyUAwb_yoW3KrbEv3
	yktF4I9a45Ar97Cr4SqF15GFyjgryYk3saqF1rta1DZry8Cws8J390gr47JrWSq39xuwsx
	Jr4ayr9Ik3y7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8v_M7UUUUU==
X-Originating-IP: [112.22.168.212]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/xtbBZgYhEVaECngbmwAAsw
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
Cc: huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Complete the manpage for fragments feature.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 man/mkfs.erofs.1 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index b65d01b..37f2609 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -64,6 +64,11 @@ Don't inline regular files to enable FSDAX for these files (Linux v5.15+).
 .BI ztailpacking
 Pack the tail part (pcluster) of compressed files into its metadata to save
 more space and the tail part I/O. (Linux v5.17+)
+.TP
+.BI fragments=
+Pack the tail part (pcluster) of compressed files or the whole files into a
+special inode for smaller image sizes, may take an argument as the pcluster
+size of the packed inode in bytes. (Linux v6.1+)
 .RE
 .TP
 .BI "\-L " volume-label
-- 
2.25.1

