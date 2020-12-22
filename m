Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1579D2E0651
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 08:05:28 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0S5x1BYPzDqM4
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 18:05:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=UU6uyfCt; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UU6uyfCt; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0S5t5kTmzDqJM
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 18:05:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608620716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tPyt0UPSFBPRNEwlq3aGY6qtk+qVGEmqLbkli3f301k=;
 b=UU6uyfCtFmhmT9qutEG6lfH21LeXA5SiBTmwftQql3FBNTM9ib/Z/ttOlRriiQFCsLauqm
 wHtXZh8iBK3IREsXYRDESCIpegHXnImHggGNFLJ4hFYFCaDPiO7h9gXFwJcvO5XFypaViZ
 fqelqzUAGkLIyxLHWhdDjeDT+n4ZWR8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608620716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tPyt0UPSFBPRNEwlq3aGY6qtk+qVGEmqLbkli3f301k=;
 b=UU6uyfCtFmhmT9qutEG6lfH21LeXA5SiBTmwftQql3FBNTM9ib/Z/ttOlRriiQFCsLauqm
 wHtXZh8iBK3IREsXYRDESCIpegHXnImHggGNFLJ4hFYFCaDPiO7h9gXFwJcvO5XFypaViZ
 fqelqzUAGkLIyxLHWhdDjeDT+n4ZWR8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-NCJMhoWUO1WXOP1AqdfvDQ-1; Tue, 22 Dec 2020 02:05:11 -0500
X-MC-Unique: NCJMhoWUO1WXOP1AqdfvDQ-1
Received: by mail-pf1-f200.google.com with SMTP id r15so6323676pfg.5
 for <linux-erofs@lists.ozlabs.org>; Mon, 21 Dec 2020 23:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tPyt0UPSFBPRNEwlq3aGY6qtk+qVGEmqLbkli3f301k=;
 b=GkHG/jGGhN3DkZCqzrhnfPaBe+UCGsE0cH5i6GXI5BVy3+bKWbVEJpaSlB5dCUC61E
 d0ot1YKHhXnkUlF39HyM0oF0h9gab5Cj61de78f7wFzgdfWoQt2jUt4kY7wLMz0Nwvyp
 he4mMc3nt562DH/VDKijGQVrJNhnUnw5zFGLrXbVb+mOaYZ+i5t3hL72Ytt58z3Fmco2
 bFT7q2mzepA5YZ+s5E6Ackh9ubp/alZRJFjEN4wQYz9dSwLmTHjL3YN9IrN2LykGAypM
 +gYX3WhiBTqs33DRdvQC8S2K1XnJMAMc9JTsdtf9OGkOeivuyJtuhXIWx8AXheDZs9Y0
 n+Nw==
X-Gm-Message-State: AOAM531ZJURI/Np6dymOJ1h+JjD0Ekw5yQXMEd4baDa+cTJ1xxOxRksA
 aA06hysF089QKoyGxEBoIdxZRLbexPeXBjHw5dJ9ywYyVX6X7C889aZDfe0MQXUe/A4arOGLRmk
 b8YvsWY9gcA8+x1S8YCnDSXmP
X-Received: by 2002:a17:90b:1c0d:: with SMTP id
 oc13mr20320987pjb.113.1608620710735; 
 Mon, 21 Dec 2020 23:05:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2+5LR044sjV4dnq0kbAE7yzOM7DBMhW1ED+EsGAye+Bj5ibT0+XKaMVZM0VWIZFUyN3eqRA==
X-Received: by 2002:a17:90b:1c0d:: with SMTP id
 oc13mr20320963pjb.113.1608620710481; 
 Mon, 21 Dec 2020 23:05:10 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id ck20sm18518343pjb.20.2020.12.21.23.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Dec 2020 23:05:10 -0800 (PST)
Date: Tue, 22 Dec 2020 15:04:58 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201222070458.GA1803221@xiangao.remote.csb>
References: <20201222020430.12512-1-zbestahu@gmail.com>
 <20201222034455.GA1775594@xiangao.remote.csb>
 <20201222124733.000000fe.zbestahu@gmail.com>
 <20201222063112.GB1775594@xiangao.remote.csb>
MIME-Version: 1.0
In-Reply-To: <20201222063112.GB1775594@xiangao.remote.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Tue, Dec 22, 2020 at 02:31:12PM +0800, Gao Xiang wrote:

...

> 
> Ok, I will try to find some clue to verify later.
> 
> > 
> > > 
> > > > Moreover, we should not add the mount point to fspath on root inode for
> > > > fs_config() branch.  
> > > 
> > > Is there some descriptive words or reference for this? To be honest,
> > > I'm quite unsure about this kind of Android-specific things... :(
> > 
> > Refer to change: mksquashfs: Run android_fs_config() on the root inode
> > 
> > I think erofs of AOSP has this issue also. Am i right?
> 
> Not quite sure if it effects non-canned fs_config after
> reading the commit message...
> https://android.googlesource.com/platform/external/squashfs-tools/+/85a6bc1e52bb911f195c5dc0890717913938c2d1%5E%21/#F0
> 
> And no permission to access Bug 72745016, so...
> maybe we need to limit this to non-canned fs_config only?
> (at least confirming the original case would be better)
> 
> BTW, Also, from its testcase command line in the commit message:
> "mksquashfs path system.raw.img -fs-config-file fs_config -android-fs-config"
> 
> I'm not sure if "--mount-point" is passed in so I think for
> such case no need to use such "goto" as well? 
> 
> Thanks,
> Gao Xiang

Could you verify the following patch if possible? (without compilation,
I don't have test environment now since AOSP code is on my PC)

From: Yue Hu <huyue2@yulong.com>
Date: Tue, 22 Dec 2020 14:52:22 +0800
Subject: [PATCH] AOSP: erofs-utils: fix sub-directory prefix for canned
 fs_config

"failed to find [%s] in canned fs_config" is observed by using
"--fs-config-file" option under Android 10.

Notice that canned fs_config has a prefix to sub-directory if
"--mount-point" presents. However, such prefix cannot be added by
just using erofs_fspath().

Fixes: 8a9e8046f170 ("AOSP: erofs-utils: add fs_config support")
Signed-off-by: Yue Hu <huyue2@yulong.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lib/inode.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 3d634fc..9469074 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -701,21 +701,25 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 	char *fspath;
 
 	inode->capabilities = 0;
+	if (!cfg.mount_point)
+		fspath = erofs_fspath(path);
+	else if (asprintf(&fspath, "%s/%s", cfg.mount_point,
+			  erofs_fspath(path)) <= 0)
+		return -ENOMEM;
+
+
 	if (cfg.fs_config_file)
-		canned_fs_config(erofs_fspath(path),
+		canned_fs_config(fspath,
 				 S_ISDIR(st->st_mode),
 				 cfg.target_out_path,
 				 &uid, &gid, &mode, &inode->capabilities);
-	else if (cfg.mount_point) {
-		if (asprintf(&fspath, "%s/%s", cfg.mount_point,
-			     erofs_fspath(path)) <= 0)
-			return -ENOMEM;
-
+	else
 		fs_config(fspath, S_ISDIR(st->st_mode),
 			  cfg.target_out_path,
 			  &uid, &gid, &mode, &inode->capabilities);
+
+	if (cfg.mount_point)
 		free(fspath);
-	}
 	st->st_uid = uid;
 	st->st_gid = gid;
 	st->st_mode = mode | stat_file_type_mask;
-- 
2.27.0

