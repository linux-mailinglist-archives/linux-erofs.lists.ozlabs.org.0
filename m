Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C6A6A2A4C
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Feb 2023 15:27:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PP8HG6Z7Hz3cBX
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Feb 2023 01:27:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jdROx0sc;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.181.12.197; helo=m12.mail.163.com; envelope-from=zbestahu@163.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jdROx0sc;
	dkim-atps=neutral
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PP8H72v75z3bgx
	for <linux-erofs@lists.ozlabs.org>; Sun, 26 Feb 2023 01:27:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sQiSC
	/JfzhfLS10svMokIIHJ6FkOgyydyrxIY4la26c=; b=jdROx0scu4YvaYVT/ydzF
	SNdhMEwg0GhhryIhteRsUBip1Cg5XYGg0Maskyh/1DmouQ6N3qX2Tv0DoMRLB2ec
	omEFLQOKHAMzOKOhUJA4Gzy0YhkP7NyYTLD0nIOccO9j99FAXwLfW+ADM6aHmiWw
	UNPy1H9j6sc2VH/PjGua6A=
Received: from localhost.localdomain (unknown [112.22.168.212])
	by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wCnxMHBGvpjMsyeBA--.35252S2;
	Sat, 25 Feb 2023 22:27:16 +0800 (CST)
From: Yue Hu <zbestahu@163.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: manpage: add -Ededupe option
Date: Sat, 25 Feb 2023 22:27:07 +0800
Message-Id: <20230225142707.28408-1-zbestahu@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnxMHBGvpjMsyeBA--.35252S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWktFWUAw4UKF4fGrWxWFg_yoWfWrXEq3
	95JF1I9ayUAr97GF4fKF1fGryF9rWjkw1vqF15tF4DAryUuwsxXFZ09anxWF4fXr45Cw43
	Jr1ayryIkanFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbE_MDUUUUU==
X-Originating-IP: [112.22.168.212]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/xtbBoQYhEWI0XBYjbAAAsE
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

Complete the manpage for global compressed data deduplication feature.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 man/mkfs.erofs.1 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 37f2609..5e039bd 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -69,6 +69,11 @@ more space and the tail part I/O. (Linux v5.17+)
 Pack the tail part (pcluster) of compressed files or the whole files into a
 special inode for smaller image sizes, may take an argument as the pcluster
 size of the packed inode in bytes. (Linux v6.1+)
+.TP
+.BI dedupe
+Enable global compressed data deduplication to reduce the amount of storage
+required for all files. May used with fragments option together to further
+reduce storage reqirement. (Linux v6.1+)
 .RE
 .TP
 .BI "\-L " volume-label
-- 
2.25.1

