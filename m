Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AAC2E0833
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 10:40:21 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0WXd4STZzDqQZ
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 20:40:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=N2A+3hZg; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I6QoE37j; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0WXZ1gyrzDqJR
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 20:40:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608630009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A0gr9zpgyeGuIVzn5b+DvDrXr/LTcLx82QYNQHVJMY8=;
 b=N2A+3hZgJtOclAFDwhYDCykVrnPm0hoEC5tq/76/c7eDCdkX1cGtB2f4mau1dXQ9KDaRhn
 Bo9lE8Wt27ifiGDsNYVdqNLxHKxjxu95+/ekJWXm/7a5unHf/QkouGhv9Ry5c/oFRL31LO
 7dtu87KQnSN1Ph26+gwSwm7ap8qdxKs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608630010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A0gr9zpgyeGuIVzn5b+DvDrXr/LTcLx82QYNQHVJMY8=;
 b=I6QoE37jqh2VGoGgI3hzVkmAaEstypBAntNrAL/A/6gM5lUU2bt8GDOHv5FtIs58NArU+I
 4BxZ+iRZ0SPKhlZJeDn28+iZx1l8M6sLca58DDKA4x2Vww6kJQiwx38+WY9dvR30F448Hj
 11YTI9jlz3mcPpVo0v/cPFESgCY64xs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-5uDc3fyXMUGTYZTbIUpRuw-1; Tue, 22 Dec 2020 04:40:06 -0500
X-MC-Unique: 5uDc3fyXMUGTYZTbIUpRuw-1
Received: by mail-pg1-f200.google.com with SMTP id z20so8231136pgh.18
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 01:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=A0gr9zpgyeGuIVzn5b+DvDrXr/LTcLx82QYNQHVJMY8=;
 b=qM+K448d95fMGHjVa2QBzDphUd9inut0q5d5S+k9zIGmRy/smjgdSagjUU2+CB1MMq
 0K85wsxE6P5WhMlR8yn5E/GBPQ0WzSQzf5Vz2Xvfemgc5qsz4/Ks6aWHaYTFk+3jdgOW
 BPo/bUonCjul6qFeW1CgvXqSeMir2VVPWn2OXykP2k/DyxoUF3WpsbYRIbL5BSeBt1pi
 p96hKbhHEh+xr2U3Mod5pHFbltwawjLhYy5eu22IqWP7SGrlbeSswBe3L6X2RA1EM74Z
 yIUxyd2wmZzxKU/g6wyNhJ93du9q+9MbrRsCAlS37pi8z7J3gpOj9N1RhwqWwbnpH86Z
 CQZg==
X-Gm-Message-State: AOAM530i+lWb3bMZwvKxFbswXl2XhUGT2fvV+vKaL/qWTUEuM8uTYrqF
 W3j9s/r8FKDpDUl3bi7InvqhjUeETRXn1ssy6wjHMiOnqy6IY3e6PgKDIPCCGgJIwmgfqYGc76P
 gS8wiJqZXIuBxyJnd4sbTOgfP
X-Received: by 2002:a62:25c7:0:b029:156:72a3:b0c0 with SMTP id
 l190-20020a6225c70000b029015672a3b0c0mr18626457pfl.59.1608630004940; 
 Tue, 22 Dec 2020 01:40:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxErWiSdpHp9CSnhHrZhn76hOFVRIQYJeQOMvpDOO4e01V3dguaUD/NIkbwwyw3UNWOiBz+MQ==
X-Received: by 2002:a62:25c7:0:b029:156:72a3:b0c0 with SMTP id
 l190-20020a6225c70000b029015672a3b0c0mr18626445pfl.59.1608630004677; 
 Tue, 22 Dec 2020 01:40:04 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c24sm20003935pgi.71.2020.12.22.01.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Dec 2020 01:40:04 -0800 (PST)
Date: Tue, 22 Dec 2020 17:39:52 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201222093952.GC1819755@xiangao.remote.csb>
References: <20201222020430.12512-1-zbestahu@gmail.com>
 <20201222034455.GA1775594@xiangao.remote.csb>
 <20201222124733.000000fe.zbestahu@gmail.com>
 <20201222063112.GB1775594@xiangao.remote.csb>
 <20201222070458.GA1803221@xiangao.remote.csb>
 <20201222160935.000061c3.zbestahu@gmail.com>
 <20201222091340.GA1819755@xiangao.remote.csb>
 <20201222173014.000055d3.zbestahu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201222173014.000055d3.zbestahu@gmail.com>
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

On Tue, Dec 22, 2020 at 05:30:14PM +0800, Yue Hu wrote:

...

> > > 
> > >   
> > > > +	else if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> > > > +			  erofs_fspath(path)) <= 0)  
> > > 
> > > The argument of path will be root directory. And canned fs_config for root directory as
> > > below:
> > > 
> > > 0 0 755 selabel=u:object_r:rootfs:s0 capabilities=0x0
> > > 
> > > So, cannot add mount point to root directory for canned fs_config. And what about non-canned
> > > fs_config?  
> > 
> > Not quite sure what you mean. For non-canned fs_config, we didn't observed any strange
> > before (I ported to cuttlefish and hikey960 with boot success, also as I mentioned before
> > some other vendors already use it.)
> > 
> > I think the following commit is only useful for squashfs since its (non)root inode
> > workflows are different, so need to add in two difference place. But mkfs.erofs is not.
> > https://android.googlesource.com/platform/external/squashfs-tools/+/85a6bc1e52bb911f195c5dc0890717913938c2d1%5E%21/#F0
> > 
> > For root inode is erofs, I think erofs_fspath(path) would return "", so that case
> > is included as well.... Am I missing something?
> 
> Yes, erofs_fspath(path) returns "" for root inode. However, the above patch add the mount
> point to fspath when specify it, so the real path is "vendor/" which does not exist in canned
> fs_config file. build will report below error:
> 
> failed to find [/vendor/] in canned fs_config

Hmmm... such design is quite strange for me....
Could you try the following diff?

diff --git a/lib/inode.c b/lib/inode.c
index 9469074..9af6179 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -698,11 +698,14 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 	/* filesystem_config does not preserve file type bits */
 	mode_t stat_file_type_mask = st->st_mode & S_IFMT;
 	unsigned int uid = 0, gid = 0, mode = 0;
+	bool alloced;
 	char *fspath;
 
 	inode->capabilities = 0;
-	if (!cfg.mount_point)
-		fspath = erofs_fspath(path);
+
+	alloced = (cfg.mount_point && erofs_fspath(path)[0] != '\0');
+	if (!alloced)
+		fspath = (char *)erofs_fspath(path);
 	else if (asprintf(&fspath, "%s/%s", cfg.mount_point,
 			  erofs_fspath(path)) <= 0)
 		return -ENOMEM;
@@ -718,7 +721,7 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 			  cfg.target_out_path,
 			  &uid, &gid, &mode, &inode->capabilities);
 
-	if (cfg.mount_point)
+	if (alloced)
 		free(fspath);
 	st->st_uid = uid;
 	st->st_gid = gid;

if it works, will redo a formal patch then....

Thanks,
Gao Xiang

> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > 
> > > Thx.
> > > 
> > >   
> > > > +		return -ENOMEM;
> > > > +
> > > > +
> > > >  	if (cfg.fs_config_file)
> > > > -		canned_fs_config(erofs_fspath(path),
> > > > +		canned_fs_config(fspath,
> > > >  				 S_ISDIR(st->st_mode),
> > > >  				 cfg.target_out_path,
> > > >  				 &uid, &gid, &mode, &inode->capabilities);
> > > > -	else if (cfg.mount_point) {
> > > > -		if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> > > > -			     erofs_fspath(path)) <= 0)
> > > > -			return -ENOMEM;
> > > > -
> > > > +	else
> > > >  		fs_config(fspath, S_ISDIR(st->st_mode),
> > > >  			  cfg.target_out_path,
> > > >  			  &uid, &gid, &mode, &inode->capabilities);
> > > > +
> > > > +	if (cfg.mount_point)
> > > >  		free(fspath);
> > > > -	}
> > > >  	st->st_uid = uid;
> > > >  	st->st_gid = gid;
> > > >  	st->st_mode = mode | stat_file_type_mask;  
> > >   
> > 
> 

