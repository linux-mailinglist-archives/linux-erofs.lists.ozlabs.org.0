Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5577A34C429
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 08:56:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F83JT6vvGz301P
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 17:56:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L9Q6TOwu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L9Q6TOwu;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=L9Q6TOwu; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=L9Q6TOwu; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F83JR494vz2yZD
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Mar 2021 17:56:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617000963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4GdsC9nTr5c3d2LljxYrJ0LZy9p6iV8bgPQvynNu1wU=;
 b=L9Q6TOwuns2dX/aweeRPK31yIDt//HbDucCKk+4s841B3FJqw+OnmaLhFS+xmGShuBl3jd
 LWWDOOGeSokRX9fcKORSywLVZSQah6+vZD+nGlFDYx/aTlohjD4RLdO7UM1odB3J8OY9XT
 GD97ULwdHbGjlYzHjarLwaVfW2jdE2M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617000963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4GdsC9nTr5c3d2LljxYrJ0LZy9p6iV8bgPQvynNu1wU=;
 b=L9Q6TOwuns2dX/aweeRPK31yIDt//HbDucCKk+4s841B3FJqw+OnmaLhFS+xmGShuBl3jd
 LWWDOOGeSokRX9fcKORSywLVZSQah6+vZD+nGlFDYx/aTlohjD4RLdO7UM1odB3J8OY9XT
 GD97ULwdHbGjlYzHjarLwaVfW2jdE2M=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-j2gIeDVxNVCM5DyRAGaSKg-1; Mon, 29 Mar 2021 02:56:01 -0400
X-MC-Unique: j2gIeDVxNVCM5DyRAGaSKg-1
Received: by mail-pl1-f200.google.com with SMTP id p12so3559469plw.0
 for <linux-erofs@lists.ozlabs.org>; Sun, 28 Mar 2021 23:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4GdsC9nTr5c3d2LljxYrJ0LZy9p6iV8bgPQvynNu1wU=;
 b=GNV/dxVSG0iQ+vT5ijm6+SKXbVOz30MXwmjB3HNQ85E/gJWt+Xs6Fj8XfevW5aXbVe
 IFGxZR6QSf1aGoyrEFp74MCwxapI9+oO0DGgQZ802XozkOgzfZpgbFY1FYC6A6/DF5iN
 zMO5GBXgTAFZ6Qq3tQ3E4igBkU9aZWpfvRbDF6x8lxUH9GpkS9baFus4uA/YzD2JRLtX
 o9W39uvhZhLDv5HFrC+iNITcQcFzq9jMvPI6zH/qbjdhx2rsdRFMBfS24IaOFyd/Emj+
 +bfiZFLs1LGC16+L9549SCVqCyeenuhZ43GZYPmY6IwKFv/YJta9csohygqgY2kAO7aE
 mpGg==
X-Gm-Message-State: AOAM532TgiLHrpsDwxFZ1l8k5gtjH+XYMq8ESLLuTKyzQSst3BQOt+WN
 vJdpt4cS1yeYkO5W1VZb96b1Nsv+fVZlEjg8Sso5/jDe5QwFrYJI7zrLuTjWGar90YErYEHuXjl
 djS3v9EpKwB6ZoK4LL5yxZp24
X-Received: by 2002:a17:90a:de90:: with SMTP id
 n16mr25478488pjv.10.1617000960136; 
 Sun, 28 Mar 2021 23:56:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVnvIpHWr9jmHxyVlRZhQuRAZlLVivU+kZ7hoLnDagGVhYbw2c+KNBs3otjq+KdmCPzMh86Q==
X-Received: by 2002:a17:90a:de90:: with SMTP id
 n16mr25478473pjv.10.1617000959917; 
 Sun, 28 Mar 2021 23:55:59 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f6sm16425302pfk.11.2021.03.28.23.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 23:55:59 -0700 (PDT)
Date: Mon, 29 Mar 2021 14:55:49 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2 4/4] erofs: add on-disk compression configurations
Message-ID: <20210329065549.GB3281654@xiangao.remote.csb>
References: <20210329012308.28743-1-hsiangkao@aol.com>
 <20210329012308.28743-5-hsiangkao@aol.com>
 <f24bd7dc-54c3-1c19-a461-97ddca778c06@huawei.com>
 <20210329063625.GA3293200@xiangao.remote.csb>
 <3c0bf7e5-0924-3d85-56db-35a2d39dbb8d@huawei.com>
MIME-Version: 1.0
In-Reply-To: <3c0bf7e5-0924-3d85-56db-35a2d39dbb8d@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Mar 29, 2021 at 02:43:48PM +0800, Chao Yu wrote:

...

> > > > +
> > > > +static int erofs_load_compr_cfgs(struct super_block *sb,
> > > > +				 struct erofs_super_block *dsb)
> > > > +{
> > > > +	struct erofs_sb_info *sbi;
> > > > +	struct page *page;
> > > > +	unsigned int algs, alg;
> > > > +	erofs_off_t offset;
> > > > +	int size, ret;
> > > > +
> > > > +	sbi = EROFS_SB(sb);
> > > > +	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
> > > > +
> > > > +	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
> > > > +		erofs_err(sb,
> > > > +"try to load compressed image with unsupported algorithms %x",
> > > 
> > > Minor style issue:
> > > 
> > > 			"try to load compressed image with unsupported "
> > > 			"algorithms %x",
> > > 			sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
> > 
> > If I remembered correctly, kernel code style suggests "don't break the print
> > message, it'd more easy to grep". Actually such style above is from XFS, and
> > can pass checkpatch.pl check, see:
> > 
> > (fs/xfs/xfs_log_recover.c) xlog_recover():
> > 		/*
> > 		 * Version 5 superblock log feature mask validation. We know the
> > 		 * log is dirty so check if there are any unknown log features
> > 		 * in what we need to recover. If there are unknown features
> > 		 * (e.g. unsupported transactions, then simply reject the
> > 		 * attempt at recovery before touching anything.
> > 		 */
> > 		if (XFS_SB_VERSION_NUM(&log->l_mp->m_sb) == XFS_SB_VERSION_5 &&
> > 		    xfs_sb_has_incompat_log_feature(&log->l_mp->m_sb,
> > 					XFS_SB_FEAT_INCOMPAT_LOG_UNKNOWN)) {
> > 			xfs_warn(log->l_mp,
> > "Superblock has unknown incompatible log features (0x%x) enabled.",
> > 				(log->l_mp->m_sb.sb_features_log_incompat &
> > 					XFS_SB_FEAT_INCOMPAT_LOG_UNKNOWN));
> > 			xfs_warn(log->l_mp,
> > "The log can not be fully and/or safely recovered by this kernel.");
> > 			xfs_warn(log->l_mp,
> > "Please recover the log on a kernel that supports the unknown features.");
> > 			return -EINVAL;
> > 		}
> > 
> > If that does't look ok for us, I could use > 80 line for this instead,
> > but I tend to not break the message ..
> 
> Xiang,
> 
> Ah, I didn't notice this is following above style, if it's fine to you,
> let's use some tabs in front of message line, though it will cause
> exceeding 80 line warning.
> 

I found a reference here,
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v5.11#n99
also vaguely remembered some threads from Linus, but hard to find now :-(

ok, I will insert tabs instead, thanks for the suggestion!

Thanks,
Gao Xiang


> Thanks,

