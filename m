Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F39537799B
	for <lists+linux-erofs@lfdr.de>; Mon, 10 May 2021 03:07:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FdjZM3hjtz2ykQ
	for <lists+linux-erofs@lfdr.de>; Mon, 10 May 2021 11:07:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oIALVRrF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oIALVRrF; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FdjZG6R1Kz2yXv
 for <linux-erofs@lists.ozlabs.org>; Mon, 10 May 2021 11:07:02 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88A4D6101A;
 Mon, 10 May 2021 01:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620608818;
 bh=rs4is7yDGCIV5OW+vb+VO11z4qAoafSKQee69ec2m7c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oIALVRrF7B4ufEP5A5l/rpcVFbKBf/MnQqjAIrktbFGm/X5KpQx36TfBd6V/Ldkli
 BWL0DCfaNBBrOP13TgoJh1lDyJiyiuAqL68wSJoSMlT4Td142PMPSox0BsbPkkaySL
 SRLLupbqp8swXp66/bqwz0DYT8CxexBYhH6DupuAZHDeRr5cs70oxBxS4bBkrBreHj
 M9CKL5fAW0mUvXE1NFLm641HgHnPvlQj0zYmHBaimkTCni+7raUCRm1gEL6iXxhL3p
 xpKe+BEl/iNUGnskCKpSUj/3XOB96o50Enj79S1Nen6xREbqVCk7gpwcWS6lznsWLk
 FYgBbspwxRKWw==
Date: Mon, 10 May 2021 09:06:54 +0800
From: Gao Xiang <xiang@kernel.org>
To: Li GuiFu <bluce.lee@aliyun.com>, Li Guifu <bluce.liguifu@huawei.com>
Subject: Re: [PATCH v1 2/2] erofs-utils: introduce erofs_subdirs to one dir
 for sort
Message-ID: <20210510010653.GA31518@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210505142615.38306-1-bluce.lee@aliyun.com>
 <20210505142615.38306-2-bluce.lee@aliyun.com>
 <20210507070958.GA8929@hsiangkao-HP-ZHAN-66-Pro-G1>
 <aa2954c6-442b-86e2-5f0e-27dad4026ff1@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa2954c6-442b-86e2-5f0e-27dad4026ff1@aliyun.com>
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
Cc: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, May 09, 2021 at 10:30:06PM +0800, Li GuiFu wrote:
> GaoXiang
> 
> On 2021/5/7 15:09, Gao Xiang wrote:
> > Hi Guifu,
> > 
> > On Wed, May 05, 2021 at 10:26:15PM +0800, Li Guifu via Linux-erofs wrote:
> >> The structure erofs_subdirs has a dir number and a list_head,
> >> the list_head is the same with i_subdirs in the inode.
> >> Using erofs_subdirs as a temp place for dentrys under the dir,
> >> and then sort it before replace to i_subdirs
> >>
> >> Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
> >> ---
> >>  include/erofs/internal.h |  5 +++
> >>  lib/inode.c              | 95 +++++++++++++++++++++++++---------------
> >>  2 files changed, 64 insertions(+), 36 deletions(-)
> >>
> >> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> >> index 1339341..7cd42ca 100644
> >> --- a/include/erofs/internal.h
> >> +++ b/include/erofs/internal.h
> >> @@ -172,6 +172,11 @@ struct erofs_inode {
> >>  #endif
> >>  };
> >>  
> >> +struct erofs_subdirs {
> >> +	struct list_head i_subdirs;
> >> +	unsigned int nr_subdirs;
> >> +};
> >> +
> >>  static inline bool is_inode_layout_compression(struct erofs_inode *inode)
> >>  {
> >>  	return erofs_inode_is_data_compressed(inode->datalayout);
> >> diff --git a/lib/inode.c b/lib/inode.c
> >> index 787e5b4..3e138a6 100644
> >> --- a/lib/inode.c
> >> +++ b/lib/inode.c
> >> @@ -96,7 +96,7 @@ unsigned int erofs_iput(struct erofs_inode *inode)
> >>  	return 0;
> >>  }
> >>  
> >> -struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
> >> +struct erofs_dentry *erofs_d_alloc(struct erofs_subdirs *subdirs,
> >>  				   const char *name)
> >>  {
> >>  	struct erofs_dentry *d = malloc(sizeof(*d));
> >> @@ -107,7 +107,8 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
> >>  	strncpy(d->name, name, EROFS_NAME_LEN - 1);
> >>  	d->name[EROFS_NAME_LEN - 1] = '\0';
> >>  
> >> -	list_add_tail(&d->d_child, &parent->i_subdirs);
> >> +	list_add_tail(&d->d_child, &subdirs->i_subdirs);
> >> +	subdirs->nr_subdirs++;
> >>  	return d;
> >>  }
> >>  
> >> @@ -150,38 +151,12 @@ static int comp_subdir(const void *a, const void *b)
> >>  	return strcmp(da->name, db->name);
> >>  }
> >>  
> >> -int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
> >> +int erofs_prepare_dir_file(struct erofs_inode *dir)
> > 
> > Err... nope, that is not what I suggested, I was suggesting
> > 
> > int erofs_prepare_dir_file(struct erofs_inode *dir,
> > 			   struct erofs_subdirs *subdirs)
> > 
> >>  {
> >> -	struct erofs_dentry *d, *n, **sorted_d;
> >> -	unsigned int d_size, i_nlink, i;
> >> +	struct erofs_dentry *d;
> >> +	unsigned int d_size, i_nlink;
> >>  	int ret;
> >>  
> >> -	/* dot is pointed to the current dir inode */
> >> -	d = erofs_d_alloc(dir, ".");
> >> -	d->inode = erofs_igrab(dir);
> >> -	d->type = EROFS_FT_DIR;
> >> -
> >> -	/* dotdot is pointed to the parent dir */
> >> -	d = erofs_d_alloc(dir, "..");
> >> -	d->inode = erofs_igrab(dir->i_parent);
> >> -	d->type = EROFS_FT_DIR;
> > 
> > Leave these two here, since it's a part of dir preparation.
> I think  this erofs_prepare_dir_file() funtion just do space prepare
> that  dirs have been sorted before
> 
> . and .. should been added along with readir

Nope, I don't think introduce another two one-shot fixed helpers
would be helpful here.

Also, prepare_dir_file() clearly means "prepare for the dir file".
It can naturally accept all original subdir inputs, add ".", ".."
dirents, sort them all in dir formats and output the dir files.

I don't know what is wrong with such clean sematics? And you must
seperate it into several helpers?

Thanks,
Gao Xiang

> 
> 
