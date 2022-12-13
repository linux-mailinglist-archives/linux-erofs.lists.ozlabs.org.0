Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B8764B21D
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 10:15:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NWXsh5ZGBz3bh4
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 20:15:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=C+mGXv+b;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=C+mGXv+b;
	dkim-atps=neutral
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NWXsX3Mzbz3bT1
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Dec 2022 20:15:42 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id 4so9019687plj.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 13 Dec 2022 01:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IS2wKfZomLvysFuAQ5aT0KAlY4xN+yrF9NlKNPSjbc=;
        b=C+mGXv+bz9oIjXgCnxJ/4T5Wxf17qY/ph6eVUIw1dY12o0Hlbd+nLUm50+otfRv4/K
         0zXW439rXtFAbDanGJjKz585QPfFInIVA0w9AGc2VtzYAWWt30xt3MyCGUkI2M+SCqX2
         UGLd4dpu8SDxllSN9esYc+aJwIgTaGXz7vwQW0W53kfFQx6iv/8crP06jyaDrqU85apr
         LE3lNu8VJIEDZe6G1aBAU1Ez3ErpNkU8Amv/1crkrWGrgO89pA9lvgYykwTUHs/1EkzM
         5nPRCiVk0rLPN9lG9ROXNEZCzc8XgpRiF6CaHy2UveWLRSSL2ayNZgs6OQfdfUArItNX
         5S7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IS2wKfZomLvysFuAQ5aT0KAlY4xN+yrF9NlKNPSjbc=;
        b=qmo2u/fg4st0AZol1rGlLZFjXLZAAUSpk4Uazu+xGT/uhwpX1HPWzGL1kEnxo6hWyf
         4/9uL67/VyfZSoI/RdRY2G8CrDOxcpVd664qg8LZN+wn+yyD1CbzZ6sQ4vqsFj9f9768
         U8v+5AAsknDSeS/ld9j7PMaSIu1UakLZ+sITpJQGcmJDmJ1E1emV5gIfCWOSGb7ehnVV
         px6XzJBGNGaN0ucpbWcEmoHnhCUhHMmKVF+xAhaCTHSTOzVlcjVYSQ8ThUgNsIQ08wUY
         j/v0ZQqqPvflb9LKpuvNprsn0tHWEiJl5Xylz4wpu6c04C7GzflQmEc9FiLj0tewBEvS
         CkZA==
X-Gm-Message-State: ANoB5pngs8UWDIyqxmWpzclvGzDeQwlx3zyvKPehh1tuhuarkAeoKH95
	RVAuGZt1z599ZbEmuiL7YMY=
X-Google-Smtp-Source: AA0mqf52guxcY+LHlRTL4HmQgzopaEsr+7YA67DMi6PQ6RgSwhv2IJ0J964EPTF2gBmkDVLXgL5mJA==
X-Received: by 2002:a05:6a20:9393:b0:a9:1472:c480 with SMTP id x19-20020a056a20939300b000a91472c480mr23719098pzh.17.1670922938944;
        Tue, 13 Dec 2022 01:15:38 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090282c700b00186a2444a43sm7888431plz.27.2022.12.13.01.15.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Dec 2022 01:15:38 -0800 (PST)
Date: Tue, 13 Dec 2022 17:20:06 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: fix fragmentoff overflow for large packed
 inode
Message-ID: <20221213172006.00000418.zbestahu@gmail.com>
In-Reply-To: <Y5g3eauzxLvKyyms@B-P7TQMD6M-0146.local>
References: <20221213071643.11874-1-zbestahu@gmail.com>
	<Y5g3eauzxLvKyyms@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, Khem Raj <raj.khem@gmail.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 13 Dec 2022 16:27:37 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> (cc Khem Raj <raj.khem@gmail.com>... Since I'd like to apply this first
>  and then enable _FILE_OFFSET_BITS=64 unconditionally so that we could
>  clean up all hard-coded _FILE_OFFSET_BITS in the source code.)
> 
> Hi Yue,
> 
> On Tue, Dec 13, 2022 at 03:16:43PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > The return value of ftell() is a long int, use ftello{64} instead. Also,
> > use lseek64 for large file position to avoid this error if we have it.
> > And need to return at once if they fail.
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> >  configure.ac    |  2 ++
> >  lib/fragments.c | 34 +++++++++++++++++++++++++++++-----
> >  lib/inode.c     |  9 +++++++--
> >  3 files changed, 38 insertions(+), 7 deletions(-)
> > 
> > diff --git a/configure.ac b/configure.ac
> > index a736ff0..5c9666a 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -190,6 +190,8 @@ AC_CHECK_FUNCS(m4_flatten([
> >  	llistxattr
> >  	memset
> >  	realpath
> > +	lseek64
> > +	ftello64
> >  	pread64
> >  	pwrite64
> >  	strdup
> > diff --git a/lib/fragments.c b/lib/fragments.c
> > index e69ae47..4302cd5 100644
> > --- a/lib/fragments.c
> > +++ b/lib/fragments.c
> > @@ -3,7 +3,18 @@
> >   * Copyright (C), 2022, Coolpad Group Limited.
> >   * Created by Yue Hu <huyue2@coolpad.com>
> >   */
> > +#ifndef _LARGEFILE_SOURCE
> > +#define _LARGEFILE_SOURCE
> > +#endif
> > +#ifndef _LARGEFILE64_SOURCE
> > +#define _LARGEFILE64_SOURCE
> > +#endif
> > +#ifndef _FILE_OFFSET_BITS
> > +#define _FILE_OFFSET_BITS 64
> > +#endif
> > +#ifndef _GNU_SOURCE
> >  #define _GNU_SOURCE
> > +#endif
> >  #include <stdlib.h>
> >  #include <unistd.h>
> >  #include "erofs/err.h"
> > @@ -30,6 +41,13 @@ static struct list_head dupli_frags[FRAGMENT_HASHSIZE];
> >  static FILE *packedfile;
> >  const char *frags_packedname = "packed_file";
> >  
> > +#ifndef HAVE_LSEEK64
> > +static inline off_t lseek64(int fd, u64 offset, int set)
> > +{
> > +	return lseek(fd, offset, set);
> > +}
> > +#endif  
> 
> Could we use another function name other than native lseek64?
> 
> > +
> >  static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
> >  					 u32 crc)
> >  {
> > @@ -53,8 +71,7 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
> >  	if (!data)
> >  		return -ENOMEM;
> >  
> > -	ret = lseek(fd, inode->i_size - length, SEEK_SET);
> > -	if (ret < 0) {
> > +	if (lseek64(fd, inode->i_size - length, SEEK_SET) < 0) {
> >  		ret = -errno;
> >  		goto out;
> >  	}
> > @@ -113,8 +130,7 @@ int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc)
> >  	if (inode->i_size <= EROFS_TOF_HASHLEN)
> >  		return 0;
> >  
> > -	ret = lseek(fd, inode->i_size - EROFS_TOF_HASHLEN, SEEK_SET);
> > -	if (ret < 0)
> > +	if (lseek64(fd, inode->i_size - EROFS_TOF_HASHLEN, SEEK_SET) < 0)
> >  		return -errno;
> >  
> >  	ret = read(fd, data_to_hash, EROFS_TOF_HASHLEN);
> > @@ -192,9 +208,17 @@ void z_erofs_fragments_commit(struct erofs_inode *inode)
> >  int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
> >  			   unsigned int len, u32 tofcrc)
> >  {
> > +#ifdef HAVE_FTELLO64
> > +	off64_t offset = ftello64(packedfile);
> > +#else
> > +	off_t offset = ftello(packedfile);
> > +#endif
> >  	int ret;
> >  
> > -	inode->fragmentoff = ftell(packedfile);
> > +	if (offset < 0)
> > +		return -errno;
> > +
> > +	inode->fragmentoff = (erofs_off_t)offset;
> >  	inode->fragment_size = len;
> >  
> >  	if (fwrite(data, len, 1, packedfile) != 1)
> > diff --git a/lib/inode.c b/lib/inode.c
> > index 9de4dec..a8510f3 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -1196,7 +1196,10 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
> >  	struct erofs_inode *inode;
> >  	int ret;
> >  
> > -	lseek(fd, 0, SEEK_SET);
> > +	ret = lseek(fd, 0, SEEK_SET);
> > +	if (ret < 0)
> > +		return ERR_PTR(-errno);  
> 
> This should be in a seperate patch, please don't fix it here.
> 
> > +
> >  	ret = fstat64(fd, &st);
> >  	if (ret)
> >  		return ERR_PTR(-errno);
> > @@ -1223,7 +1226,9 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
> >  
> >  	ret = erofs_write_compressed_file(inode, fd);
> >  	if (ret == -ENOSPC) {
> > -		lseek(fd, 0, SEEK_SET);
> > +		ret = lseek(fd, 0, SEEK_SET);
> > +		if (ret < 0)  
> 
> Same here.

Okay, will update for all in v2.

> 
> Thanks,
> Gao Xiang
> 
> > +			return ERR_PTR(-errno);
> >  		ret = write_uncompressed_file_from_fd(inode, fd);
> >  	}
> >  
> > -- 
> > 2.17.1  

