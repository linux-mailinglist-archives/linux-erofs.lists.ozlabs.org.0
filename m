Return-Path: <linux-erofs+bounces-304-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D79B9AB22BC
	for <lists+linux-erofs@lfdr.de>; Sat, 10 May 2025 11:02:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZvfyZ66Qsz2yNG;
	Sat, 10 May 2025 19:02:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.87.244.166
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746867750;
	cv=none; b=AXRFWja06UZCjoNtHa1eJdOBRQv5FsXHQ45md0VglJ2ao+8pXK4nCOQuFwN5GR1Io2Zmw3Q2cTm05XgejGm7vaqa0SLsV0ph1/ySGiNVsunAPmIhndM2rf04Y3Kkm0KaeS56x9w1NQfeSdKGsg2smUFAthDJ+BOtNaWH6CfqmsPFaV4tC8GrUxImmXQ88UC6mtXO+JjRODP2qyHJAoEiQqQfJnzDk8q9T7Pg236mQV3y2iV/OLT4at9oNS84DasCFqRp1jMlBO91GsFP+4zLJDo3QAvOea6YAxS8tnrI2eOlhdn4zfMn1v6v+6rO8AHqiuWYrzUg0VCVZ/ZeSyPSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746867750; c=relaxed/relaxed;
	bh=FUvZT6/rilQJs5g25VVQFKACpufeNSjlJg1SKedQd70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXqLyROBTJvsxjB3YH+Ecg9GXxv5Scw4rgXZfpkcSTiAdmgcCYshx2oQ4L9FBMXB7BAGaJ5HXx8p9pGiriLRz636Hq5FFbBimQnHnA7bJKevYGJ925hnEzQC7JkxrSAGOk+KdpcdkVkMS/6dgSZpZFVmakmvEYOKw5GQ7Y6mziP8616Q1m39YWGFQo50/Gei0GV4BYpx2W/neTzl5j6ihQ6q0LqkYLs0/F87hb9NTe8t+4dgDdpg8rQpskzlVwkv44z3uJ+QNKjjpLPC57mgudTEqGG/0Ov3kqI5noJJvbKsDyw2PYjM9cUNrE0s4ZKK01ejUN4jA8JIEufncUefxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arvanta.net; spf=pass (client-ip=93.87.244.166; helo=fx.arvanta.net; envelope-from=mps@arvanta.net; receiver=lists.ozlabs.org) smtp.mailfrom=arvanta.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arvanta.net (client-ip=93.87.244.166; helo=fx.arvanta.net; envelope-from=mps@arvanta.net; receiver=lists.ozlabs.org)
Received: from fx.arvanta.net (93-87-244-166.static.isp.telekom.rs [93.87.244.166])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZvfyY6jK4z2yMt
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 May 2025 19:02:29 +1000 (AEST)
Received: from m1pro.arvanta.net (m1pro.arvanta.net [10.5.1.11])
	by fx.arvanta.net (Postfix) with SMTP id 7D82B12EB1;
	Sat, 10 May 2025 11:02:25 +0200 (CEST)
Date: Sat, 10 May 2025 11:02:20 +0200
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v2] erofs-utils: fix build failure with musl libc
Message-ID: <20250510090220.GA15686@m1pro.arvanta.net>
References: <20250506121102.GA15164@m1pro.arvanta.net>
 <20250507132548.2293699-1-hsiangkao@linux.alibaba.com>
 <20250507183507.09027ea8@ncopa-desktop>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507183507.09027ea8@ncopa-desktop>
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, 2025-05-07 at 18:35, Natanael Copa wrote:
> On Wed,  7 May 2025 21:25:48 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > because musl use readdir, pread and lseek instead of readdir64,
> > pread64 and lseek64.
> > 
> > Reported-by: Milan P. Stani* <mps@arvanta.net>
> > Thanks-to: Natanael Copa <ncopa@alpinelinux.org>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> > (Fix wrong email address typo..)
> > 
> > Hi,
> > 
> > Due to the original patch lacks of the commit message and
> > SOB, so I revised myself.
> 
> Ok with me.

Also ok with me.

> > I add "_FILE_OFFSET_BITS 64" in the top since "contrib/stress.c"
> > can be compiled individually.
> 
> This looks correct.
> 
> 
> Thank you!
> 
> > Feel free to repost a formal patch if inappropriate.
> > 
> > Thanks,
> > Gao Xiang
> > 
> >  contrib/stress.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> > 
> > diff --git a/contrib/stress.c b/contrib/stress.c
> > index d8def6a..0ef8c67 100644
> > --- a/contrib/stress.c
> > +++ b/contrib/stress.c
> > @@ -4,6 +4,7 @@
> >   *
> >   * Copyright (C) 2019-2025 Gao Xiang <xiang@kernel.org>
> >   */
> > +#define _FILE_OFFSET_BITS 64
> >  #define _GNU_SOURCE
> >  #include "erofs/defs.h"
> >  #include <errno.h>
> > @@ -271,7 +272,7 @@ static int __getdents_f(unsigned int sn, struct fent *fe)
> >  	}
> >  
> >  	dir = fdopendir(dfd);
> > -	while (readdir64(dir) != NULL)
> > +	while (readdir(dir) != NULL)
> >  		continue;
> >  	closedir(dir);
> >  	return 0;
> > @@ -428,7 +429,7 @@ static int __read_f(unsigned int sn, struct fent *fe, uint64_t filesize)
> >  
> >  	printf("%d[%u]/%u read_f: %llu bytes @ %llu of %s\n", getpid(), procid,
> >  	       sn, len | 0ULL, off | 0ULL, fe->subpath);
> > -	nread = pread64(fe->fd, buf, len, off);
> > +	nread = pread(fe->fd, buf, len, off);
> >  	if (nread != trimmed) {
> >  		fprintf(stderr, "%d[%u]/%u read_f: failed to read %llu bytes @ %llu of %s\n",
> >  			getpid(), procid, sn, len | 0ULL, off | 0ULL,
> > @@ -439,7 +440,7 @@ static int __read_f(unsigned int sn, struct fent *fe, uint64_t filesize)
> >  	if (fe->chkfd < 0)
> >  		return 0;
> >  
> > -	nread2 = pread64(fe->chkfd, chkbuf, len, off);
> > +	nread2 = pread(fe->chkfd, chkbuf, len, off);
> >  	if (nread2 <= 0) {
> >  		fprintf(stderr, "%d[%u]/%u read_f: failed to check %llu bytes @ %llu of %s\n",
> >  			getpid(), procid, sn, len | 0ULL, off | 0ULL,
> > @@ -477,14 +478,14 @@ static int read_f(int op, unsigned int sn)
> >  	if (ret)
> >  		return ret;
> >  
> > -	fsz = lseek64(fe->fd, 0, SEEK_END);
> > +	fsz = lseek(fe->fd, 0, SEEK_END);
> >  	if (fsz <= 0) {
> >  		if (!fsz) {
> >  			printf("%d[%u]/%u %s: zero size @ %s\n",
> >  			       getpid(), procid, sn, __func__, fe->subpath);
> >  			return 0;
> >  		}
> > -		fprintf(stderr, "%d[%u]/%u %s: lseek64 %s failed %d\n",
> > +		fprintf(stderr, "%d[%u]/%u %s: lseek %s failed %d\n",
> >  			getpid(), procid, sn, __func__, fe->subpath, errno);
> >  		return -errno;
> >  	}
> > @@ -504,7 +505,7 @@ static int __doscan_f(unsigned int sn, const char *op, struct fent *fe,
> >  	for (pos = 0; pos < filesize; pos += chunksize) {
> >  		ssize_t nread, nread2;
> >  
> > -		nread = pread64(fe->fd, buf, chunksize, pos);
> > +		nread = pread(fe->fd, buf, chunksize, pos);
> >  
> >  		if (nread <= 0)
> >  			return -errno;
> > @@ -515,7 +516,7 @@ static int __doscan_f(unsigned int sn, const char *op, struct fent *fe,
> >  		if (fe->chkfd < 0)
> >  			continue;
> >  
> > -		nread2 = pread64(fe->chkfd, chkbuf, chunksize, pos);
> > +		nread2 = pread(fe->chkfd, chkbuf, chunksize, pos);
> >  		if (nread2 <= 0)
> >  			return -errno;
> >  
> > @@ -547,14 +548,14 @@ static int doscan_f(int op, unsigned int sn)
> >  	if (ret)
> >  		return ret;
> >  
> > -	fsz = lseek64(fe->fd, 0, SEEK_END);
> > +	fsz = lseek(fe->fd, 0, SEEK_END);
> >  	if (fsz <= 0) {
> >  		if (!fsz) {
> >  			printf("%d[%u]/%u %s: zero size @ %s\n",
> >  			       getpid(), procid, sn, __func__, fe->subpath);
> >  			return 0;
> >  		}
> > -		fprintf(stderr, "%d[%u]/%u %s: lseek64 %s failed %d\n",
> > +		fprintf(stderr, "%d[%u]/%u %s: lseek %s failed %d\n",
> >  			getpid(), procid, sn, __func__, fe->subpath, errno);
> >  		return -errno;
> >  	}
> > @@ -576,7 +577,7 @@ static int doscan_aligned_f(int op, unsigned int sn)
> >  	ret = tryopen(sn, __func__, fe);
> >  	if (ret)
> >  		return ret;
> > -	fsz = lseek64(fe->fd, 0, SEEK_END);
> > +	fsz = lseek(fe->fd, 0, SEEK_END);
> >  	if (fsz <= psz) {
> >  		if (fsz >= 0) {
> >  			printf("%d[%u]/%u %s: size too small %lld @ %s\n",
> > @@ -584,7 +585,7 @@ static int doscan_aligned_f(int op, unsigned int sn)
> >  			       fe->subpath);
> >  			return 0;
> >  		}
> > -		fprintf(stderr, "%d[%u]/%u %s: lseek64 %s failed %d\n",
> > +		fprintf(stderr, "%d[%u]/%u %s: lseek %s failed %d\n",
> >  			getpid(), procid, sn, __func__, fe->subpath, errno);
> >  		return -errno;
> >  	}
> 

