Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C955F48F6
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Oct 2022 19:54:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhlhQ6wbWz3bYM
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Oct 2022 04:54:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SFeKU2JW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SFeKU2JW;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MhlhJ01Fnz2yRM
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Oct 2022 04:54:23 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 7AABAB81B37;
	Tue,  4 Oct 2022 17:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D23C433C1;
	Tue,  4 Oct 2022 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664906058;
	bh=FBpNIIhf8/uGgoGomdVp1SICmaAg6h0Fm1E0PQtCSrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFeKU2JWkQCndlvY35Ymt3qMPWd4DOaBlu2drG2W1i/lXf6zRZTiuN1twAB3w/XyJ
	 fHtZZPP4qoTtpEbpCd4nkLcVmhEHrDRRtI2ISX/tQ+6rJT0tnCWSG19+8dsXCoU2FE
	 R853c4cuPGbAnx7A55TBLhz8iXUc3cGtRu2Ga08KvciCjGzxB66Nvtfl+6fzdXpOuK
	 soJ+S1EEHmp5ZVtSo3DCJSymqJTYWkhrOw8WMZEMiR63bCmOsHA42qOf1HjUmqB57y
	 d7Bnpvky7VPNX/4pI7IYD6BRRDxOSO9xtzBthf8FCyuOE8XXsQq5xmh30GdYDXbPrs
	 dC2tDcy42gPQQ==
Date: Wed, 5 Oct 2022 01:54:13 +0800
From: Gao Xiang <xiang@kernel.org>
To: Naoto Yamaguchi <wata2ki@gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: Add volume-name setting support
Message-ID: <YzxzRTg5oUeOCMr+@debian>
Mail-Followup-To: Naoto Yamaguchi <wata2ki@gmail.com>,
	linux-erofs@lists.ozlabs.org,
	Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
References: <YzxgPKoi9Q1scK3N@debian>
 <20221004164324.11481-1-naoto.yamaguchi@aisin.co.jp>
 <YzxkE6rN1KcZmF09@debian>
 <CABBJnRY9PRQD6T4zLJSGGRP_MUUUtZ4D50m-+BzSHNyQgg6-Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABBJnRY9PRQD6T4zLJSGGRP_MUUUtZ4D50m-+BzSHNyQgg6-Dg@mail.gmail.com>
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
Cc: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Naoto,

On Wed, Oct 05, 2022 at 02:04:39AM +0900, Naoto Yamaguchi wrote:
> Hi Gao
> 
> Sorry I'm missing subject and commit message.
> I inclement and fix commit message.
> 

I've fixed some minor stuffs as below, please help check if it looks
good to you so that I could apply this version then.

Thanks,
Gao Xiang

> Thanks,
> Naoto Yamaguchi.
> a member of Automotive Grade Linux Instrument Cluster EG.
> 

From b1114ba7b3acfc60c9ab5a707f0a5f38eb4ac825 Mon Sep 17 00:00:00 2001
From: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
Date: Wed, 5 Oct 2022 02:01:15 +0900
Subject: [PATCH] erofs-utils: mkfs: Add volume-label setting support

The on-disk erofs_super_block has the volume_name field.  On the other
hand, mkfs.erofs doesn't support setting volume label.

This patch adds volume-label setting support to mkfs.erofs.
Option keyword is similar to mke2fs.

Usage:
  mkfs.erofs -L volume-label image-fn dir

Signed-off-by: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  1 +
 man/mkfs.erofs.1         |  5 +++++
 mkfs/main.c              | 15 ++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index db7ac2d..13c691b 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -94,6 +94,7 @@ struct erofs_sb_info {
 	u64 inos;
 
 	u8 uuid[16];
+	char volume_name[16];
 
 	u16 available_compr_algs;
 	u16 lz4_max_distance;
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 11e8323..b65d01b 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -66,6 +66,11 @@ Pack the tail part (pcluster) of compressed files into its metadata to save
 more space and the tail part I/O. (Linux v5.17+)
 .RE
 .TP
+.BI "\-L " volume-label
+Set the volume label for the filesystem to
+.IR volume-label .
+The maximum length of the volume label is 16 bytes.
+.TP
 .BI "\-T " #
 Set all files to the given UNIX timestamp. Reproducible builds requires setting
 all to a specific one.
diff --git a/mkfs/main.c b/mkfs/main.c
index 8b97796..00a2deb 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -86,6 +86,7 @@ static void usage(void)
 	      " -zX[,Y]               X=compressor (Y=compression level, optional)\n"
 	      " -C#                   specify the size of compress physical cluster in bytes\n"
 	      " -EX[,...]             X=extended options\n"
+	      " -L volume-label       set the volume label (maximum 16)\n"
 	      " -T#                   set a fixed UNIX timestamp # to all files\n"
 #ifdef HAVE_LIBUUID
 	      " -UX                   use a given filesystem UUID\n"
@@ -237,7 +238,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	int opt, i;
 	bool quiet = false;
 
-	while ((opt = getopt_long(argc, argv, "C:E:T:U:d:x:z:",
+	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:d:x:z:",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
@@ -280,6 +281,17 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (opt)
 				return opt;
 			break;
+
+		case 'L':
+			if (optarg == NULL ||
+			    strlen(optarg) > sizeof(sbi.volume_name)) {
+				erofs_err("invalid volume label");
+				return -EINVAL;
+			}
+			strncpy(sbi.volume_name, optarg,
+				sizeof(sbi.volume_name));
+			break;
+
 		case 'T':
 			cfg.c_unix_timestamp = strtoull(optarg, &endptr, 0);
 			if (cfg.c_unix_timestamp == -1 || *endptr != '\0') {
@@ -510,6 +522,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	sb.root_nid     = cpu_to_le16(root_nid);
 	sb.packed_nid    = cpu_to_le64(packed_nid);
 	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
+	memcpy(sb.volume_name, sbi.volume_name, sizeof(sb.volume_name));
 
 	if (erofs_sb_has_compr_cfgs())
 		sb.u1.available_compr_algs = sbi.available_compr_algs;
-- 
2.30.2

