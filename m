Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89BA3514AC
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 14:01:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FB1xR5L5vz3c9f
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 23:01:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uk9Uy1z8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uk9Uy1z8; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FB1xP1MVhz3bw0
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Apr 2021 23:01:29 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0228A60FEF;
 Thu,  1 Apr 2021 12:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617278486;
 bh=2Y42ZCyZYrzYEokzxl+Jllj47PdIdkfZ0mo8f5NcGkk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uk9Uy1z8FnKyE1UVJ/TIDaU7r26i0pSKkqlNYguo4SMKNAqsVchnoVVYpi7SkDsaq
 xZCRHeszI0fXAVjKqcxmKTWYvXz9oFTLjV9ph5dTpZ2qzTnvmcfmwVfYjVhVz8lR16
 yXxnUk5UV7tbq/UnNjMO0hp/kjr7PavYr1rbYKTGUIzxmaMLsToTDDrROtBu23F1+9
 uJaj/GUd/FD2yqNRU9fS0W5K/B3O9w8zCSxfEMd7wzgd+B2+XL5RYwMNQIFLtzlSha
 8sPcXjI1Zl6fuVhzG5QAMf8k/bfQYwt9uTaUMjLSbbJru3Fq0gy0Vmd4iGyIyvIuXh
 c06frcv3ghOHw==
Date: Thu, 1 Apr 2021 20:01:03 +0800
From: Gao Xiang <xiang@kernel.org>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH v2] erofs-utils: add cmd argument to override uid/gid
Message-ID: <20210401120102.GA30040@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210401060132.GA3827683@xiangao.remote.csb>
 <20210401113610.49094-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210401113610.49094-1-sehuww@mail.scut.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Apr 01, 2021 at 07:36:10PM +0800, Hu Weiwen wrote:
> Also added '--all-root' option to set uid and gid to root conveniently.
> 
> This function can be useful if we want to pack some data owned by user with
> large uid, but we want to use compact inode.
> 
> This interface mimics that of 'mksquashfs'.
> 
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>

Yey! I've applied with the following modification,

diff --git a/include/erofs/config.h b/include/erofs/config.h
index e6eaef66b91c..15390f4ca9c8 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -54,8 +54,7 @@ struct erofs_configure {
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
 	u64 c_unix_timestamp;
-	u32 c_uid;
-	u32 c_gid;
+	u32 c_uid, c_gid;
 #ifdef WITH_ANDROID
 	char *mount_point;
 	char *target_out_path;
diff --git a/mkfs/main.c b/mkfs/main.c
index 72b7f17e1c66..d8823b539194 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -77,8 +77,8 @@ static void usage(void)
 #ifdef HAVE_LIBSELINUX
 	      " --file-contexts=X  specify a file contexts file to setup selinux labels\n"
 #endif
-	      " --force-uid=UID    set all file uids to UID\n"
-	      " --force-gid=GID    set all file gids to GID\n"
+	      " --force-uid=#      set all file uids to # (# = UID)\n"
+	      " --force-gid=#      set all file gids to # (# = GID)\n"
 	      " --all-root         make all files owned by root\n"
 	      " --help             display this help and exit\n"
 #ifdef WITH_ANDROID

Otherwise looks good to me,
Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang
